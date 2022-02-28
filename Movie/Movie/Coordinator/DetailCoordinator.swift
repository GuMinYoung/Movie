//
//  DetailCoordinator.swift
//  Movie
//
//  Created by KSNetDev1 on 2022/02/14.
//

import Foundation
import UIKit
import RealmSwift

protocol DetailCoordinatorDelegate: AnyObject {
  func didFinishDetailCoordinator(coordinator: Coordinator)
  func bookmarkTapped()
}

class DetailCoordinator: BaseCoordinator, SearchViewModelCoordinatorDelegate{
    func selectMovie(_ movie: Movie) {
        
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
    }
    
    func bookmarkClicked() {
        
    }
    
    private let navigationController: UINavigationController
    weak var delegate: DetailCoordinatorDelegate?
    private let movie: Movie
    
    lazy var detailVC: DetailViewController? = {
      let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
      let viewModel = DetailViewModel(with: self.movie)
      vc?.viewModel = viewModel
      vc?.viewModel?.coordinatorDelegate = self
      vc?.navigationItem.title = self.movie.title
      return vc
    }()
    
    /*
    lazy var bookmarkVC: BookmarkViewController? = {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BookmarkViewController") as? BookmarkViewController
        vc?.modalPresentationStyle = .fullScreen
        
        //let viewModel = ForecastViewModel(cityId: city.cityId)
        //vc?.viewModel = viewModel
        //vc?.viewModel?.coordinatorDelegate = self
        return vc
    }()
     */
    
    init(navigationController:UINavigationController, movie: Movie) {
      self.navigationController = navigationController
      self.movie = movie
    }
    
    override func start() {
//      if let vc = self.detailWeatherVC {
//        self.navigationController.setViewControllers([vc], animated: false)
//      }
        if let vc = self.detailVC {
          self.navigationController.pushViewController(vc, animated: true)
        }
    }
}

//extension DetailCoordinator: DetailViewModelCoordinatorlDelegate {
//    func starClicked(_ movie: inout Movie) {
//        <#code#>
//    }
//
//    func bookmark() {}
//}
