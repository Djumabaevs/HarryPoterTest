//
//  CharacterViewController.swift
//  HarryPoterTest
//
//  Created by Bakyt Dzhumabaev on 28/12/21.
//

import UIKit

class CharacterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var page: Int = 1
    var characters: [Character?] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var images: [UIImage?] = []
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CharacterCellTableViewCell.self, forCellReuseIdentifier: CharacterCellTableViewCell.identifier)
        tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: LoadingTableViewCell.identifier)
        tableView.clipsToBounds = true
        tableView.alwaysBounceVertical = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Characters"
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == self.characters.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LoadingTableViewCell.identifier, for: indexPath) as? LoadingTableViewCell else {
                fatalError()
            }
            
            NetworkManager.shared.getCharactersData(page: page) { result in
                switch result {
                case .success(let models):
                    for var character in models.results {
                        
                        NetworkManager.shared.getCharacterImage(character: character) { data in
                            switch data {
                            case .success(let responseData):
                                character.imageData = responseData
                                self.characters.append(character)
                            case .failure(let error):
                                print(error)
                            }
                        }
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCellTableViewCell.identifier, for: indexPath) as? CharacterCellTableViewCell else {
            fatalError()
        }
        
        cell.character = characters[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count + 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let character = characters[indexPath.row] {
            present(UINavigationController(rootViewController: CharacterDetailViewController(character: character)), animated: true, completion: nil)
        }
    }

}
