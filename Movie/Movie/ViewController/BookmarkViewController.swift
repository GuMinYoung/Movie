//
//  BookmarkViewController.swift
//  Movie
//
//  Created by 구민영 on 2022/02/14.
//

import UIKit

class BookmarkViewController: UIViewController {
    var viewModel: BookmarkViewModel?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        self.navigationController?.navigationItem.title = "즐겨찾기 목록"
        //let closeButton = UIBarButtonItem(title: "닫기", style: UIBarButtonItem.Style.done, target: self, action: )
        // Do any additional setup after loading the view.
        print(viewModel?.bookmarkList)
    }
}

extension BookmarkViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell else {return MovieCell()}
        cell.update(viewModel?.movie(at: indexPath.row) ?? Movie())
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.numberOfRowsInSection(section) ?? 0
    }
}

extension BookmarkViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.selectRow(row: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
