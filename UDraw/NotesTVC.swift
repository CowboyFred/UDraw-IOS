//
//  NotesTVC.swift
//  UDraw
//
//  Created by Denis Eltcov on 5/8/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit
import CoreData

class NotesTVC: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var notes = [Notes]()
    var context: NSManagedObjectContext!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        loadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func loadData() {
        let noteRequest: NSFetchRequest<Notes> = Notes.fetchRequest()
        
        do {
            notes = try context.fetch(noteRequest)
            self.tableView.reloadData()
        }
        catch{
            let fetch_error = error as NSError
            print("error", fetch_error.localizedDescription)
        }
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
        // #warning Incomplete implementation, return the number of rows
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotesCell
        
        let noteItem = notes[indexPath.row]
        
        if let noteImage = UIImage(data: (noteItem.image)!)
        {
            cell.usersImageView.image = noteImage
        }
        
        cell.titleLbl.text = noteItem.title
        cell.authorLbl.text = "By: " + noteItem.authorName!
        
        return cell
    }

    @IBAction func AddNote(_ sender: Any) {
        
        let noteItem = Notes(context: context)
        
        if (postImage != nil)
        {
            noteItem.image = NSData(data: UIImageJPEGRepresentation(postImage!, 0.5)!) as Data
            noteItem.authorName = userName
        }

        else {
            let alert = UIAlertController(title: "Your post is empy", message: "Please draw something at first", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        let alert = UIAlertController(title: "New post", message: "Enter the title", preferredStyle: .alert)
        
        alert.addTextField { (textfield:UITextField) in
            textfield.placeholder = "Title"
        }
        
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: {(action:UIAlertAction) in
            
            let titleField = alert.textFields?.first
            
            
            if titleField?.text != ""
            {
                noteItem.title = titleField?.text
                
                do {
                    try self.context.save()
                } catch {
                    let fetch_error = error as NSError
                    print("error", fetch_error.localizedDescription)
                }
            }
            self.loadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func createNoteItem() {

    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
