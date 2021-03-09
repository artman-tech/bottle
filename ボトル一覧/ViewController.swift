//
//  ViewController.swift
//  Bottle
//
//  Created by 有田栄乃祐 on 2021/3/1.
//  Copyright © 2020 artApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet var table: UITableView!
    @IBOutlet var label: UILabel!
    @IBOutlet var navLeftButton: UIBarButtonItem!
    @IBOutlet var search: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    
    let cellIdentifier = "TableViewCell"
    
    private var models: [(title: String, note: String, year: String, month: String, day: String, noteYear: String, noteMonth: String, noteDay: String, memo: String, remain: String, number: String)] = []
    
    private var searchResult: [(title: String, note: String, year: String, month: String, day: String, noteYear: String, noteMonth: String, noteDay: String, memo: String, remain: String, number: String)] = []

    
    @IBAction func selectedSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            searchResult = models
        default:
            break
        }
        table.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedSegmentTintColor = .lightGray
        
        searchResult = models
        self.title = "ボトル一覧"
        search.enablesReturnKeyAutomatically = false
        search.resignFirstResponder()
        search.placeholder = "ボトル名またはお客様氏名を入力してください"
        
        let searchBartextField = search.value(forKey: "searchField") as? UITextField
        searchBartextField?.textColor = .white
        searchBartextField?.font = searchBartextField?.font?.withSize(16)
        
        // 特定済みのUITextFieldからPlaceholderを特定する
        let searchBarPlaceholderLabel = searchBartextField?.value(forKey: "placeholderLabel") as? UILabel
        // 11サイズのシステムフォントに変更する
        searchBarPlaceholderLabel?.font = .systemFont(ofSize: 11)
        // 自動で小さくする可変文字サイズにする場合の例
        searchBarPlaceholderLabel?.adjustsFontSizeToFitWidth = true
        searchBarPlaceholderLabel?.minimumScaleFactor = 0.8  // 最小サイズ
        
        
        table.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        table.delegate = self
        table.dataSource = self
        table.layer.cornerRadius = 12
        search.delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    

    // キャンセルボタンが押されると呼ばれる
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        view.endEditing(true)
        searchResult = models
        //tableViewを再読み込みする
        table.reloadData()
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

//      検索バーに入力があったら呼ばれる
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
        
        let segmentIndex = segmentedControl.selectedSegmentIndex
        switch segmentIndex {
            
        case 0:
            cell.numberLabel?.text = models[indexPath.row].number
            cell.customerLabel?.text = models[indexPath.row].title
            cell.remainLabel?.text = models[indexPath.row].remain
            cell.yearKeepLabel?.text = models[indexPath.row].noteYear
            cell.monthKeepLabel?.text = models[indexPath.row].noteMonth
            cell.dayKeepLabel?.text = models[indexPath.row].noteDay
            cell.backgroundColor = .white
            cell.layer.cornerRadius = 12
            cell.setSelected(true, animated: true)
            break
            
        case 1:
            break
            
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    
}


