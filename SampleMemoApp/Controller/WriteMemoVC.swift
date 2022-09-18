//
//  WriteMemoVC.swift
//  SampleMemoApp
//
//  Created by Yoonjae on 2022/09/17.
//

import UIKit
import RealmSwift

class WriteMemoViewController: UIViewController {
    // Realm을 시작하기 위한 코드
    let localRealm = try! Realm()
    var tasks: Results<MemoList>!
    var memoContentAll = ""
    
    // 글을 적기 위한 텍스트뷰 셋팅
    private var memoTextView: UITextView = {
        let view = UITextView()
        view.textInputView.backgroundColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        addContent()
    }
}

private extension WriteMemoViewController {
    func addContent() {
        addTextView()
    }
    
    func addTextView() {
        self.view.addSubview(self.memoTextView)
        self.memoTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            memoTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12),
            memoTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12),
            memoTextView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10),
            memoTextView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10)
        ])
    }
}
