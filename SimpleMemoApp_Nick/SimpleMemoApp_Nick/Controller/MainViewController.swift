//
//  ViewController.swift
//  SimpleMemoApp_Nick
//
//  Created by Seungyun Kim on 2022/09/15.
//

import UIKit

class MainViewController: UIViewController {

    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width - 64)/3, height: 120)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    private lazy var memoList = MemoList()
    
    private var currentViewType: LayoutType = .collection {
        didSet {
            render()
        }
    }
    
    private var currentSortingType: SortingType = .title {
        didSet {
            switch currentSortingType {
            case .title:
                memos = memoList.getMemoDatasByOrder(by: self.currentSortingType)
            case .createdDate:
                memos = memoList.getMemoDatasByOrder(by: self.currentSortingType)
            case .random:
                memos = memoList.getMemoDatasByOrder(by: self.currentSortingType)
            }
        }
    }
    private var observer: NSKeyValueObservation!
    private lazy var memos: [MemoData] = [] {
        didSet {
            tableView.reloadData()
            collectionView.reloadData()
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
    
    private lazy var optionButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"),
                                     style: .plain,
                                     target: self,
                                     action: nil)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
        configUI()
        configView()
        setOptionButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        memos = memoList.getMemoDatasByOrder(by: currentSortingType)
    }
    
    private func touchUpInsideToShowOption(type: SortingType) {
        currentSortingType = type
    }
    
    private func touchUpInsideToChangeLayoutType() {
        if currentViewType == .table {
            currentViewType = .collection
//            self.setLayoutType.title = "갤러리로 보기"
//            self.setLayoutType.image = UIImage(systemName: "square.grid.2x2")
        } else {
            currentViewType = .table
//            self.setLayoutType.title = "목록으로 보기"
//            self.setLayoutType.image = UIImage(systemName: "list.bullet")
        }
    }
    
    private lazy var setLayoutType = UIAction(title: "갤러리로 보기", image: UIImage(systemName: "square.grid.2x2"), handler: { _ in self.touchUpInsideToChangeLayoutType() })
    private lazy var sortByTitle = UIAction(title: "제목 순", image: UIImage(systemName: "t.square"), handler: { _ in self.touchUpInsideToShowOption(type: .title)})
    private lazy var sortByCreatedDate = UIAction(title: "생성일 순", image: UIImage(systemName: "calendar"), handler: { _ in self.touchUpInsideToShowOption(type: .createdDate) })
    private lazy var sortByRandom = UIAction(title: "랜덤 순", image: UIImage(systemName: "questionmark.circle"), handler: { _ in self.touchUpInsideToShowOption(type: .random) })
    
    private func setOptionButton () {
        optionButton.menu = UIMenu(title: "", options: .displayInline, children: [setLayoutType, sortByTitle, sortByCreatedDate, sortByRandom])
    }
    
    @objc
    private func touchUpInsideToWriteMemoButton() {
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MemoView") as? MemoViewController {
            viewController.delegate = self
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    private func render() {
        if currentViewType == .table {
            view.addSubview(tableView)
            tableView.constraint(top: view.topAnchor, leading: view.leadingAnchor,  bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        } else {
            view.addSubview(collectionView)
            collectionView.constraint(top: view.topAnchor, leading: view.leadingAnchor,  bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
        }
        
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
    
    private func configView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MemoTableViewCell.self, forCellReuseIdentifier: "MemoTableViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MemoCollectionViewCell.self, forCellWithReuseIdentifier: "MemoCollectionViewCell")
        setMemoListObserverToDataTableView()
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MemoTableViewCell", for: indexPath) as? MemoTableViewCell else { return UITableViewCell() }
        
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

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemoCollectionViewCell", for: indexPath) as? MemoCollectionViewCell else { return UICollectionViewCell() }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "MM/dd/yy"
        
        let createdDate = dateFormatter.string(from: memos[indexPath.row].createdDate)
        
        var tempMemo = memos[indexPath.row].memoText.components(separatedBy: "\n")
        
        while tempMemo.first == "" {
            tempMemo.remove(at: 0)
        }
        
        var title: String = "새로운 메모"
        if !tempMemo.isEmpty {
            title = tempMemo[0]
        }
        
        cell.titleLabel.text = title
        cell.createdDate.text = createdDate
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {
    
}


extension MainViewController: MemoDelegate {
    func addMemoAtForm(data: MemoData) {
        memoList.setNewMemoData(memoText: data.memoText, createdDate: data.createdDate)
    }
}
