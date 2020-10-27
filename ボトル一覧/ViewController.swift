//
//  ViewController.swift
//  Bottle
//
//  Created by 有田栄乃祐 on 2020/09/28.
//  Copyright © 2020 artApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UISearchBarDelegate {
    
    @IBOutlet var table: UITableView!
    @IBOutlet var label: UILabel!
    @IBOutlet var navLeftButton: UIBarButtonItem!
    @IBOutlet var search: UISearchBar!
    
    let cellIdentifier = "TableViewCell"
    
    
    private var models: [(title: String, note: String, year: String, month: String, day: String, noteYear: String, noteMonth: String, noteDay: String, memo: String, remain: String, number: String)] = []
    
    private var searchResult: [(title: String, note: String, year: String, month: String, day: String, noteYear: String, noteMonth: String, noteDay: String, memo: String, remain: String, number: String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //検索結果配列にデータをコピーする
        searchResult = models
        self.title = "ボトル一覧"
        //何も入力されなくてもReturnキーを押せるようにする。
        search.enablesReturnKeyAutomatically = false
        
        table.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        table.delegate = self
        table.dataSource = self
        table.layer.cornerRadius = 12
        search.delegate = self
        gradation()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    func searchItems(searchText: String) {
        //要素を検索する
        if searchText != "" {
            searchResult = models.filter { model in
                return true
            } as Array
        } else {
            //渡された文字列が空の場合は全てを表示
            searchResult = models
        }
        //tableViewを再読み込みする
        table.reloadData()
    }
    
    //  検索バーに入力があったら呼ばれる
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            searchResult = models
            table.reloadData()
            return
        }
        searchResult = models.filter({ model -> Bool in
            model.title.lowercased().contains(searchText.lowercased())
        })
        table.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search.text = ""
        view.endEditing(true)
        searchResult = models
        searchItems(searchText: search.text! as String)
        //tableViewを再読み込みする
        table.reloadData()
    }
    
    
    
    @IBAction func didTapNewNote() {
        guard let vc = storyboard?.instantiateViewController(identifier: "new") as? EntryViewController else {
            return
        }
        vc.title = "New Bottle"
        vc.navigationItem.largeTitleDisplayMode = .never
        //修正する
        vc.completion = { noteTitle, note, year, month, day, noteYear, noteMonth, noteDay, memo, remain, number in
            self.navigationController?.popViewController(animated: true)
            //修正する
            self.models.append((title: noteTitle, note: note, year: year, month: month, day: day, noteYear: noteYear, noteMonth: noteMonth, noteDay: noteDay, memo: memo, remain: remain, number: number))
            self.label.isHidden = true
            self.table.isHidden = false
            self.table.reloadData()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // UITableView Delete
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    //remove
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            models.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    //UITableViewCell Move
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        models.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    
    
    @IBAction func didTapSort() {
        if table.isEditing {
            table.isEditing = false
        }
        else {
            table.isEditing = true
        }
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
        gradientLayer.frame = self.view.bounds
        //グラデーションレイヤーをビューの一番下に配置
        self.view.layer.insertSublayer(gradientLayer, at: 1)
    }
    
}




extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        
        let model = models[indexPath.row]
        //show note controller
        guard let vc = storyboard?.instantiateViewController(identifier: "note") as? NoteViewController else {
            return
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = "Bottle"
        vc.noteTitle = model.title
        vc.note = model.note
        vc.year = model.year
        vc.month = model.month
        vc.day = model.day
        vc.noteYear = model.noteYear
        vc.noteMonth = model.noteMonth
        vc.noteDay = model.noteDay
        vc.memo = model.memo
        vc.remain = model.remain
        vc.number = model.number
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    //UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    //TableViewのcellについて
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
        cell.numberLabel?.text = models[indexPath.row].number
        cell.customerLabel?.text = models[indexPath.row].title
        cell.remainLabel?.text = models[indexPath.row].remain
        cell.yearKeepLabel?.text = models[indexPath.row].noteYear
        cell.monthKeepLabel?.text = models[indexPath.row].noteMonth
        cell.dayKeepLabel?.text = models[indexPath.row].noteDay
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 12
        cell.setSelected(true, animated: true)
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    
}


