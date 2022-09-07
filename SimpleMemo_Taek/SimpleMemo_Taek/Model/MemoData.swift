//
//  MemoData.swift
//  SimpleMemo_Taek
//
//  Created by 한택환 on 2022/09/07.
//

import Foundation

@objc class MemoData: NSObject {
    var date: Date
    var title: String
    var content: String?
    
    init(date: Date, title: String, _ content: String?) {
        self.date = date
        self.title = title
        self.content = content
    }
}
