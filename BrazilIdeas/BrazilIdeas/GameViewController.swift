//
//  GameViewController.swift
//  BrazilIdeas
//
//  Created by Mike Rotondo on 8/23/14.
//  Copyright (c) 2014 Taka Taka. All rights reserved.
//

import SceneKit
import QuartzCore

class GameViewController: NSViewController {
    
    @IBOutlet var gameView: GameView
    
    override func awakeFromNib(){
        // create a new scene
        let scene = SCNScene()
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 2)
        
        // create and add a 3d box to the scene
        let boxNode = SCNNode()
        boxNode.geometry = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0.02)
        scene.rootNode.addChildNode(boxNode)
        
        // create and configure a material
        let material = SCNMaterial()
        material.diffuse.contents = NSImage(named: "texture")
        material.specular.contents = NSColor.whiteColor()
        material.specular.intensity = 0.2
        material.locksAmbientWithDiffuse = true
        
        // set the material to the 3d object geometry
        boxNode.geometry.firstMaterial = material
        
        // animate the 3d object
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "rotation")
        animation.toValue = NSValue(SCNVector4: SCNVector4(x: 1, y: 1, z: 0, w: M_PI*2))
        animation.duration = 5
        animation.repeatCount = MAXFLOAT //repeat forever
        boxNode.addAnimation(animation, forKey: "")
        
        // set the scene to the view
        self.gameView!.scene = scene
        
        // allows the user to manipulate the camera
        self.gameView!.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        self.gameView!.showsStatistics = true
        
        // configure the view
        self.gameView!.backgroundColor = NSColor.blackColor()
    }

}
