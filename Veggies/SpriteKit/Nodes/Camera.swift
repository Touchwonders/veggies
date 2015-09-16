//
//  Camera.swift
//  Veggies
//
//  Created by RHLJH Hooijmans on 07/09/15.
//  Copyright © 2015 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Camera: SKCameraNode {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        super.init()
        
        name = Statics.Nodes.Camera
    }
}