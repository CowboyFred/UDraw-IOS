//
//  LoginVC.swift
//  UDraw
//
//  Created by Denis Eltcov on 5/1/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit
import CoreData


class LoginVC: UIViewController {

    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var signInLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signInBtnPressed(_ sender: Any) {
        userName = userNameTxt.text!
        let userPassword = passwordTxt.text
        //let userDefault = UserDefaults.standard
        //var storedUserDetails = [[String:String?]]()
        
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        let predicate = NSPredicate(format: "name = %@", userName)
        fetchrequest.predicate = predicate
        do
        {
            let result = try context.fetch(fetchrequest) as NSArray
            
            if result.count>0
            {
                let objectentity = result.firstObject as! Users
                
                if objectentity.name == userName && objectentity.password == userPassword
                {
                    self.performSegue(withIdentifier: "mainView", sender: nil)
                }
                else
                {
                    let actionSheet = UIAlertController(title: "Wrong password and(or) username", message: "", preferredStyle: .alert)
                    actionSheet.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(actionSheet, animated: true, completion: nil)
                }
            }
        }
            
        catch
        {
            let fetch_error = error as NSError
            print("error", fetch_error.localizedDescription)
        }
        
        
        
        
        
        
        
    }
        /*Code for User Defaults
        if (userDefault.object(forKey: "userDetails") != nil)
        {
            storedUserDetails = (userDefault.object(forKey: "userDetails") as? [[String:String?]])!
            for user in storedUserDetails
            {
                if (user["name"]! == userName && user["password"]! == userPassword)
                {
                    userDefault.synchronize()
                    self.performSegue(withIdentifier: "mainView", sender: nil)
                }
            }
        }
            let actionSheet = UIAlertController(title: "Wrong password and(or) username", message: "", preferredStyle: .alert)
            actionSheet.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(actionSheet, animated: true, completion: nil)
    }*/
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
