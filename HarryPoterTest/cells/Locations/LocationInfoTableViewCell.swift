//
//  LocationInfoTableViewCell.swift
//  HarryPoterTest
//
//  Created by Bakyt Dzhumabaev on 28/12/21.
//

import UIKit

class LocationInfoTableViewCell: UITableViewCell {
    static let identifier = "LocationInfoTableViewCell"
    
    var location: Location? {
        didSet {
            self.configureCell()
        }
    }
    
    var typeImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage.init(systemName: "person.2")
        iv.tintColor = UIColor.secondaryLabel
        iv.contentMode = .scaleAspectFit
        iv.frame = CGRect(origin: .zero, size: CGSize(width: 32, height: 32))
        iv.layer.cornerRadius = 16
        iv.clipsToBounds = true
        return iv
    }()
    
    var typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = UIColor.secondaryLabel
        return label
    }()
    
    var dataLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(typeImageView)
        addSubview(typeLabel)
        addSubview(dataLabel)
        
        typeImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 4, paddingLeft: 16, paddingBottom: 0, paddingRight: 4, width: 32, height: 32, enableInsets: false)
        typeLabel.anchor(top: topAnchor, left: typeImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 16, paddingBottom: 4, paddingRight: 4, width: 100, height: 44, enableInsets: false)
        dataLabel.anchor(top: topAnchor, left: typeLabel.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 4, paddingRight: 8, width: 150, height: 44, enableInsets: false)
        

        
        self.configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {
        
    }

}
