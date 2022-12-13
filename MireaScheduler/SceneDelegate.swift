//
//  SceneDelegate.swift
//  MireaScheduler
//
//  Created by Vladislav Koshelev on 10.12.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let mainVC = MainViewController(
            viewModel: .init(groupService: GroupService())
        )
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
    }
}

