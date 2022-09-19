//
//  ViewController.swift
//  SimpleMemoApp_Nick
//
//  Created by Seungyun Kim on 2022/09/15.
//

import UIKit

class MainViewController: BaseViewController {

    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    var memos: [MemoData] = [
        MemoData(title: "Hi", body: "이것은 바디!!!", createdDate: Date()),
        MemoData(title: "Hello, I'm Seungyun", body: "이것은 바디!!!", createdDate: Date()),
        MemoData(title: "This is a memo clone coding project!", body: "이것은 바디!!!", createdDate: Date()),
        MemoData(title: "merong", body: "이것은 바디!!!", createdDate: Date()),
        MemoData(title: "wooooooo~~~~~~~~~~", body: "이것은 바디!!!", createdDate: Date()),
        MemoData(title: "Lovely Weather ☀️", body: "이것은 바디!!!", createdDate: Date()),
        MemoData(title: "We're going to be amazing developers 🧑🏻‍💻", body: "이것은 바디!!!", createdDate: Date()),
        MemoData(title: "Hi", body: "이것은 바디!!!", createdDate: Date()),
        MemoData(title: "Hello, I'm Seungyun", body: "이것은 바디!!!", createdDate: Date()),
        MemoData(title: "This is a memo clone coding project!", body: "이것은 바디!!!", createdDate: Date()),
        MemoData(title: "merong", body: "이것은 바디!!!", createdDate: Date()),
        MemoData(title: "wooooooo~~~~~~~~~~", body: "이것은 바디!!!", createdDate: Date()),
        MemoData(title: "Lovely Weather ☀️", body: "이것은 바디!!!", createdDate: Date()),
        MemoData(title: "We're going to be amazing developers 🧑🏻‍💻", body: "이것은 바디!!!", createdDate: Date()),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    override func render() {
        view.addSubview(tableView)
        tableView.constraint(top: view.topAnchor, leading: view.leadingAnchor,  bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
//        view.addSubview(bottomView)
    }
    
    override func configUI() {
        view.backgroundColor = .systemBackground
        self.navigationItem.title = "메모"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MemoTableViewCell.classForCoder(), forCellReuseIdentifier: "dataCell")
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        memos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath) as? MemoTableViewCell else { return UITableViewCell() }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "MM/dd/yy"
        
        let createdDate = dateFormatter.string(from: memos[indexPath.row].createdDate)
        
        cell.titleLabel.text = memos[indexPath.row].title
        cell.bodyLabel.text = memos[indexPath.row].body
        cell.createdDate.text = createdDate
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MemoView") as? MemoViewController {
//            print("HI")
//            self.navigationController?.pushViewController(viewController, animated: true)
//        }
    }
}
