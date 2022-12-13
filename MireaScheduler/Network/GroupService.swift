//
//  GroupService.swift
//  MireaScheduler
//
//  Created by Vladislav Koshelev on 12.12.2022.
//

import Foundation
import RxSwift
import RxCocoa

enum NetworkError: Error {
    case invalidURL
}

extension String{
    var encodeUrl : String {
        addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    var decodeUrl : String {
        removingPercentEncoding!
    }
}

final class GroupService {
    func fetch(_ group: String) -> Single<[Schedule]> {
        guard
            let url = URL(string: "http://localhost:8000/api/group/\(group)".encodeUrl)
        else { return .error(NetworkError.invalidURL) }
        let request = URLRequest(url: url)
        return URLSession.shared.rx.data(request: request)
            .map { data in
                do {
                    return try JSONDecoder().decode([Schedule].self, from: data)
                } catch {
                    print(error.localizedDescription)
                    return []
                }
            }
            .asSingle()
    }
}
