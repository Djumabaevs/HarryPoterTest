//
//  EpisodeDetailViewController.swift
//  HarryPoterTest
//
//  Created by Bakyt Dzhumabaev on 28/12/21.
//

import UIKit

class EpisodeDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(EpisodeInfoTableViewCell.self, forCellReuseIdentifier: EpisodeInfoTableViewCell.identifier)
        tableView.register(CharacterCellTableViewCell.self, forCellReuseIdentifier: CharacterCellTableViewCell.identifier)
        tableView.clipsToBounds = true
        return tableView
    }()
    
    var episode: Episode?
    
    var characters: [Character?] = [] {
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
    
    var speciesLabel: UILabel = {
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
        title = episode?.name
        view.addSubview(tableView)
        tableView.frame = view.frame
        tableView.dataSource = self
        tableView.delegate = self
        
        getCharactersInEpisode(forEpisode: episode!)
    }
    
    init(episode: Episode) {
        super.init(nibName: nil, bundle: nil)
        self.episode = episode
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
            return episode?.characters.count ?? 1
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeInfoTableViewCell.identifier, for: indexPath) as? EpisodeInfoTableViewCell else {
                fatalError()
            }
            
            cell.selectionStyle = .none
            
            if indexPath.row == 0 {
                cell.typeImageView.image = UIImage.init(systemName: "list.number")
                cell.typeLabel.text = "Episode"
                cell.dataLabel.text = episode?.episode
            }
            
            else if indexPath.row == 1 {
                cell.typeImageView.image = UIImage.init(systemName: "person.2")
                cell.typeLabel.text = "Name"
                cell.dataLabel.text = episode?.name
            }
            
            else if indexPath.row == 2 {
                cell.typeImageView.image = UIImage.init(systemName: "calendar")
                cell.typeLabel.text = "Air Date"
                cell.dataLabel.text = episode?.air_date
            }
            
            cell.episode = episode
            return cell
        }
        
        if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCellTableViewCell.identifier, for: indexPath) as? CharacterCellTableViewCell else {
                fatalError()
            }
            
            cell.charImageView.anchor(top: cell.topAnchor, left: cell.leftAnchor, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 16, paddingBottom: 0, paddingRight: 4, width: 32, height: 32, enableInsets: false)
            cell.charImageView.layer.cornerRadius = 8
            if (characters.count == episode?.characters.count) {
                cell.character = characters[indexPath.row]
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
            return "Characters"
        }
        
        return "Default Title"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let character = characters[indexPath.row], indexPath.section == 1 {
            present(UINavigationController(rootViewController: CharacterDetailViewController(character: character)), animated: true, completion: nil)
        }
    }
    
    func getCharactersInEpisode(forEpisode episode: Episode) {
        for url in episode.characters {
            NetworkManager.shared.getCharacterInfoForURL(episodeURL: url) { data in
                switch data {
                case .success(let model):
                    self.characters.append(model)
                case .failure(let error):
                    print("getEpisodeData fail")
                    print(error)
                }
            }
        }
    }
}
