//
//  ViewController.swift
//  CircleGesture
//
//  Created by Mohsin on 13/02/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

// ref: http://www.mathsisfun.com/algebra/circle-equations.html


import UIKit
// for maths functions
import Darwin

class ViewController: UIViewController {

    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var rotatingView: UIView!
    
    
    var panGesture = UIPanGestureRecognizer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        self.rotatingView.addGestureRecognizer(self.panGesture)
        
        self.rotatingView.userInteractionEnabled = true
        
        self.panGesture.addTarget(self, action: "draggingView:")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func draggingView(sender:UIPanGestureRecognizer){

      //  self.view.bringSubviewToFront(sender.view!)
        
        println(sender.locationInView(self.view) )

        let translation = sender.translationInView(self.view)
        
//        let currentX = sender.view!.center.x + translation.x
//        let currentY = sender.view!.center.y + translation.y
        
        let currentX = sender.locationInView(self.view).x + translation.x
        let currentY = sender.locationInView(self.view).y + translation.y
        
        let center = self.centerView.center

        var newX = Float()
        var newY = Float()
        
        println("current Y: \(currentY)")
        println("current X: \(currentX)")
        
        println("center Y: \(center.y)")
        println("center X: \(center.x)")
        
        
        if currentY <= center.y{
            newY = circleFormula(center, radius: 120.0, x: Float(currentX),isAbove: true)
            //newY = 200.0

            
            println("new Y: \(newY)")
            println("new X: \(newX)")
            
            println("above")

        }
        else if currentY > center.y{
            newY = circleFormula(center, radius: 120, x: Float(currentX),isAbove: false)
            
            
            println("new Y: \(newY)")
            println("new X: \(newX)")
            
            println("below")
        }
        
        newX = Float(currentX)
        
        if currentX > center.x+120.0{
            newX = Float(center.x+120.0)
            newY = Float(center.y)
            
        }
        else if currentX < center.x-120.0{
            newX = Float(center.x-120.0)
            newY = Float(center.y)
        }
        
        sender.view!.center = CGPointMake(CGFloat(newX), CGFloat(newY))
 
        
//        sender.view!.center = CGPointMake(sender.view!.center.x + translation.x, sender.view!.center.y + translation.y)
        sender.setTranslation(CGPointZero, inView: self.view)
        

    }

    
    
    func circleFormula(center: CGPoint, radius: Float, x: Float, isAbove : Bool) -> Float{
        
        let temp = x - Float(center.x)
        let temp1 = (radius * radius ) - (temp * temp)
        let temp2 = abs(temp1)
        
        if isAbove{
            let newY = Float(center.y)-sqrt(temp2)
            return newY
        }
        else{
            let newY = Float(center.y)+sqrt(temp2)
            return newY
        }
        
    }
    
//    
//    func circleFormula(center: CGPoint, radius: Float, x: Float, isAbove : Bool) -> Float{
//        
//        let temp = x - Float(center.x)
//        let temp1 = (radius * radius ) - (temp * temp)
//        
//        if isAbove{
//            let newY = Float(center.y)-sqrt(temp1)
//            return newY
//        }
//        else{
//            let newY = Float(center.y)+sqrt(temp1)
//            return newY
//        }
//        
//    }
}

