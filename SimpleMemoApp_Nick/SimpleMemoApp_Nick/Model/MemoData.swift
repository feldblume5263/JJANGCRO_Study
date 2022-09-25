//
//  MemoData.swift
//  SimpleMemoApp_Nick
//
//  Created by Seungyun Kim on 2022/09/15.
//

import Foundation

@objc class MemoData: NSObject {
    var memoText: String
    var createdDate: Date
    
    init(memoText: String, createdDate: Date) {
        self.memoText = memoText
        self.createdDate = createdDate
    }
}
