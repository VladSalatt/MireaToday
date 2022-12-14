// Copyright (c) 2022 Detsky Mir PJSC. All rights reserved.

import RxCocoa
import RxDataSources
import RxSwift
import AppRouter
import UIKit

final class MainViewModel {
    private let bag = DisposeBag()
    private let groupService: GroupService

    init(groupService: GroupService) {
        self.groupService = groupService
    }
    
    func transform(input: Input) -> Output {
        let dataCurrent = input.alertResult
            .compactMap { $0 }
            .asObservable()
            .flatMapLatest { [groupService] group in
                groupService.fetch(group)
            }
            .compactMap { $0.first }
            .share()
        
        let title = dataCurrent
            .compactMap { $0.groupName }
        
        let today = dataCurrent
            .compactMap(\.dayInfo)
            .compactMap { day -> [[String?]]? in
                guard
                    let index = Calendar.current.dateComponents([.weekday], from: Date()).weekday
                else { return nil }
                let dayOfWeek = Weekly.allCases[index - 1]
                switch dayOfWeek {
                case .saturday: return day.saturday
                case .monday: return day.monday
                case .tuesday: return day.tuesday
                case .wednesday: return day.wednesday
                case .thursday: return day.thursday
                case .friday: return day.friday
                }
            }
        
        let items = today
            .map { day  -> [MainCollectionViewCell.Model] in
                day.map { pair in
                        .init(
                            number: pair[2]?.makeChet(with: pair[6]),
                            teacher: pair[4],
                            type: pair[3]?.typeOfPair,
                            time: pair[1]?.time,
                            name: pair[0],
                            cabina: pair[5]?.cabina
                        )
                }
            }
        
        let sections = items
            .withLatestFrom(title) { ($0, $1) }
            .compactMap { items, title in
                guard
                    let index = Calendar.current.dateComponents([.weekday], from: Date()).weekday
                else { return nil }
                let dayOfWeek = Weekly.allCases[index - 1]
                let today = dayOfWeek.rawValue
                return (items, title, today)
            }
            .map { items, title, today -> [SectionModel<(String, String), MainCollectionViewCell.Model>] in
                [SectionModel(model: (today, title), items: items)]
            }
            .asDriver(onErrorJustReturn: [])

        return .init(
            items: sections
        )
    }
}

extension MainViewModel {
    struct Input {
        let viewWillAppear: Signal<Void>
        let alertResult: Signal<String?>
    }

    struct Output {
        let items: Driver<[SectionModel<(String, String), MainCollectionViewCell.Model>]>
    }
}
            
private extension String {
    var typeOfPair: String {
        switch self {
        case "Л", "ЛК": return "лекция"
        case "П", "ПР": return "практика"
        default: return self
        }
    }
    
    var time: String {
        replacingOccurrences(of: ":", with: "\n\n")
    }
    
    func makeChet(with str: String?) -> String {
        guard let str else { return self }
        let chet = str == "I" ? " (четная)" : " (нечетная)"
        return appending(chet)
    }
    
    var cabina: String {
        replacingOccurrences(of: " ", with: "\n")
    }
}
