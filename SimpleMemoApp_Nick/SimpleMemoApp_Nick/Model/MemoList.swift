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
        memoDatas.insert(MemoData(title: "Hi", body: "이것은 바디!!!", createdDate: Date()))
        memoDatas.insert(MemoData(title: "Hello, I'm Seungyun", body: "이것은 바디!!!", createdDate: Date()))
        memoDatas.insert(MemoData(title: "This is a memo clone coding project!", body: "이것은 바디!!!", createdDate: Date()))
        memoDatas.insert(MemoData(title: "merong", body: "이것은 바디!!!", createdDate: Date()))
        memoDatas.insert(MemoData(title: "wooooooo~~~~~~~~~~", body: "이것은 바디!!!", createdDate: Date()))
        memoDatas.insert(MemoData(title: "Lovely Weather ☀️", body: "이것은 바디!!!", createdDate: Date()))
        memoDatas.insert(MemoData(title: "We're going to be amazing developers 🧑🏻‍💻", body: "이것은 바디!!!", createdDate: Date()))
        memoDatas.insert(MemoData(title: "Hi", body: "이것은 바디!!!", createdDate: Date()))
        memoDatas.insert(MemoData(title: "Hello, I'm Seungyun", body: "이것은 바디!!!", createdDate: Date()))
        memoDatas.insert(MemoData(title: "This is a memo clone coding project!", body: "이것은 바디!!!", createdDate: Date()))
        memoDatas.insert(MemoData(title: "merong", body: "이것은 바디!!!", createdDate: Date()))
        memoDatas.insert(MemoData(title: "wooooooo~~~~~~~~~~", body: "이것은 바디!!!", createdDate: Date()))
        memoDatas.insert(MemoData(title: "Lovely Weather ☀️", body: "이것은 바디!!!", createdDate: Date()))
        memoDatas.insert(MemoData(title: "We're going to be amazing developers 🧑🏻‍💻", body: "이것은 바디!!!", createdDate: Date()))
    }
    
    func getMemoDatasByOrder() -> [MemoData] {
        print(memoDatas)
        return memoDatas.sorted {
            $0.createdDate < $1.createdDate
        }
    }
    
    func setNewMemoData(title: String, body: String, createdDate: Date) {
        memoDatas.insert(MemoData(title: title, body: body, createdDate: createdDate))
    }
}
