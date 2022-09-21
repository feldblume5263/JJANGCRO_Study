//
//  ViewController.swift
//  SampleMemoApp
//
//  Created by Yoonjae on 2022/09/15.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    // Realm을 시작하기 위한 코드
    let localRealm = try! Realm()
    var tasks: Results<MemoList>!
    var memoContentAll = ""
    var allTasks: Results<MemoList>!
    var searchController:  UISearchController!
    var searchText = ""
    
    // memoTableView 생성
    private let memoTableView: UITableView = {
        let memoTableView = UITableView()
        memoTableView.translatesAutoresizingMaskIntoConstraints = false
        memoTableView.register(MemoTableViewCell.self, forCellReuseIdentifier: MemoTableViewCell.identifier)
        return memoTableView
    }()
    
    // 아래에 툴바 생성
    private let toolbar: UIToolbar = {
        let toolbar = UIToolbar(frame: .init(x: 0, y: 0, width: 100, height: 100))
        var items: [UIBarButtonItem] = []
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let toolbarItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(writeMemoButtonClicked))
        items.append(flexibleSpace)
        items.append(toolbarItem)
        items.forEach{ (item) in
            item.tintColor = .orange
        }
        toolbar.setItems(items, animated: true)
        return toolbar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        memoTableView.dataSource = self
        memoTableView.delegate = self
        view.addSubview(memoTableView)
        addContentView()
        
        // 검색 기능 추가
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "검색"
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        searchController.searchBar.tintColor = .systemOrange
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.searchController = searchController
        
        // 네비게이션 아이템추가
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let memoCount = numberFormatter.string(for: localRealm.objects(MemoList.self).count)!
        navigationItem.title = "\(memoCount)개 Memo"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.hidesSearchBarWhenScrolling = false // 스크롤 할 때 서치부분은 남겨두기
        
        // 뒤로가는 버튼 셋팅
        let backBarButtonItem = UIBarButtonItem(title: "메모", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .systemOrange
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        tasks = localRealm.objects(MemoList.self).sorted(byKeyPath: "memoDate", ascending: false)
    }
    
    // layout lifeCycle은 크게 3가지로 나뉘어 지는데 Update -> layout -> Draw로 이루어져 있습니다.
    // 1.Update : Autolayoyt의 Constraints을 갱신합니다.
    // 2.layout : Update의 Constraints를 기반으로 레이아웃을 실행합니다. 그리고 여기서 view의 center와 bounds를 결정합니다.
    // 3.draw : layout후에 UIView의 drawRect(rect:CGRect)을 호출하게 됩니다. 그리고 이 단계에서 CoreGraphics를 사용하여 그리게 됩니다.
    
    // ViewController에서 layout이 결정되는 과정
    // 1. viewWillLayoutSubviews() 메서드 호출
    // 2. ViewConroller의 Content View가 layoutSubviews()메서드 호출
    // 이때 layoutSubviews()란? : 현재 레이아웃 정보들을 바탕으로 새로운 레이아웃 정보를 계산 -> 뷰 계층구조를 순회하면서 모든 하위 뷰들이 동일한 메서드를 호출합니다.
    // 3. 레이아웃 정보의 변경사항을 뷰들에 반영
    // 4. viewDidLayoutSubviews()메서드를 호출합니다.
    
    // layout subviews 메서드 쓰임
    // 1. viewWillLayoutSubviews() : 뷰가 서브뷰의 배치를 조정하기 직전임을 알려주는 메서드입니다.
    // ex) 뷰들을 추가하거나 제거, 뷰들의 크기나 위치를 업데이트, 레이아웃 constraint를 업데이트, 뷰와 관련된 기타 프로퍼티들을 업데이트할 때 사용합니다.
    // 2. layoutSubviews() : 뷰의 크기에 변경이 발생한다면 우선 하위 뷰들의 autosizing 동작을 적용하는데 변경사항을 반영하기 위하여 layoutSubviews()메서드를 호출 -> 하위 뷰에서도 연쇄적으로 호출이 됩니다.
    // 3. viewDidLayoutSubviews() : 뷰가 서브 뷰의 배치를 다했다는 소식을 뷰 컨트롤러에게 알려줍니다.
    // ex) 다른 뷰들의 content 업데이트, 뷰들의 크기나 위치를 최종적으로 조정, 테이블의 데이터를 reload할 때 사용됩니다.
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        memoTableView.frame = view.bounds
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    @objc func writeMemoButtonClicked(_sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WriteMemoViewController") as! WriteMemoViewController
        vc.backActionHandler = {
            var title = ""
            var content = ""
            if vc.memoTextView.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                return
            }
            else if !vc.memoTextView.text!.contains("\n"){
                title = vc.memoTextView.text!
            }
            // 개행 있을 경우
            else{
                title = String(vc.memoTextView.text!.split(separator: "\n").first!) //첫번째 줄만
                content = String(vc.memoTextView.text!.dropFirst(title.count+1)) // 제목 자르고 넣음
            }
            
            let task = MemoList(memoTitle: title, memoContent: content, memoAll: vc.memoTextView.text, memoDate: Date())
                        
            try! self.localRealm.write {
                self.localRealm.add(task)
                self.memoTableView.reloadData()
                self.viewWillAppear(false) // 타이틀 수정하기 위해서
            }
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

private extension ViewController {
    func addContentView() {
        toolbarSetting()
    }
    
    func toolbarSetting() {
        view.addSubview(toolbar)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toolbar.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 0),
            toolbar.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 0),
            toolbar.trailingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.trailingAnchor, multiplier: 0),
        ])
    }
}

extension ViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        tasks = localRealm.objects(MemoList.self).filter("memoAll CONTAINS '\(searchController.searchBar.text!)'").sorted(byKeyPath: "memoDate", ascending: false)
        searchText = searchController.searchBar.text!
    }
    
    // 검색 버튼을 눌렀을 때 실행
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    // 취소 버튼 눌렀을 때 실행
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        updateSearchResults(for: searchController)
    }
    
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "메모"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableMemoCell = tableView.dequeueReusableCell(withIdentifier: MemoTableViewCell.identifier, for: indexPath) as? MemoTableViewCell else {
            return UITableViewCell()
        }
        
        let row = tasks[indexPath.row]
        
        let format = DateFormatter()
        format.dateFormat = "yyyy. MM. dd. a hh:mm"
        
        //calendar
        let calendarDate = Calendar.current
        //월요일 구하기
        var component = calendarDate.dateComponents([.weekOfYear, .yearForWeekOfYear, .weekday], from: Date())
        component.weekday = 2
        let mondayWeek = calendarDate.date(from: component)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        formatter.locale = Locale(identifier:"ko_KR")
        let tempRegDate = formatter.string(from: row.memoDate)
        
        for i in 0...6{
            let week = calendarDate.date(byAdding: .day , value: i, to: mondayWeek!)
            let weekStr = formatter.string(from: week!)
            
            if tempRegDate == weekStr{
                format.dateFormat = "EEEE"
            }
        }
        
        format.locale = Locale(identifier: "ko_KR")
        let memoDate = format.string(from: row.memoDate)
        
        tableMemoCell.memoTitleLabel.text = row.memoTitle
        tableMemoCell.memoDateLabel.text = memoDate
        tableMemoCell.memoContentLabel.text = row.memoContent
        if isFiltering() && !searchBarIsEmpty() {
            tableMemoCell.memoTitleLabel.highlight(searchText: searchText, color: .systemOrange)
            tableMemoCell.memoContentLabel.highlight(searchText: searchText, color: .systemOrange)
        } else if !isFiltering() {
            tableMemoCell.memoTitleLabel.nohightlight(color: .label)
            tableMemoCell.memoContentLabel.nohightlight(color: .lightGray)
        }
        
        return tableMemoCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WriteMemoViewController") as! WriteMemoViewController
        var taskUpdate = tasks[indexPath.row]
        vc.memoContentAll = taskUpdate.memoAll
        
        vc.backActionHandler = {
            var title = ""
            var content = ""
            
            //공백일 경우
            if vc.memoTextView.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                try! self.localRealm.write{
                    self.localRealm.delete(taskUpdate) // 지우기
                    tableView.reloadData()
                    self.viewWillAppear(false)// 제목 수정하기위해
                }
                return
            }
            //수정했는데 같을 경우
            else if taskUpdate.memoAll == vc.memoTextView.text{
                return
            }
            // 한줄일 경우
            else if !vc.memoTextView.text!.contains("\n"){
                title = vc.memoTextView.text!
            }
            // 개행 있을 경우
            else{
                title = String(vc.memoTextView.text!.split(separator: "\n").first!) //첫번째 줄만
                content = String(vc.memoTextView.text!.dropFirst(title.count+1)) // 제목 자르고 넣음
            }
                        
            try! self.localRealm.write {
                taskUpdate.memoTitle = title
                taskUpdate.memoContent = content
                taskUpdate.memoAll = vc.memoTextView.text
                taskUpdate.memoDate = Date()
            
                self.memoTableView.reloadData()
            }
        }
        
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


