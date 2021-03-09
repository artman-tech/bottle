//
//  GradaientLayer.swift
//  Bottle
//
//  Created by 有田栄乃祐 on 2021/02/13.
//  Copyright © 2021 artApps. All rights reserved.
//

import UIKit
import Foundation

extension CAGradientLayer {
    static func layerForView() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors =  [UIColor.lightGray.cgColor,
                                 UIColor.black.cgColor]
        // 設定した各グラデーションカラーのstopポイントを決めている？
        // これを設定しないとおそらく設定したカラーが画面全体に均一の割合で表示される
        gradientLayer.locations = [0.0, 0.6]
        // startPointとendPointを決めることでグラデーションをかける方向を決めている？
        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 2)
        return gradientLayer
    }
}
