//
//  MoonsRouter.swift
//  VIPPlanets
//
//  Created by Александр Рахимов on 26.04.2023.
//

import UIKit

protocol IMoonsRouter {
    var navigationViewController: UINavigationController? { get set }
    func pop()
}

class MoosRouter: IMoonsRouter {
    weak var navigationViewController: UINavigationController?
    func pop() {
        navigationViewController?.popViewController(animated: false)
    }
}
