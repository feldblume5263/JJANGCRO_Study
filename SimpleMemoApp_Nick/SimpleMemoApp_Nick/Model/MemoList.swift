//
//  MemoList.swift
//  SimpleMemoApp_Nick
//
//  Created by Seungyun Kim on 2022/09/25.
//

import Foundation

@objc final class MemoList: NSObject {
    @objc dynamic var memoDatas = Set<MemoData>()
    
    func getMemoDatasByOrder() -> [MemoData] {
        return memoDatas.sorted {
            $0.createdDate < $1.createdDate
        }
    }
    
    func setNewMemoData(title: String, body: String, createdDate: Date) {
        memoDatas.insert(MemoData(title: title, body: body, createdDate: createdDate))
    }
}
