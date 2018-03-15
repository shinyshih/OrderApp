//
//  MainTableViewController.swift
//  OrderApp
//
//  Created by 施馨檸 on 14/03/2018.
//  Copyright © 2018 施馨檸. All rights reserved.
//

import UIKit
import Firebase

class MainTableViewController: UITableViewController {
    
    //var meals = [Meal]()
    var create_30:[Date] = []
    var daylist = ["星期一","星期二","星期三","星期四","星期五"]
    //var daylist = ["Mon","Tue","Wed","Thu","Fri"]
    
    @IBOutlet var TheTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        get_next_5_days()
        //        now_date()
        //self.meals = Meal.readItemsFromFile()!
    }
    
    var posts: Posts?
    override func viewDidLoad() {
        super.viewDidLoad()
        DatabaseService.shared.postsReference.observe(DataEventType.value, with: { (snapshot) in
            print("snapshot ",snapshot)
            //guard let postsSnapshot = PostsSnapshot(with: snapshot) else { return }
            //self.posts = postsSnapshot.posts
            //self.posts.sort(by: { $0.date.compare($1.date) == .orderedDescending })
            print("snapshot.value", snapshot.value)
            let jsonDecoder = JSONDecoder()
            
            if let value = snapshot.value, (value is NSNull) == false, let data = try? JSONSerialization.data(withJSONObject: value, options: []) {
                
                self.posts = try? jsonDecoder.decode(Posts.self, from: data)
                self.tableView.reloadData()
            }
            
            
            
            /*
             let postDict = snapshot.value as? [String: [String:String]] ?? [:]
             
             self.posts = postDict
             print("posts", self.posts)
             self.TheTableView.reloadData()
             */
            
        })
        
        //self.meals = Meal.readItemsFromFile()!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userID = Auth.auth().currentUser?.uid
        if userID == "UxXBPCMErgRpdcCZmsqb8gJ1vno1" {
            performSegue(withIdentifier: "editSegue", sender: nil)
        } else {
            performSegue(withIdentifier: "detailSegue", sender: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        return indexPath
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainTableViewCell
        
        cell.weekdayLabel.text = daylist[indexPath.row]
        var post: Posts.Post?
        if indexPath.row == 0 {
            post = posts?.mon
        } else if indexPath.row == 1 {
            post = posts?.tue
        } else if indexPath.row == 2 {
            post = posts?.wed
        } else if indexPath.row == 3 {
            post = posts?.thu
        } else if indexPath.row == 4 {
            post = posts?.fri
        }
        
        if let post = post {
            cell.meatLabel.text = post.meat.name
            cell.dish1Label.text = post.dish1.name
            cell.dish2Label.text = post.dish2.name
            cell.soupLabel.text = post.soup.name
            
            
            let request = URLRequest(url: post.meat.pic, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 30)
            
            let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
                if let data = data {
                    DispatchQueue.main.async {
                        if let currentIndexPath = self.tableView.indexPath(for: cell), currentIndexPath == indexPath {
                            cell.dishImageView.image = UIImage(data: data)
                        }
                    }
                }
            }
            task.resume()
        }
        
        
        
        
        return cell
    }
    
    @IBAction func unwindToMainTableViewController(segue: UIStoryboardSegue) {
        /*
        guard let source = segue.source as? DetailTableViewController, let meal = source.meal else {return}
        meals.append(meal)
        Meal.saveToFile(meals: meals)
 */
    }
    
    func get_next_5_days() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let now = Date()
        let dateStr = formatter.string(from: now)
        let currDate = formatter.date(from: dateStr)
        
        for i in 1...5 {
            let interval = TimeInterval(60 * 60 * 24 * i - 1)
            let newDate = currDate?.addingTimeInterval(interval)
            create_30.append(newDate!)
        }
    }
    
    func now_date() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        dateFormatter.dateFormat = "EEEE"
        let currentDateString: String = dateFormatter.string(from: date)
        print("Current date is \(currentDateString)")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPathRow = tableView.indexPathForSelectedRow?.row {
            
            if segue.identifier == "detailSegue" {
                let controller = segue.destination as! DetailTableViewController
                controller.weekday = indexPathRow + 2
                controller.dayString = daylist[indexPathRow]
            } else if segue.identifier == "editSegue" {
                let controller = segue.destination as! EditMenuViewController
                // let date = Date()
                // let dateFormatter = DateFormatter()
                // dateFormatter.dateFormat = "mm-dd"
                // let dateString = dateFormatter.string(from: date)
                
                controller.navtitle = daylist[indexPathRow]
            }
        } else {
            print("error")
        }
    }
}



