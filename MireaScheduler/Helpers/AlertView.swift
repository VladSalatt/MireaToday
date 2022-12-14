//
//  AlertView.swift
//  MireaScheduler
//
//  Created by Vladislav Koshelev on 14.12.2022.
//

import UIKit

final class AlertView: UIAlertController {
    private lazy var localTextField = UITextField()
    private var correctAnswer: String = ""
    
    convenience init(
        title: String,
        message: String,
        correctAnswer: String,
        checkAction: @escaping ((Result<Void, Error>) -> Void),
        closeAction: (() -> Void)? = nil
    ) {
        self.init(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        self.correctAnswer = correctAnswer
        
        addTextField { [weak self] textField in
            guard let self = self else { return }
            textField.placeholder = "Группа"
//            textField.addTarget(
//                self,
//                action: #selector(self.textFieldDidChange(field:)),
//                for: .editingChanged
//            )
            self.localTextField = textField
        }
        
        let closeAction = UIAlertAction(
            title: "Отмена",
            style: .destructive,
            handler: { _ in
                guard let closeAction = closeAction else { return }
                closeAction()
            }
        )
        let checkAction: UIAlertAction = {
            let action = UIAlertAction(
                title: "Поиск",
                style: .default,
                handler: { _ in
                    checkAction(.success(()))
                }
            )
            action.isEnabled = false
            return action
        }()
        addAction(closeAction)
        addAction(checkAction)
    }
}
