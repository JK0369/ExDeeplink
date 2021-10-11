//
//  AppDelegate.swift
//  ExDeeplink
//
//  Created by 김종권 on 2021/10/06.
//

import UIKit
import Firebase
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // FCM, Dynamic Link모두 필요한 코드
        FirebaseApp.configure()

        // FCM에 필요한 코드
        registerRemoteNotification()

        return true
    }

    // FCM에 필요한 코드
    private func registerRemoteNotification() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        center.requestAuthorization(options: options) { granted, _ in
            // (FCM) 1. APNs에 device token 등록 요청
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }

    // (FCM) 2. APNs에서 `device token 등록 요청`에 관한 응답이 온 경우, Provider Server인 Firebase에 등록
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
}

extension AppDelegate: UNUserNotificationCenterDelegate {

    /// Foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }

    // FCM에서 푸시를 탭했을 때 url 처리
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
        print(userInfo["url"] as? String)
        guard let deepLinkUrl = userInfo["url"] as? String,
            let url = URL(string: deepLinkUrl) else { return }

        // 해당 host를 가지고 있는지 확인
        guard url.host == "navigation" else { return }

        // 원하는 query parameter가 있는지 확인
        let urlString = url.absoluteString
        guard urlString.contains("target"), urlString.contains("promotionCode") else { return }

        // URL을 URLComponent로 만들어서 parameter값 가져오기 쉽게 접근
        let components = URLComponents(string: urlString)

        // URLQueryItem 형식은 [name: value] 쌍으로 되어있으서 Dctionary로 변형
        let urlQueryItems = components?.queryItems ?? []
        var dictionaryData = [String: String]()
        urlQueryItems.forEach { dictionaryData[$0.name] = $0.value }
        guard let target = dictionaryData["target"],
            let promotionCode = dictionaryData["promotionCode"] else { return }

        print("결과 = \(target), \(promotionCode)")
        switch DeepLinkTarget(rawValue: target) {
        case .thirdScene: routeToThirdScene(with: promotionCode)
        default: return
        }
    }

    private func routeToThirdScene(with promotinoCode: String) {
        // 타겟 화면인 ViewController3 초기화
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let viewController3 = storyboard.instantiateViewController(withIdentifier: "ViewController3") as? ViewController3 else { return }
        viewController3.promotionCode = promotinoCode

        /// 이미 로그인 이 된 경우, 바로 present
        if UserDefaults.standard.bool(forKey: "didLogin") {
            // 타겟 화면을 띄울 window의 rootViewController 참조
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
            let rootViewController = sceneDelegate.window?.rootViewController
            rootViewController?.present(viewController3, animated: true, completion: nil)
        } else {
            /// 로그인이 안되어 있는 경우, 로그인 완료 시 나오는 페이지에 타겟 화면이 표출되도록 예약
        }
    }
}

enum DeepLinkTarget: String {
    case thirdScene
}
