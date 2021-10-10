//
//  SceneDelegate.swift
//  ExDeeplink
//
//  Created by 김종권 on 2021/10/06.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    // my-app://navigation?name=jake
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
//        print(URLContexts)
        guard let url = URLContexts.first?.url else { return }
        print("값")
        print(url)
//
//        // 해당 scheme과 host를 가지고 있는지 파악
//        print(url.host)
//        guard url.scheme == "my-app", url.host == "navigation" else { return }
//
//        // 원하는 query parameter가 있는지 파악
//        let urlString = url.absoluteString
//        guard urlString.contains("name") else { return }
//
//        let components = URLComponents(string: url.absoluteString)
//        let urlQueryItems = components?.queryItems ?? []
//
//        var dictionaryData = [String: String]()
//        urlQueryItems.forEach { dictionaryData[$0.name] = $0.value }
//
//        guard let name = dictionaryData["name"] else { return }
//
//        print("딥링크로 넘어온 name 쿼리 파라미터의 value = \(name)")
    }
}
