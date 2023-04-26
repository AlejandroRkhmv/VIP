//
//  PlanetsModel.swift
//  VIPPlanets
//
//  Created by Александр Рахимов on 26.04.2023.
//

import Foundation

// MARK: - API model
// MARK: - SolarSystemBodies
struct SolarSystemBodies: Codable {
    let bodies: [SolarSystemBody]
}

// MARK: - Body
struct SolarSystemBody: Codable {
    let id, name, englishName: String
    let isPlanet: Bool
    let moons: [Moon]?
    let gravity: Double
    let meanRadius: Double
    let bodyType: String
    let perihelion: Int
}

// MARK: - Moon
struct Moon: Codable {
    let moon: String
    let rel: String
}

// MARK: - Planet
class Planet: Identifiable {
    let id: String
    let name: String
    let englishName: String
    let moons: [Moon]?
    let meanRadius: Double
    let gravity: Double
    let bodyType: String
    let perihelion: Int
    
    init(model: SolarSystemBody) {
        self.id = model.id
        self.name = model.name
        self.englishName = model.englishName
        self.gravity = model.gravity
        self.bodyType = model.bodyType
        self.meanRadius = model.meanRadius
        self.moons = model.moons
        self.perihelion = model.perihelion
    }
}

enum PlanetsList {
    enum FetchPlanetsList {
        struct Request {}
        struct Response {
            let planets: [SolarSystemBody]
        }
        struct ViewModel {
            let planets: [Planet]
        }
    }
}
