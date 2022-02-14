//
//  Coordinator.swift
//  Movie
//
//  Created by KSNetDev1 on 2022/02/14.
//

import Foundation

protocol Coordinator : AnyObject {
  var childCoordinators: [Coordinator] { get set }
  func start()
}

extension Coordinator {
  // 새 코디네이터를 저장
  func store(coordinator: Coordinator) {
    childCoordinators.append(coordinator)
  }

  // 흐름 완료 시 제거
  // ex. 뒤로가기(네비게이션), dismiss 등
  func free(coordinator: Coordinator) {
    childCoordinators = childCoordinators.filter { $0 !== coordinator }
  }
}
