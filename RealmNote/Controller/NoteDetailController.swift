//
//  NoteDetailController.swift
//  RealmNote
//
//  Created by Jiwoo Ban on 2020/06/03.
//  Copyright © 2020 Jiwoo Ban. All rights reserved.
//

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
    let placeholder = "Tap here to type..."
    
    var originalContent: String = ""
    var shouldDelete: Bool = false
    
    var doneButton: UIBarButtonItem? = nil
    var trashButton: UIBarButtonItem? = nil
    
    let noteDataSource: NoteDataSource
    
    init(noteDataSource: NoteDataSource) {
        self.noteDataSource = noteDataSource
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = Theme.backgroundColor
        self.navigationItem.title = "Editing"
        self.navigationItem.largeTitleDisplayMode = .never
        
        if self.note == nil {
            self.note = Note(content: "")
        }
        
        self.originalContent = self.note?.content ?? ""
        
        self.view.addSubview(self.textView)
        
        self.textView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.textView.leadingAnchor.constraint(equalTo: self.view.readableContentGuide.leadingAnchor).isActive = true
        self.textView.trailingAnchor.constraint(equalTo: self.view.readableContentGuide.trailingAnchor).isActive = true
        self.textView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.textView.text = self.note?.content.isEmpty == true ? self.placeholder : self.note?.content
        self.textView.delegate = self
        
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

    override func viewWillDisappear(_ animated: Bool) {
        if self.textView.text.isEmpty || self.shouldDelete {
            self.note?.delete(dataSource: self.noteDataSource)
        } else {
            // Ensure that the content of the note has changed.
            guard self.originalContent != self.note?.content else {
                return
            }
            
            self.note?.write(dataSource: self.noteDataSource)
        }
    }
    
}

extension NoteDetailController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == self.placeholder {
            textView.text = ""
        }
        
        self.navigationItem.hidesBackButton = true
        
        if let trashButton = self.trashButton, let doneButton = self.doneButton {
            self.navigationItem.rightBarButtonItems = [doneButton, trashButton]
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = self.placeholder
        }
        
        self.note?.content = textView.text
        
        if let trashButton = self.trashButton {
            self.navigationItem.rightBarButtonItems = [trashButton]
        }
        
        self.navigationItem.hidesBackButton = false
    }
    
}
