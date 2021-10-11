//
//  ViewController2.swift
//  ExDeeplink
//
//  Created by 김종권 on 2021/10/11.
//

import UIKit

class ViewController2: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "로그인 완료 시 첫 화면"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        UserDefaults.standard.set(true, forKey: "didLogin")
    }
}
