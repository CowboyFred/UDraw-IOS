//
//  RegisterVC.swift
//  UDraw
//
//  Created by Denis Eltcov on 5/1/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit
import CoreData

class RegisterVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPasswordTxt: UITextField!
    @IBOutlet weak var ageTxt: UITextField!
    @IBOutlet weak var genderTxt: UITextField!
    @IBOutlet weak var occupationTxt: UITextField!
    
    @IBOutlet weak var ageDropDown: UIPickerView!
    @IBOutlet weak var genderDropDown: UIPickerView!
    @IBOutlet weak var occupationDropDown: UIPickerView!
    
    var age = ["10-18",
               "19-29",
               "30-45",
               "45-55",
               "56 & above"]
    
    var gender = ["Male",
                  "Female",
                  "Other"]
    
    var occupation = ["Student",
                      "Unemployed",
                      "Web Frontend Developer",
                      "Web Backend Developer",
                      "Fullstack Web Developer",
                      "Java Developer",
                      "Swift Developer",
                      "C++ Developer",
                      "Assembler Developer",
                      "Pirate"]
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var rowsCounter : Int = age.count
        
        if pickerView == genderDropDown
        {
            rowsCounter = self.gender.count
        }
        
        if pickerView == occupationDropDown
        {
            rowsCounter = self.occupation.count
        }
        
        return rowsCounter
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == genderDropDown
        {
            let titleRow = gender[row]
            return titleRow
        }
        
        else if pickerView == ageDropDown
        {
            let titleRow = age[row]
            return titleRow
        }
        
        else if pickerView == occupationDropDown
        {
            let titleRow = occupation[row]
            return titleRow
        }
        
        
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == genderDropDown
        {
            self.genderTxt.text = self.gender[row]
            self.genderDropDown.isHidden = true
        }
        
        else if pickerView == ageDropDown
        {
            self.ageTxt.text = self.age[row]
            self.ageDropDown.isHidden = true
        }
        
        else if pickerView == occupationDropDown
        {
            self.occupationTxt.text = self.occupation[row]
            self.occupationDropDown.isHidden = true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.genderTxt
        {
            self.genderDropDown.isHidden = false
            self.ageDropDown.isHidden = true
            self.occupationDropDown.isHidden = true
        }
        
        else if textField == self.ageTxt
        {
            self.genderDropDown.isHidden = true
            self.ageDropDown.isHidden = false
            self.occupationDropDown.isHidden = true
        }
        
        else if textField == self.occupationTxt
        {
            self.genderDropDown.isHidden = true
            self.ageDropDown.isHidden = true
            self.occupationDropDown.isHidden = false
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func gotoSignIn(_ sender: Any) {
        self.dismiss(animated: true, completion:nil)
    }
    
    
    @IBAction func registerBtnPressed(_ sender: Any) {
        let userName = userNameTxt.text
        let userPassword = passwordTxt.text
        let userConfirmPassword = confirmPasswordTxt.text
        let userAge = ageTxt.text
        let userOccupation = occupationTxt.text
        let userGender = genderTxt.text
        //let userDefault = UserDefaults.standard
        
        //Check fields
        
        
        //Check if fields are correcr
        if ((userName?.isEmpty)! || (userPassword?.isEmpty)! || (userConfirmPassword?.isEmpty)! || (userAge?.isEmpty)! || (userOccupation?.isEmpty)! || (userGender?.isEmpty)! )
        {
            
            displayErrorMsg(userMsg: "All fields are reqired")
            return
        }
        
        //Passwords validation
        if(userPassword != userConfirmPassword)
        {
            displayErrorMsg(userMsg: "Passwords don't match")
            return
        }
        
        //Password strength
        // Upper case, Lower case, Number & Symbols
        var passwordStrength:Int = 0
        let passwordLength:Int = (userPassword?.count)!
        let patterns = ["^(?=.*[A-Z]).*$", "^(?=.*[a-z]).*$", "^(?=.*[0-9]).*$", "^(?=.*[!@#%&-_=:;\"'<>,`~\\*\\?\\+\\[\\]\\(\\)\\{\\}\\^\\$\\|\\\\\\.\\/]).*$"]
        
        for pattern in patterns {
            if userPassword?.range(of: pattern, options: .regularExpression, range: nil, locale: nil) != nil  {
                passwordStrength += 1
            }
        }
        if (passwordStrength < 4 || passwordLength < 6 )
        {
            displayErrorMsg(userMsg: "Your password is too weak. Please use at least 6 characters which contain Upper case, Lower case, Number & Symbol")
            return
        }
        
        //Initialize Core Data
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext

        
        //Check if user exists
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        let predicate = NSPredicate(format: "name == %@", userName!)
        request.predicate = predicate
        request.fetchLimit = 1
        
        do{
            let count = try context.count(for: request)
            if(count != 0){
                displayErrorMsg(userMsg: "Current user is already exist")
                return
            }
        }
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        //Store data
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        
        newUser.setValue(userName, forKey: "name")
        newUser.setValue(userPassword, forKey: "password")
        newUser.setValue(userGender, forKey: "gender")
        newUser.setValue(userOccupation, forKey: "occupation")
        newUser.setValue(userAge, forKey: "age")
        
        
        do
        {
            try context.save()
            //Confirmation alert
            let actionSheet = UIAlertController(title: "You were registered successfully", message: "", preferredStyle: .alert)
            actionSheet.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                self.dismiss(animated: true, completion:nil)
            }))
            present(actionSheet, animated: true, completion: nil)
        }
        catch let error as NSError
        {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        
        
        
        
        
        
        
        
        
        
        //Code for UserDefaults
        //Check existing users
        /*
        var storedUserDetails = [[String:String?]]()

        if (userDefault.object(forKey: "userDetails") != nil)
        {
            storedUserDetails = (userDefault.object(forKey: "userDetails") as? [[String:String?]])!
            for user in storedUserDetails
            {
                if user["name"]! == userName
                {
                    displayErrorMsg(userMsg: "Current user is already exist")
                    return
                }
            }
        }

        
        //Store data
        let userDetails = ["name":userName, "password": userPassword, "age":userAge, "gender":userGender, "occupation":userOccupation]
        storedUserDetails.append(userDetails )
        
        userDefault.set(storedUserDetails, forKey: "userDetails")
        userDefault.synchronize()
        */
        
        
        
        
        

        
    }
    
    func displayErrorMsg (userMsg:String)
    {
        let actionSheet = UIAlertController(title: userMsg, message: "", preferredStyle: .alert)
        actionSheet.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(actionSheet, animated: true, completion: nil)
    }

    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
