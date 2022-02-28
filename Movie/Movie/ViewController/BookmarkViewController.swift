//
//  BookmarkViewController.swift
//  Movie
//
//  Created by 구민영 on 2022/02/14.
//

import UIKit

class BookmarkViewController: UIViewController {
    var viewModel = BookmarkViewModel() {
        didSet {
            if tableView != nil {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        self.navigationController?.navigationItem.title = "즐겨찾기 목록"
        //let closeButton = UIBarButtonItem(title: "닫기", style: UIBarButtonItem.Style.done, target: self, action: )
        // Do any additional setup after loading the view.
    }
    
    @IBAction func starButtonClicked(_ sender: UIButton) {
        var superview = sender.superview
        while let view = superview, !(view is UITableViewCell) {
            superview = view.superview
        }

        guard let cell = superview as? MovieCell,
              let indexPath = tableView.indexPath(for: cell) else { return }
        
        self.viewModel.starClicked(at: indexPath.row)
        cell.setBookmarkBtnImage(status: self.viewModel.movie(at: indexPath.row).isBookmark)
        self.tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}

extension BookmarkViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell else {return MovieCell()}
        cell.update(viewModel.movie(at: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRowsInSection(section)
    }
}

extension BookmarkViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectRow(row: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
