//
//  ViewController.swift
//  Todoe
//
//  Created by Marios Effraimiadis on 18/04/2018.
//  Copyright © 2018 Marios. All rights reserved.
//

import UIKit
//subclassing
class TodoListViewController: UITableViewController {  //If you change the name of the swift file to: TodoListViewController; then also change the class name (here).
//We inherrited the UITableViewController. Adding a Table View Controller to the story board (instead of the a normal view controller) means that we dont need set ourselves as the delegate or datasource or link the ib-outlets. Xcode takes care of all of that.
   
    var itemArray = [Item]() //creating a new item array
    
    let defaults = UserDefaults.standard //standar user default (new object creation). UserDefaults is an "Interfrace to the user's default DB where you store key value pairs persistently accross launches of your app." !!!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Finish iOS"
        itemArray.append(newItem)
        
        
        let newItem2 = Item()
        newItem.title = "Learn iOS"
        itemArray.append(newItem2)
        
        
        let newItem3 = Item()
        newItem.title = "Practice iOS"
        itemArray.append(newItem3)
        
        
        
        //itemArray = defaults.array(forKey: "TodoListArray") as! [String]
        //If you dont put the following then it is like you have saved our itemArray into are defaults (which is the file {com.effraimiadis.Todoe.plist} which you can find if you follow the result from: print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)) but we havent used are saved item to load up the tableView (!!!). It will still get all data from the itemArray (who is not yet persistent).
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] //hard coded key. Cast as an array of strings.
         itemArray = items
        }
    }
    
    //MARK - Creating Tableview Datasource Methods (what the tableview should display and homw many rows we should have).
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    //You start by writing table view. This creates 3 cells in my table view. (because we have 3 items only).
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //you start by table view
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        //the identifer is the identifier we gave to the prototype cell
        //the indexpath is the current indexpath that the table view is looking to populate
        //check the tableviews in Flash Chat for more info.
        
        let item = itemArray[indexPath.row] //to avoid writing indexPath.row all the time below
        cell.textLabel?.text = item.title
        
        //TERNARY operator (we have a condition like an if statement)
        //Value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        //^reads : Set the cell's accessoryType depending or whether the item.dome is true, if it is true then set it to .checkmark, if it is not true then set it to .none.
    
        // cell.accessoryType = item.done ? .checkmark : .none (different ways)
        //if item.done == true {cell.accessoryType = .checkmark} else {cell.accessoryType =.none} (different ways)
 
        return cell //The cell returns to the tableView and gets displayed.
        }
        
        //cell.textLabel?.text = itemArray[indexPath.row].title (this is the label in every single cell)
        //We set the text property of every cell to equal the items in the item array and at the indexPath that we are currently populating.row. So the current row of the current indexPath.
    
    //MARK - TableView Delegate Methods (auto douleuei opote kanoume click se mia row)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath.row) //prints row
        //print(itemArray[indexPath.row]) //prints the item array of a row
        
        itemArray[indexPath.row].done == !itemArray[indexPath.row].done // reverses the boolean true - false.
        
                                            /* if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
                                                    tableView.cellForRow(at: indexPath)?.accessoryType = .none }
                                            //if it has a checkmark we change its accessory to none.
                                                    else {tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark }*/
    
        tableView.reloadData()
    
        tableView.deselectRow(at: indexPath, animated: true)  //so that it will not stay gray everytime we click on an array
 
 }
    
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert) //creating a new alert
            //creating a UIAlert action (the button that you are going to press when you are done with writing your new to do list item)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add Item Button on our UIAlert (!!!)(this is a closure) //print(textField.text)

            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem) //force unwrap because it will never nil (it can be an empty string but not nill) if the user puts nothing then he will have an empty cell (because it will be an empty string)
        
                //saving the updated item array to our user defaults. The key "TodoListArray" is going to unidentify this array inside our user defaults.
            self.defaults.set(self.itemArray, forKey: "TodoListArray")//key identifies this array inside our user defaults
            
            self.tableView.reloadData() } //make sure you reload (if you dont reload, it will not take into the account the new array that has the extra item (hence it will not appear.
        
        alert.addTextField { (alertTextField) in                                                         //to add some text on the text field
            alertTextField.placeholder = "Create new Item"                           //in will show in grey and dissapear when we click on it
            textField = alertTextField }

        alert.addAction(action) //we add the action to our alert.
        present(alert, animated: true, completion: nil) //to show our alert (The View controller we want to present is : alert)
    }

}
