//
//  Realm.swift
//  Movie
//
//  Created by KSNetDev1 on 2022/02/22.
//

import Foundation
import RealmSwift

class RealmManager {
    let db: Realm
    
    static let shared = RealmManager()
    
    private init() {
        do {
            db = try Realm()
        }
        catch {
            fatalError(error.localizedDescription)
        }
    }
}
