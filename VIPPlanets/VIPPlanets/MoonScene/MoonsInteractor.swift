//
//  MoonsInteractor.swift
//  VIPPlanets
//
//  Created by Александр Рахимов on 26.04.2023.
//

import Foundation

protocol IMoonsInteractor: AnyObject {
    var moonsWorker: IMoonssWorker? { get set }
    var moonsPresenter: IMoonsPresenter? { get set }
    func getDataMoons(moons: [Moon]) async throws
}

class MoonsInteractor: IMoonsInteractor {
    var moonsWorker: IMoonssWorker?
    var moonsPresenter: IMoonsPresenter?
    
    func getDataMoons(moons: [Moon]) async throws {
        
    }
}
