//
//  AppDelegate.swift
//  The Freak Circus
//
//  Created by WebView Generator
//  Copyright © 2026 Garula. All rights reserved.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 设置全局外观
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        
        // 防止屏幕休眠（游戏时保持屏幕常亮）
        UIApplication.shared.isIdleTimerDisabled = true
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    // MARK: - 应用生命周期
    
    func applicationWillResignActive(_ application: UIApplication) {
        // 应用即将进入非活动状态
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // 应用进入后台
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // 应用即将进入前台
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // 应用已激活
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // 应用即将终止
    }
}
