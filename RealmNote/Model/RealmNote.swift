//
//  RealmNote.swift
//  RealmNote
//
//  Created by Jiwoo Ban on 2020/06/06.
//  Copyright © 2020 Jiwoo Ban. All rights reserved.
//

import Foundation
import RealmSwift

class RealmNote: Object {
    @objc dynamic var identifier: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var lastEdited: Date = Date()
    
    //We are not passing the value of the identifier property, we're passing the name of the property itself
    override class func primaryKey() -> String? {
        return "identifier"
    }
    
}

extension RealmNote {
    convenience init(note: Note) {
        self.init()
        
        self.identifier = note.identifier
        self.content = note.content
        self.lastEdited = note.lastEdited
    }
    
    var note: Note {
        //New Note 에 pass in the object that we are working with
        return Note(realmNote: self)
    }
} // 이제 note.swift로 옮겨가서 똑같이 해준다.
