//
//  GameView.swift
//  CrayonCannon
//
//  Created by Luke Iannini on 8/24/14.
//  Copyright (c) 2014 tree. All rights reserved.
//

import SceneKit
import SceneKrift

func randFloat() -> CGFloat {
    return CGFloat(arc4random_uniform(10000)) / 10000
}

class GameView: OVRView {
    let player = SCNNode(geometry: SCNSphere(radius: 2))
    
    let possibleGeometries = [
//        SCNCone(topRadius: 0, bottomRadius: 1, height: 1),
        SCNPyramid(width: 1, height: 1, length: 1),
//        SCNCylinder(radius: 1, height: 1),
        SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0),
//        SCNTorus(ringRadius: 1, pipeRadius: 1),
//        SCNCapsule(capRadius: 1, height: 1),
//        SCNTube(innerRadius: 0.5, outerRadius: 1, height: 1)
    ]
    
    override func awakeFromNib(){
        super.awakeFromNib()
        // set the scene to the view
        self.scene = SCNScene()
        self.scene.background.contents = NSColor.redColor()
        
        self.window?.makeFirstResponder(self)
        
        // allows the user to manipulate the camera
//        self.allowsCameraControl = true
        
        // show statistics such as fps and timing information
//        self.showsStatistics = true
        
        // configure the view
//        self.backgroundColor = NSColor.blackColor()
        
        // create and add a camera to the scene
//        let cameraNode = player
//        cameraNode.camera = SCNCamera()
//        cameraNode.camera.automaticallyAdjustsZRange = true
        // place the camera
//        cameraNode.position = SCNVector3(x: 0, y: 0, z: 0)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light.type = SCNLightTypeAmbient
        ambientLightNode.light.color = NSColor.darkGrayColor()
        scene.rootNode.addChildNode(ambientLightNode)
        
        let floor = SCNFloor()
        let floorNode = SCNNode(geometry:floor)
        floorNode.physicsBody = SCNPhysicsBody(type: .Static, shape: nil)
        floor.firstMaterial.diffuse.contents = NSColor.whiteColor()
        scene.rootNode.addChildNode(floorNode)
        self.createPlayer()
        self.createCities()
    }
    
    func gimmeGeometry() -> SCNGeometry {
        let count = UInt32(possibleGeometries.count)
        return possibleGeometries[Int(arc4random_uniform(count))]
    }
    
    func createCities() {
        for cityX in 0..<100 {
            for cityZ in 0..<100 {
                if arc4random_uniform(20) == 0 {
                    addCityAtPoint((cityX - 50) * 100, cityZ: (cityZ - 50) * 100)
                }
            }
        }
    }
    
    func addCityAtPoint(cityX:Int, cityZ:Int) {
        let geom = gimmeGeometry().copy() as SCNGeometry
        let baseHue = randFloat()
        
        let spire = SCNNode(geometry:SCNBox(width: 5, height: 1000, length: 5, chamferRadius: 0))
        spire.geometry.firstMaterial.diffuse.contents = NSColor(
            hue:baseHue,
            saturation:0.8,
            brightness:1,
            alpha:0.9)
        spire.position = SCNVector3(x: CGFloat(cityX + 5), y: 500, z: CGFloat(cityZ + 5))
        scene.rootNode.addChildNode(spire)
        
//        for x in 0..<10 {
//            for z in 0..<10 {
//                let node = SCNNode(geometry:geom)
//                let nodeHue = baseHue + CGFloat(arc4random_uniform(1000)) / 1000 * 0.1
//                node.position = SCNVector3(x: CGFloat(x + cityX), y: -10, z: CGFloat(z + cityZ))
//                
//                geom.firstMaterial = SCNMaterial()
//                
//                geom.firstMaterial.diffuse.contents = NSColor(
//                    hue:nodeHue, saturation:0.5, brightness:1, alpha: 1)
//                node.scale = SCNVector3Make(1, randFloat() * 20 + 0.1, 1)
//                
//                scene.rootNode.addChildNode(node)
//            }
//        }
    }
    
    func createPlayer() {
        player.position = SCNVector3(x: 0, y: 1, z: 0)
        player.physicsBody = SCNPhysicsBody(type: .Dynamic, shape: nil)
        player.physicsBody.rollingFriction = 1
        player.physicsBody.angularDamping = 1
        scene.rootNode.addChildNode(player)
        player.addChildNode(self.headNode)
    }
    
    override func mouseDown(theEvent: NSEvent) {
//        player.physicsBody.applyForce(SCNVector3(
//            x: randFloat()*100 - 50, y: randFloat()*100, z: randFloat()*100 - 50), impulse: true)
        super.mouseDown(theEvent)
    }
    
    override func keyDown(theEvent: NSEvent!) {
        println("Key: \(theEvent.keyCode)")
        let (left:UInt16, right:UInt16, down:UInt16, up:UInt16) = (123, 124, 125, 126)
        let enter:UInt16 = 36
        SCNTransaction.begin()
        SCNTransaction.setAnimationDuration(0.5)
        switch theEvent.keyCode {
        case left:
            player.transform = SCNMatrix4Rotate(player.transform, 0.3, 0, 1, 0)
        case right:
            player.transform = SCNMatrix4Rotate(player.transform, -0.3, 0, 1, 0)
        case up:
            player.transform = SCNMatrix4Rotate(player.transform, -0.3, 1, 0, 0)
        case down:
            player.transform = SCNMatrix4Rotate(player.transform, 0.3, 1, 0, 0)
        case enter:
            player.physicsBody.applyForce(
                SCNVector3(
                    x: player.rotation.x * 500,
                    y: player.rotation.y * 500,
                    z: player.rotation.z * 500),
                impulse: true)
        default:
            println("wha")
        }
        SCNTransaction.commit()
    }
}
