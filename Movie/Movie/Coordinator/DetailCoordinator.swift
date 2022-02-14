//
//  DetailCoordinator.swift
//  Movie
//
//  Created by KSNetDev1 on 2022/02/14.
//

import Foundation
import UIKit

protocol DetailCoordinatorDelegate: AnyObject {
  func didFinishDetailCoordinator(coordinator: Coordinator)
  //func forecastClicked()
}

class DetailCoordinator: BaseCoordinator {
    private let navigationController: UINavigationController
    weak var delegate: DetailCoordinatorDelegate?
    private let movie: Movie
    
    lazy var detailVC: DetailViewController? = {
      let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
      let viewModel = DetailViewModel(with: self.movie)
      vc?.viewModel = viewModel
      vc?.viewModel?.coordinatorDelegate = self
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

extension DetailCoordinator: DetailViewModelCoordinatorlDelegate {
    func bookmark() {}
}
