//
//  BookmarkViewController.swift
//  Movie
//
//  Created by 구민영 on 2022/02/14.
//

import UIKit

class BookmarkViewController: UIViewController {
    var viewModel: BookmarkViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationItem.title = "즐겨찾기 목록"
        //let closeButton = UIBarButtonItem(title: "닫기", style: UIBarButtonItem.Style.done, target: self, action: )
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
