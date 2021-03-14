//
//  UserProfileCell.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 25/06/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit

public enum CellType : String {
    case DisplayName = "Save"
    case Email = "Verify"
    case Logout = "Logout"
    case ChangePassword = "Change Password"
    case RemoveAccount = "Remove Account"
}

protocol UserProfileCellDelegate {
    func cellAction(cellValue: String?, cellType: CellType)
}

class UserProfileCell: UITableViewCell {
    
    var cellType: CellType = .DisplayName
    
    var delegate: UserProfileCellDelegate?
    
    lazy var cellTitle: UITextField = {
        let title = UITextField()
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    lazy var cellCommand: UIButton = {
        let command = UIButton()
        command.translatesAutoresizingMaskIntoConstraints = false
        return command
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(cellType: CellType, titleText: String = "", isVerified: Bool = false) {
        self.cellType = cellType
        addSubview(cellTitle)
        addSubview(cellCommand)
        cellTitle.text = titleText
        cellTitle.delegate = self
        cellTitle.font = UIFont(name: "Comfortaa-Regular", size: 14.0)
        cellCommand.setTitle(cellType.rawValue, for: .normal)
        cellCommand.titleLabel?.font = UIFont(name: "Comfortaa-Bold", size: 15.0)
        cellCommand.isHidden = isVerified
        cellCommand.addTarget(self, action: #selector(cellAction), for: .touchUpInside)
        
        if (cellType == .DisplayName || cellType == .Email) {
            NSLayoutConstraint.activate([
                cellTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0),
                cellTitle.topAnchor.constraint(equalTo: topAnchor),
                cellTitle.bottomAnchor.constraint(equalTo: bottomAnchor),
                cellCommand.leadingAnchor.constraint(equalTo: cellTitle.trailingAnchor, constant: 10.0),
                cellCommand.widthAnchor.constraint(equalToConstant: 60.0),
                cellCommand.heightAnchor.constraint(equalToConstant: 30.0),
                cellCommand.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0),
                cellCommand.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
            
            if (cellType == .Email) {
                cellCommand.setTitleColor(.cerulean, for: .normal)
                cellTitle.isEnabled = false
            } else {
                cellCommand.setTitleColor(.red, for: .normal)
            }
        } else if (cellType == .Logout || cellType == .ChangePassword || cellType == .RemoveAccount) {
            cellTitle.isHidden = true
            NSLayoutConstraint.activate([
                cellCommand.leadingAnchor.constraint(equalTo: leadingAnchor),
                cellCommand.trailingAnchor.constraint(equalTo: trailingAnchor),
                cellCommand.topAnchor.constraint(equalTo: topAnchor),
                cellCommand.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
            
            if (cellType == .Logout) {
                cellCommand.backgroundColor = .red
                cellCommand.setTitleColor(.white, for: .normal)
            }
            else if (cellType == .ChangePassword) {
                cellCommand.setTitleColor(.cerulean, for: .normal)
            } else if (cellType == .RemoveAccount) {
                cellCommand.setTitleColor(.red, for: .normal)
            }
        }
    }
    
    @objc func cellAction() {
        self.cellTitle.resignFirstResponder()
        self.delegate?.cellAction(cellValue: cellTitle.text, cellType: cellType)
    }
}

extension UserProfileCell : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
