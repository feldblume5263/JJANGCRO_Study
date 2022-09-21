//
//  WriteMemoVC.swift
//  SampleMemoApp
//
//  Created by Yoonjae on 2022/09/17.
//

import UIKit
import RealmSwift

class WriteMemoViewController: UIViewController, UITextViewDelegate {
    // Realm을 시작하기 위한 코드
    let localRealm = try! Realm()
    var tasks: Results<MemoList>!
    var memoContentAll = ""
    
    // 뒤로 가면 자동 저장하기 위한 handler
    var backActionHandler: (() -> ())?
    
    // 글을 적기 위한 텍스트뷰 셋팅
    var memoTextView: UITextView = {
        let view = UITextView()
        view.textInputView.backgroundColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memoTextView.delegate = self
        memoTextView.text = memoContentAll
        self.navigationController?.navigationBar.prefersLargeTitles = false
        addContent()
        
        // 메모 저장 버튼 추가
        var items: [UIBarButtonItem] = []
        let saveItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        items.append(saveItem)
        items.forEach{ (item) in
            item.tintColor = .orange
        }
        navigationItem.rightBarButtonItems = items
        self.navigationController?.navigationBar.tintColor = .orange
    }
    
    // UITextView에서 키보드를 올리는 액션을 취하기 위해서 becomeFirstResponder() 메소드를 추가합니다.
    override func viewDidAppear(_ animated: Bool) {
        self.memoTextView.becomeFirstResponder()
    }
    
    // 뒤로 가면 현재 작성된 메모 저장
    override func viewDidDisappear(_ animated: Bool) {
        backActionHandler?()
    }
    
    // 메모 파일 저장
    func saveTextFile() {
        let filename = getDocumentsDirectory().appendingPathComponent("memo.txt")
        do {
            try memoTextView.text!.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("error")
        }
    }
    
    // 도큐먼트 폴더 위치
    func documentDirectoryPath() -> String?{
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        if let directoryPath = path.first{
            return directoryPath
        } else {
            return nil
        }
    }
    
    func presentActivityViewController() {
        let fileName = (documentDirectoryPath()! as NSString).appendingPathComponent("memo.txt")
        let fileURL = URL(fileURLWithPath: fileName)
        let vc = UIActivityViewController(activityItems: [fileURL], applicationActivities: [])
        self.present(vc, animated: true, completion: nil)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    @objc func saveButtonClicked() {
        self.navigationController?.popViewController(animated: true)
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
