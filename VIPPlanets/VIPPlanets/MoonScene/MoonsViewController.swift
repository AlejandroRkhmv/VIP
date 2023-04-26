//
//  MoonViewController.swift
//  VIPPlanets
//
//  Created by Александр Рахимов on 26.04.2023.
//

import UIKit

protocol IMoonViewController: AnyObject {
    var moons: [Moon]? { get set }
}

class MoonsViewController: UIViewController {
    
    var moonsInteractor: IMoonsInteractor?
    weak var navigationViewController: UINavigationController?
    var moonsRouter: IMoonsRouter?
    var table = UITableView()
    let cellIdentifier = "cel"
    var moons: [Moon]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createBackButton()
        setup()
        createTable()
    }
}


extension MoonsViewController: IMoonViewController {
    
    func setup() {
        let moonViewController = self
        let moonsInteractor = MoonsInteractor()
        let moonsPresenter = MoonsPresenter()
        let moonsWorker = MoonsWorker()
        let moonRouter = MoosRouter()
        moonRouter.navigationViewController = self.navigationController
        moonsInteractor.moonsWorker = moonsWorker
        moonsInteractor.moonsPresenter = moonsPresenter
        moonViewController.moonsInteractor = moonsInteractor
        moonViewController.moonsRouter = moonRouter
    }
    
    private func createTable() {
        table.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.height)
        table.center = view.center
        view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    private func createBackButton() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        let action = UIAction(title: "Back to planets") { [weak self] _ in
            guard let self = self else { return }
            self.moonsRouter?.pop()
        }
        let backButton = UIButton(type: .system, primaryAction: action)
        backButton.setTitleColor(.purple, for: .normal)
        let customBackButtonItem: UIBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = customBackButtonItem
    }
}

extension MoonsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let moons = moons else { return 0 }
        return moons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        var content = cell.defaultContentConfiguration()
        guard let moons = moons else { return UITableViewCell() }
        content.text = moons[indexPath.row].moon
        cell.contentConfiguration = content
        return cell
    }
}
