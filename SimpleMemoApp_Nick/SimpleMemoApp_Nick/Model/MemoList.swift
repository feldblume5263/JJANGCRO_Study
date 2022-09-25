//
//  MemoList.swift
//  SimpleMemoApp_Nick
//
//  Created by Seungyun Kim on 2022/09/25.
//

import Foundation

@objc final class MemoList: NSObject {
    @objc dynamic var memoDatas = Set<MemoData>()
    
    override init() {
        memoDatas.insert(MemoData(memoText: "Hi", createdDate: Date()))
        memoDatas.insert(MemoData(memoText: "Hello, I'm Seungyun", createdDate: Date()))
        memoDatas.insert(MemoData(memoText: "This is a memo clone coding project!", createdDate: Date()))
        memoDatas.insert(MemoData(memoText: "merong", createdDate: Date()))
        memoDatas.insert(MemoData(memoText: "wooooooo~~~~~~~~~~", createdDate: Date()))
        memoDatas.insert(MemoData(memoText: "Lovely Weather ☀️", createdDate: Date()))
        memoDatas.insert(MemoData(memoText: "We're going to be amazing developers 🧑🏻‍💻", createdDate: Date()))
        memoDatas.insert(MemoData(memoText: "Hi", createdDate: Date()))
        memoDatas.insert(MemoData(memoText: "Hello, I'm Seungyun", createdDate: Date()))
        memoDatas.insert(MemoData(memoText: "This is a memo clone coding project!", createdDate: Date()))
        memoDatas.insert(MemoData(memoText: "merong", createdDate: Date()))
        memoDatas.insert(MemoData(memoText: "wooooooo~~~~~~~~~~", createdDate: Date()))
        memoDatas.insert(MemoData(memoText: "Lovely Weather ☀️", createdDate: Date()))
        memoDatas.insert(MemoData(memoText: "We're going to be amazing developers 🧑🏻‍💻", createdDate: Date()))
    }
    
    func getMemoDatasByOrder() -> [MemoData] {
        return memoDatas.sorted {
            $0.createdDate < $1.createdDate
        }
    }
    
    func setNewMemoData(memoText: String, createdDate: Date) {
        memoDatas.insert(MemoData(memoText: memoText, createdDate: createdDate))
    }
}
