//
//  ViewController.swift
//  SimpleMemoApp_Nick
//
//  Created by Seungyun Kim on 2022/09/15.
//

import UIKit

class MainViewController: UIViewController {

    
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
    
    private let bottomBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 0.3
        return view
    }()
    
    private let itemNumberLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .preferredFont(forTextStyle: .caption2)
        return label
    }()
    
    private lazy var writeMemoButton = CustomActionButton(title: "square.and.pencil") {
        self.touchUpInsideToWriteMemoButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
        configUI()
        setTableView()
    }
    
    @objc
    private func touchUpInsideToWriteMemoButton() {
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MemoView") as? MemoViewController {
            viewController.delegate = self
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    private func render() {
        view.addSubview(tableView)
        tableView.constraint(top: view.topAnchor, leading: view.leadingAnchor,  bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
        view.addSubview(bottomBarView)
        bottomBarView.constraint(leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        bottomBarView.constraint(bottomBarView.heightAnchor, constant: 75)
        
        bottomBarView.addSubview(itemNumberLabel)
        itemNumberLabel.text = "\(memos.count) 개의 메모"
        itemNumberLabel.constraint(top: bottomBarView.topAnchor, centerX: bottomBarView.centerXAnchor, padding: UIEdgeInsets(top: 23, left: 0, bottom: 0, right: 0))
        
        bottomBarView.addSubview(writeMemoButton)
        writeMemoButton.constraint(top: bottomBarView.topAnchor, trailing: bottomBarView.trailingAnchor, padding: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 20))
    }
    
    private func configUI() {
        view.backgroundColor = .systemBackground
        self.navigationItem.title = "메모"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setTableView() {
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
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MemoView") as? MemoViewController {
            viewController.memoTextView.text = """
            \(memos[indexPath.row].title)
            \(memos[indexPath.row].body)
            """
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension MainViewController: MemoDelegate {
    func addMemoAtForm(data: MemoData) {
        
    }
}
