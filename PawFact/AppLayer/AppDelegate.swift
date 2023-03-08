//
//  AppDelegate.swift
//  PawFact
//
//  Created by Azizbek Asadov on 08/03/23.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    private var statusItem: NSStatusItem!
    private var popOver: NSPopover!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        initStatusItem()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    private func initStatusItem() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let statusButton = statusItem.button {
            statusButton.image = NSImage(systemSymbolName: "pawprint.circle",
                                         accessibilityDescription: "Paw")
            statusButton.action = #selector(togglePopOver(_:))
        }
        
        popOver = NSPopover()
        popOver.contentSize = NSSize(width: 400, height: 200)
        popOver.behavior = .transient
        popOver.contentViewController = PawBuilder.build()
    }

    @objc
    private func togglePopOver(_ sender: Any) {
        if let button = statusItem.button {
            if popOver.isShown {
                popOver.performClose(sender)
            } else {
                popOver.show(relativeTo: button.bounds,
                             of: button,
                             preferredEdge: .minY)
            }
        }
    }
}

