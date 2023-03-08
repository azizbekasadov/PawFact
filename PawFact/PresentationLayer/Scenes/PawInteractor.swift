//
//  PawInteractor.swift
//  PawFact
//
//  Created by Azizbek Asadov on 08/03/23.
//

import Foundation

protocol PawBusinessLogic: AnyObject {
    func fetchFact() async
}

final class PawInteractor {
    weak var viewController: PawViewController?
    
    private let worker: PawWorker
    
    init(worker: PawWorker) {
        self.worker = worker
    }
}

extension PawInteractor: PawBusinessLogic {
    func fetchFact() async {
        await worker.loadFact { [weak self] result in
            switch result {
            case .success(let fact):
                await self?.viewController?.showFact(fact)
            case .failure(let error):
                await self?.viewController?.showError(error)
            }
        }
    }
}
