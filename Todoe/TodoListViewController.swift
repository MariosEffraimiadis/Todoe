//
//  ViewController.swift
//  Todoe
//
//  Created by Marios Effraimiadis on 18/04/2018.
//  Copyright © 2018 Marios. All rights reserved.
//

import UIKit
//subclassing
class TodoListViewController: UITableViewController {  // if you change the name of the file to : TodoListViewController allakse kai to onoma edw.
//we inherrited the UITableViewController and adding a Table View Controller to the story board (instead of the a normal view controller). We dont need set ourselves as the delegate or datasource or link iboutlets. Xcode takes care of all of that.
   
    var itemArray = ["Finish IOS", "Learn IOS", "Practice IOS"] //creating a new item array
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK - Creating Tableview Datasource Methods
    //what the tableview should display and homw many rows we should have.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    //You start by writing table view. This creates 3 cells in the table view. (because we have 3 items only).
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //you start by table view
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        //the identifer is the identifier we gave to the prototype cell
        //the indexpath is the current indexpath that the table view is looking to populate
        //check the tableviews in Flash Chat for more info.
        
        cell.textLabel?.text = itemArray[indexPath.row] //this is the label in every single cell.
        //We set the text property of every cell to equal the items in the item array and at the indexPath that we are currently populating.row. So the current row of the current indexPath.
        return cell //The cell returns to the tableView and gets displayed.
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath.row) //prints row
        //print(itemArray[indexPath.row]) //prints the item array of a row
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none //if it has a checkmare we change its accessory to none.
        }
        else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        //creating a new alert
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        //creating a UIAlert action (the button that you are going to press when you are done with writing your new to do list item)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add Item Button on our UIAlert (!!!)     (this is a closure) //print(textField.text)
        
            self.itemArray.append(textField.text!) //force unwrap because it will never nil (it can be an empty string but not nill) if the user puts nothing then he will have an empty cell (because it will be an empty string)
        
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in                                                         //to add some text on the text field
            alertTextField.placeholder = "Create new Item"                           //in will show in grey and dissapear when we click on it
            textField = alertTextField
            }
        
        alert.addAction(action) //we add the action to our alert.
        present(alert, animated: true, completion: nil) //to show our alert (The View controller we want to present is : alert)
    }
}


