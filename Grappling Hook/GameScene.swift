//
//  GameScene.swift
//  Grappling Hook
//
//  Created by mitchell hudson on 7/4/16.
//  Copyright (c) 2016 mitchell hudson. All rights reserved.
//


/*
 
 This example attempts to illustrate a grappling hook mechanic using physics. 
 
 Note: this example needs some work. it illustrate the idea but the effect is somewhat random.
 
 The example is built around SKPhysicsJointSpring used to connect the player to 
 a target object. Advantages of this approach: 
 
    1. Using this method you would get realisitic pring like motion
    2. You can also use physics collisions as the spring joint will repsect these. 
    3. Would be possible to attach the target to a moving object.
 
 Disadvantages of this method:
    
    1. Seems more complex than other methods. See the note above.
 
 */

import SpriteKit

class GameScene: SKScene {
    
    var player: SKSpriteNode!
    var rope: SKShapeNode!
    var ropeTarget: SKSpriteNode!
    var springJoint = SKPhysicsJointSpring()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        // Edge loop
        physicsBody = SKPhysicsBody(edgeLoopFromRect: view.frame)
        
        
        // Player
        let playerSize = CGSize(width: 30, height: 30)
        player = SKSpriteNode(color: UIColor.redColor(), size: playerSize)
        addChild(player)
        player.position.x = 200
        player.position.y = 100
        player.physicsBody = SKPhysicsBody(rectangleOfSize: playerSize)
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.linearDamping = 0.5
        
        // Rope
        rope = SKShapeNode()
        addChild(rope)
        
        // Rope Target
        let ropeTargetSize = CGSize(width: 10, height: 10)
        ropeTarget = SKSpriteNode(color: UIColor.blueColor(), size: ropeTargetSize)
        addChild(ropeTarget)
        ropeTarget.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        ropeTarget.physicsBody?.dynamic = false
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        // On a touch find the position of the touch
        let touch = touches.first
        let location = touch?.locationInNode(self)
        
        
        // remove the previouse joint
        physicsWorld.removeJoint(springJoint)
        
        // NOTE! The length of the spring is set to the distance between the objects!
        // To work with this fact move the target to the position of the player.
        ropeTarget.position = player.position
        
        // Make a spring joint. Attach it to the player and the target
        springJoint = SKPhysicsJointSpring.jointWithBodyA(
            ropeTarget.physicsBody!,
            bodyB: player.physicsBody!,
            anchorA: ropeTarget.position,
            anchorB: player.position)
        
        springJoint.damping = 3
        springJoint.frequency = 3
        
        // Add the joint to the physics world
        physicsWorld.addJoint(springJoint)
        
        // Now move the target to the touch position.
        ropeTarget.position = location!
        // The length of the spring has been set to zero since the position 
        // of the target was set to the position of the player above. 
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        // This code handles drawing the line between the player and target
        let ropePath = CGPathCreateMutable()
        CGPathMoveToPoint(ropePath, nil, player.position.x, player.position.y)
        CGPathAddLineToPoint(ropePath, nil, ropeTarget.position.x, ropeTarget.position.y)
        rope.path = ropePath
        rope.strokeColor = UIColor.orangeColor()
        rope.lineWidth = 4
        
    }
}
