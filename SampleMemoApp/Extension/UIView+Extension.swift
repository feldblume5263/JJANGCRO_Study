//
//  UIView+Extension.swift
//  SampleMemoApp
//
//  Created by Yoonjae on 2022/09/17.
//

import Foundation
import UIKit

extension UIView {
    // 원하는 위치 라운드주기
    func roundCorners(cornRadius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
}
