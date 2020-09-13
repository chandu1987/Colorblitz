//
//  GameViewController.swift
//  Color Blitz!
//
//  Created by Chandra Sekhar Ravi on 09/09/2020.
//  Copyright © 2020 Chandra Sekhar. All rights reserved.
//

import UIKit
import Skillz

class GameViewController: UIViewController {
    
    var skillz: Skillz!


    override func viewDidLoad() {
        super.viewDidLoad()
        

                    let skView = self.view as! SKView
                    let scene = ColorBlitzScene(size:CGSize(width: 1536, height: 2048))
                    skView.showsFPS = true
                    skView.showsNodeCount = true
                    skView.ignoresSiblingOrder = true
                    scene.scaleMode = .aspectFill
                    skillz = Skillz.skillzInstance()
                    skView.presentScene(scene)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
