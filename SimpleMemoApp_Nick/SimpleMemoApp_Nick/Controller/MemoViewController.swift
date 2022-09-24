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
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let makeCheckListButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checklist"), for: .normal)
        button.tintColor = .systemYellow
        return button
    }()
    
    private let addPhotoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "camera"), for: UIControl.State.normal)
        button.tintColor = .systemYellow
        return button
    }()
    
    private let showPencilKitButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil.tip.crop.circle"), for: UIControl.State.normal)
        button.tintColor = .systemYellow
        return button
    }()
    
    private let writeMemoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.pencil"), for: UIControl.State.normal)
        button.tintColor = .systemYellow
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
        configUI()
    }
    
    private func render() {
        
        view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(makeCheckListButton)
        buttonStackView.addArrangedSubview(addPhotoButton)
        buttonStackView.addArrangedSubview(showPencilKitButton)
        buttonStackView.addArrangedSubview(writeMemoButton)
        buttonStackView.constraint(leading: view.leadingAnchor,
                                   bottom: view.bottomAnchor,
                                   trailing: view.trailingAnchor)
        buttonStackView.constraint(buttonStackView.heightAnchor, constant: 100)
        
        view.addSubview(memoTextView)
        memoTextView.constraint(top: view.safeAreaLayoutGuide.topAnchor,
                                leading: view.safeAreaLayoutGuide.leadingAnchor,
                                bottom: makeCheckListButton.topAnchor,
                                trailing: view.safeAreaLayoutGuide.trailingAnchor,
                                padding: UIEdgeInsets(top: 0, left: 24, bottom: 50, right: 24))
        
    }
    
    private func configUI() {
        self.navigationController?.navigationBar.tintColor = .systemYellow
    }
}
