//
//  ViewController.swift
//  SimpleMemo_Taek
//
//  Created by 한택환 on 2022/09/07.
//

import UIKit

final class MemoListViewController: UIViewController {
    lazy private var memoList = MemoList()
    private var tableView: UITableView!
    private var observer: NSKeyValueObservation!
    lazy private var memoDatas: [MemoData] = [] {
        willSet {
            tableView.reloadData()
        }
    }
    
    override func loadView() {
        super.loadView()
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setMemoListView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.memoDatas = self.memoList.getMemo()
    }

}

private extension MemoListViewController {
    
    func setNavigationBar() {
        self.navigationItem.title = "메모"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}

private extension MemoListViewController {
    func setMemoListView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MemoTableViewCell.classForCoder(), forCellReuseIdentifier: "memoListCell")
        self.view.addSubview(tableView)
        setMemoListLayout()
        setMemoObserverToTableView()
    }
    
    func setMemoObserverToTableView() {
        observer = self.memoList.observe(\.memoList) { (data, change) in
            self.memoDatas = self.memoList.getMemo()
        }
    }
}

extension MemoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoDatas.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let memoData = memoDatas[indexPath.row]
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "memoListCell") as? MemoTableViewCell ?? UITableViewCell()
        
        (cell as? MemoTableViewCell)?.titleLabel.text = memoData.title
        (cell as? MemoTableViewCell)?.contentLabel.text = memoData.content
        (cell as? MemoTableViewCell)?.dateLabel.text = memoData.date.toStringWithDate()
        return cell
    }
}

extension MemoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

private extension MemoListViewController {
    func setMemoListLayout() {
        print("set")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}

// MARK: - Preview
#if DEBUG
import SwiftUI
struct MemoListVCPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(rootViewController:MemoListViewController()).toPreview()
    }
}
#endif
