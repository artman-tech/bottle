//
//  EntryViewController.swift
//  Bottle
//
//  Created by 有田栄乃祐 on 2021/3/8
//  Copyright © 2020 artApps. All rights reserved.
//

import UIKit


class EntryViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet var scrollView: UIScrollView!
    //お客様氏名
    @IBOutlet var customerView: UIView!
    @IBOutlet var customerNameField: UITextField!
    //ボトル名
    @IBOutlet var productView: UIView!
    @IBOutlet var productNameField: UITextField!
    //ボトル利用日
    @IBOutlet var bottleUseView: UIView!
    @IBOutlet var bottleUseYearField: UITextField!
    @IBOutlet var bottleUseMonthField: UITextField!
    @IBOutlet var bottleUseDayField: UITextField!
    //キープ期限日
    @IBOutlet var keepLimitedView: UIView!
    @IBOutlet var keepLimitedYearField: UITextField!
    @IBOutlet var keepLimitedMonthField: UITextField!
    @IBOutlet var keepLimitedDayField: UITextField!
    //メモ欄
    @IBOutlet var memoTextView: UITextView!
    @IBOutlet var memoView: UIView!
    
    @IBOutlet var remainField: UITextField!
    @IBOutlet var remainFieldView: UIView!
    
    @IBOutlet var numberField: UITextField!
    @IBOutlet var numberFieldView: UIView!
    
    @IBOutlet var addButton: UIButton!
    
    // 入力可能な最大文字数
    let maxLength: Int = 4
    let minLength: Int = 2
    
    let picker =  UIPickerView()
    
    let remain = ["75~100%", "50~75%", "25~50%", "~25%", "残量なし"]
    
    
    public var completion: ((String, String, String, String, String, String, String, String, String, String, String) -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegateDataSource()
        viewLayer()
        createDatePicker()
        notificationAddObserver()
        textFieldKeyboardType()
        gradation()
        customerNameField.becomeFirstResponder()
        productNameField.becomeFirstResponder()
        
        // ナビゲーションバーのアイテムの色　（戻る　＜　とか　読み込みゲージとか）
        self.navigationController?.navigationBar.tintColor = .white
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    
    func textFieldKeyboardType() {
        numberField.keyboardType = .numberPad
        bottleUseYearField.keyboardType = .numberPad
        bottleUseMonthField.keyboardType = .numberPad
        bottleUseDayField.keyboardType = .numberPad
        keepLimitedYearField.keyboardType = .numberPad
        keepLimitedMonthField.keyboardType = .numberPad
        keepLimitedDayField.keyboardType = .numberPad
    }
    
    func notificationAddObserver() {
        // myTextFieldの入力チェック(文字数チェック)をオブザーバ登録
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textFieldDidMaxChange(notification:)),
                                               name: UITextField.textDidChangeNotification,
                                               object: bottleUseYearField)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textFieldDidMinChange(notification:)),
                                               name: UITextField.textDidChangeNotification,
                                               object: bottleUseMonthField)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textFieldDidMinChange(notification:)),
                                               name: UITextField.textDidChangeNotification,
                                               object: bottleUseDayField)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textFieldDidMaxChange(notification:)),
                                               name: UITextField.textDidChangeNotification,
                                               object: keepLimitedYearField)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textFieldDidMinChange(notification:)),
                                               name: UITextField.textDidChangeNotification,
                                               object: keepLimitedMonthField)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textFieldDidMinChange(notification:)),
                                               name: UITextField.textDidChangeNotification,
                                               object: keepLimitedDayField)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textFieldDidMinChange(notification:)),
                                               name: UITextField.textDidChangeNotification,
                                               object: numberField)
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
        return remain.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return remain[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        remainField.text = remain[row]
        remainField.resignFirstResponder()
    }
    
    
    
    
    
    @IBAction func didTapAdd() {
        
//        let model = models()
//        model.title = customerNameField.text!
//        model.note = productNameField.text!
//        model.year = bottleUseYearField.text!
//        model.month = bottleUseMonthField.text!
//        model.day = bottleUseDayField.text!
//        model.noteYear = keepLimitedYearField.text!
//        model.noteMonth = keepLimitedMonthField.text!
//        model.noteDay = keepLimitedDayField.text!
//        model.memo = memoTextView.text!
//        model.number = numberField.text!
//        model.remain = remainField.text!
//
//        let realm = try! Realm()
        
        if let text = customerNameField.text,
            let productText = productNameField.text,
            let useYearText = bottleUseYearField.text,
            let useMonthText = bottleUseMonthField.text,
            let useDayText = bottleUseDayField.text,
            let keepYearText = keepLimitedYearField.text,
            let keepMonthText = keepLimitedMonthField.text,
            let keepDayText = keepLimitedDayField.text,
            let memoText = memoTextView.text,
            let remainText = remainField.text,
            let numberText = numberField.text,
            !text.isEmpty, !productText.isEmpty, !useYearText.isEmpty, !useMonthText.isEmpty, !useDayText.isEmpty, !keepYearText.isEmpty, !keepMonthText.isEmpty, !keepDayText.isEmpty, !remainText.isEmpty {
            completion?(text, productText, useYearText, useMonthText, useDayText, keepYearText, keepMonthText, keepDayText, memoText, remainText, numberText)
        } else {
            showAleet()
        }
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        customerNameField.text = textField.text
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
        self.view.endEditing(true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func gradation() {
        let gradientLayer = CAGradientLayer.layerForView()
        // gradientLayerは生成されただけだとまだフレームサイズが決まってなくてx:0, y:0 ,height:0 ,width: 0 のままなのでinsertSublayerしても表示されないためフレームを決めてあげる必要がある
        gradientLayer.frame = self.contentView.frame
        // layerのsublayersno0番目にgradientLayerを差し込む
        self.contentView.layer.insertSublayer(gradientLayer, at: 0)
    }
    

    
    func delegateDataSource() {
        customerNameField.delegate = self
        productNameField.delegate = self
        bottleUseYearField.delegate = self
        bottleUseMonthField.delegate = self
        bottleUseDayField.delegate = self
        keepLimitedYearField.delegate = self
        keepLimitedMonthField.delegate = self
        keepLimitedDayField.delegate = self
        numberField.delegate = self
        remainField.delegate = self
        memoTextView.delegate = self
    }
    
    
    
    func showAleet() {
        let alert = UIAlertController(title: "空の項目があります", message: "項目を埋めてください", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "了解", style: .default, handler: nil))
        present(alert,animated: true)
    }
    
    
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        remainField.inputView = picker
        picker.delegate = self
        picker.dataSource = self
        
        let doneBtn = UIBarButtonItem(title: "完了",
                                      style: .done,
                                      target: self,
                                      action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        bottleUseYearField.inputAccessoryView = toolbar
        bottleUseYearField.textAlignment = .center
        bottleUseMonthField.inputAccessoryView = toolbar
        bottleUseMonthField.textAlignment = .center
        bottleUseDayField.inputAccessoryView = toolbar
        bottleUseDayField.textAlignment = .center
        keepLimitedYearField.inputAccessoryView = toolbar
        keepLimitedYearField.textAlignment = .center
        keepLimitedMonthField.inputAccessoryView = toolbar
        keepLimitedMonthField.textAlignment = .center
        keepLimitedDayField.inputAccessoryView = toolbar
        keepLimitedDayField.textAlignment = .center
        numberField.inputAccessoryView = toolbar
        numberField.textAlignment = .center
        remainField.inputAccessoryView = toolbar
        remainField.textAlignment = .center
        memoTextView.inputAccessoryView = toolbar
        
    }
    @objc func donePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "jp_JP")
        formatter.dateStyle = DateFormatter.Style.medium
        self.view.endEditing(true)
    }
    
    func viewLayer() {
        //CustomerView
        customerView.layer.cornerRadius = 8
        customerView.layer.shadowColor = UIColor.darkGray.cgColor
        customerView.layer.shadowOpacity = 1
        customerView.layer.shadowRadius = 8
        customerView.layer.shadowOffset = CGSize(width: 4, height: 4)
        customerView.layer.borderColor = UIColor.black.cgColor
        customerView.layer.borderWidth = 0.5
        //ProductView
        productView.layer.cornerRadius = 8
        productView.layer.shadowColor = UIColor.darkGray.cgColor
        productView.layer.shadowOpacity = 1
        productView.layer.shadowRadius = 8
        productView.layer.shadowOffset = CGSize(width: 4, height: 4)
        productView.layer.borderColor = UIColor.black.cgColor
        productView.layer.borderWidth = 0.5
        //bottleUseView
        bottleUseView.layer.cornerRadius = 8
        bottleUseView.layer.shadowColor = UIColor.darkGray.cgColor
        bottleUseView.layer.shadowOpacity = 1
        bottleUseView.layer.shadowRadius = 8
        bottleUseView.layer.shadowOffset = CGSize(width: 4, height: 4)
        bottleUseView.layer.borderColor = UIColor.black.cgColor
        bottleUseView.layer.borderWidth = 0.5
        //keepLimitedView
        keepLimitedView.layer.cornerRadius = 8
        keepLimitedView.layer.shadowColor = UIColor.darkGray.cgColor
        keepLimitedView.layer.shadowOpacity = 1
        keepLimitedView.layer.shadowRadius = 8
        keepLimitedView.layer.shadowOffset = CGSize(width: 4, height: 4)
        keepLimitedView.layer.borderColor = UIColor.black.cgColor
        keepLimitedView.layer.borderWidth = 0.5
        //remainView
        remainFieldView.layer.cornerRadius = 8
        remainFieldView.layer.shadowColor = UIColor.darkGray.cgColor
        remainFieldView.layer.shadowOpacity = 1
        remainFieldView.layer.shadowRadius = 8
        remainFieldView.layer.shadowOffset = CGSize(width: 4, height: 4)
        remainFieldView.layer.borderColor = UIColor.black.cgColor
        remainFieldView.layer.borderWidth = 0.5
        //numberFieldView
        numberFieldView.layer.cornerRadius = 8
        numberFieldView.layer.shadowColor = UIColor.darkGray.cgColor
        numberFieldView.layer.shadowOpacity = 1
        numberFieldView.layer.shadowRadius = 8
        numberFieldView.layer.shadowOffset = CGSize(width: 4, height: 4)
        numberFieldView.layer.borderColor = UIColor.black.cgColor
        numberFieldView.layer.borderWidth = 0.5
        //memoTextView
        memoTextView.layer.cornerRadius = 8
        memoTextView.layer.shadowColor = UIColor.darkGray.cgColor
        memoTextView.layer.shadowOpacity = 1
        memoTextView.layer.shadowRadius = 8
        memoTextView.layer.shadowOffset = CGSize(width: 4, height: 4)
        memoTextView.layer.borderColor = UIColor.black.cgColor
        memoTextView.layer.borderWidth = 0.5
        //addButton
        addButton.layer.cornerRadius = 8
        addButton.layer.shadowColor = UIColor.darkGray.cgColor
        addButton.layer.shadowOpacity = 1
        addButton.layer.shadowRadius = 8
        addButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        addButton.layer.borderColor = UIColor.black.cgColor
        addButton.layer.borderWidth = 0.5
        
    }

}


