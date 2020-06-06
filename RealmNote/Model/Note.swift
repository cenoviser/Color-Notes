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
//RealmNote.swift와 Note 연결 짓기.
extension Note {
    
    convenience init(realmNote: RealmNote) {
        self.init(identifier: realmNote.identifier, content: realmNote.content, lastEdited: realmNote.lastEdited)
    }
    
    //Make realmNote Property,
    var realmNote: RealmNote {
        //So we can access the RealmNote
        return RealmNote(note: self)
    }
} //이제 DataSource.swift에 데이터를 저장할 수 있다.



extension Note: Writable {
    func write(dataSource: DataSource) {
        self.lastEdited = Date()
        
        dataSource.store(object: self)
    }
    
    func delete(dataSource: DataSource) {
        dataSource.delete(object: self)
    }
    
    
}
