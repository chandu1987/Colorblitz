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
    var colorNames = ["Blue","Red","Yellow","Green"]
    var currentColor:String?
    var currentNo: UInt32 = 0

    var score = 0
    
    var currentRotationDirection = rotationDirection.none
    
    var colorWheel : SKNode?
    var colorBar : SKSpriteNode?
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
              colorWheel!.zRotation = .pi/4
              addChild(colorWheel!)

        
    }
    
    
    func addColorBar(){
        
//        let rectangle = CGRect(x: 0, y: 0, width: 300, height: 50)
//        let path = UIBezierPath(roundedRect: rectangle, cornerRadius: 20)
//        colorBar  = SKShapeNode(path:path.cgPath, centered: false)
//       // colorBar!.physicsBody = SKPhysicsBody(rectangleOf: path.cgPath)
//        colorBar!.physicsBody?.affectedByGravity = false
//        changeColor()
//        colorBar!.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
//        colorBar!.zRotation = .pi/2
//        self.addChild(colorBar!)
        
        colorBar = createImage()
        changeColor()
        colorBar!.colorBlendFactor = 1.0
        colorBar!.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 300))
        colorBar!.physicsBody?.affectedByGravity = false
        colorBar!.position = CGPoint(x: self.frame.midX , y: self.frame.midY)
        colorBar!.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        addChild(colorBar!)
      //  colorBar?.zRotation = .pi
        

    }
    
    override func update(_ currentTime: TimeInterval) {
        let targetNode = colorWheel!.childNode(withName: "Green")!
        print("Chandu - \(targetNode.zRotation)")
        print("Chandu - \(colorBar!.zRotation)")
        if colorBar!.zRotation == targetNode.zRotation{
            
            
        }
        




    }
    
    func createImage() -> SKSpriteNode{
            UIGraphicsBeginImageContext(CGSize(width: 50, height: 300))
            UIColor.white.setFill()
            let rectangle = CGRect(x: 0, y: 0, width: 50, height: 300)
            let path = UIBezierPath(roundedRect: rectangle, cornerRadius: 20)
            path.fill()
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        
            let texture = SKTexture(image: image!)
            return SKSpriteNode(texture: texture)

    }
    
    
    func addScoreLabel(){
          scoreLabel = SKLabelNode(fontNamed: "Helvetica")
          scoreLabel!.text = String(score)
          scoreLabel!.fontColor = .white
          scoreLabel!.horizontalAlignmentMode = .center
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
            section.name = colorNames[i]
            section.zRotation = rotationFactor * CGFloat(i);
            container.addChild(section)
        }
        return container
    }
        
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            
        score = score + 1
        scoreLabel?.text = String(score)
        skillz.updatePlayersCurrentScore(score as NSNumber)
        
            
//        print("Chandu - \(distanceBetweenTwoNodes(first: targetNode.position, second: colorBar!.position))")
        

//        if colorBar!.intersects(colorWheel!.childNode(withName: currentColor!)!){
//            print("Chandu - yesssss")
//        }else{
//            print("Chandu - Nooooo")
//        }

        
    
//        if score == 20 {
//
//        }
        
        changeColor()
        
        
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
        let randomIndex = randomNumber(maximum: UInt32(self.colors!.count))
        let color = colors![randomIndex]
        colorBar?.color = color
     //   colorBar!.fillColor = color
       // colorBar?.strokeColor = color
        currentColor = colorNames[randomIndex]
    }
    
    func randomNumber(maximum: UInt32) -> Int {

        var randomNumber: UInt32
        repeat {
            randomNumber = (arc4random_uniform(maximum))
        }while currentNo == randomNumber

        currentNo = randomNumber

        return Int(randomNumber)
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


extension SKSpriteNode {
    func addTo(parent:SKNode?, withRadius:CGFloat) {
        guard parent != nil else { return }
        guard  withRadius>0.0 else {
            parent!.addChild(self)
            return
        }
        let radiusShape = SKShapeNode.init(rect: CGRect.init(origin: CGPoint.zero, size: size), cornerRadius: withRadius)
        radiusShape.position = CGPoint.zero
        radiusShape.lineWidth = 2.0
        radiusShape.fillColor = UIColor.red
        radiusShape.strokeColor = UIColor.red
        radiusShape.zPosition = 2
        radiusShape.position = CGPoint.zero
        let cropNode = SKCropNode()
        cropNode.position = self.position
        cropNode.zPosition = 3
        cropNode.addChild(self)
        cropNode.maskNode = radiusShape
        parent!.addChild(cropNode)
    }
}
