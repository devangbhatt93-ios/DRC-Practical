//
//  ArticlesTableViewCell.swift
//  Practical
//
//  Created by Apple on 13/02/21.
//

import UIKit
import Kingfisher

class ArticlesTableViewCell: UITableViewCell {

    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var datelabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func prepareCellfor(article: Articles) {
        if let url = article.imageURL {
            articleImageView.kf.indicatorType = .activity
            articleImageView.kf.setImage(with: url)
        } else {
            
        }
        
        nameLabel.text = article.author ?? ""
        titleLabel.text = article.description ?? ""
        datelabel.text = article.publishedAt ?? ""
        
    }
}
