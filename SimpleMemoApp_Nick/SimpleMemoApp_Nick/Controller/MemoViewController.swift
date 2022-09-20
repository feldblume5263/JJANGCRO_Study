//
//  MemoViewController.swift
//  SimpleMemoApp_Nick
//
//  Created by Seungyun Kim on 2022/09/19.
//

import UIKit

class MemoViewController: UIViewController {

    let memoTextView: UITextView = {
        let textView = UITextView()
        textView.font = .preferredFont(forTextStyle: .body)
        textView.tintColor = .systemYellow
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
        configUI()
    }
    
    private func render() {
        view.addSubview(memoTextView)
        memoTextView.constraint(top: view.safeAreaLayoutGuide.topAnchor,
                                leading: view.safeAreaLayoutGuide.leadingAnchor,
                                bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                trailing: view.safeAreaLayoutGuide.trailingAnchor,
                                padding: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24))
    }
    
    private func configUI() {
        self.navigationController?.navigationBar.tintColor = .systemYellow
    }
}
