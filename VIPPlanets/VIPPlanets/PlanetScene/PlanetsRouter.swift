//
//  PlanetsRouter.swift
//  VIPPlanets
//
//  Created by Александр Рахимов on 26.04.2023.
//

import Foundation
import UIKit

protocol IPlanetsRouter {
    var navigationViewController: UINavigationController? { get set }
    func navigateToMoonScene(moons: [Moon]?)
}

class PlanetsRouter: IPlanetsRouter {
    weak var navigationViewController: UINavigationController?
    
    func navigateToMoonScene(moons: [Moon]?) {
        let moonsViewController = MoonsViewController()
        moonsViewController.navigationViewController = navigationViewController
        guard let moons = moons else { return }
        passDataToMoonsViewController(sourse: moons, destination: moonsViewController)
        pushMoons(viewController: moonsViewController)
    }
    
    fileprivate func passDataToMoonsViewController(sourse: [Moon], destination: IMoonViewController) {
        destination.moons = sourse
    }
    
    fileprivate func pushMoons(viewController: IMoonViewController) {
        if let navigationViewController = navigationViewController {
            navigationViewController.pushViewController(viewController as! UIViewController, animated: false)
        }
    }
}
