// Copyright (c) 2022 Detsky Mir PJSC. All rights reserved.

import AppRouter
import RxSwift
import UIKit

extension AppRouter {
    enum RouteError: Error {
        case routeError
    }
    
    static func openInputGroup(vc: UIViewController?) -> Single<String?> {
        guard let topViewController = vc else { return .error(RouteError.routeError) }
        return UIAlertController.present(
            in: topViewController,
            title: "Поиск группы",
            message: "Введите номер группы",
            cancelTitle: "Отмена",
            buttonAccessibilityIdentifier: nil,
            style: .alert,
            placeholder: "Группа"
        ).asSingle()
    }
}

