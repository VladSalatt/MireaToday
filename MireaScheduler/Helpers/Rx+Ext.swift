//
//  Rx+Ext.swift
//  MireaScheduler
//
//  Created by Vladislav Koshelev on 11.12.2022.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType {
    func mapToVoid() -> Observable<Void> {
        map { _ in }
    }
}
