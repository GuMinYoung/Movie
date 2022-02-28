//
//  DetailViewController.swift
//  Movie
//
//  Created by KSNetDev1 on 2022/02/14.
//

import UIKit
import Foundation
import WebKit

class DetailViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var infoView: MovieInfo!
    var viewModel: DetailViewModel?
    let spinner = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        self.webView.navigationDelegate = self
        
        guard let movie = viewModel?.movie,
            let urlString = viewModel?.movie.link,
              let url = URL(string: urlString) else {return}
        let req = URLRequest(url: url)
        self.webView.load(req)
        self.infoView.update(with: movie)
        self.infoView.bookmarkBtn.addTarget(self, action: #selector(starButtonClicked(_:)), for: .touchUpInside)
    }
    
    @objc func starButtonClicked(_ sender: UIButton) {
        self.viewModel?.starClicked()
        guard let viewModel = self.viewModel else {
            return
        }
        self.infoView.setBookmarkBtnImage(status: viewModel.movie.isBookmark)
    }
}

extension DetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        spinner.frame = webView.bounds
        webView.addSubview(spinner)
        spinner.startAnimating()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.spinner.stopAnimating()
        self.spinner.removeFromSuperview()
    }
}
