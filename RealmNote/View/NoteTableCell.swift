//
//  NoteTableCell.swift
//  RealmNote
//
//  Created by Jiwoo Ban on 2020/06/06.
//  Copyright © 2020 Jiwoo Ban. All rights reserved.
//

import UIKit

class NoteTableCell: UITableViewCell {
    
    let customBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //다크모드
//        view.backgroundColor = UIColor(red: 64/255, green: 64/255, blue: 64/255, alpha: 1.0)
        //그린모드
//        view.backgroundColor = UIColor(red: 0.11, green:0.43, blue:0.11, alpha: 1.0)
        view.backgroundColor = UIColor(red: 0.19, green:0.7, blue:0.19, alpha: 1.0)

        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = UIColor.white
        label.numberOfLines = 1
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = UIColor.white.withAlphaComponent(0.5)
        label.numberOfLines = 0
        return label
    }()
    
    var note: Note? = nil {
        didSet {
            guard let note = note else {
                return
            }
            
            self.titleLabel.text = String(note.content.split(separator: "\n")[0])
            
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            
            self.subtitleLabel.text = "Edited on \(formatter.string(from: note.lastEdited))"
        }
    }
    
    static let identifier = "NoteTableCell"
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessibilityTraits = UIAccessibilityTraits.button
        
        self.fontSizeDidChange()
        NotificationCenter.default.addObserver(self, selector: #selector(fontSizeDidChange), name: UIContentSizeCategory.didChangeNotification, object: nil)
        
        self.contentView.addSubview(self.customBackgroundView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.subtitleLabel)
        
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.customBackgroundView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        self.customBackgroundView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0).isActive = true
        self.customBackgroundView.leadingAnchor.constraint(equalTo: self.contentView.readableContentGuide.leadingAnchor).isActive = true
        self.customBackgroundView.trailingAnchor.constraint(equalTo: self.contentView.readableContentGuide.trailingAnchor).isActive = true
        
        self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.readableContentGuide.leadingAnchor, constant: 10).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.readableContentGuide.trailingAnchor).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20).isActive = true

        self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor).isActive = true
        self.subtitleLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor).isActive = true
        self.subtitleLabel.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor).isActive = true
        self.subtitleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    @objc func fontSizeDidChange() {
        if UIApplication.shared.preferredContentSizeCategory.isAccessibilityCategory {
            self.titleLabel.numberOfLines = 3
        } else {
            self.titleLabel.numberOfLines = 1
        }
    }
    
}
