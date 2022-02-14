//
//  SearchCoordinator.swift
//  Movie
//
//  Created by KSNetDev1 on 2022/02/14.
//

import Foundation
import UIKit

protocol SearchCoordinatorDelegate: AnyObject {
    func didFinishSearchCordinator(coordinator: Coordinator, movie: Movie)
  }

class SearchCoordinator: BaseCoordinator {
    private let navigationController: UINavigationController
    weak var delegate: SearchCoordinatorDelegate?
    
    init(navigationController: UINavigationController) {
      self.navigationController = navigationController
    }
    
    override func start() {
        if let vc = self.searchVC {
            self.navigationController.setViewControllers([vc], animated: false)
            
            let viewModel = SearchViewModel()
            viewModel.coordinatorDelegate = self
            vc.viewModel = viewModel
        }
    }
    
    lazy var searchVC: SearchViewController? = {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
        return vc
    }()
    
    lazy var detailVC: DetailViewController? = {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        return vc
    }()
    
    lazy var bookmarkVC: BookmarkViewController? = {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BookmarkViewController") as? BookmarkViewController
        vc?.modalPresentationStyle = .pageSheet
        return vc
    }()
}

extension SearchCoordinator: SearchViewModelCoordinatorDelegate {
    func bookmarkClicked() {
        let viewModel = BookmarkViewModel()
        guard let vc = self.bookmarkVC else {return}
        vc.viewModel = viewModel
        
        
        self.navigationController.present(vc, animated: true, completion: nil)
    }
    
    func starClicked(_ movie: Movie) {
        //
    }
    
    func selectMovie(_ movie: Movie) {
        self.delegate?.didFinishSearchCordinator(coordinator: self, movie: movie)
    }
}
