//
//  DueContactCell.swift
//  CheckinReminder
//
//  Created by Yue Tong on 9/16/19.
//  Copyright © 2019 Biang Studio. All rights reserved.
//

import UIKit
import SnapKit
import ChameleonFramework

class DueContactCell: UITableViewCell {
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d yyyy"
        return formatter
    }()

    var contact: Contact? {
        didSet{
            contactNameLabel.text = "\(contact?.lastName ?? "No"), \(contact?.firstName ?? "One")"
            let days = Date().interval(ofComponent: .day, fromDate:contact!.lastContactDate)
            lastContactTime.text = "Not been in touch for \(days) days"
        }
    }
    
    private let contactNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let lastContactTime: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let backgroundCardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.flatBlue()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // configure layout
        contentView.addSubview(backgroundCardView)
        contentView.addSubview(contactNameLabel)
        contentView.addSubview(lastContactTime)
        
        backgroundCardView.snp.makeConstraints{make in
            make.edges.equalTo(contentView).inset(UIEdgeInsets(top:15, left: 10,bottom: 5,right: 15))
        }
        
        contactNameLabel.snp.makeConstraints{make in
            make.top.equalTo(backgroundCardView.snp.top).offset(5)
            make.leading.equalTo(backgroundCardView.snp.leading).offset(5)
        }
        
        lastContactTime.snp.makeConstraints{make in
            make.top.equalTo(contactNameLabel.snp.bottom).offset(3)
            make.leading.equalTo(backgroundCardView.snp.leading).offset(5)
        }

        
        // set add rounded corner
        backgroundCardView.clipsToBounds = false
        backgroundCardView.layer.cornerRadius = 10
        backgroundCardView.layer.borderColor = UIColor.clear.cgColor

        // set shadow
        backgroundCardView.layer.shadowColor = UIColor.black.cgColor
        backgroundCardView.layer.shadowOffset = CGSize(width: 2, height: 2)
        backgroundCardView.layer.shadowRadius = 5
        
        backgroundCardView.layer.shadowOpacity = 0.40
        // TODO: improve performance by using UIBezierPath
        //layer.shadowPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
        backgroundCardView.layer.shouldRasterize = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
