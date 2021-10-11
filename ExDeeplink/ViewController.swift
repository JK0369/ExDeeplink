//
//  ViewController.swift
//  ExDeeplink
//
//  Created by 김종권 on 2021/10/06.
//

import UIKit
import FirebaseDynamicLinks

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "로그인 화면"
    }

    @IBAction func createDynamicLink(_ sender: Any) {

        // bundleID가 `com.jake.sample.ExDeeplink`에서만 열리는 `https://www.example.com/my-page` 링크 생성
        guard let link = URL(string: "https://www.example.com/my-page") else { return }
        let dynamicLinksDomainURIPrefix = "https://exdeeplinkjake.page.link"
        let bundleID = "com.jake.sample.ExDeeplink"
        let linkBuilder = DynamicLinkComponents(link: link, domainURIPrefix: dynamicLinksDomainURIPrefix)
        linkBuilder?.iOSParameters = DynamicLinkIOSParameters(bundleID: bundleID)
        linkBuilder?.androidParameters = DynamicLinkAndroidParameters(packageName: bundleID)

        guard let longDynamicLink = linkBuilder?.url else { return }
        print("The long URL is: \(longDynamicLink)")

        /// 짧은 Dynamic Link로 변환
        linkBuilder?.shorten(completion: { url, warnings, error in
            guard let url = url else { return }

            print("The short URL is: \(url)")
        })
    }

    @IBAction func createParameterDynamicLink(_ sender: Any) {
        guard let link = URL(string: "https://exdeeplinkjake.page.link/navigation&ibi=com.jake.sample.ExDeeplink") else { return }
        let dynamicLinksDomainURIPrefix = "https://exdeeplinkjake.page.link"
        let linkBuilder = DynamicLinkComponents(link: link, domainURIPrefix: dynamicLinksDomainURIPrefix)
        let bundleID = "com.jake.sample.ExDeeplink"

        linkBuilder?.iOSParameters = DynamicLinkIOSParameters(bundleID: bundleID)
        linkBuilder?.iOSParameters?.appStoreID = "123456789"
        linkBuilder?.iOSParameters?.minimumAppVersion = "0.0.0"

//        linkBuilder?.androidParameters = DynamicLinkAndroidParameters(packageName: bundleID)
//        linkBuilder?.androidParameters?.minimumVersion = 123

//        linkBuilder?.analyticsParameters = DynamicLinkGoogleAnalyticsParameters(source: "orkut",
//                                                                               medium: "social",
//                                                                               campaign: "example-promo")

        linkBuilder?.iTunesConnectParameters = DynamicLinkItunesConnectAnalyticsParameters()
        linkBuilder?.iTunesConnectParameters?.providerToken = "123456"
        linkBuilder?.iTunesConnectParameters?.campaignToken = "example-promo"

        linkBuilder?.socialMetaTagParameters? = DynamicLinkSocialMetaTagParameters()
        linkBuilder?.socialMetaTagParameters?.title = "Example of a Dynamic Link"
        linkBuilder?.socialMetaTagParameters?.descriptionText = "This link works whether the app is installed or not!"
        linkBuilder?.socialMetaTagParameters?.imageURL = URL(string: "https://www.example.com/my-image.jpg")

        guard let longDynamicLink = linkBuilder?.url else { return }
        print("The long URL is: \(longDynamicLink)")

        // https://exdeeplinkjake.page.link/?isi=123456789&utm_source=orkut&ibi=com%2Ejake%2Esample%2EExDeeplink&utm_campaign=example%2Dpromo&utm_medium=social&imv=1%2E2%2E3&link=https%3A%2F%2Fwww%2Eexample%2Ecom%2Fmy%2Dpage&pt=123456&ct=example%2Dpromo&apn=com%2Ejake%2Esample%2EExDeeplink&amv=123
    }
}
