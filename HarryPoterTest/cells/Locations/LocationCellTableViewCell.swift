//
//  LocationCellTableViewCell.swift
//  HarryPoterTest
//
//  Created by Bakyt Dzhumabaev on 28/12/21.
//

import UIKit

class LocationCellTableViewCell: UITableViewCell {
    
    static let identifier = "LocationCellTableViewCell"
    
    var location: Location? {
        didSet {
            configureCell()
        }
    }
    
    var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(label)
        label.frame = contentView.frame
        label.frame = frame.inset(by: UIEdgeInsets(top: 4, left: 20, bottom: 4, right: 0))
        self.configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {
        if let name = location?.name, let type = location?.type {
            label.text = name + " - " + type
        }
    }
}
