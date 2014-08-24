//
//  Beam.swift
//  BrazilIdeas
//
//  Created by Mike Rotondo on 8/23/14.
//  Copyright (c) 2014 Taka Taka. All rights reserved.
//

import Cocoa
import SceneKit

class Beam: SCNNode {
    
    var beamNode : SCNNode
    var pyramidNode : SCNNode
    var rings : [SCNNode]
    
    override init() {
        let height : CGFloat = 100.0
        
        beamNode = SCNNode()
        beamNode.geometry = SCNCylinder()
        beamNode.scale = SCNVector3(x: 1, y: height * 2, z: 1)
        let beamColor = NSColor(
            calibratedRed: CGFloat(arc4random_uniform(1000)) / 1000,
            green: CGFloat(arc4random_uniform(1000)) / 1000,
            blue: CGFloat(arc4random_uniform(1000)) / 1000,
            alpha: 0.5)
        beamNode.geometry.firstMaterial.diffuse.contents = beamColor
        beamNode.geometry.firstMaterial.emission.contents = beamColor
        
        pyramidNode = SCNNode()
        pyramidNode.geometry = SCNCone(topRadius: 0.5, bottomRadius: 10, height: 4)

        let numRings = 5
        rings = []
        for i in (0..<numRings) {
            let scale = randFloat() * 3
            let ring = SCNNode()
            ring.geometry = SCNTorus(ringRadius: scale, pipeRadius: 0.25)
            ring.position = SCNVector3(x: 0, y: randFloat() * height, z: 0)
            rings.append(ring)
        }
        
        super.init()
        
        self.addChildNode(beamNode)
        self.addChildNode(pyramidNode)
        for ring in self.rings {
            self.addChildNode(ring)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("Sucks")
    }

    
}
