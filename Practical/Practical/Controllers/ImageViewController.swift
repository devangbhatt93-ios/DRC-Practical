//
//  ImageViewController.swift
//  Practical
//
//  Created by Apple on 14/02/21.
//

import UIKit
import Kingfisher

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var articleImageView: UIImageView!

    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageScrollView.minimumZoomScale = 1.0
        imageScrollView.maximumZoomScale = 6.0
        imageScrollView.delegate = self
        
        if let imageURL = url {
            articleImageView.kf.indicatorType = .activity
            articleImageView.kf.setImage(with: imageURL)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return articleImageView
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
