//
//  AppDelegate.swift
//  DictionaryBar
//
//  Created by NHNEnt on 15/02/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    private enum ACTION_TYPE {
        case VIEW, MENU
    }
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    let popover = NSPopover()
    let menu = NSMenu()
    
    private var prevAction: ACTION_TYPE?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application

        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))

        if let button = statusItem.button {
            button.image = NSImage(named: NSImage.Name("dictionary_512"))
            button.action = #selector(toggleViewMenu(_:))
            button.target = self
            button.sendAction(on: [.rightMouseUp])
            
            let gesture = NSPressGestureRecognizer(target: self, action: #selector(handlePressGesture))
            button.addGestureRecognizer(gesture)
            
            let clickLeftGesture = NSClickGestureRecognizer(target: self, action: #selector(handleClickGesture))
            button.addGestureRecognizer(clickLeftGesture)
        }
        
        popover.contentViewController = SearchViewController.initialLoad()
 
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        
    }
    
    @objc func handlePressGesture(_ recognizer: NSPressGestureRecognizer) {
        
        if recognizer.state == .ended {
            showMenu()
        }
        
    }
    
    @objc func handleClickGesture(_ recognizer: NSClickGestureRecognizer) {
        
        prevAction = ACTION_TYPE.VIEW
        
        if popover.isShown {
            closePopover(sender: nil)
        } else {
            showPopover(sender: nil)
        }
        
    }
    
    @objc func toggleViewMenu(_ sender: Any?) {

        if NSApp.currentEvent!.type == NSEvent.EventType.rightMouseUp {
            showMenu()
        }
    }
    
    private func showMenu() {
        
        if prevAction ?? ACTION_TYPE.MENU == ACTION_TYPE.VIEW {
            closePopover(sender: nil)
        }
        
        let button = statusItem.button!
        let x = button.frame.origin.x
        let y = button.frame.origin.y - 5
        let location = button.superview!.convert(NSMakePoint(x, y), to: nil)
        let w = button.window!
        let event = NSEvent.mouseEvent(with: .rightMouseUp,
                                       location: location,
                                       modifierFlags: NSEvent.ModifierFlags(rawValue: 0),
                                       timestamp: 0,
                                       windowNumber: w.windowNumber,
                                       context: nil,
                                       eventNumber: 0,
                                       clickCount: 1,
                                       pressure: 0)!
        NSMenu.popUpContextMenu(menu, with: event, for: button)
    }
  
    func showPopover(sender: Any?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }
    
    func closePopover(sender: Any?) {
        popover.performClose(sender)
    }
    
}
