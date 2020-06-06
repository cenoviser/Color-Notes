//
//  DataSource.swift
//  RealmNote
//
//  Created by Jiwoo Ban on 2020/06/06.
//  Copyright © 2020 Jiwoo Ban. All rights reserved.
//

import Foundation

protocol DataSource {
    func store<T>(object: T)
    func delete<T>(object: T)
}
