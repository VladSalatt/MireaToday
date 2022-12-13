//
//  Schedule.swift
//  MireaScheduler
//
//  Created by Vladislav Koshelev on 13.12.2022.
//

import Foundation

// MARK: - WelcomeElement
struct Schedule: Decodable {
    let groupName: String?
    let dayInfo: DayInfo?

    enum CodingKeys: String, CodingKey {
        case groupName = "group_name"
        case dayInfo = "day_info"
    }
}

// MARK: - DayInfo
extension Schedule {
    struct DayInfo: Decodable {
        let monday: [[String?]]?
        let tuesday: [[String?]]?
        let wednesday: [[String?]]?
        let thursday: [[String?]]?
        let friday: [[String?]]?
        let saturday: [[String?]]?
        
        enum CodingKeys: String, CodingKey {
            case monday = "ПОНЕДЕЛЬНИК"
            case tuesday = "ВТОРНИК"
            case wednesday = "СРЕДА"
            case thursday = "ЧЕТВЕРГ"
            case friday = "ПЯТНИЦА"
            case saturday = "СУББОТА"
        }
    }
}

enum Weekly: String, CaseIterable {
    case saturday = "СУББОТА"
    case monday = "ПОНЕДЕЛЬНИК"
    case tuesday = "ВТОРНИК"
    case wednesday = "СРЕДА"
    case thursday = "ЧЕТВЕРГ"
    case friday = "ПЯТНИЦА"
}

//[
//    "кр. 1 н. Прогнозно-аналитические системы ", -> Название пары
//    "9-00:10-30", -> Время проведения
//    "1", -> Номер пары
//    "Л", -> Тип пары (практика, лекция)
//    "Скляр А.Я.", -> Имя препода
//    "ауд. А-16 (В-78)", -> Аудитория (заменить пробелы на \n)
//    "I" -> четная нечетная
//],
