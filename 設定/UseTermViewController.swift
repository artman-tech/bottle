//
//  UseTermViewController.swift
//  Bottle
//
//  Created by 有田栄乃祐 on 2020/09/28.
//  Copyright © 2020 artApps. All rights reserved.
//

import UIKit

class UseTermViewController: UIViewController {
    
    @IBOutlet var didTapCloseButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "利用規約"

        didTapCloseButton.layer.cornerRadius = 12
        didTapCloseButton.layer.shadowColor = UIColor.black.cgColor //影の色を決める
        didTapCloseButton.layer.shadowOpacity = 0.8 //影の色の透明度
        didTapCloseButton.layer.shadowRadius = 8 //影のぼかし
        didTapCloseButton.layer.shadowOffset = CGSize(width: 4, height: 4)
    }
    
    @IBAction func didTapClose() {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
}
