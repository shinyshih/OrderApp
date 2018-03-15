//
//  LoginViewController.swift
//  OrderApp
//
//  Created by 施馨檸 on 14/03/2018.
//  Copyright © 2018 施馨檸. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func Close(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func Login(_ sender: UIButton) {
        if let email = name.text, let pass = password.text {
            Auth.auth().signIn(withEmail: email, password: pass, completion: { (user, error) in
                
                if user != nil {
                    
                    let userID = Auth.auth().currentUser!.uid
                    DatabaseService.shared.usersReference.child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
                        if let value = snapshot.value as? NSDictionary, let role = value["role"] as? String {
                            print(role)
                            
                            if role == "boss" {
                                print("Editor Has login")
                                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                let initialViewController = (self.storyboard?.instantiateViewController(withIdentifier: "TabBarForEditor"))! as UIViewController
                                appDelegate.window?.rootViewController = initialViewController
                                appDelegate.window?.makeKeyAndVisible()
                                
                            } else {
                                print("User Has login", user)
                                
                                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                let initialViewController = (self.storyboard?.instantiateViewController(withIdentifier: "TabBarForUser"))! as UIViewController
                                appDelegate.window?.rootViewController = initialViewController
                                appDelegate.window?.makeKeyAndVisible()
                            }
                        }
                    })
                    
                }
                
                if error != nil {
                    print("Login Failed")
                    
                    let alert = UIAlertController(title: "登錄錯誤", message: "帳號或密碼錯誤", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

