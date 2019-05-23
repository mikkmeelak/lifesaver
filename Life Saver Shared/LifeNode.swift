//
//  LifeNode.swift
//  Life Saver
//
//  Created by Brad Root on 5/23/19.
//  Copyright © 2019 Brad Root. All rights reserved.
//

import SpriteKit

class LifeNode: SKSpriteNode {
    let relativePosition: CGPoint
    var alive: Bool
    var timeInState: Int = 0
    var aliveColor: SKColor

    init(relativePosition: CGPoint, alive: Bool, color: SKColor, size: CGSize) {
        self.relativePosition = relativePosition
        self.alive = alive
        aliveColor = color
        super.init(texture: FileGrabber.shared.getSKTexture(named: "square"), color: aliveColor, size: size)
        anchorPoint = CGPoint(x: 0, y: 0)
        colorBlendFactor = 1
        zPosition = 0
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    public func live(duration: TimeInterval) {
        if alive {
            timeInState += 1
            return
        }

        removeAllActions()
        timeInState = 0
        alive = true

        let fadeAction = SKAction.fadeAlpha(to: 1, duration: duration)
        let colorAction = SKAction.colorize(with: aliveColor, colorBlendFactor: 1, duration: duration)
        let actionGroup = SKAction.group([fadeAction, colorAction])
        actionGroup.timingMode = .easeInEaseOut
        run(actionGroup)
    }

    public func die(duration: TimeInterval) {
        if !alive {
            timeInState += 1
            return
        }

        removeAllActions()
        timeInState = 0
        alive = false

        let fadeAction = SKAction.fadeAlpha(to: 0.2, duration: duration)
        fadeAction.timingMode = .easeInEaseOut
        run(fadeAction)
    }
}