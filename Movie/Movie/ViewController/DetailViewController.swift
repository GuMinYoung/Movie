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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var viewModel: DetailViewModel?
    
    override func viewDidLoad() {
        self.webView.navigationDelegate = self
        
        guard let urlString = viewModel?.movie.link,
              let url = URL(string: urlString) else {return}
        let req = URLRequest(url: url)
        self.webView.load(req)

    }
}

extension DetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.spinner.startAnimating()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.spinner.stopAnimating()
    }
}

