//
//  truncate.swift
//  RealmNote
//
//  Created by Jiwoo Ban on 2020/06/07.
//  Copyright © 2020 Jiwoo Ban. All rights reserved.
//
import Foundation

extension String {
    
    func truncate(length: Int, trailing: String = "…") -> String {
        if self.count > length {
            return String(self.prefix(length)) + trailing
        } else {
            return self
        }
    }
    
}
