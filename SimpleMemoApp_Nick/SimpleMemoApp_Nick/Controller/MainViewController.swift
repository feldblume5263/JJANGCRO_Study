//
//  ViewController.swift
//  SimpleMemoApp_Nick
//
//  Created by Seungyun Kim on 2022/09/15.
//

import UIKit

class MainViewController: UIViewController {

    private lazy var memoList = MemoList()
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private lazy var memos: [MemoData] = [] {
        didSet {
            tableView.reloadData()
            itemNumberLabel.text = "\(memos.count) 개의 메모"
        }
    }
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        memos = memoList.getMemoDatasByOrder()
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
        
        var tempMemo = memos[indexPath.row].memoText.components(separatedBy: "\n")
        
        while tempMemo.first == "" {
            tempMemo.remove(at: 0)
        }
        
        var title: String = "새로운 메모"
        var body: String = "추가 텍스트 없음"
        if !tempMemo.isEmpty {
            title = tempMemo[0]
        }
        
        tempMemo.remove(at: 0)
        
        if !tempMemo.isEmpty {
            while tempMemo.first == "" {
                tempMemo.remove(at: 0)
            }
            body = tempMemo[0]
        }
        
        cell.titleLabel.text = title
        cell.bodyLabel.text = body
        cell.createdDate.text = createdDate
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MemoView") as? MemoViewController {
            viewController.memoTextView.text = "\(memos[indexPath.row].memoText)"
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension MainViewController: MemoDelegate {
    func addMemoAtForm(data: MemoData) {
        memoList.setNewMemoData(memoText: data.memoText, createdDate: data.createdDate)
    }
}
