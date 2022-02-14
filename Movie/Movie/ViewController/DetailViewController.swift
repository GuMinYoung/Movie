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
        
        guard let urlString = viewModel?.movie.link,
              let url = URL(string: urlString) else {return}
        let req = URLRequest(url: url)
        self.webView.load(req)

        guard let movie = viewModel?.movie else {return}
        infoView.update(with: movie)
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
