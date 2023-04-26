//
//  PlanetsPresenter.swift
//  VIPPlanets
//
//  Created by Александр Рахимов on 26.04.2023.
//

import Foundation

protocol IPlanetsPresenter: AnyObject {
    var planetViewController: IPlanetsViewController? { get set }
    func createPlanetsForViewModel(bodies: [SolarSystemBody]) async throws
}

class PlanetsPresenter: IPlanetsPresenter {
    
    weak var planetViewController: IPlanetsViewController?
    
    func createPlanetsForViewModel(bodies: [SolarSystemBody]) async throws {
        var planetsForViewModel: [Planet] = []
        
        for body in bodies {
            if body.isPlanet {
                let planet = Planet(model: body)
                planetsForViewModel.append(planet)
            }
        }
        
        let viewModel = PlanetsList.FetchPlanetsList.ViewModel(planets: planetsForViewModel.sorted(by: { $0.perihelion < $1.perihelion }))
        DispatchQueue.main.async {
            self.planetViewController?.displaylanets(from: viewModel)
        }
    }
}
