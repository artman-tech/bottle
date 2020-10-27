//
//  LaunchViewController.swift
//  Bottle
//
//  Created by 有田栄乃祐 on 2020/10/15.
//  Copyright © 2020 artApps. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let topColor = UIColor(red:0, green:0, blue:0, alpha:0)
        //グラデーションの開始色
        let bottomColor = UIColor(red:2.55, green:2.55, blue:2.55, alpha:1)
        //グラデーションの色を配列で管理
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        //グラデーションレイヤーを作成
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        //グラデーションの色をレイヤーに割り当てる
        gradientLayer.colors = gradientColors
        //グラデーションレイヤーをスクリーンサイズにする
        gradientLayer.frame = self.view.bounds
        //グラデーションレイヤーをビューの一番下に配置
        self.view.layer.insertSublayer(gradientLayer, at: 1)
    }
    

}
