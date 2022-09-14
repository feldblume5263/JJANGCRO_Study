//
//  MemoData.swift
//  SimpleMemoApp_Nick
//
//  Created by Seungyun Kim on 2022/09/15.
//

import Foundation

@objc class MemoData: NSObject {
    var title: String
    var body: String
    var createdDate: Date
    
    init(title: String, body: String, _ createdDate: Date) {
        self.title = title
        self.body = body
        self.createdDate = createdDate
    }
}
