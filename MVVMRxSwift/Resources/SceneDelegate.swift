//
//  SceneDelegate.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 19.07.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let dependencyAssembly = DependencyAssembly()
        let mainCoordinator = MainCoordinatorAssembly(dependencyAssembly: dependencyAssembly).assembly()
        window?.rootViewController = dependencyAssembly.navigationController
        mainCoordinator.start()
        window?.makeKeyAndVisible()
    }
}
