//
//  PlanetsInteractor.swift
//  VIPPlanets
//
//  Created by Александр Рахимов on 26.04.2023.
//

import Foundation

protocol IPlanetsInteractor: AnyObject {
    func getDataPlanets() async throws
}

class PlanetsInteractor: IPlanetsInteractor {
    
    var planetWorker: PlanetsWorker?
    var planetPresenter: IPlanetsPresenter?
    
    func getDataPlanets() async throws {
        guard let planets = try await planetWorker?.fetchUserData() else { print(Errors.bodiesNil); return }
        let response = PlanetsList.FetchPlanetsList.Response(planets: planets)
        try await planetPresenter?.createPlanetsForViewModel(bodies: response)
    }
}
