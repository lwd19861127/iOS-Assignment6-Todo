//
//  TodoTableViewController.swift
//  SimpleTodoApp
//
//  Created by mac on 2020/5/7.
//  Copyright © 2020 Don. All rights reserved.
//

import UIKit

class TodoTableViewController: UITableViewController {

    private let cellId = "TodoCell"
    private var trailingSwipeEditIndexPath:IndexPath? = nil
    
    private var highLists: [TodoModel] = [
        TodoModel(title: "Shoot vedio", todoDescription: "Calvin's homework", completedSymbol: "⭕️", priorityNumber: 0)
        ]
    private var mediumLists: [TodoModel] = [
        TodoModel(title: "Goto Hospitol", todoDescription: "Madison's blood check", completedSymbol: "⭕️", priorityNumber: 1)
        ]
    private var lowLists: [TodoModel] = [
        TodoModel(title: "Homework", todoDescription: "Wenda's homework", completedSymbol: "✅", priorityNumber: 2)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var todo: TodoModel!
        if segue.identifier == "detail" {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                switch selectedIndexPath.section {
                case 0:
                    todo = highLists[selectedIndexPath.row]
                case 1:
                    todo = mediumLists[selectedIndexPath.row]
                case 2:
                    todo = lowLists[selectedIndexPath.row]
                default:
                    todo = TodoModel(title: "", todoDescription: "", completedSymbol: "", priorityNumber: 1)
                }
            }
            let detailVC = segue.destination as! DetailViewController
            detailVC.todo = todo
        }
        if segue.identifier == "edit" {
            if let selectedIndexPath = trailingSwipeEditIndexPath{
                switch selectedIndexPath.section {
                case 0:
                    todo = highLists[selectedIndexPath.row]
                case 1:
                    todo = mediumLists[selectedIndexPath.row]
                case 2:
                    todo = lowLists[selectedIndexPath.row]
                default:
                    todo = TodoModel(title: "", todoDescription: "", completedSymbol: "", priorityNumber: 1)
                }
            }
            let navController = segue.destination as! UINavigationController
            let editVC = navController.topViewController as! addTableViewController
            editVC.todo = todo
        }
    }
    
    @IBAction func unwindTodoTableView(segue: UIStoryboardSegue) {
        if segue.identifier == addTableViewController.unwindSegueId {
          let sourceVC = segue.source as! addTableViewController
          if let todo = sourceVC.todo {
            if let indexPath = trailingSwipeEditIndexPath {
                // edit
                if todo.priorityNumber != indexPath.section {
                    if indexPath.section == 0 {
                        self.highLists.remove(at: indexPath.row)
                    }else if indexPath.section == 1 {
                        self.mediumLists.remove(at: indexPath.row)
                    }else if indexPath.section == 2 {
                        self.lowLists.remove(at: indexPath.row)
                    }
                    if todo.priorityNumber == 0 {
                        self.highLists.append(todo)
                    }else if todo.priorityNumber == 1 {
                        self.mediumLists.append(todo)
                    }else if todo.priorityNumber == 2 {
                        self.lowLists.append(todo)
                    }
                    tableView.reloadSections([indexPath.section, todo.priorityNumber], with: .automatic)
                }else {
                    if indexPath.section == 0 {
                        self.highLists[indexPath.row] = todo
                    }else if indexPath.section == 1 {
                        self.mediumLists[indexPath.row] = todo
                    }else if indexPath.section == 2 {
                        self.lowLists[indexPath.row] = todo
                    }
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                }
                trailingSwipeEditIndexPath = nil
            }else {
                // add
                if todo.priorityNumber == 0 {
                    highLists.append(todo)
                    tableView.insertRows(at: [IndexPath(row: highLists.count - 1, section: 0)], with: .automatic)
                }else if todo.priorityNumber == 1 {
                    mediumLists.append(todo)
                    tableView.insertRows(at: [IndexPath(row: mediumLists.count - 1, section: 1)], with: .automatic)
                }else if todo.priorityNumber == 2 {
                    lowLists.append(todo)
                    tableView.insertRows(at: [IndexPath(row: lowLists.count - 1, section: 2)], with: .automatic)
                }
            }
          }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "High Priority"
        case 1:
            return "Medium Priority"
        case 2:
            return "Low Priority"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return highLists.count
        case 1:
            return mediumLists.count
        case 2:
            return lowLists.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TodoTableViewCell
        let todo: TodoModel!
        if indexPath.section == 0 {
            todo = highLists[indexPath.row]
        }else if indexPath.section == 1 {
            todo = mediumLists[indexPath.row]
        }else if indexPath.section == 2 {
            todo = lowLists[indexPath.row]
        }else {
            todo = nil
        }
        cell.updateUI(with: todo)
        return cell
    }
    
    // MARK: - table view delegate
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    /// Defines left buttons when in editting mode
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
      return .none
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let todoToMove: TodoModel!
        switch sourceIndexPath.section {
        case 0:
            todoToMove = highLists.remove(at: sourceIndexPath.row)
        case 1:
            todoToMove = mediumLists.remove(at: sourceIndexPath.row)
        case 2:
            todoToMove = lowLists.remove(at: sourceIndexPath.row)
        default:
            todoToMove = nil
        }
        switch destinationIndexPath.section {
        case 0:
            highLists.insert(todoToMove, at: destinationIndexPath.row)
        case 1:
            mediumLists.insert(todoToMove, at: destinationIndexPath.row)
        case 2:
            lowLists.insert(todoToMove, at: destinationIndexPath.row)
        default:
            let _ = 1
        }
    }
    
    @available(iOS 11.0, *)
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction:UIContextualAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            completionHandler(true)
            switch indexPath.section {
            case 0:
                self.highLists.remove(at: indexPath.row)
            case 1:
                self.mediumLists.remove(at: indexPath.row)
            case 2:
                self.lowLists.remove(at: indexPath.row)
            default:
                let _ = 1
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = .red
        let editAction:UIContextualAction = UIContextualAction(style: .destructive, title: "Edit") { (action, sourceView, completionHandler) in
            completionHandler(true)
            self.trailingSwipeEditIndexPath = indexPath
            self.performSegue(withIdentifier: "edit", sender: self)
        }
        editAction.backgroundColor = .gray
        
        let actions:[UIContextualAction] = [deleteAction, editAction]
        let action:UISwipeActionsConfiguration = UISwipeActionsConfiguration(actions: actions)
        action.performsFirstActionWithFullSwipe = true
        return action
    }
    
    @available(iOS 11.0, *)
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var list: [TodoModel]!
        switch indexPath.section {
            case 0:
                list = highLists
            case 1:
                list = mediumLists
            case 2:
                list = lowLists
            default:
                list = nil
        }
        let completeAction:UIContextualAction = UIContextualAction(style: .destructive, title: "Complete") { (action, sourceView, completionHandler) in
            completionHandler(true)
            switch indexPath.section {
                case 0:
                    self.highLists[indexPath.row].completedSymbol = "✅"
                case 1:
                    self.mediumLists[indexPath.row].completedSymbol = "✅"
                case 2:
                    self.lowLists[indexPath.row].completedSymbol = "✅"
                default:
                    let _ = 1
            }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        completeAction.backgroundColor = .green
        
        let unCompleteAction:UIContextualAction = UIContextualAction(style: .destructive, title: "unComplete") { (action, sourceView, completionHandler) in
        completionHandler(true)
            switch indexPath.section {
                case 0:
                    self.highLists[indexPath.row].completedSymbol = "⭕️"
                case 1:
                    self.mediumLists[indexPath.row].completedSymbol = "⭕️"
                case 2:
                    self.lowLists[indexPath.row].completedSymbol = "⭕️"
                default:
                    let _ = 1
            }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        unCompleteAction.backgroundColor = .orange
        
        var actions:[UIContextualAction] = []
        if list[indexPath.row].completedSymbol == "✅"{
            actions.append(unCompleteAction)
        }else if list[indexPath.row].completedSymbol == "⭕️" {
            actions.append(completeAction)
        }
        let action:UISwipeActionsConfiguration = UISwipeActionsConfiguration(actions: actions)
        action.performsFirstActionWithFullSwipe = true
        return action
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detail", sender: self)
    }
}
