//
//  PaletteVC.swift
//  UDraw
//
//  Created by Denis Eltcov on 3/23/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

protocol PaletteVCDelegate:class {
    func paletteVCDidFinish(_ paletteVC:PaletteVC)
}

class PaletteVC: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var brushSizeLabel: UILabel!
    @IBOutlet var opacityLabel: UILabel!
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @objc var red:CGFloat = 1.0
    @objc var green:CGFloat = 0
    @objc var blue:CGFloat = 0
    @objc var brushSize:CGFloat = 5.0
    @objc var alfaChannel:CGFloat = 1.0
    
    var delegate:PaletteVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        drawPreview(red: red, green: green, blue: blue)
        
        redSlider.value = Float(red)
        redLabel.text = String(Int(redSlider.value) * 255)
        
        greenSlider.value = Float(green)
        greenLabel.text = String(Int(greenSlider.value) * 255)
        
        blueSlider.value = Float(blue)
        blueLabel.text = String(Int(blueSlider.value) * 255)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(_ sender: Any) {
        if delegate != nil {
            delegate?.paletteVCDidFinish(self)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func brushSizeChanged(_ sender: Any) {
        let slider = sender as! UISlider
        brushSize = CGFloat(slider.value)
        drawPreview(red: red, green: green, blue: blue)
    }
    
    @IBAction func opacityChanged(_ sender: Any) {
        let slider = sender as! UISlider
        alfaChannel = CGFloat(slider.value)
        drawPreview(red: red, green: green, blue: blue)
    }
    
    @IBAction func redSliderChanged(_ sender: Any) {
        let slider = sender as! UISlider
        red = CGFloat(slider.value)
        drawPreview(red: red, green: green, blue: blue)
        redLabel.text = "\(Int(slider.value * 255))"
    }
    
    @IBAction func greenSliderChanged(_ sender: Any) {
        let slider = sender as! UISlider
        green = CGFloat(slider.value)
        drawPreview(red: red, green: green, blue: blue)
        greenLabel.text = "\(Int(slider.value * 255))"
    }
    
    @IBAction func blueSliderChanged(_ sender: Any) {
        let slider = sender as! UISlider
        blue = CGFloat(slider.value)
        drawPreview(red: red, green: green, blue: blue)
        blueLabel.text = "\(Int(slider.value * 255))"
    }
    
    @objc func drawPreview (red:CGFloat, green:CGFloat, blue:CGFloat) {
        
        UIGraphicsBeginImageContext(imageView.frame.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setStrokeColor(UIColor(red: red, green: green, blue: blue, alpha: alfaChannel).cgColor)
        context?.setLineWidth(brushSize)
        context?.setLineCap(CGLineCap.round)
        
        context?.move(to: CGPoint(x:70, y:70))
        context?.addLine(to: CGPoint(x:70, y:70))
        context?.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
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
