//
//  ViewController.swift
//  view-splitter
//
//  Created by Justtn on 3/23/18.
//  Copyright © 2018 Justtn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var redViewHeight: NSLayoutConstraint!
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var upDownArrow: UIImageView!

    // MARK: - Screen division limits
    let upperLimit: CGFloat = {
       let screenHeight = UIScreen.main.bounds.height
        return screenHeight/3
    }()
    let lowerLimit: CGFloat = {
        let screenHeight = UIScreen.main.bounds.height
        return (screenHeight/3) * 2
    }()
    
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()        
        upDownArrow.isUserInteractionEnabled = true
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedArrow(_:)))
        upDownArrow.addGestureRecognizer(panGesture)
    }

    
    // MARK: - Drag functionality
    @objc func draggedArrow(_ sender: UIPanGestureRecognizer){
        let translation = sender.translation(in: self.view)
        if upDownArrow.center.y == upperLimit && translation.y < 0.0 {
            return
        }
        if upDownArrow.center.y == lowerLimit && translation.y > 0.0 {
            return
        }

        upDownArrow.center = CGPoint(x: upDownArrow.center.x, y: upDownArrow.center.y + translation.y)
        redViewHeight.constant += translation.y

        if upDownArrow.center.y < upperLimit {
            upDownArrow.center.y = upperLimit
            redViewHeight.constant = upperLimit - 8.0
        } else if upDownArrow.center.y > lowerLimit {
            upDownArrow.center.y = lowerLimit
            redViewHeight.constant = lowerLimit - 8.0
        }
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    

    
}

