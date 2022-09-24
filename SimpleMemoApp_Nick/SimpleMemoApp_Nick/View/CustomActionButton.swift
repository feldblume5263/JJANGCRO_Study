//
//  CustomActionButton.swift
//  SimpleMemoApp_Nick
//
//  Created by Seungyun Kim on 2022/09/25.
//

import UIKit

class CustomActionButton: UIButton {
    
    init(title: String) {
        super.init(frame: CGRect.zero)
        self.setImage(UIImage(systemName: title), for: .normal)
        self.tintColor = .systemYellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
