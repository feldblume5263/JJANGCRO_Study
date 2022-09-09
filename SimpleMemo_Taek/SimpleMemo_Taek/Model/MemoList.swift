//
//  MemoList.swift
//  SimpleMemo_Taek
//
//  Created by 한택환 on 2022/09/09.
//

import UIKit

@objc final class MemoList: NSObject {
    @objc dynamic var memoList = Set<MemoData>()
    
    override init() {
        memoList.insert(MemoData(date: Date(), title: "메모1", "내용1"))
        memoList.insert(MemoData(date: Date(), title: "메모2", "내용2"))
        memoList.insert(MemoData(date: Date(), title: "메모3", "내용3"))
        memoList.insert(MemoData(date: Date(), title: "메모4", "내용4"))
        memoList.insert(MemoData(date: Date(), title: "메모5", "내용5"))
    }
    
    func addNewMemo(date: Date, title: String, content: String?) {
        memoList.insert(MemoData(date: date, title: title, content))
    }
}
