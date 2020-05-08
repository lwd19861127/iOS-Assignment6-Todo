//
//  addTableViewController.swift
//  SimpleTodoApp
//
//  Created by mac on 2020/5/7.
//  Copyright © 2020 Don. All rights reserved.
//

import UIKit

class addTableViewController: UITableViewController {
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var high: UIButton!
    @IBOutlet var medium: UIButton!
    @IBOutlet var low: UIButton!
    @IBOutlet var save: UIBarButtonItem!
    
    private var priority: Int = 1
    static let unwindSegueId = "saveUnwind"
    var todo: TodoModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let todo = todo {
          // edit
            titleTextField.text = todo.title
            descriptionTextField.text = todo.todoDescription
            priority = todo.priorityNumber
            if priority == 0 {
                high.backgroundColor = .green
            }else if priority == 1 {
                medium.backgroundColor = .green
            }else if priority == 2 {
                low.backgroundColor = .green
            }
        }else {
            //add
            medium.backgroundColor = .green
        }
        validateTextFields()
    }
    
    private func validateTextFields() {
        let title = titleTextField.text ?? ""
        save.isEnabled = !title.isEmpty
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == addTableViewController.unwindSegueId {
        let title = titleTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        todo = TodoModel(title: title, todoDescription: description, completedSymbol: "⭕️", priorityNumber: priority)
      }
    }
    
    @IBAction func setPriority(_ sender: UIButton) {
        if sender.restorationIdentifier == "high" {
            high.backgroundColor = .green
            medium.backgroundColor = .white
            low.backgroundColor = .white
            priority = 0
        } else if sender.restorationIdentifier == "medium" {
            high.backgroundColor = .white
            medium.backgroundColor = .green
            low.backgroundColor = .white
            priority = 1
        }else if sender.restorationIdentifier == "low" {
            high.backgroundColor = .white
            medium.backgroundColor = .white
            low.backgroundColor = .green
            priority = 2
        }
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
      validateTextFields()
    }
    
    @IBAction func returnKeyPressed(_ sender: UITextField) {
      sender.resignFirstResponder()
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
      dismiss(animated: true, completion: nil)
    }
}
