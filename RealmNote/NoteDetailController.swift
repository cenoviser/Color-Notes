//
//  NoteDetailController.swift
//  RealmNote
//
//  Created by Jiwoo Ban on 2020/06/03.
//  Copyright © 2020 Jiwoo Ban. All rights reserved.
//

import Foundation
import UIKit

class NoteDetailController: UIViewController {
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.preferredFont(forTextStyle: .headline)
        textView.adjustsFontForContentSizeCategory = true
        textView.textColor = UIColor.white
        textView.text = "..."
        textView.textAlignment = .left
        textView.isScrollEnabled = true
        textView.backgroundColor = UIColor.clear
        textView.dataDetectorTypes = .all
        
        return textView
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = Theme.backgroundColor
        self.navigationItem.title = "Editing"
        self.navigationItem.largeTitleDisplayMode = .never
        
        self.view.addSubview(textView)
        
        self.textView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.textView.leadingAnchor.constraint(equalTo: self.view.readableContentGuide.leadingAnchor).isActive = true
        self.textView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.textView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
    }
}
