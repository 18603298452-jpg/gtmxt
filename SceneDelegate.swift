//
//  SceneDelegate.swift
//  The Freak Circus
//
//  Created by WebView Generator
//  Copyright © 2026 Garula. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let viewController = ViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.isHidden = true
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // 场景已断开连接
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // 场景已激活
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // 场景即将退出活动状态
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // 场景即将进入前台
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // 场景已进入后台
    }
}
