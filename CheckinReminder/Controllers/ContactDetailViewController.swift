//
//  ContactDetailViewController.swift
//  CheckinReminder
//
//  Created by Yue Tong on 8/14/19.
//  Copyright © 2019 Biang Studio. All rights reserved.
//

import UIKit
import RealmSwift
import SnapKit
import ChameleonFramework

class ContactDetailViewController: UIViewController {
    // MARK: - Properties
    let realm = try! Realm()
    var contact: Contact?
    
    let nameLabel = UILabel()
    let cadenceLabel = UILabel()
    let lastContactDateLabel = UILabel()
    let notesLabel = UILabel()
    let markCaughtUpBotton = UIButton(type: .system)
    let testSquareView = UIView()
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d yyyy"
        return formatter
    }()
    
    @IBAction func editButtonPressed(_ sender: Any) {
        print("edit button pressed. sugue to be performed")
        performSegue(withIdentifier: "gotoEditContact", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
    }
    
    func setupViews() {
        // labels and buttons
        guard let firstName = contact?.firstName,
            let lastName = contact?.lastName,
            let cadence = contact?.cadence,
            let lastContactDate = contact?.lastContactDate else {
                fatalError("Contact not loaded correctly")
        }
        
        nameLabel.text = "\(firstName) \(lastName)"
        cadenceLabel.text = "Once every \(cadence) weeks"
        lastContactDateLabel.text = ContactDetailViewController.dateFormatter.string(from: lastContactDate)
        notesLabel.text = "No notes available."
        markCaughtUpBotton.setTitle("Already caught up with \(firstName)", for: .normal)
        
        // styling
        nameLabel.numberOfLines = 0
        nameLabel.textColor = .purple
        nameLabel.font = .systemFont(ofSize: 25)
        
        cadenceLabel.numberOfLines = 0
        cadenceLabel.font = .systemFont(ofSize: 15)
        
        lastContactDateLabel.font = .systemFont(ofSize: 15)
        
        notesLabel.numberOfLines = 0
        notesLabel.font = .italicSystemFont(ofSize: 15)
        
        
        markCaughtUpBotton.addTarget(self, action: #selector(caughtUpButtonPressed), for: .touchUpInside)
        if (contact!.nextDueDate > Date()){
            markCaughtUpBotton.isHidden = true
        }
        else{
            markCaughtUpBotton.isHidden = false
        }
        
        // layout
        let stackView = UIStackView(arrangedSubviews: [nameLabel, cadenceLabel, lastContactDateLabel, notesLabel])
        
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        view.addSubview(stackView)
        view.addSubview(markCaughtUpBotton)
        
        stackView.snp.makeConstraints{ make in
            make.leading.equalTo(view).offset(32)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            make.width.equalTo(view.safeAreaLayoutGuide)
            
        }
        
        markCaughtUpBotton.snp.makeConstraints{ make in
            make.top.equalTo(stackView.snp.bottom).offset(4)
            make.leading.equalTo(stackView.snp.leading)
        }
        
        view.addSubview(testSquareView)
        
        testSquareView.snp.makeConstraints{make in
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
        }
        //testSquareView.backgroundColor = GradientColor(.leftToRight, frame: testSquareView.frame, colors: [.flatRed, .flatSkyBlueDark, .flatBlue])
        testSquareView.backgroundColor = UIColor.flatLime
        
        view.setNeedsLayout()
    }
    
    @objc func caughtUpButtonPressed(sender: UIButton!){
        print("button pressed. Should update date and due date.")
        // perhaps ask the user to confirm
        do{
            try realm.write {
                contact?.lastContactDate = Date()
                contact?.updateDueDate()
                }
            }catch{
                fatalError("error saving catch up.")
        }
        setupViews()
    }
}

//MARK: - Navigation
extension ContactDetailViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoEditContact"{
            let destVC = segue.destination as! EditContactViewController
            
            destVC.formToEditAContact = true
            destVC.contactVM = contact
        }
    }
}
