//
//  MemoViewController.swift
//  SimpleMemoApp_Nick
//
//  Created by Seungyun Kim on 2022/09/19.
//

import UIKit

class MemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        render()
        configUI()
    }
    
    func render() {
        
    }
    
    func configUI() {
        self.navigationController?.navigationBar.tintColor = .systemYellow
    }
}
