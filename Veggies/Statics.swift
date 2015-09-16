//
//  Statics.swift
//  Veggies
//
//  Created by RHLJH Hooijmans on 07/09/15.
//  Copyright © 2015 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import UIKit

struct Statics {
    
    static let TintColor = UIColor(red: 255.0 / 255.0, green: 97.0 / 255.0, blue: 56.0 / 255.0, alpha: 255.0 / 255.0)
    static let DebugColor = UIColor(red: 100.0 / 255.0, green: 200.0 / 255.0, blue: 200.0 / 255.0, alpha: 255.0 / 255.0)
    
    struct Nodes {
        static let Dot: String = "DotNode"
        static let Camera: String = "CameraNode"
        static let GravityField: String = "GravityFieldNode"
        
        struct Wheels {
            static let Left: String = "LeftWheelNode"
            static let Right: String = "RightWheelNode"
        }
    }
}
