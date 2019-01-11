//
//  TableViewController.swift
//  TestProject
//
//  Created by Vlad Maevsky on 12/14/18.
//  Copyright © 2018 Vlad Maevsky. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var items = ["one", "two", "three", "four"]
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBAction func actionAdd(_ sender: Any?) {
        addNewItem()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        addNewItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        addButton.isHidden = true
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = items[sourceIndexPath.row]
        items.remove(at: sourceIndexPath.row)
        items.insert(item, at: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    
    func addNewItem() {
        var textField: UITextField?
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { [unowned self] _ in
            self.items.append(textField?.text ?? "")
            let indexPath = IndexPath(row: self.items.count - 1, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Add a new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        if (editing) {
            super.setEditing(true, animated: true)
            addButton.isHidden = false
        } else {
            super.setEditing(false, animated: true)
            addButton.isHidden = true
        }
    }
}
