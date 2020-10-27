//
//  PrivacyPolicyViewController.swift
//  Bottle
//
//  Created by 有田栄乃祐 on 2020/09/28.
//  Copyright © 2020 artApps. All rights reserved.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {
    
    @IBOutlet var privacyPolicyCloseButton: UIButton!
    @IBOutlet var privacyTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        privacyPolicyCloseButton.layer.cornerRadius = 12
        privacyPolicyCloseButton.layer.shadowColor = UIColor.black.cgColor //影の色を決める
        privacyPolicyCloseButton.layer.shadowOpacity = 0.8 //影の色の透明度
        privacyPolicyCloseButton.layer.shadowRadius = 8 //影のぼかし
        privacyPolicyCloseButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        
        privacyTextView.text = "プライバシーポリシーは、このアプリ内の"

    }
    
    @IBAction func privacyPolicyClose() {
        self.dismiss(animated: true, completion: nil)
    }

}
