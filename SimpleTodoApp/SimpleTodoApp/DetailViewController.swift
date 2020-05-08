//
//  DetailViewController.swift
//  SimpleTodoApp
//
//  Created by mac on 2020/5/7.
//  Copyright © 2020 Don. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var titleLable: UILabel!
    @IBOutlet var detailLable: UILabel!
    
    var todo: TodoModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateUI(todo?.title ?? "", todo?.todoDescription ?? "")
    }
    
    fileprivate func updateUI(_ title: String, _ detail: String) {
        titleLable.text = title
        detailLable.text = detail
    }
}
