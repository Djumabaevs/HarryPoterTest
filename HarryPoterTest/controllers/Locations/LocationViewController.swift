//
//  LocationViewController.swift
//  HarryPoterTest
//
//  Created by Bakyt Dzhumabaev on 28/12/21.
//

import UIKit

class LocationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var page: Int = 1
    var locations: [Location?] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(LocationCellTableViewCell.self, forCellReuseIdentifier: LocationCellTableViewCell.identifier)
        tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: LoadingTableViewCell.identifier)
        tableView.clipsToBounds = true
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Locations"
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == self.locations.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LoadingTableViewCell.identifier, for: indexPath) as? LoadingTableViewCell else {
                fatalError()
            }
            
            NetworkManager.shared.getLocationsData(page: page) { result in
                switch result {
                case .success(let models):

                    for result in models.results {
                        self.locations.append(result)
                    }
                    self.page += 1
                    
                case .failure(let error):
                    print(error)
                    DispatchQueue.main.async {
                        cell.isHidden = true
                    }
                }
            }
            
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationCellTableViewCell.identifier, for: indexPath) as? LocationCellTableViewCell else {
            fatalError()
        }
        
        cell.location = locations[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count + 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let location = locations[indexPath.row] {
            present(UINavigationController(rootViewController: LocationDetailViewController(location: location)), animated: true, completion: nil)
        }
    }

}
