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
    
    @IBOutlet weak var gameView: GameView!
    
    override func awakeFromNib(){
        // create a new scene
        let scene = SCNScene()
        
        let floorNode = SCNNode()
        floorNode.geometry = SCNFloor()
        scene.rootNode.addChildNode(floorNode)
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.camera.automaticallyAdjustsZRange = true
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 2, z: 15)
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light.type = SCNLightTypeAmbient
        ambientLightNode.light.color = NSColor.darkGrayColor()
        scene.rootNode.addChildNode(ambientLightNode)
                
        for cool in 0..<10 {
            let beam = Beam()
            beam.position = SCNVector3(x: CGFloat(arc4random_uniform(100)) - 50, y: 0, z: CGFloat(arc4random_uniform(100)) - 50)
            scene.rootNode.addChildNode(beam)
        }
        
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
