//
//  NotesViewController.swift
//  RealmNote
//
//  Created by Jiwoo Ban on 2020/05/28.
//  Copyright © 2020 Jiwoo Ban. All rights reserved.
//

import Foundation
import UIKit
class NotesViewController: UIViewController {
    override func viewDidLoad() {
        self.view.backgroundColor = Theme.backgroundColor
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.title = "Realm Notes"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: nil)
        
        
        
    }
}
