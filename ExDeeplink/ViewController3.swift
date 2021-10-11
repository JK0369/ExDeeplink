//
//  ViewController3.swift
//  ExDeeplink
//
//  Created by 김종권 on 2021/10/11.
//

import UIKit

class ViewController3: UIViewController {
    @IBOutlet weak var promotionLabel: UILabel!

    var promotionCode: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "세 번째 화면"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        promotionLabel.text = promotionCode == "" ? "-" : promotionCode
    }
}
