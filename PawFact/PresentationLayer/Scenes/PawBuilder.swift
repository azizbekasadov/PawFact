//
//  PawBuilder.swift
//  PawFact
//
//  Created by Azizbek Asadov on 08/03/23.
//

import Foundation

struct PawBuilder {
    static func build() -> PawViewController {
        let apiService = APIImpl()
        let worker = PawWorker(apiService: apiService)
        let interactor = PawInteractor(worker: worker)
        
        let viewController = PawViewController()
        viewController.interactor = interactor
        return viewController
    }
}
