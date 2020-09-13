//
//  ColorBlitzScene.swift
//  Color Blitz!
//
//  Created by Chandra Sekhar Ravi on 07/09/2020.
//  Copyright © 2020 Chandra Sekhar. All rights reserved.
//

import UIKit
import SpriteKit
import Skillz



enum rotationDirection{
      case clockwise
      case counterClockwise
      case none
  }

class ColorBlitzScene: SKScene {
    
    let segmentBlue =   UIColor(red: 26.0/255.0, green: 160.0/255.0, blue: 251.0/255.0, alpha: 1)
    let segmentRed = UIColor(red: 251.0/255.0, green: 0.0/255.0, blue: 53.0/255.0, alpha: 1)
    let segmentYellow = UIColor(red: 242.0/255.0, green: 224.0/255.0, blue: 17.0/255.0, alpha: 1)
    let segmentGreen = UIColor(red: 60.0/255.0, green: 187.0/255.0, blue: 97.0/255.0, alpha: 1)
    
    
    var colors : [UIColor]?
    let player = SKShapeNode(circleOfRadius: 40)
    var score = 0
    
    var currentRotationDirection = rotationDirection.none
    
    var colorWheel : SKNode?
    var colorBar : SKShapeNode?
    var button : SKSpriteNode?
    var scoreLabel : SKLabelNode?
    var tipsLabel : SKLabelNode?
    var skillz: Skillz!




    
    
    override func didMove(to view: SKView) {
        colors = [segmentBlue, segmentRed , segmentYellow , segmentGreen]
        setupGame()
        skillz = Skillz.skillzInstance()

       // backgroundColor = UIColor.white
    }


    func setupGame() {
        addColorCircle()
        addColorBar()
        addScoreLabel()
        addTipsLabel()
      // addSkillzButton()
    }
    
    func addColorCircle(){
        
        let path = UIBezierPath()
              path.move(to: CGPoint(x: 0, y: -400))
              path.addLine(to: CGPoint(x: 0, y: -360))
              path.addArc(withCenter: CGPoint.zero,
                          radius: 360,
                          startAngle: CGFloat(3.0 * .pi/2),
                          endAngle: CGFloat(0),
                          clockwise: true)

              path.addLine(to: CGPoint(x: 400, y: 0))
              path.addArc(withCenter: CGPoint.zero,
                          radius: 400,
                          startAngle: CGFloat(0.0),
                          endAngle: CGFloat(3.0 * .pi/2),
                          clockwise: false)


              colorWheel = obstacleByDuplicatingPath(path, clockwise: true)
              colorWheel!.position = CGPoint(x: size.width/2, y: size.height/2)
              addChild(colorWheel!)

              let rotateCircle = SKAction.rotate(byAngle: 0.7, duration: 0.1)
              colorWheel!.run(rotateCircle)
        
    }
    
    
    func addColorBar(){

        let cgPath = CGPath(roundedRect: CGRect(x: 0, y: 0, width: 300, height: 50), cornerWidth: 20, cornerHeight: 0, transform: nil)
        colorBar  = SKShapeNode(path:cgPath, centered: false)
        changeColor()
        colorBar!.physicsBody?.affectedByGravity = false
        colorBar!.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        //    colorBar?.anchorPoint = CGPoint(x: 1, y: 1)
        self.addChild(colorBar!)
    }
    
    
    func addScoreLabel(){
          scoreLabel = SKLabelNode(fontNamed: "Helvetica")
          scoreLabel!.text = String(score)
          scoreLabel!.fontColor = .white
          scoreLabel!.horizontalAlignmentMode = .right
          scoreLabel!.fontSize = 150
          scoreLabel!.position = CGPoint(x: size.width/2, y: colorWheel!.frame.origin.y + 600)
          addChild(scoreLabel!)

        
    }
    
    
    func addTipsLabel(){
             tipsLabel = SKLabelNode(fontNamed: "Helvetica")
             tipsLabel!.text = "Tips - Match the colors"
             tipsLabel!.fontColor = .white
             tipsLabel!.fontSize = 80
             tipsLabel!.position = CGPoint(x: size.width/2, y: colorWheel!.frame.origin.y - 600)
             addChild(tipsLabel!)
    }
    

    
    


    func obstacleByDuplicatingPath(_ path: UIBezierPath, clockwise: Bool) -> SKNode {

        let container = SKNode()
        var rotationFactor:CGFloat = .pi/2

        if !clockwise {
            rotationFactor *= -1
        }

        for i in 0...3 {
            let section = SKShapeNode(path: path.cgPath)
            section.fillColor = colors![i]
            section.strokeColor = colors![i]
            section.zRotation = rotationFactor * CGFloat(i);
            container.addChild(section)
        }
        return container
    }
    
    
//    func  addSkillzButton(){
//
//       let button = AGSpriteButton(color: UIColor.white, andSize: CGSize(width: 200, height: 60))
//       button.position = CGPoint(x: size.width/2, y: size.height - 200)
//       button.addTarget(self, selector: #selector(addSkillz), with: nil, for: .touchUpInside)
//       button.setLabelWithText("Skillz", andFont: nil, with: UIColor.black)
//       addChild(button)
//
//       }
    
    
//    @objc func addSkillz(){
//        print("Launching Skillz")
//        skillz.launch()
//        print("Starting Match")
//    }
    
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        
        score = score + 1
        scoreLabel?.text = String(score)
        skillz.updatePlayersCurrentScore(score as NSNumber)

        if score == 20 {
            
        }
        
        changeColor()
        
        tipsLabel?.isHidden = true
        
        let touch : UITouch = touches.first!
        let touchPosition = touch.location(in: self)
        let newRotationDirection : rotationDirection = touchPosition.x < self.frame.midX ? .clockwise : .counterClockwise
        
        if currentRotationDirection == .none{
            setupRotationWith(direction: newRotationDirection)
            currentRotationDirection = newRotationDirection
        }else{
            reverseRotation()
            currentRotationDirection = newRotationDirection
        }

//            if currentRotationDirection != newRotationDirection && currentRotationDirection != .none{
//              reverseRotation()
//              currentRotationDirection = newRotationDirection
//            } else if currentRotationDirection == newRotationDirection{
//              stopRotation()
//              currentRotationDirection = .none
//            } else if (currentRotationDirection == .none){
//            setupRotationWith(direction: newRotationDirection)
//            currentRotationDirection = newRotationDirection
//            }
        
    }

    func changeColor(){
     //   colorBar!.color = colors!.randomElement()!
        let color = colors!.randomElement()!
        colorBar!.fillColor = color
        colorBar?.strokeColor = color

    }

    func reverseRotation(){
        let oldRotateAction = colorBar!.action(forKey: "rotate")
        let newRotateAction = SKAction.reversed(oldRotateAction!)
        colorBar!.run(newRotateAction(), withKey: "rotate")
    }

    func stopRotation(){
        colorBar!.removeAction(forKey: "rotate")
    }

    func setupRotationWith(direction: rotationDirection){
        let angle : Float = (direction == .clockwise) ? .pi : -.pi
        let rotate = SKAction.rotate(byAngle: CGFloat(angle), duration: 1)
        let repeatAction = SKAction.repeatForever(rotate)
        colorBar!.run(repeatAction, withKey: "rotate")
    }

    func endGame(){
        skillz.displayTournamentResults(withScore:score as NSNumber, withCompletion: { () in
            print("Finished Display")
        })
    }

    
}
