//
//  NotesViewController.swift
//  RealmNote
//
//  Created by Jiwoo Ban on 2020/05/28.
//  Copyright © 2020 Jiwoo Ban. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
//    let colorButton: UIButton = {
//        let colorButton = UIButton()
//        colorButton.translatesAutoresizingMaskIntoConstraints = false
////        let twitterBlue = UIColor(r: 61, g: 167, b: 244)
//        colorButton.backgroundColor = UIColor.red
//        colorButton.layer.cornerRadius = 2
////        colorButton.layer.borderColor
//        colorButton.setTitle("Change", for: .normal)
//
////        button.layer.cornerRadius = 2
////        button.layer.borderColor = twitterBlue.cgColor
////        button.layer.borderWidth = 2
////        button.setTitleColor(twitterBlue, for: .normal)
////        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
////        button.setImage(.checkmark, for: .normal)
////        button.imageView?.contentMode = .scaleAspectFit
////        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
//        return colorButton
//
//    }()
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var notes: [Note] {
        return self.noteDataSource.notes
    }
    
    let noteDataSource: NoteDataSource
    
    init(noteDataSource: NoteDataSource) {
        self.noteDataSource = noteDataSource
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    
    
    //Color 노트 dropdown 메뉴 구현
    var dropViewBtn = dropDownBtn()
    
    
    override func viewDidLoad() {
        
        
        //
        self.view.backgroundColor = Theme.backgroundColor
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.title = "Color Notes "
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didTapColorChange)), UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(didTapCompose))]
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.tableFooterView = UIView() // Remove the empty separator lines
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = CGFloat(50)
        
        self.tableView.register(NoteTableCell.self, forCellReuseIdentifier: NoteTableCell.identifier)
        
        self.view.addSubview(self.tableView)
        
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(notesDidUpdate), name: .noteDataChanged, object: nil)
        
        
        
        
        //Color 노트 dropdown 메뉴 구현
        dropViewBtn = dropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
//        dropViewBtn.setTitle("12121212", for: .normal)
        dropViewBtn.setTitle("Color", for: .normal)
        dropViewBtn.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(dropViewBtn)
        
        dropViewBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        dropViewBtn.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        dropViewBtn.widthAnchor.constraint(equalToConstant: 150).isActive = true
        dropViewBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        dropViewBtn.dropView.dropDownOptions = ["Red", "Orange", "Yellow", "Green", "Blue", "Navy", "Purple"]
    }
    
    
    
    @objc func didTapCompose() {
        self.navigationController?.pushViewController(NoteDetailController(noteDataSource: self.noteDataSource), animated: true)
    }
    
//    func myMenu() -> UIContextMenuConfiguration? {
//            let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
//            let action = UIAction(title: "Color1") { _ in
//                print("Color1!")
//            }
//            let menu = UIMenu(title: "Color1", image: nil, identifier: nil, options: [], children: [action])
//
//            return menu
//        }
//
//        return config
//    }
    
    @objc func didTapColorChange() {
//        self.navigationController?.pushViewController(ColorViewController(), animated: true)
//        self.navigationController?.show(ColorViewController(), sender: nil)
        

        
//        self.show(config, sender: nil)
//        self.navigationController?.show(config, sender: nil)
        print("Tapped")
        
//        let items = ["1", "2"]
//        let menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: BTTitle.title("Dropdown Menu"), items: items)
//        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> () in
//            print("Did select")
//        }
    }
    
    
    
    @objc func notesDidUpdate() {
        print ("NotesViewController: Note Data Changed")
        self.tableView.reloadData()
    }

}


extension NotesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableCell.identifier, for: indexPath) as! NoteTableCell
        cell.note = self.notes[indexPath.row]
        
        cell.layoutIfNeeded() // This will ensure labels don't get cut off
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notes.count
    }
    
}

extension NotesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = NoteDetailController(noteDataSource: self.noteDataSource)
        controller.note = self.notes[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}





//메뉴아이템중에 선택하는것이 메뉴아이템의 title로 된다.
protocol dropDownProtocol {
    func dropDownPressed(string: String)
}


class dropDownBtn: UIButton, dropDownProtocol {
    
    func dropDownPressed(string: String) {
        self.setTitle(string, for: .normal)
        //menuItem 선택하면 dropdown dismiss
        self.dismissDropDown()
    }
    
    
    var dropView = dropDownView()
    
    var height = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.backgroundColor = UIColor.blue
        
        dropView = dropDownView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        dropView.delegate = self //data that coming from the data will be passed along to this function.
        dropView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func didMoveToSuperview() {
        self.superview?.addSubview(dropView)
        self.superview?.bringSubviewToFront(dropView)
        
        dropView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        dropView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dropView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        height = dropView.heightAnchor.constraint(equalToConstant: 0)
    }
    
    var isOpen = false
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isOpen == false {
            
            isOpen = true
            
            NSLayoutConstraint.deactivate([self.height])
            
            
            //tableview의 필드에 맞게 height 맞추기
            if self.dropView.tableView.contentSize.height > 150 {
                self.height.constant = 150
            } else {
                self.height.constant = self.dropView.tableView.contentSize.height
            }
            
            
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.layoutIfNeeded()
                self.dropView.center.y += self.dropView.frame.height / 2
            }, completion: nil)
            
        } else {
            isOpen = false
            
            NSLayoutConstraint.deactivate([self.height])
            self.height.constant = 0
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                
                self.dropView.center.y -= self.dropView.frame.height / 2
                self.dropView.layoutIfNeeded()

            }, completion: nil)
        }
        
    }
    
    //메뉴아이템 선택하면 dropdown 메뉴 dismiss
    func dismissDropDown() {
        isOpen = false
        
        NSLayoutConstraint.deactivate([self.height])
        self.height.constant = 0
        NSLayoutConstraint.activate([self.height])
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            
            self.dropView.center.y -= self.dropView.frame.height / 2
            self.dropView.layoutIfNeeded()

        }, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}






class dropDownView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var dropDownOptions = [String]() //array of strings
    
    var tableView = UITableView()
    
    var delegate : dropDownProtocol!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.backgroundColor = UIColor.red
        self.backgroundColor = UIColor.yellow
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropDownOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        cell.backgroundColor = UIColor.blue
        
        cell.textLabel?.text = dropDownOptions[indexPath.row]
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate.dropDownPressed(string: dropDownOptions[indexPath.row])
        //메뉴아이템에서 선택되어있는거 원상복구
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    

}
