//
//  DotsView.swift
//  Veggies
//
//  Created by RHLJH Hooijmans on 21/08/15.
//  Copyright © 2015 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class DotsView: SKView {
    
    var debugMode: Bool = false {
        didSet {
            showsFPS = debugMode
            showsDrawCount = debugMode
            showsNodeCount = debugMode
            showsQuadCount = debugMode
            showsPhysics = debugMode
            showsFields = debugMode
            
            scene?.backgroundColor = debugMode ? .blackColor() : .whiteColor()
            
            if let scene = scene as? DotsScene {
                
                for child in scene.children {
                    
                    if let dot = child as? Dot {
                        dot.texture = debugMode ? SKTexture(imageNamed: "debug_circle") : SKTexture(imageNamed: "veggie\(dot.imageIndex)")
                    } else if let wheel = child as? Wheel {
                        wheel.texture = debugMode ? SKTexture(imageNamed: "debug_wheel") : SKTexture(imageNamed: "wheel")
                    }
                }
            }
            
            if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate, navigationController = appDelegate.navigationController {
                navigationController.navigationBarHidden = debugMode
            }
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        asynchronous = true
        allowsTransparency = false
        ignoresSiblingOrder = true
        shouldCullNonVisibleNodes = true
        frameInterval = 1
        
        let scene = DotsScene(size: bounds.size)
        scene.scaleMode = .AspectFit
        presentScene(scene)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: scene, action: Selector("panGestureRecognized:"))
        addGestureRecognizer(panGestureRecognizer)
        
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: scene, action: Selector("pinchGestureRecognized:"))
        addGestureRecognizer(pinchGestureRecognizer)
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "longPressGestureRecognized:")
        longPressGestureRecognizer.minimumPressDuration = 0.5
        addGestureRecognizer(longPressGestureRecognizer)
        
        debugMode = false
    }
    
    func longPressGestureRecognized(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        
        switch longPressGestureRecognizer.state {
        case UIGestureRecognizerState.Began:
            
            if let scene = scene as? DotsScene, camera = scene.camera {
                
                if camera.xScale != 1.0 || camera.yScale != 1.0 {
                    camera.xScale = 1.0
                    camera.yScale = 1.0
                } else {
                    debugMode = debugMode == true ? false : true
                }
            }
        default: break
        }
    }
}