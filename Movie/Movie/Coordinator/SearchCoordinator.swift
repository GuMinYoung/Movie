//
//  SearchCoordinator.swift
//  Movie
//
//  Created by KSNetDev1 on 2022/02/14.
//

import Foundation
import UIKit
import RealmSwift

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
        vc?.modalPresentationStyle = .fullScreen
        return vc
    }()
}

extension SearchCoordinator: SearchViewModelCoordinatorDelegate {
    func bookmarkClicked() {
        let viewModel = BookmarkViewModel()
        viewModel.coordinatorDelegate = self
        guard let vc = self.bookmarkVC else {return}
        vc.viewModel = viewModel
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func starClicked(_ selectedMovie: inout Movie) {
        if let savedData = RealmManager.shared.db.objects(Favorite.self).first {
            try! RealmManager.shared.db.write{
                if let idx = savedData.bookmarkList.firstIndex(where: {
                    $0.link == selectedMovie.link
                })
                {
                    savedData.bookmarkList.remove(at: idx)
                    selectedMovie.isBookmark = false
                } else {
                    
                    savedData.bookmarkList.append(selectedMovie.realmObject())
                    selectedMovie.isBookmark = true
                    
                }
            }
        } else {
            do {
                let realmMovieList = List<RealmMovie>()
                realmMovieList.append(selectedMovie.realmObject())
                let newData = Favorite(bookmarkList: realmMovieList)
                try RealmManager.shared.db.write {
                    RealmManager.shared.db.create(Favorite.self, value: newData)
                    selectedMovie.isBookmark = true
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    func selectMovie(_ movie: Movie) {
        self.delegate?.didFinishSearchCordinator(coordinator: self, movie: movie)
    }
}
