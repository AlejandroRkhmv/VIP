//
//  Errors.swift
//  VIPPlanets
//
//  Created by Александр Рахимов on 26.04.2023.
//

import Foundation

enum Errors: Error {
    case errorBodiesUrl
    case errorMoonsUrl
    case errorParseBodiesToAPIModel
    case errorParseMoonToAPIModel
    case errorTaskBodies
    case errorTaskMoons
    case bodiesNil
    case moonsNil
}
