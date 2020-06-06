//
//  Writable.swift
//  RealmNote
//
//  Created by Jiwoo Ban on 2020/06/06.
//  Copyright © 2020 Jiwoo Ban. All rights reserved.
//

import Foundation

protocol Writable {
    
    func write(dataSource: DataSource)
    func delete(dataSource: DataSource)
    
}
