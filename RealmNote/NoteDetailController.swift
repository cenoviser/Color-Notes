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
    
    var note: Note? = nil
    
    var originalContent: String = ""
    
    var placeholder = "Tap here to type..."
    
    var shouldDelete: Bool = false
    
    var doneButton: UIBarButtonItem? = nil
    var trashButton: UIBarButtonItem? = nil
    
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = Theme.backgroundColor
        self.navigationItem.title = "Editing"
        self.navigationItem.largeTitleDisplayMode = .never
        
        if self.note == nil {
            self.note = Note(content: "")
        }
        
        self.originalContent = self.note?.content ?? ""
        
        self.view.addSubview(textView)
        
        self.textView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.textView.leadingAnchor.constraint(equalTo: self.view.readableContentGuide.leadingAnchor).isActive = true
        self.textView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.textView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        //노트의 내용이 비어있으면 placeholder로 표시하기
        self.textView.text = self.note?.content.isEmpty == true ? self.placeholder : self.note?.content
        
        self.doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        
        self.trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete))
        
        
        if let trashButton = self.trashButton {
            self.navigationItem.rightBarButtonItems = [trashButton]
        }
    }
    
    @objc func didTapDone() {
        self.textView.endEditing(true)
    }
    
    @objc func didTapDelete() {
        self.shouldDelete = true
        
        self.navigationController?.popViewController(animated: true)
    }
}
