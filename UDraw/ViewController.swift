//
//  ViewController.swift
//  UDraw
//
//  Created by Peka on 3/20/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit
import Social

var userName = ""
var postImage:UIImage? = nil

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var toolIcon: UIButton!
    @IBOutlet weak var paletteIcon: UIButton!
    @IBOutlet weak var toolsStack: UIStackView!
    @IBOutlet weak var tempImageView: UIImageView!
    @IBOutlet weak var settingsIcon: UIButton!
    @IBOutlet weak var settingsStack: UIStackView!
    
    @objc var lastPoint = CGPoint.zero
    @objc var currentPoint = CGPoint.zero
    
    @objc var swiped = false
    
    @objc var red:CGFloat = 1.0
    @objc var green:CGFloat = 0.0
    @objc var blue:CGFloat = 0.0
    @objc var alfaChannel:CGFloat = 1.0
    
    @objc var savedRed:CGFloat = 1.0
    @objc var savedGreen:CGFloat = 0.0
    @objc var savedBlue:CGFloat = 0.0
    @objc var savedAlfa:CGFloat = 1.0
    
    @objc var brushSize:CGFloat = 5.0
    
    @objc var tool:UIImageView!
    @objc var toolId:String = "brush"
    @objc var selectedImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tool = UIImageView()
        tool.frame = CGRect(x: self.view.bounds.size.width, y: self.view.bounds.size.height, width: 20, height: 20)
        tool.image = #imageLiteral(resourceName: "brush")
        self.view.addSubview(tool)
    }
    
    
    @IBAction func handlePan(_ sender: UIPanGestureRecognizer)
    {
        if sender.state == .began
        {
            lastPoint = sender.location(in: self.view)
            currentPoint = lastPoint
        }
        else if sender.state == .changed
        {
            currentPoint = sender.location(in: self.view)
            
            if (toolId == "brush" || toolId == "eraser")
            {
                drawLines(fromPoint: lastPoint, toPoint: currentPoint)
                lastPoint = currentPoint
            }
            else
            {
                showLines(fromPoint: lastPoint, toPoint: currentPoint)
            }
        }
        else if sender.state == .ended
        {
            drawLines(fromPoint: lastPoint, toPoint: currentPoint)
            self.tempImageView.image = nil
        }
    }
 
    
//Just left it as an alternative way
 /*    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped  = false
        
        if let touch = touches.first {
            lastPoint = touch.location(in: self.view)
            currentPoint = lastPoint
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        
        if let touch = touches.first {
            currentPoint = touch.location(in: self.view)
            
            
            if (toolId == "brush" || toolId == "eraser")
            {
                drawLines(fromPoint: lastPoint, toPoint: currentPoint)
                lastPoint = currentPoint
            }
            else
            {
                showLines(fromPoint: lastPoint, toPoint: currentPoint)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            drawLines(fromPoint: lastPoint, toPoint: currentPoint)
            self.tempImageView.image = nil
    }
  */
    
    
    @objc func drawLines (fromPoint:CGPoint, toPoint:CGPoint) {

        UIGraphicsBeginImageContext(imageView.frame.size)
        imageView.image?.draw(in: CGRect (x: 0, y: 0, width: imageView.frame.width, height: imageView.frame.height))
        let context = UIGraphicsGetCurrentContext()
        
        switch toolId
        {
        case "line":
            context?.addPath(ShapePath().line(startPoint: fromPoint, endPoint: toPoint).cgPath)
            
        case "round":
            context?.addPath(ShapePath().round(startPoint: fromPoint, endPoint: toPoint).cgPath)
            
        case "rect":
            context?.addPath(ShapePath().rect(startPoint: fromPoint, endPoint: toPoint).cgPath)
            
        case "hex":
            context?.addPath(ShapePath().hex(startPoint: fromPoint, endPoint: toPoint).cgPath)
            
        case "oct":
            context?.addPath(ShapePath().oct(startPoint: fromPoint, endPoint: toPoint).cgPath)
            
        case "brush":
            context?.addPath(ShapePath().brush(startPoint: fromPoint, endPoint: toPoint).cgPath)
        
        case "eraser":
            context?.addPath(ShapePath().brush(startPoint: fromPoint, endPoint: toPoint).cgPath)
        
        default:
            print("Error occured with the selected tool!")
        }
        
        tool.center = toPoint
        
       
        context?.setBlendMode(CGBlendMode.normal)
        context?.setLineCap(CGLineCap.round)
        
        if (toolId == "brush" || toolId == "eraser" || toolId == "line")
        {
            context?.setLineWidth(brushSize)
            context?.setStrokeColor(UIColor(red: red, green: green, blue: blue, alpha: alfaChannel).cgColor)
            context?.strokePath()
        }
        else
        {
            context?.setFillColor(UIColor(red: red, green: green, blue: blue, alpha: alfaChannel).cgColor)
            context?.fillPath()
        }

        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
    }
    
    //SHow dynamicaly drawable shapes on temp layer and clear it
    @objc func showLines (fromPoint:CGPoint, toPoint:CGPoint) {
        
        tempImageView.image = nil
        UIGraphicsBeginImageContext(tempImageView.frame.size)
        tempImageView.image?.draw(in: CGRect (x: 0, y: 0, width: tempImageView.frame.width, height: tempImageView.frame.height))
        let context = UIGraphicsGetCurrentContext()
        
        switch toolId
        {
        case "line":
            context?.addPath(ShapePath().line(startPoint: fromPoint, endPoint: toPoint).cgPath)
            
        case "round":
            context?.addPath(ShapePath().round(startPoint: fromPoint, endPoint: toPoint).cgPath)
            
        case "rect":
            context?.addPath(ShapePath().rect(startPoint: fromPoint, endPoint: toPoint).cgPath)
            
        case "hex":
            context?.addPath(ShapePath().hex(startPoint: fromPoint, endPoint: toPoint).cgPath)
            
        case "oct":
            context?.addPath(ShapePath().oct(startPoint: fromPoint, endPoint: toPoint).cgPath)
        default:
            print("Error occured with the selected tool!")
        }
        
        tool.center = toPoint
        
        
        context?.setBlendMode(CGBlendMode.normal)
        context?.setLineCap(CGLineCap.round)
        
        if (toolId == "line")
        {
            context?.setLineWidth(brushSize)
            context?.setStrokeColor(UIColor(red: red, green: green, blue: blue, alpha: alfaChannel).cgColor)
            context?.strokePath()
        }
        else
        {
            context?.setFillColor(UIColor(red: red, green: green, blue: blue, alpha: alfaChannel).cgColor)
            context?.fillPath()
        }
        
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
    }
    
    @IBAction func clear(_ sender: UIBarButtonItem) {
        
        let actionSheet = UIAlertController(title: "Are you sure?", message: "", preferredStyle: .alert)
        
        actionSheet.addAction(UIAlertAction(title: "Clear the canvas", style: .destructive, handler: { (_) in
            self.imageView.image = nil
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.barButtonItem = sender
        }
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func settings(_ sender: Any) {
        showStack(stack: settingsStack, btn: settingsIcon)
    }
    
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        
        self.settingsStack.isHidden = true
        self.settingsIcon.alpha = 1.0
        let actionSheet = UIAlertController(title: "Save & Load", message: "", preferredStyle: .alert)
        actionSheet.addAction(UIAlertAction(title: "Load an Image", style: .default, handler: { (_) in
            
            
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            imagePicker.delegate = self
            
            self.present(imagePicker, animated: true, completion: nil)
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Save an Image", style: .default, handler: { (_) in
            if let image = self.imageView.image {
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.barButtonItem = sender
        }
        
        present(actionSheet, animated: true, completion: nil)
        
    }
    
    @IBAction func share(_ sender: UIBarButtonItem) {
        self.settingsStack.isHidden = true
        self.settingsIcon.alpha = 1.0
        let actionSheet = UIAlertController(title: "Share your drawing", message: "", preferredStyle: .alert)
        
        actionSheet.addAction(UIAlertAction(title: "Share on Facebook", style: .default, handler: { (_) in
            if let image = self.imageView.image {
                if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook)
                {
                    let post = SLComposeViewController(forServiceType: SLServiceTypeFacebook)!
                    
                    post.setInitialText("Check out my new drawing!")
                    post.add(image)
                    
                    self.present(post, animated: true, completion: nil)
                }
                else
                {
                    self.showAlert(service: "Facebook")
                }
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Share on Twitter", style: .default, handler: { (_) in
            if let image = self.imageView.image {
                if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter)
                {
                    let post = SLComposeViewController(forServiceType: SLServiceTypeTwitter)!
                    
                    post.setInitialText("Check out my new drawing!")
                    post.add(image)
                    
                    self.present(post, animated: true, completion: nil)
                }
                else
                {
                    self.showAlert(service: "Twitter")
                }
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.barButtonItem = sender
        }
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func addNote(_ sender: Any) {
        self.settingsStack.isHidden = true
        self.settingsIcon.alpha = 1.0
    }
    
    
    @IBAction func erase(_ sender: AnyObject) {
        
        if (!toolsStack.isHidden)
        {
            hideToolsStack()
        }
        (savedRed, savedGreen, savedBlue, savedAlfa) = (red, green, blue, alfaChannel)
        (red, green, blue, alfaChannel) = (255,255,255,1.0)
        tool.image = #imageLiteral(resourceName: "eraser")
        toolId = "eraser"

    }
    
    @IBAction func tool(_ sender: AnyObject) {
        showStack(stack: toolsStack, btn: toolIcon)
    }
    
    @IBAction func brushChosen(_ sender: Any) {
        hideToolsStack()
        toolId = "brush"
        toolIcon.setImage(#imageLiteral(resourceName: "brush"), for: .normal)
        tool.image = #imageLiteral(resourceName: "brush")
    }
    @IBAction func lineChosen(_ sender: Any) {
        hideToolsStack()
        toolId = "line"
        toolIcon.setImage(#imageLiteral(resourceName: "line"), for: .normal)
        tool.image = #imageLiteral(resourceName: "line")
    }
    @IBAction func roundChosen(_ sender: Any) {
        hideToolsStack()
        toolId = "round"
        toolIcon.setImage(#imageLiteral(resourceName: "round"), for: .normal)
        tool.image = #imageLiteral(resourceName: "round")
    }
    @IBAction func rectChosen(_ sender: Any) {
        hideToolsStack()
        toolId = "rect"
        toolIcon.setImage(#imageLiteral(resourceName: "rect"), for: .normal)
        tool.image = #imageLiteral(resourceName: "rect")
    }
    @IBAction func hexChosen(_ sender: Any) {
        hideToolsStack()
        toolId = "hex"
        toolIcon.setImage(#imageLiteral(resourceName: "hex"), for: .normal)
        tool.image = #imageLiteral(resourceName: "hex")
    }
    @IBAction func octChosen(_ sender: Any) {
        hideToolsStack()
        toolId = "oct"
        toolIcon.setImage(#imageLiteral(resourceName: "oct"), for: .normal)
        tool.image = #imageLiteral(resourceName: "oct")
    }
    
    @objc func hideToolsStack () {
        //Return saved color for drawing
        if (toolId == "eraser")
        {
            (red, green, blue, alfaChannel) = (savedRed, savedGreen, savedBlue, savedAlfa)        }
        
        
        UIView.animate(withDuration: 0.5, animations: {
            self.toolsStack.alpha -= 1
            self.toolIcon.alpha += 0.5
        }, completion: { (finished: Bool) in
            self.toolsStack.isHidden = true
        })
        
        
        
    }
    
    func showStack (stack:UIStackView, btn:UIButton)
    {
        stack.isHidden = false
        
        stack.alpha = 0
        stack.frame.origin.y -= 20
        
        UIView.animate(withDuration: 0.5, animations: {
            stack.frame.origin.y += 20
            stack.alpha += 1
            if (btn.alpha > 0.5)
            {
                btn.alpha -= 0.5
            }
        }, completion: nil)
    }

    func showAlert(service:String)
    {
        let alert = UIAlertController(title: "You are not connected to \(service)", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Got it", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    

    @IBAction func palette(_ sender: Any) {
    }
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "paletteSegue" {
            super.prepare(for: segue, sender: sender)
            let paletteVC = segue.destination as! PaletteVC
            paletteVC.delegate = self
            paletteVC.red = red
            paletteVC.green = green
            paletteVC.blue = blue
            paletteVC.brushSize = brushSize
            paletteVC.alfaChannel = alfaChannel
        } else if segue.identifier == "notesSegue" {
            postImage = self.imageView.image
        }
    }
    
}

extension ViewController:UINavigationControllerDelegate,UIImagePickerControllerDelegate, PaletteVCDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imagePicked = info[UIImagePickerControllerOriginalImage] as? UIImage{
            //Get the image
            self.selectedImage = imagePicked
            self.imageView.image = selectedImage
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func paletteVCDidFinish(_ paletteVC: PaletteVC) {
        self.red = paletteVC.red
        self.green = paletteVC.green
        self.blue = paletteVC.blue
        self.brushSize = paletteVC.brushSize
        self.alfaChannel = paletteVC.alfaChannel
        self.paletteIcon.backgroundColor = UIColor(red: paletteVC.red, green: paletteVC.green, blue: paletteVC.blue, alpha: paletteVC.alfaChannel)
    }
}

