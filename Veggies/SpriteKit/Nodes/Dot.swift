//
//  Dot.swift
//  Veggies
//
//  Created by RHLJH Hooijmans on 22/08/15.
//  Copyright © 2015 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

protocol DotDelegate: class {
    func tappedDot(dot: Dot)
}

class Dot: SKSpriteNode {
    
    weak var delegate: DotDelegate?
    
    var imageIndex: Int = 0
    var initialRadius: CGFloat = 0.0
    var multiplier: Int = 0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(radius: CGFloat, index: Int){
        super.init(texture: SKTexture(imageNamed: "veggie\(index)"), color: .blackColor(), size: CGSizeMake(radius * 2.0, radius * 2.0))
        
        imageIndex = index
        initialRadius = radius
        
        
        let randomValue = CGFloat(Int(arc4random()) % 100) / 100.0
        
        name = Statics.Nodes.Dot
        userInteractionEnabled = true
        physicsBody = SKPhysicsBody(circleOfRadius: radius + 1.0)
        if let physicsBody = physicsBody {
            physicsBody.dynamic = true
            physicsBody.usesPreciseCollisionDetection = false
            physicsBody.allowsRotation = true
            physicsBody.pinned = false
            physicsBody.resting = false
            physicsBody.friction = 0.01
            physicsBody.restitution = 0.1
            physicsBody.linearDamping = randomValue * 10.0
            physicsBody.angularDamping = 0.01
            physicsBody.mass = randomValue
            physicsBody.affectedByGravity = true
        }

    }
    
    
    
    func addToShoppingList() -> SKAction {
        
        multiplier = multiplier == 0 ? 1 : 0
        
        let initialScale: CGFloat = xScale
        let duration: NSTimeInterval = 0.2
        let scale: CGFloat = 1.0 + (CGFloat(multiplier) * 0.5)
        
        let growToNewScale = SKAction.customActionWithDuration(duration) { (node, elapsedTime) -> Void in
            
            let t: CGFloat = elapsedTime / CGFloat(duration)
            let p: CGFloat = t * t
            let s: CGFloat = initialScale * (1.0 - p) + scale * p
            node.setScale(s)
        }
        
        return growToNewScale
    }

    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        delegate?.tappedDot(self)
    }
}