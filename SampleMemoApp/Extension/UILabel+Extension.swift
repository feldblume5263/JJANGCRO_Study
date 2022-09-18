//
//  UILabel+Extension.swift
//  SampleMemoApp
//
//  Created by Yoonjae on 2022/09/17.
//

import UIKit

extension UILabel {
    // label에 하이라이트가 적용된 진한 글씨
    func highlight(searchText: String, color: UIColor) {
        guard let text = self.text else { return }
        do {
            let str = NSMutableAttributedString(string: text)
            let regex = try NSRegularExpression(pattern: searchText, options: .caseInsensitive)
            
            for match in regex.matches(in: text, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: text.utf16.count))  as [NSTextCheckingResult] {
                str.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: match.range)
            }
            self.attributedText = str
        } catch {
            print(error)
        }
    }
    
    // label에 하이라이트가 없는 연한 글씨
    func nohightlight(color: UIColor) {
        guard let text = self.text else { return }
        let str = NSMutableAttributedString(string: text)
        str.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSRange(location: 0, length: text.count))
        self.attributedText = str
    }
    
}
