//
//  main.swift
//  PawFact
//
//  Created by Azizbek Asadov on 08/03/23.
//

import AppKit

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate

let main = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
print(main.description)
