//
//  PlanetsWorker.swift
//  VIPPlanets
//
//  Created by Александр Рахимов on 26.04.2023.
//

import Foundation

protocol IPlanetsWorker: AnyObject {
    func fetchUserData() async throws -> [SolarSystemBody]?
}

class PlanetsWorker: IPlanetsWorker {
    
    private let urlString = "https://api.le-systeme-solaire.net/rest/bodies/"
    
    func fetchUserData() async throws -> [SolarSystemBody]? {
        guard let url = URL(string: urlString) else {
            throw Errors.errorBodiesUrl
        }
        
        let session = URLSession(configuration: .default)
        let response = try await session.data(from: url)
        let decoder = JSONDecoder()
        
        do {
            let solarSystemBodies = try decoder.decode(SolarSystemBodies.self, from: response.0)
            return solarSystemBodies.bodies
        } catch {
            print(Errors.errorParseBodiesToAPIModel)
        }
        return nil
    }
}
