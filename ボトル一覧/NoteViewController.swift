//
//  NoteViewController.swift
//  Bottle
//
//  Created by 有田栄乃祐 on 2020/09/28.
//  Copyright © 2020 artApps. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var contentView: UIView!
    //お客様氏名
    @IBOutlet var noteCustomerView: UIView!
    @IBOutlet var noteCustomerNameField: UITextField!
    //ボトル名
    @IBOutlet var noteProductNameField: UITextField!
    @IBOutlet var noteProductView: UIView!
    //ボトル利用日
    @IBOutlet var noteBottleUseView: UIView!
    @IBOutlet var noteBottleUseYearField: UITextField!
    @IBOutlet var noteBottleUseMonthField: UITextField!
    @IBOutlet var noteBottleUseDayField: UITextField!
    //キープ期限日
    @IBOutlet var noteBottleKeepView: UIView!
    @IBOutlet var noteBottleKeepYearField: UITextField!
    @IBOutlet var noteBottleKeepMonthField: UITextField!
    @IBOutlet var noteBottleKeepDayField: UITextField!
    //メモ欄
    @IBOutlet weak var noteMemoTextView: UITextView!
    
    @IBOutlet var noteRemainField: UITextField!
    @IBOutlet var noteRemainFieldView: UIView!
    
    @IBOutlet var noteNumberField: UITextField!
    @IBOutlet var noteNumberFieldView: UIView!
    
    @IBOutlet var updateButton: UIButton!
    
    public var noteTitle: String = ""
    public var note: String = ""
    public var year: String = ""
    public var month: String = ""
    public var day: String = ""
    public var noteYear: String = ""
    public var noteMonth: String = ""
    public var noteDay: String = ""
    public var memo: String = ""
    public var remain: String = ""
    public var number: String = ""
    
    // 入力可能な最大・最小文字数
    let maxLength: Int = 4
    let minLength: Int = 2
    
    let picker =  UIPickerView()
    
    let noteRemain = ["100~75%", "75~50%", "50~25%", "25~0%", "残量なし"]
    
    public var completion: ((String, String, String, String, String, String, String, String, String, String, String) -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        delegateDataSpurce()
        ViewLayer()
        gradation()
        createDatePicker()
        notificationAddObserver()
        textFieldAlignment()
        textFieldKeyboardType()
        
        noteCustomerNameField.text = noteTitle
        noteProductNameField.text = note
        noteBottleUseYearField.text = year
        noteBottleUseMonthField.text = month
        noteBottleUseDayField.text = day
        noteBottleKeepYearField.text = noteYear
        noteBottleKeepMonthField.text = noteMonth
        noteBottleKeepDayField.text = noteDay
        noteMemoTextView.text = memo
        noteRemainField.text = remain
        noteNumberField.text = number
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    
    func textFieldKeyboardType() {
        noteNumberField.keyboardType = .numberPad
        noteBottleUseYearField.keyboardType = .numberPad
        noteBottleUseMonthField.keyboardType = .numberPad
        noteBottleUseDayField.keyboardType = .numberPad
        noteBottleKeepYearField.keyboardType = .numberPad
        noteBottleKeepMonthField.keyboardType = .numberPad
        noteBottleKeepDayField.keyboardType = .numberPad
    }
    
    func textFieldAlignment() {
        noteCustomerNameField.textAlignment = .center
        noteProductNameField.textAlignment = .center
        noteBottleUseYearField.textAlignment = .center
        noteBottleUseMonthField.textAlignment = .center
        noteBottleUseDayField.textAlignment = .center
        noteBottleKeepYearField.textAlignment = .center
        noteBottleKeepMonthField.textAlignment = .center
        noteBottleKeepDayField.textAlignment = .center
        noteRemainField.textAlignment = .center
    }
    
    func notificationAddObserver() {
        // myTextFieldの入力チェック(文字数チェック)をオブザーバ登録
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textFieldDidMaxChange(notification:)),
                                               name: UITextField.textDidChangeNotification,
                                               object: noteBottleUseYearField)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textFieldDidMinChange(notification:)),
                                               name: UITextField.textDidChangeNotification,
                                               object: noteBottleUseMonthField)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textFieldDidMinChange(notification:)),
                                               name: UITextField.textDidChangeNotification,
                                               object: noteBottleUseDayField)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textFieldDidMaxChange(notification:)),
                                               name: UITextField.textDidChangeNotification,
                                               object: noteBottleKeepYearField)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textFieldDidMinChange(notification:)),
                                               name: UITextField.textDidChangeNotification,
                                               object: noteBottleKeepMonthField)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textFieldDidMinChange(notification:)),
                                               name: UITextField.textDidChangeNotification,
                                               object: noteBottleKeepDayField)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textFieldDidMinChange(notification:)),
                                               name: UITextField.textDidChangeNotification,
                                               object: noteNumberField)
    }
    
    // オブザーバの破棄
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // 入力チェック(文字数チェック)処理
    @objc private func textFieldDidMaxChange(notification: NSNotification) {
        let textField = notification.object as! UITextField

        if let text = textField.text {
            if textField.markedTextRange == nil && text.count > maxLength {
                textField.text = text.prefix(maxLength).description
            }
        }
    }
    
    @objc private func textFieldDidMinChange(notification: NSNotification) {
        let textField = notification.object as! UITextField

        if let text = textField.text {
            if textField.markedTextRange == nil && text.count > minLength {
                textField.text = text.prefix(minLength).description
            }
        }
    }
    
    //UIPickerView
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return noteRemain.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return noteRemain[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        noteRemainField.text = noteRemain[row]
        noteRemainField.resignFirstResponder()
    }
    
    
    @IBAction func didTapUpdate() {
        if let text = noteCustomerNameField.text,
            let productText = noteProductNameField.text,
            let useYearText = noteBottleUseYearField.text,
            let useMonthText = noteBottleUseMonthField.text,
            let useDayText = noteBottleUseDayField.text,
            let keepYearText = noteBottleKeepYearField.text,
            let keepMonthText = noteBottleKeepMonthField.text,
            let keepDayText = noteBottleKeepDayField.text,
            let memoText = noteMemoTextView.text,
            let remainText = noteRemainField.text,
            let numberText = noteNumberField.text,
            !text.isEmpty, !productText.isEmpty, !useYearText.isEmpty, !useMonthText.isEmpty, !useDayText.isEmpty, !keepYearText.isEmpty, !keepMonthText.isEmpty, !keepDayText.isEmpty, !remainText.isEmpty {
            completion?(text, productText, useYearText, useMonthText, useDayText, keepYearText, keepMonthText, keepDayText, memoText, remainText, numberText)
        } else {
            showAleet()
        }
    }
    
    func showAleet() {
        let alert = UIAlertController(title: "空の項目があります", message: "項目を埋めてください", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "了解", style: .default, handler: nil))
        present(alert,animated: true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        noteCustomerNameField.text = textField.text
        return true
    }
    
    
    // ツールバー生成 サイズはsizeToFitメソッドで自動で調整される。
    let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    // 左側のBarButtonItemはflexibleSpace。これがないと右に寄らない。
    let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                                 target: self,
                                 action: nil)
    // Doneボタン
    let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done,
                                       target: self,
                                       action: #selector(commitButtonTapped))
    @objc func commitButtonTapped() {
        self.contentView.endEditing(true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.contentView.endEditing(true)
    }
    
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        noteRemainField.inputView = picker
        picker.delegate = self
        picker.dataSource = self
        
        let doneBtn = UIBarButtonItem(title: "完了",
                                      style: .done,
                                      target: self,
                                      action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        noteRemainField.inputAccessoryView = toolbar
        
        noteBottleUseYearField.inputAccessoryView = toolbar
        noteBottleUseYearField.textAlignment = .center
        noteBottleUseMonthField.inputAccessoryView = toolbar
        noteBottleUseMonthField.textAlignment = .center
        noteBottleUseDayField.inputAccessoryView = toolbar
        noteBottleUseDayField.textAlignment = .center
        noteBottleKeepYearField.inputAccessoryView = toolbar
        noteBottleKeepYearField.textAlignment = .center
        noteBottleKeepMonthField.inputAccessoryView = toolbar
        noteBottleKeepMonthField.textAlignment = .center
        noteBottleKeepDayField.inputAccessoryView = toolbar
        noteBottleKeepDayField.textAlignment = .center
        noteNumberField.inputAccessoryView = toolbar
        noteNumberField.textAlignment = .center
        noteRemainField.textAlignment = .center
        noteMemoTextView.inputAccessoryView = toolbar
    }
    
    @objc func donePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "jp_JP")
        formatter.dateStyle = DateFormatter.Style.medium
        self.view.endEditing(true)
    }
    
    
    func ViewLayer() {
        //noteCustomerView
        noteCustomerView.layer.cornerRadius = 8
        noteCustomerView.layer.shadowColor = UIColor.white.cgColor //影の色を決める
        noteCustomerView.layer.shadowOpacity = 0.5 //影の色の透明度
        noteCustomerView.layer.shadowRadius = 8 //影のぼかし
        noteCustomerView.layer.shadowOffset = CGSize(width: 4, height: 4)
        noteCustomerView.layer.borderColor = UIColor.black.cgColor
        noteCustomerView.layer.borderWidth = 0.5
        //noteProductView
        noteProductView.layer.cornerRadius = 8
        noteProductView.layer.shadowColor = UIColor.white.cgColor //影の色を決める
        noteProductView.layer.shadowOpacity = 0.5 //影の色の透明度
        noteProductView.layer.shadowRadius = 8 //影のぼかし
        noteProductView.layer.shadowOffset = CGSize(width: 4, height: 4)
        noteProductView.layer.borderColor = UIColor.black.cgColor
        noteProductView.layer.borderWidth = 0.5
        //noteBottleUseView
        noteBottleUseView.layer.cornerRadius = 8
        noteBottleUseView.layer.shadowColor = UIColor.white.cgColor //影の色をbottleUseView
        noteBottleUseView.layer.shadowOpacity = 0.5 //影の色の透明度
        noteBottleUseView.layer.shadowRadius = 8 //影のぼかし
        noteBottleUseView.layer.shadowOffset = CGSize(width: 4, height: 4)
        noteBottleUseView.layer.borderColor = UIColor.black.cgColor
        noteBottleUseView.layer.borderWidth = 0.5
        //noteBottleKeepView
        noteBottleKeepView.layer.cornerRadius = 8
        noteBottleKeepView.layer.shadowColor = UIColor.white.cgColor //影の色を決める
        noteBottleKeepView.layer.shadowOpacity = 0.5 //影の色の透明度
        noteBottleKeepView.layer.shadowRadius = 8 //影のぼかし
        noteBottleKeepView.layer.shadowOffset = CGSize(width: 4, height: 4)
        noteBottleKeepView.layer.borderColor = UIColor.black.cgColor
        noteBottleKeepView.layer.borderWidth = 0.5
        //noteRemainView
        noteRemainFieldView.layer.cornerRadius = 8
        noteRemainFieldView.layer.shadowColor = UIColor.white.cgColor //影の色を決める
        noteRemainFieldView.layer.shadowOpacity = 0.5 //影の色の透明度
        noteRemainFieldView.layer.shadowRadius = 8 //影のぼかし
        noteRemainFieldView.layer.shadowOffset = CGSize(width: 4, height: 4)
        noteRemainFieldView.layer.borderColor = UIColor.black.cgColor
        noteRemainFieldView.layer.borderWidth = 0.5
        //noteMemoTextView
        noteMemoTextView.layer.cornerRadius = 8
        noteMemoTextView.layer.shadowColor = UIColor.white.cgColor //影の色を決める
        noteMemoTextView.layer.shadowOpacity = 0.5 //影の色の透明度
        noteMemoTextView.layer.shadowRadius = 8 //影のぼかし
        noteMemoTextView.layer.shadowOffset = CGSize(width: 4, height: 4)
        noteMemoTextView.layer.borderColor = UIColor.black.cgColor
        noteMemoTextView.layer.borderWidth = 0.5
        
        //noetNumberFieldView
        noteNumberFieldView.layer.cornerRadius = 8
        noteNumberFieldView.layer.shadowColor = UIColor.white.cgColor //影の色を決める
        noteNumberFieldView.layer.shadowOpacity = 0.5 //影の色の透明度
        noteNumberFieldView.layer.shadowRadius = 8 //影のぼかし
        noteNumberFieldView.layer.shadowOffset = CGSize(width: 4, height: 4)
        noteNumberFieldView.layer.borderColor = UIColor.black.cgColor
        noteNumberFieldView.layer.borderWidth = 0.5
        //noteMemoTextView
        noteMemoTextView.layer.cornerRadius = 8
        noteMemoTextView.layer.shadowColor = UIColor.white.cgColor //影の色を決める
        noteMemoTextView.layer.shadowOpacity = 0.5 //影の色の透明度
        noteMemoTextView.layer.shadowRadius = 8 //影のぼかし
        noteMemoTextView.layer.shadowOffset = CGSize(width: 4, height: 4)
        noteMemoTextView.layer.borderColor = UIColor.black.cgColor
        noteMemoTextView.layer.borderWidth = 0.5
        
        updateButton.layer.cornerRadius = 8
        updateButton.layer.shadowColor = UIColor.white.cgColor //影の色を決める
        updateButton.layer.shadowOpacity = 0.5 //影の色の透明度
        updateButton.layer.shadowRadius = 8 //影のぼかし
        updateButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        updateButton.layer.borderColor = UIColor.black.cgColor
        updateButton.layer.borderWidth = 0.5
        
    }
    
    func delegateDataSpurce() {
        //delegate
        noteCustomerNameField.delegate = self
        noteProductNameField.delegate = self
        noteBottleUseYearField.delegate = self
        noteBottleUseMonthField.delegate = self
        noteBottleUseDayField.delegate = self
        noteBottleKeepYearField.delegate = self
        noteBottleKeepMonthField.delegate = self
        noteBottleKeepDayField.delegate = self
        noteMemoTextView.delegate = self
    }
    
    
    
    func gradation() {
        let topColor = UIColor(red:0, green:0, blue:0, alpha:0)
        //グラデーションの開始色
        let bottomColor = UIColor(red:3, green:3, blue:3, alpha:1)
        //グラデーションの色を配列で管理
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        //グラデーションレイヤーを作成
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        //グラデーションの色をレイヤーに割り当てる
        gradientLayer.colors = gradientColors
        //グラデーションレイヤーをスクリーンサイズにする
        gradientLayer.frame = self.contentView.bounds
        //グラデーションレイヤーをビューの一番下に配置
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
