//
//  CustomActionButton.swift
//  SimpleMemoApp_Nick
//
//  Created by Seungyun Kim on 2022/09/25.
//

import UIKit

class CustomActionButton: UIButton {
    
    init(title: String, primaryAction: @escaping (() -> ())) {
        super.init(frame: CGRect.zero)
        let buttonAction = UIAction { _ in
            primaryAction()
        }
        self.setImage(UIImage(systemName: title), for: .normal)
        self.tintColor = .systemYellow
        self.addAction(buttonAction, for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
