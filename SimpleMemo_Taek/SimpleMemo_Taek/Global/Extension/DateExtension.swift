//
//  DateExtension.swift
//  SimpleMemo_Taek
//
//  Created by 한택환 on 2022/09/09.
//

import Foundation


extension Date {
    func toStringWithDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd."
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: self)
    }
}
