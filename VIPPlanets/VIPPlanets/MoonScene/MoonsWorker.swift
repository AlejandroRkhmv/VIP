//
//  MoonsWorker.swift
//  VIPPlanets
//
//  Created by Александр Рахимов on 26.04.2023.
//

import Foundation

protocol IMoonssWorker: AnyObject {
    func fetchUserData(urlString: String) async throws -> MoonBody?
}

class MoonsWorker: IMoonssWorker {
    
    func fetchUserData(urlString: String) async throws -> MoonBody? {
        guard let url = URL(string: urlString) else {
            throw Errors.errorBodiesUrl
        }
        
        let session = URLSession(configuration: .default)
        let response = try await session.data(from: url)
        let decoder = JSONDecoder()
        
        do {
            let moonBody = try decoder.decode(MoonBody.self, from: response.0)
            return moonBody
        } catch {
            print(Errors.errorParseMoonToAPIModel)
        }
        return nil
    }
}
