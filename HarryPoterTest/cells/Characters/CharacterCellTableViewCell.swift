//
//  CharacterCellTableViewCell.swift
//  HarryPoterTest
//
//  Created by Bakyt Dzhumabaev on 28/12/21.
//


import UIKit

class CharacterCellTableViewCell: UITableViewCell {
    
    static let identifier = "CharacterCellTableViewCell"
    
    var character: Character? {
        didSet {
            configureCell()
        }
    }
    
    var charImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage.init(systemName: "person.2")
        iv.contentMode = .scaleAspectFit
        iv.frame = CGRect(origin: .zero, size: CGSize(width: 50, height: 50))
        iv.layer.cornerRadius = 16
        iv.clipsToBounds = true
        return iv
    }()
    
    var statusImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .gray
        iv.contentMode = .scaleAspectFit
        iv.frame = CGRect(origin: .zero, size: CGSize(width: 16, height: 16))
        iv.layer.cornerRadius = 4
        iv.clipsToBounds = true
        return iv
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    var subLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(charImageView)
        addSubview(label)
        addSubview(subLabel)
        addSubview(statusImageView)
        
        charImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 16, paddingBottom: 0, paddingRight: 4, width: 44, height: 44, enableInsets: false)
        label.anchor(top: topAnchor, left: charImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 16, paddingBottom: 0, paddingRight: 4, width: 300, height: 32, enableInsets: false)
        statusImageView.anchor(top: label.bottomAnchor, left: charImageView.rightAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 8, paddingRight: 0, width: 8, height: 8, enableInsets: false)
        subLabel.anchor(top: label.bottomAnchor, left: statusImageView.rightAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 4, paddingBottom: 8, paddingRight: 4, width: 300, height: 12, enableInsets: false)
        
        self.configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {
        if let name = character?.name, let subtitle = character?.species, let status = character?.status {
            label.text = name
            subLabel.text = "\(status) - \(subtitle)"
            if status == "Alive" {
                statusImageView.backgroundColor = .green
            }
            else if status == "Dead" {
                statusImageView.backgroundColor = .red
            }
            
        }
        
        if let imageData = character?.imageData {
            charImageView.image = UIImage(data: imageData)
        }
    }
}
