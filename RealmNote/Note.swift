//
//  Note.swift
//  RealmNote
//
//  Created by Jiwoo Ban on 2020/06/05.
//  Copyright © 2020 Jiwoo Ban. All rights reserved.
//

import Foundation

class Note {
    
    var identifier: String
    var content: String
    var lastEdited: Date
    
    init(
        identifier: String = UUID().uuidString,
        content: String,
        lastEdited: Date = Date()) {
        self.identifier = identifier
        self.content = content
        self.lastEdited = lastEdited
    }
}

//Connect with Realm(RealmNote.swift)
