//
//  AppCoordinator.swift
//  Movie
//
//  Created by KSNetDev1 on 2022/02/14.
//

import Foundation
import UIKit

class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    func start() {}
}

class AppCoordinator: BaseCoordinator {
    // MARK: - Properties
    let window: UIWindow?
    
    lazy var rootViewController: UINavigationController = {
        return UINavigationController()
    }()
    
    //  the AppCoordinator it must own the window.
    init(window: UIWindow?) {
        self.window = window
    }
    
    override func start() {
        guard let window = window else { return }
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        
        self.searchFlow()
    }
    
    private func searchFlow() {
        let searchCoordinator = SearchCoordinator(navigationController: self.rootViewController)
        searchCoordinator.delegate = self
        store(coordinator: searchCoordinator)
        searchCoordinator.start()
    }
    
    private func detailFlow(_ movie: Movie) {
        let detailCoordinator = DetailCoordinator(navigationController: self.rootViewController, movie: movie)
        detailCoordinator.delegate = self
        store(coordinator: detailCoordinator)
        detailCoordinator.start()
    }
    
//    private func bookmarkFlow() {
//        let bookmarkCoordinator = BookmarkCoordinator(navigationController: self.rootViewController)
//        bookmarkCoordinator.delegate = self
//        store(coordinator: bookmarkCoordinator)
//        bookmarkCoordinator.start()
//    }
}

extension AppCoordinator: SearchCoordinatorDelegate {
    func didFinishSearchCordinator(coordinator: Coordinator, movie: Movie) {
        //self.free(coordinator: coordinator)
        self.detailFlow(movie)
    }
}

extension AppCoordinator: DetailCoordinatorDelegate {
    func didFinishDetailCoordinator(coordinator: Coordinator) {
        self.free(coordinator: coordinator)
        self.searchFlow()
    }
    
    func bookmarkTapped() {
        //
    }
}
