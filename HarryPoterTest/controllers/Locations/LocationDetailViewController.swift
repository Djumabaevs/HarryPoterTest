//
//  LocationDetailViewController.swift
//  HarryPoterTest
//
//  Created by Bakyt Dzhumabaev on 28/12/21.
//

import UIKit

class LocationDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(LocationInfoTableViewCell.self, forCellReuseIdentifier: LocationInfoTableViewCell.identifier)
        tableView.register(CharacterCellTableViewCell.self, forCellReuseIdentifier: CharacterCellTableViewCell.identifier)
        tableView.clipsToBounds = true
        return tableView
    }()
    
    var location: Location?
    
    var residents: [Character?] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    var typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    var genderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = location?.name
        view.addSubview(tableView)
        tableView.frame = view.frame
        tableView.dataSource = self
        tableView.delegate = self
        
        getCharactersInLocation(forLocation: location!)
    }
    
    init(location: Location) {
        super.init(nibName: nil, bundle: nil)
        self.location = location
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }
        
        else if section == 1 {
            return location?.residents.count ?? 1
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationInfoTableViewCell.identifier, for: indexPath) as? LocationInfoTableViewCell else {
                fatalError()
            }
            
            cell.selectionStyle = .none
            
            if indexPath.row == 0 {
                cell.typeImageView.image = UIImage.init(systemName: "character.book.closed")
                cell.typeLabel.text = "Name"
                cell.dataLabel.text = location?.name
            }
            
            else if indexPath.row == 1 {
                cell.typeImageView.image = UIImage.init(systemName: "paperplane")
                cell.typeLabel.text = "Type"
                cell.dataLabel.text = location?.type
            }
            
            else if indexPath.row == 2 {
                cell.typeImageView.image = UIImage.init(systemName: "dial.max")
                cell.typeLabel.text = "Dimension"
                cell.dataLabel.text = location?.dimension
            }
            
            cell.location = location
            return cell
        }
        
        if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCellTableViewCell.identifier, for: indexPath) as? CharacterCellTableViewCell else {
                fatalError()
            }
            
            cell.charImageView.anchor(top: cell.topAnchor, left: cell.leftAnchor, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 16, paddingBottom: 0, paddingRight: 4, width: 40, height: 40, enableInsets: false)
            
            if (residents.count == location?.residents.count) {
                cell.character = residents[indexPath.row]
            }
            
            return cell
        }
        
    
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if section == 0 {
            return "Info"
        }
        
        if section == 1 {
            return "Residents"
        }
        
        return "Default Title"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let character = residents[indexPath.row], indexPath.section == 1 {
            present(UINavigationController(rootViewController: CharacterDetailViewController(character: character)), animated: true, completion: nil)
        }
    }
    
    func getCharactersInLocation(forLocation location: Location) {
        for url in location.residents {
            NetworkManager.shared.getCharacterInfoForURL(episodeURL: url) { data in
                switch data {
                case .success(let model):
                    self.residents.append(model)
                case .failure(let error):
                    print("getEpisodeData fail")
                    print(error)
                }
            }
        }
    }
}
