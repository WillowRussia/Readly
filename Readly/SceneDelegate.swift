//
//  SceneDelegate.swift
//  Readly
//
//  Created by Илья Востров on 28.02.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let previewView = PreviewView()
        
        let windowStateGateway = UserDefaultsWindowStateGateway()
        
        let launchRouter = LaunchRouterImplementation(window: window, windowStateGateway: windowStateGateway)
        previewView.router = launchRouter
        
        window.rootViewController = previewView
        
        self.window = window
        window.makeKeyAndVisible()
    }
}
