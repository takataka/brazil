//
//  AppDelegate.swift
//  CrayonCannon
//
//  Created by Luke Iannini on 8/24/14.
//  Copyright (c) 2014 tree. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    
    @IBOutlet weak var gameViewController: GameViewController!
    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        window.makeFirstResponder(gameViewController)
        // Insert code here to initialize your application
    }
    
}
