//
//  WhackSlot.swift
//  Whack-a-Penguin
//
//  Created by Dulio Denis on 2/15/15.
//  Copyright (c) 2015 ddApps. All rights reserved.
//

import UIKit
import SpriteKit

class WhackSlot: SKNode {
    
    var charNode: SKSpriteNode!
    
    var isVisible = false
    var isHit = false
    
    func configureAtPosition(pos: CGPoint) {
        position = pos
        
        let sprite = SKSpriteNode(imageNamed: "whackHole")
        addChild(sprite)
        
        let cropNode = SKCropNode()
        cropNode.position = CGPoint(x: 0, y: 15)
        cropNode.zPosition = 1
        cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask")
        charNode = SKSpriteNode(imageNamed: "penguinGood")
        charNode.position = CGPoint(x: 0, y: -90)
        charNode.name = "character"
        cropNode.addChild(charNode)
        
        addChild(cropNode)
    }
    
    func show(#hideTime: Double) {
        if isVisible { return }
        
        charNode.runAction(SKAction.moveByX(0, y: 80, duration: 0.05))
        isVisible = true
        isHit = false
        
        if RandomInt(min: 0, max: 2) == 0 {
            charNode.texture = SKTexture(imageNamed: "penguinGood")
            charNode.name = "charFriend"
        } else {
            charNode.texture = SKTexture(imageNamed: "penguinEvil")
            charNode.name = "charEnemy"
        }
        
        charNode.xScale = 1
        charNode.yScale = 1
        
        runAfterDelay(hideTime * 3.5) { [unowned self] in
            self.hide()
        }
    }
    
    func hide() {
        if !isVisible { return }
        
        charNode.runAction(SKAction.moveByX(0, y: -80, duration: 0.05))
        isVisible = false
    }
    
    func hit() {
        isHit = true
        let delay = SKAction.waitForDuration(0.25)
        let hide = SKAction.moveByX(0, y: -80, duration: 0.5)
        let notVisible = SKAction.runBlock { [unowned self] in self.isVisible = false }
        let sequence = SKAction.sequence([delay, hide, notVisible])
        charNode.runAction(sequence)
    }
}
