//
//  DetailTableViewController.swift
//  OrderApp
//
//  Created by 施馨檸 on 14/03/2018.
//  Copyright © 2018 施馨檸. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    @IBOutlet weak var portionLabel: UILabel!
    @IBOutlet weak var riceLabel: UILabel!
    @IBOutlet weak var meatLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var dayString: String?
    var weekday: Int = 0
    var meal: Meal?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weekDayLabel.text = dayString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    @IBOutlet weak var portionStepper: UIStepper!
    @IBOutlet weak var riceStepper: UIStepper!
    @IBOutlet weak var meatStepper: UIStepper!
    
    @IBAction func portion(_ sender: Any) {
        portionLabel.text = "\(Int(portionStepper.value))"
        
    }
    
    @IBAction func rice(_ sender: Any) {
        riceLabel.text = "\(Int(riceStepper.value))"
    }
    
    @IBAction func meat(_ sender: Any) {
        meatLabel.text = "\(Int(meatStepper.value))"
    }
    
    @IBAction func addToCart(_ sender: Any) {
        print("pressed addToCart btn")
        
        meal = Meal(weekday: weekday, count: Int(portionStepper.value), rice:Int(riceStepper.value), meat:Int(meatStepper.value))
        
    }
    
    
    
    // MARK: - Navigation
    /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
     }
     */
    
}

