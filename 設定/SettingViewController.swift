//
//  SettingViewController.swift
//  Bottle
//
//  Created by 有田栄乃祐 on 2020/09/28.
//  Copyright © 2020 artApps. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet var useButton: UIButton!
    @IBOutlet var privacyPolicyButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        useButton.layer.cornerRadius = 12
        useButton.layer.shadowColor = UIColor.black.cgColor //影の色を決める
        useButton.layer.shadowOpacity = 0.8 //影の色の透明度
        useButton.layer.shadowRadius = 8 //影のぼかし
        useButton.layer.shadowOffset = CGSize(width: 4, height: 4) //影の方向　width、heightを負の値にすると上の方に影が表示される
        
        privacyPolicyButton.layer.cornerRadius = 12
        privacyPolicyButton.layer.shadowColor = UIColor.black.cgColor //影の色を決める
        privacyPolicyButton.layer.shadowOpacity = 0.8 //影の色の透明度
        privacyPolicyButton.layer.shadowRadius = 8 //影のぼかし
        privacyPolicyButton.layer.shadowOffset = CGSize(width: 4, height: 4) //影の方向　width、heightを負の値にすると上の方に影が表示される
        
        
    }

    @IBAction func didTapUseButton() {
        let vc = storyboard?.instantiateViewController(identifier: "useterm") as! UseTermViewController
        present(vc, animated: true)
    }



    @IBAction func didTapPrivacyButton() {
        let vc = storyboard?.instantiateViewController(identifier: "privacypolicy") as! PrivacyPolicyViewController
        present(vc, animated: true)
    }



}

