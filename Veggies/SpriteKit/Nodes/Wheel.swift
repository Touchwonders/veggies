//
//  Wheel.swift
//  Veggies
//
//  Created by RHLJH Hooijmans on 22/08/15.
//  Copyright © 2015 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Wheel: SKSpriteNode {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(radius: CGFloat){
        super.init(texture: SKTexture(imageNamed: "wheel"), color: .blackColor(), size: CGSizeMake(radius * 2.0, radius * 2.0))
        
        
        userInteractionEnabled = true
        
        physicsBody = SKPhysicsBody(circleOfRadius: radius + 1.0)
        if let physicsBody = physicsBody {
            physicsBody.pinned = true
            physicsBody.dynamic = true
            physicsBody.usesPreciseCollisionDetection = false
            physicsBody.allowsRotation = true
            physicsBody.resting = false
            physicsBody.affectedByGravity = false
            physicsBody.friction = 0.8
            physicsBody.restitution = 0.1
            physicsBody.linearDamping = 0.01
            physicsBody.angularDamping = 0.1
            physicsBody.mass = 1.0
        }

    }
}