//
//  DotsScene.swift
//  Veggies
//
//  Created by RHLJH Hooijmans on 21/08/15.
//  Copyright © 2015 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class DotsScene: SKScene {
    
    var intialGravityFieldPosition = CGPointZero
    var intialCameraScale: CGFloat = 0.0
    var panState = UIGestureRecognizerState.Possible
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        
        physicsWorld.gravity = CGVectorMake(0.0, 0.0)
        userInteractionEnabled = true
        
        let camera = Camera()
        camera.position = CGPointMake(size.width / 2.0, size.height / 2.0)
        addChild(camera)
        self.camera = camera
        
        
        
        for i in 0...50 {
            
            let index = (i % 15) + 1
            let randomX = CGFloat(Int(arc4random()) % Int(UIScreen.mainScreen().bounds.size.width))
            let randomY = CGFloat(Int(arc4random()) % Int(UIScreen.mainScreen().bounds.size.height))
            
            let radius: CGFloat = 50.0
            
            let dot = Dot(radius: radius, index: index)
            dot.position = CGPointMake(randomX, -randomY)
            dot.delegate = self
            addChild(dot)
        }

        
        
        
        let gravityField = SKFieldNode.radialGravityField()
        gravityField.name = Statics.Nodes.GravityField
        gravityField.position = CGPointMake(size.width / 2.0, 100.0)
        gravityField.region = SKRegion(radius: Float(size.height) * 1000.0)
        gravityField.strength = 15.0
        gravityField.falloff = 0.0
        gravityField.minimumRadius = 0.0
        gravityField.enabled = true
        gravityField.exclusive = true
        addChild(gravityField)
        
        
        
        let leftWheel = Wheel(radius: size.height / 2.0)
        leftWheel.position = CGPointMake(size.width + (size.height / 2.0), size.height / 2.0)
        leftWheel.name = Statics.Nodes.Wheels.Left
        addChild(leftWheel)
        
        let rightWheel = Wheel(radius: size.height / 2.0)
        rightWheel.position = CGPointMake(-(size.height / 2.0), size.height / 2.0)
        rightWheel.name = Statics.Nodes.Wheels.Right
        addChild(rightWheel)

        
    }
    
    
    
    
    
    func panGestureRecognized(panGestureRecognizer: UIPanGestureRecognizer) {
        
        panState = panGestureRecognizer.state
        
        switch panGestureRecognizer.state {
        case UIGestureRecognizerState.Began:
            
            if let gravityField = childNodeWithName(Statics.Nodes.GravityField) as? SKFieldNode {
                gravityField.removeAllActions()
                intialGravityFieldPosition = gravityField.position
            }
            
        case UIGestureRecognizerState.Changed:
            
            let translationInView = panGestureRecognizer.translationInView(panGestureRecognizer.view)
            
            if let gravityField = childNodeWithName(Statics.Nodes.GravityField) as? SKFieldNode {
                gravityField.position = CGPointMake(intialGravityFieldPosition.x + translationInView.x, intialGravityFieldPosition.y - translationInView.y)
            }
            
            if let leftWheel = childNodeWithName(Statics.Nodes.Wheels.Left) as? Wheel {
                leftWheel.physicsBody?.applyAngularImpulse(panGestureRecognizer.velocityInView(panGestureRecognizer.view).y / 10000.0)
            }
            
            if let rightWheel = childNodeWithName(Statics.Nodes.Wheels.Right) as? Wheel {
                rightWheel.physicsBody?.applyAngularImpulse(-panGestureRecognizer.velocityInView(panGestureRecognizer.view).y / 10000.0)
            }
            
        case .Ended, .Cancelled, .Failed, .Possible:
            
            if let gravityField = childNodeWithName(Statics.Nodes.GravityField) as? SKFieldNode {
                
                if !gravityField.hasActions() {
                    gravityField.runAction(SKAction.moveToX(size.width / 2.0, duration: 0.5))
                }
            }
        }
    }
    
    
    override func update(currentTime: NSTimeInterval) {
        super.update(currentTime)
        
        for child in children {
            
            if let dot = child as? Dot {
                dot.zRotation *= 0.95
                dot.physicsBody?.angularVelocity *= 0.95
            }
        }
    }

    
    func pinchGestureRecognized(pinchGestureRecognizer: UIPinchGestureRecognizer) {
        
        switch pinchGestureRecognizer.state {
        case UIGestureRecognizerState.Began:
            
            if let camera = childNodeWithName(Statics.Nodes.Camera) as? Camera {
                intialCameraScale = camera.xScale
            }
            
        case UIGestureRecognizerState.Changed:
            
            if let camera = childNodeWithName(Statics.Nodes.Camera) as? Camera {
                
                let newScale = min(5.0, max(1.0, intialCameraScale - (pinchGestureRecognizer.scale - 1.0)))
                camera.xScale = newScale
                camera.yScale = newScale
            }
            
        default: break
        }
    }

}

extension DotsScene: DotDelegate {
    
    func tappedDot(dot: Dot) {
        
        dot.runAction(dot.addToShoppingList()) { () -> Void in
            print("added \(dot.imageIndex) to shopping list!")
        }

    }
}

