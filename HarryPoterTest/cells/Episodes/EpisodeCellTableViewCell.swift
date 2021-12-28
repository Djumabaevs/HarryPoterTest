//
//  EpisodeCellTableViewCell.swift
//  HarryPoterTest
//
//  Created by Bakyt Dzhumabaev on 28/12/21.
//

import UIKit

class EpisodeCellTableViewCell: UITableViewCell {
    
    static let identifier = "EpisodeCellTableViewCell"
    
    var episode: Episode? {
        didSet {
            configureCell()
        }
    }
    
    var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        //label.numberOfLines = 0
        return label
    }()
    
    var subTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(label)
        addSubview(subTitle)
        
        label.anchor(top: topAnchor,
                     left: leftAnchor,
                     bottom: nil,
                     right: nil,
                     paddingTop: 4,
                     paddingLeft: 20,
                     paddingBottom: 0,
                     paddingRight: 0,
                     width: contentView.frame.width,
                     height: 32,
                     enableInsets: false)
        
        subTitle.anchor(top: label.bottomAnchor,
                        left: leftAnchor,
                        bottom: bottomAnchor,
                        right: nil,
                        paddingTop: -4 ,
                        paddingLeft: 20,
                        paddingBottom: 4,
                        paddingRight: 0,
                        width: contentView.frame.width,
                        height: 24,
                        enableInsets: false)
//        label.frame = frame.inset(by: UIEdgeInsets(top: 4, left: 20, bottom: 4, right: 0))
//        subTitle.frame = frame.inset(by: UIEdgeInsets(top: 24, left: 20, bottom: 4, right: 0))

        self.configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {
        if let episodeStr = episode?.episode, let name = episode?.name, let airDate = episode?.air_date {
            label.text = episodeStr + " - " + name
            subTitle.text = airDate
        }
    }
}
