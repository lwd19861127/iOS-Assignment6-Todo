//
//  TodoTableViewCell.swift
//  SimpleTodoApp
//
//  Created by mac on 2020/5/7.
//  Copyright © 2020 Don. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    @IBOutlet var completedSymbol: UILabel!
    @IBOutlet var title: UILabel!
    @IBOutlet var todoDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateUI(with todo: TodoModel) {
        completedSymbol.text = todo.completedSymbol
        title.text = todo.title
        todoDescription.text = todo.todoDescription
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
