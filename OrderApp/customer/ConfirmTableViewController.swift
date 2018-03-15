//
//  ConfirmTableViewController.swift
//  OrderApp
//
//  Created by 施馨檸 on 14/03/2018.
//  Copyright © 2018 施馨檸. All rights reserved.
//

import UIKit

class ConfirmTableViewController: UITableViewController {
    
    
    //var posts = [Post]()
    var meals = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        meals = Meal.readItemsFromFile()!
    }
    
    @IBAction func refresh(_ sender: Any) {
        print("remove meals")
        update()
    }
    
    func update() {
        
        if let isRefreshing = refreshControl?.isRefreshing, isRefreshing == true {
            refreshControl?.endRefreshing()
            meals = Meal.readItemsFromFile()!
        }
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cartCell = tableView.dequeueReusableCell(withIdentifier: "cartCell") as? CartTableViewCell
        let noteCell = tableView.dequeueReusableCell(withIdentifier: "noteCell") as? NoteTableViewCell
        
        if indexPath.row < meals.count {
            let meal = meals[indexPath.row]
            if meal.weekday == 2 {
                cartCell!.weekDayLabel.text = "星期一"
            } else if meal.weekday == 3 {
                cartCell!.weekDayLabel.text = "星期二"
            } else if meal.weekday == 4 {
                cartCell!.weekDayLabel.text = "星期三"
            } else if meal.weekday == 5 {
                cartCell!.weekDayLabel.text = "星期四"
            } else if meal.weekday == 6 {
                cartCell!.weekDayLabel.text = "星期五"
            }
            cartCell!.countLabel.text = "\(meal.count)"
            cartCell!.riceLabel.text = "\(meal.rice)"
            cartCell!.meatLabel.text = "\(meal.meat)"
            
            return cartCell!
            
        } else {
            noteCell!.noteLabel.text = "不蔥"
            
            return noteCell!
        }
        
    }
    
    
    @IBAction func unwindToConfirmTableViewController(segue: UIStoryboardSegue) {
        if segue.identifier == "saveUnwind" {
            let sourceController = segue.source as? AddEditTableViewController
            if let meal = sourceController?.meal {
                if let selectIndexPath = tableView.indexPathForSelectedRow {
                    meals[selectIndexPath.row] = meal
                    tableView.reloadData()
                } else {
                    let newIndexPath = IndexPath(row: meals.count, section: 0)
                    meals.append(meal)
                    tableView.insertRows(at: [newIndexPath], with: .automatic)
                }
            }
        }
        Meal.saveToFile(meals: meals)
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        
        if indexPath.row < meals.count {
            return true
        } else {
            return false
            
        }
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            meals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        Meal.saveToFile(meals: meals)
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editMeal" {
            let indexPath = tableView.indexPathForSelectedRow!
            let meal = meals[indexPath.row]
            let navController = segue.destination as? UINavigationController
            let controller = navController?.topViewController as? AddEditTableViewController
            
            controller?.meal = meal
        }
    }
}

