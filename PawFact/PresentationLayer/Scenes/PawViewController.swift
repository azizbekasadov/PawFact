//
//  ViewController.swift
//  PawFact
//
//  Created by Azizbek Asadov on 08/03/23.
//

import Cocoa

protocol PawDisplayLogic: AnyObject {
    @MainActor func showError(_ error: Error)
    @MainActor func showFact(_ fact: Fact)
}

final class PawViewController: NSViewController {
    private lazy var textView: NSTextView = {
        let tview = NSTextView(frame: .zero)
        tview.drawsBackground = false
        tview.isEditable = false
        tview.translatesAutoresizingMaskIntoConstraints = false
        return tview
    }()
    
    var interactor: PawBusinessLogic!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        Task {
            await loadFact()
        }
    }
    
    override func loadView() {
        let rect = NSRect(x: 0, y: 0, width: 400, height: 200)
        view = NSView(frame: rect)
    }
    
    private func loadFact() async {
        await interactor?.fetchFact()
    }
    
    private func setupUI() {
        view.addSubview(textView)
        
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            textView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textView.widthAnchor.constraint(equalToConstant: 400),
            textView.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}

extension PawViewController: PawDisplayLogic {
    @MainActor func showError(_ error: Error) {
        textView.string = error.localizedDescription
    }
    
    @MainActor func showFact(_ fact: Fact) {
        textView.string = fact.fact
    }
}
