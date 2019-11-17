//
//  DetailViewController.swift
//  NYT-TopStories
//
//  Created by Jahid Hassan on 11/17/19.
//  Copyright © 2019 Jahid Hassan. All rights reserved.
//

import UIKit
import SafariServices

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var imageViewHeightConstrint: NSLayoutConstraint!
    
    public var viewModel: DetailViewProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureView()
        adjustImageOnOrientationChange()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        invoke(onThread: DispatchQueue.main) {
            self.adjustImageOnOrientationChange()
        }
    }
}

fileprivate extension DetailViewController {
    func configureView() {
        title = viewModel.titleNavigation
        
        titleLabel.text = viewModel.title
        descriptionLabel.attributedText = viewModel.description
        authorLabel.text = viewModel.author
        
        if let url = viewModel.imageUrl {
            imageView.hnk_setImageFromURL(url)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleSeeMore(_:)))
        descriptionLabel.addGestureRecognizer(tap)
    }
    
    func adjustImageOnOrientationChange() {
        let imageHeight = viewModel.imageUrl == nil ? 0:CGFloat(viewModel.getHeight(for: Float(view.bounds.width)))
        imageViewHeightConstrint.constant = imageHeight
    }
    
    @objc func handleSeeMore(_ gesture: UITapGestureRecognizer) {
        if gesture.didTapLink(in: descriptionLabel, at: viewModel.seeMoreRange) {
            let config = SFSafariViewController.Configuration()
            let safari = SFSafariViewController(url: viewModel.articleUrl, configuration: config)
            safari.modalPresentationStyle = .overFullScreen
            navigationController?.present(safari, animated: true, completion: nil)
        }
    }
}
