//
//  MoonsModel.swift
//  VIPPlanets
//
//  Created by Александр Рахимов on 26.04.2023.
//

import Foundation

struct MoonBody: Codable {
    let id, name, englishName: String
    let isPlanet: Bool
    let gravity: Double
    let meanRadius: Double
    let bodyType: String
    let perihelion: Int
}

// MARK: - LaMoon
class LaMoon: Identifiable {
    let id: String
    let name: String
    let englishName: String
    let gravity: Double
    let meanRadius: Double
    let bodyType: String
    let perihelion: Int
    
    init(model: MoonBody) {
        self.id = model.id
        self.name = model.name
        self.englishName = model.englishName
        self.gravity = model.gravity
        self.meanRadius = model.meanRadius
        self.bodyType = model.bodyType
        self.perihelion = model.perihelion
    }
}

enum MoonsList {
    enum FetchMoonsList {
        struct Request {}
        struct Response {
            let moon: MoonBody
        }
        struct ViewModel {
            let planets: LaMoon
        }
    }
}
