//
//  ViewController.swift
//  Veggies
//
//  Created by RHLJH Hooijmans on 21/08/15.
//  Copyright © 2015 Robert-Hein Hooijmans. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func loadView() {
        view = DotsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteColor()
    }
}