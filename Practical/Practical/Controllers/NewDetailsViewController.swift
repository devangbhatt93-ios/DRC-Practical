//
//  NewDetailsViewController.swift
//  Practical
//
//  Created by Apple on 13/02/21.
//

import UIKit
import Kingfisher

class NewDetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var navigationView: UIView!
    
    lazy var article = Articles()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.navigationView.setDropShadow(radius: 5, color: .gray, offset: CGSize(width: 0 , height: 3))
        }
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(contentImageTapped(_:)))
        contentImageView.addGestureRecognizer(imageTapGesture)
        setupNewsData()
    }
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: -  Custom Methods
extension NewDetailsViewController {
    private func setupNewsData() {
        guard let title = article.title, let description = article.description,
              let content = article.content, let contentImageUrl = article.imageURL, let authorName = article.author else {
            return
        }
        
        nameLabel.text = authorName
        dateLabel.text = article.publishedDate
        titleLabel.text = title
        descriptionLabel.text = description
        contentLabel.text = content
        contentImageView.kf.indicatorType = .activity
        contentImageView.kf.setImage(with: contentImageUrl)
    }
    
    @objc func contentImageTapped(_ sender: UITapGestureRecognizer) {
        guard let imageViewController = self.storyboard?.instantiateViewController(withIdentifier: "ImageViewController") as? ImageViewController else {
            return
        }
        imageViewController.url = article.imageURL
        imageViewController.modalPresentationStyle = .currentContext
        self.navigationController?.present(imageViewController, animated: true, completion: nil)
    }
}
