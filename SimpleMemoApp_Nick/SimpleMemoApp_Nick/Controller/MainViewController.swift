//
//  ViewController.swift
//  SimpleMemoApp_Nick
//
//  Created by Seungyun Kim on 2022/09/15.
//

import UIKit

class MainViewController: UIViewController {

    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private lazy var memoList = MemoList()
    private var currentSortingType: SortingType = .title {
        didSet {
            switch currentSortingType {
            case .title:
                sortingTypeLabel.text = "제목 순"
                memos = memoList.getMemoDatasByOrder(by: self.currentSortingType)
            case .createdDate:
                sortingTypeLabel.text = "생성일 순"
                memos = memoList.getMemoDatasByOrder(by: self.currentSortingType)
            case .random:
                sortingTypeLabel.text = "랜덤"
                memos = memoList.getMemoDatasByOrder(by: self.currentSortingType)
            }
        }
    }
    private var observer: NSKeyValueObservation!
    private lazy var memos: [MemoData] = [] {
        didSet {
            tableView.reloadData()
            itemNumberLabel.text = "\(memos.count) 개의 메모"
        }
    }

    private let sortingTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "제목 순"
        return label
    }()
    
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
    
    private lazy var optionButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"),
                                     style: .plain,
                                     target: self,
                                     action: #selector(touchUpInsideToShowOption))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
        configUI()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        memos = memoList.getMemoDatasByOrder(by: currentSortingType)
    }
    
    @objc
    private func touchUpInsideToShowOption() {
        if self.currentSortingType == .title {
            currentSortingType = .createdDate
        } else if self.currentSortingType == .createdDate {
            currentSortingType = .title
        }
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
        
        bottomBarView.addSubview(sortingTypeLabel)
        sortingTypeLabel.constraint(top: bottomBarView.topAnchor, leading: bottomBarView.leadingAnchor)
    }
    
    private func configUI() {
        view.backgroundColor = .systemBackground
        self.navigationItem.title = "메모"
        self.navigationItem.rightBarButtonItem = optionButton
        self.navigationController?.navigationBar.tintColor = .systemYellow
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setMemoListObserverToDataTableView() {
        observer = memoList.observe(\.memoDatas) { (data, change) in
            print(change)
            self.memos = self.memoList.getMemoDatasByOrder(by: self.currentSortingType)
        }
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MemoTableViewCell.classForCoder(), forCellReuseIdentifier: "dataCell")
        setMemoListObserverToDataTableView()
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
