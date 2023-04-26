//
//  PlanetsViewController.swift
//  VIPPlanets
//
//  Created by Александр Рахимов on 26.04.2023.
//

import UIKit

protocol IPlanetsViewController: AnyObject {
    func displaylanets(from viewModel: PlanetsList.FetchPlanetsList.ViewModel)
}

class PlanetsViewController: UIViewController {

    var planetInteractor: IPlanetsInteractor?
    weak var navigationViewController: UINavigationController?
    var planetRouter: IPlanetsRouter?
    var table = UITableView()
    let cellIdentifier = "cel"
    var planets: [Planet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Planets"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.purple]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        setup()
        start()
        createTable()
    }
}

// MARK: - extension setup and start and createTable
extension PlanetsViewController {
    private func setup() {
        let planetViewController = self
        let planetInteractor = PlanetsInteractor()
        let planetPresenter = PlanetsPresenter()
        let planetWorker = PlanetsWorker()
        let planetRouter = PlanetsRouter()
        planetInteractor.planetWorker = planetWorker
        planetViewController.planetInteractor = planetInteractor
        planetViewController.planetRouter = planetRouter
        planetInteractor.planetPresenter = planetPresenter
        planetPresenter.planetViewController = planetViewController
        planetRouter.navigationViewController = self.navigationController
    }
    
    private func start() {
        Task {
            do {
                try await planetInteractor?.getDataPlanets()
            } catch {
                print(Errors.errorTaskBodies)
            }
        }
    }
    
    private func createTable() {
        table.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.height)
        table.center = view.center
        view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
}

// MARK: - extension display
extension PlanetsViewController: IPlanetsViewController {
    func displaylanets(from viewModel: PlanetsList.FetchPlanetsList.ViewModel) {
        self.planets = viewModel.planets
        self.table.reloadData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension PlanetsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let planetName = planets[indexPath.row].name
        var content = cell.defaultContentConfiguration()
        content.text = planetName
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        planetRouter?.navigateToMoonScene(moons: planets[indexPath.row].moons)
    }
}
