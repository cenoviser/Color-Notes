//
//  NoteDataSource.swift
//  RealmNote
//
//  Created by Jiwoo Ban on 2020/06/06.
//  Copyright © 2020 Jiwoo Ban. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class NoteDataSource: DataSource {
    
    var notes: [Note] {
        
        //이거말고, we need to fetc it from our database
        let objects = realm.objects(RealmNote.self).sorted(byKeyPath: "lastEdited", ascending: false)
        
        //오브젝트를 리턴할때, Results<RealmNote> 타입이라서, 이 어레이를 convert 해줘야 함.
        return objects.map {
            //$0 is the current object that interating over, and it's a type realm note, 그래서 we can access and then return.
            return $0.note
        }
    }
    
    //Now, Retrieve the note data from Realm Database
    var realm: Realm
    
    init() {
        // Load our data
        self.realm = try! Realm()
    }
    
    func store<T>(object: T) {
        guard let note = object as? Note else {
            return
        }
        
        // Save our note
        try? self.realm.write {
            self.realm.add(note.realmNote, update: .all)
        }
        
        NotificationCenter.default.post(name: .noteDataChanged, object: nil)
    }
    
    func delete<T>(object: T) {
        guard let note = object as? Note else {
            return
        }
        
        //Delete our note
        if let realmNote = self.realm.object(ofType: RealmNote.self, forPrimaryKey: note.identifier) {
            self.realm.beginWrite()
            self.realm.delete(realmNote)
            try? self.realm.commitWrite()
        }
        
        NotificationCenter.default.post(name: .noteDataChanged, object: nil)
    }
}

extension Notification.Name {
    
    static let noteDataChanged = Notification.Name(rawValue: "noteDataChanged")
}
