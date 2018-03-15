//
//  AddEditTableViewController.swift
//  OrderApp
//
//  Created by 施馨檸 on 14/03/2018.
//  Copyright © 2018 施馨檸. All rights reserved.
//

import UIKit

class AddEditTableViewController: UITableViewController {
    
    @IBOutlet weak var weekdayTextField: UITextField!
    @IBOutlet weak var countTextField: UITextField!
    @IBOutlet weak var riceTextField: UITextField!
    @IBOutlet weak var meatTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let meal = meal {
            weekdayTextField.text = "\(meal.weekday)"
            countTextField.text = "\(meal.count)"
            riceTextField.text = "\(meal.rice)"
            meatTextField.text = "\(meal.meat)"
        }
        updateSaveButtonState()
    }
    
    
    func updateSaveButtonState() {
        let weekdayText = weekdayTextField.text ?? ""
        let countText = countTextField.text ?? ""
        let riceText = riceTextField.text ?? ""
        let meatText = meatTextField.text ?? ""
        saveButton.isEnabled = !weekdayText.isEmpty && !countText.isEmpty && !riceText.isEmpty && !meatText.isEmpty
        
        
        print(saveButton.isEnabled)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "saveUnwind" else { return }
        
        let weekday = weekdayTextField.text ?? ""
        let count = countTextField.text ?? ""
        let rice = riceTextField.text ?? ""
        let meat = meatTextField.text ?? ""
        print("prepare")
        meal = Meal(weekday: Int(weekday)!, count: Int(count)!, rice: Int(rice)!, meat: Int(meat)!)
        
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    
    @IBAction func returnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
}

