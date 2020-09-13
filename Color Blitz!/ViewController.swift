//
//  ViewController.swift
//  Color Blitz!
//
//  Created by Chandra Sekhar Ravi on 07/09/2020.
//  Copyright © 2020 Chandra Sekhar. All rights reserved.
//

import UIKit
import SpriteKit
import Skillz



class ViewController: UIViewController {
    
    

    var skillz: Skillz!

    
    var animate = false
    var animateCompleting = false
    var animationPending = false

    
    @IBOutlet weak var revolvingButton:UIButton!
    @IBOutlet weak var controlButton:UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        skillz = Skillz.skillzInstance()

        
    }
    
    
    @IBAction func startGame(){
        
        skillz.launch()

    }
    
    
  
    



}

