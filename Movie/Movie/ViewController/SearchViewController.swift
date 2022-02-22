//
//  ViewController.swift
//  Movie
//
//  Created by 구민영 on 2022/02/11.
//

import UIKit
import Foundation
import Alamofire
import RealmSwift

class SearchViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchField: UITextField!
    
    var viewModel: SearchViewModel?
    
    @IBAction func starButtonClicked(_ sender: UIButton) {
        var superview = sender.superview
        while let view = superview, !(view is UITableViewCell) {
            superview = view.superview
        }

        guard let cell = superview as? MovieCell,
              let indexPath = tableView.indexPath(for: cell),
        let viewModel = self.viewModel else { return }
        
        viewModel.starClicked(at: indexPath.row)
        cell.setBookmarkBtnImage(status: viewModel.movie(at: indexPath.row).isBookmark)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        searchField.autocorrectionType = .no
        searchField.addTarget(self, action: #selector(textFieldDidChange),
            for: UIControl.Event.editingChanged)
        
        let rightBarButton = UIBarButtonItem(title: "북마크", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.bookmarkTapped(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func textFieldDidChange(_ textField: UITextField){
        guard let keywords = textField.text,
              let viewModel = self.viewModel else {return}
        viewModel.fetchMovie(with: keywords)
        viewModel.didFinishFetch = {
            self.tableView.reloadData()
        }
    }
    
    @objc func bookmarkTapped(_ sender: UIBarButtonItem) {
        viewModel?.goToBookmark()
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell else {return MovieCell()}
        cell.update(viewModel?.movie(at: indexPath.row) ?? Movie())
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.numberOfRowsInSection(section) ?? 0
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.selectRow(row: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
