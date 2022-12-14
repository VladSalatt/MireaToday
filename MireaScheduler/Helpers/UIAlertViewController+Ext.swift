//
//  UIAlertViewController+Ext.swift
//  MireaScheduler
//
//  Created by Vladislav Koshelev on 14.12.2022.
//

import UIKit
import RxCocoa
import RxSwift

extension UIAlertController {
    struct Action<T> {
        public var title: String?
        public var style: UIAlertAction.Style
        public var value: T
        public var buttonAccessibilityIdentifier: String?

        public init(
            title: String?,
            style: UIAlertAction.Style,
            value: T,
            buttonAccessibilityIdentifier: String? = nil
        ) {
            self.title = title
            self.style = style
            self.value = value
            self.buttonAccessibilityIdentifier = buttonAccessibilityIdentifier
        }

        // swiftlint:disable:next function_default_parameter_at_end
        static func action(title: String?, style: UIAlertAction.Style = .default, value: T) -> Action {
            Action(title: title, style: style, value: value)
        }
    }
    
    static func present(
        in viewController: UIViewController,
        title: String? = nil,
        message: String? = nil,
        cancelTitle: String? = nil,
        buttonAccessibilityIdentifier _: String? = nil,
        style: UIAlertController.Style,
        placeholder: String? = nil
    ) -> Observable<String?> {
        Observable.create { observer in
            let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
            
            alertController.addTextField { tf in
                tf.placeholder = placeholder
                tf.autocapitalizationType = .allCharacters
            }

            let successAction = UIAlertAction(
                title: "Поиск",
                style: .cancel,
                handler: { _ in
                    let text = alertController.textFields?.first?.text
                    observer.onNext(text)
                    observer.onCompleted()
                }
            )
            alertController.addAction(successAction)
            viewController.present(alertController, animated: true, completion: nil)
            return Disposables.create { alertController.dismiss(animated: true, completion: nil) }
        }
    }
}
