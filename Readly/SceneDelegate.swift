//
//  SceneDelegate.swift
//  Readly
//
//  Created by Илья Востров on 28.02.2025.
//

import UIKit

enum WindowCase{
    case preview, regist, onboarding, main
}
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(windowManager), name: .windowManager, object: nil)
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: scene)
        window?.rootViewController = PreviewView()
        window?.makeKeyAndVisible()
    }
    
    @objc func windowManager(notification: Notification){
        guard let userInfo = notification.userInfo as? [String: WindowCase] else { return }
        guard let window = userInfo[.windowInfo] else { return }
        
        switch window {
        default:
            self.window?.rootViewController = Builder.createRegistView()
        }
    }
    
}
