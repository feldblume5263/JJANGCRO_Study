//
//  ViewController.swift
//  SimpleMemoApp_Nick
//
//  Created by Seungyun Kim on 2022/09/15.
//

import UIKit

class MainViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func render() {
        view.backgroundColor = .systemBackground
    }
    
    override func configUI() {
        self.navigationItem.title = "메모"
        navigationController?.navigationBar.prefersLargeTitles = true
    }


}

