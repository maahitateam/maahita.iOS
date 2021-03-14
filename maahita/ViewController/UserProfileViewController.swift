//
//  UserProfileViewController.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 14/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit

class UserProfileViewController: PanCloseViewController {
    
    var isNameEditing: Bool = false
    
    var userDisplayName: String = ""
    var userEmailId: String = ""
    var isEmailVerified: Bool  = false
    
    lazy var profilePicView: ProfilePicView = {
        let profilePic = ProfilePicView()
        profilePic.translatesAutoresizingMaskIntoConstraints = false
        return profilePic
    }()
    
    lazy var backGroundImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "avatar")
        bgImageView.contentMode = .scaleAspectFill
        bgImageView.clipsToBounds = true
        bgImageView.translatesAutoresizingMaskIntoConstraints = false
        return bgImageView
    }()
    
    lazy var blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blur = UIVisualEffectView(effect: effect)
        blur.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blur.backgroundColor = UIColor.ceruleanThree.withAlphaComponent(0.15)
        blur.alpha = 0.85
        blur.translatesAutoresizingMaskIntoConstraints = false
        return blur
    }()
    
    lazy var profilePlaceHolder: UIView = {
        let placeholder = UIView()
        placeholder.backgroundColor = .darkGray
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        return placeholder
    }()
    
    lazy var fullName: UITextField = {
        let name = UITextField()
        name.setLeftView(image: UIImage(named: "nametag")!)
        name.font = UIFont(name: "Comfortaa-Regular", size: 16.0)
        name.clearButtonMode = .whileEditing
        name.textContentType = .name
        name.placeholder = "Full Name"
        name.textAlignment = .left
        name.returnKeyType = .done
        name.borderStyle = .none
        name.backgroundColor = .white
        name.layer.borderColor = UIColor.white.cgColor
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    lazy var cameraButton: UIButton = {
        let camera = UIButton()
        camera.setImage(UIImage(named: "camera"), for: .normal)
        camera.setImage(UIImage(named: "camera-pressed"), for: .highlighted)
        camera.setImage(UIImage(named: "camera-pressed"), for: .focused)
        camera.setImage(UIImage(named: "camera-pressed"), for: .selected)
        camera.imageView?.tintColor = .white
        camera.addTarget(self, action: #selector(openCameraActionSheet), for: .touchUpInside)
        camera.translatesAutoresizingMaskIntoConstraints = false
        return camera
    }()
    
    lazy var profileTableView: UITableView = {
        let profileTable = UITableView(frame: CGRect.zero, style: .grouped)
        profileTable.translatesAutoresizingMaskIntoConstraints = false
        return profileTable
    }()
    
    lazy var pickerController: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.mediaTypes = ["public.image"]
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = ""
        
        self.view.addSubview(profilePlaceHolder)
        profilePlaceHolder.addSubview(backGroundImageView)
        profilePlaceHolder.addSubview(blurView)
        profilePlaceHolder.addSubview(profilePicView)
        profilePlaceHolder.addSubview(cameraButton)
        self.view.addSubview(profileTableView)
        
        self.profileTableView.delegate = self
        self.profileTableView.dataSource = self
        self.profileTableView.allowsSelection = false
                
        NSLayoutConstraint.activate([
            profilePlaceHolder.topAnchor.constraint(equalTo: self.titleBackground.bottomAnchor),
            profilePlaceHolder.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            profilePlaceHolder.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            profilePlaceHolder.heightAnchor.constraint(equalToConstant: 200.0),
            backGroundImageView.topAnchor.constraint(equalTo: self.profilePlaceHolder.topAnchor),
            backGroundImageView.leadingAnchor.constraint(equalTo: self.profilePlaceHolder.leadingAnchor),
            backGroundImageView.trailingAnchor.constraint(equalTo: self.profilePlaceHolder.trailingAnchor),
            backGroundImageView.bottomAnchor.constraint(equalTo: self.profilePlaceHolder.bottomAnchor),
            blurView.topAnchor.constraint(equalTo: self.backGroundImageView.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: self.backGroundImageView.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: self.backGroundImageView.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: self.backGroundImageView.bottomAnchor),
            
            profilePicView.heightAnchor.constraint(equalTo: blurView.heightAnchor, multiplier: 0.75),
            profilePicView.widthAnchor.constraint(equalTo: profilePicView.heightAnchor),
            profilePicView.centerXAnchor.constraint(equalTo: blurView.centerXAnchor),
            profilePicView.bottomAnchor.constraint(equalTo: blurView.bottomAnchor, constant: -20.0),
            cameraButton.heightAnchor.constraint(equalToConstant: 35.0),
            cameraButton.widthAnchor.constraint(equalToConstant: 35.0),
            cameraButton.bottomAnchor.constraint(equalTo: profilePicView.bottomAnchor),
            cameraButton.trailingAnchor.constraint(equalTo: profilePicView.trailingAnchor),
            
            profileTableView.topAnchor.constraint(equalTo: profilePlaceHolder.bottomAnchor),
            profileTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        if let user = UserAuthService.instance.user {
            if let url = user.photoURL?.absoluteString {
                profilePicView.profilePicURL = url
                backGroundImageView.cacheImage(urlString: url)
            }
            
            self.userDisplayName = user.displayName ?? ""
            self.userEmailId = user.email ?? ""
            self.isEmailVerified = user.isEmailVerified
        }
        
        UserAuthService.instance.delegates?.append(self)
    }
    
//    @objc func changeImage() {
//        let fusuma = FusumaViewController()
//        fusuma.delegate = self
//        fusuma.availableModes = [FusumaMode.camera, FusumaMode.library]
//        fusumaTitleFont = UIFont(name: "Comfortaa-Regular", size: 18)
//        fusumaBackgroundColor = UIColor(from: "#666666")
//        fusumaTintColor = .white
//        fusuma.allowMultipleSelection = false
//        self.present(fusuma, animated: true, completion: nil)
//    }
    
    func saveFullName(displayName: String?) {
        if let name = displayName {
            UserAuthService.instance.save(name: name) { (success, error) in
                self.showToast(message: "Display name has been saved")
            }
        }
    }
    
    func doVerifyEmail() {
        UserAuthService.instance.verifyemail(completion: { (success, error) in
            if success {
                self.showToast(message: "A verification email has been sent.")
            }
        })
    }
    
    func changepassword() {
        let reloginViewController = ReloginViewController()
        reloginViewController.isDeleteAccount = false
        reloginViewController.delegate = self
        self.present(reloginViewController, animated: true, completion: nil)
    }
    
    func removeaccount() {
        
        let alert = UIAlertController(title: "Confirmation", message: "Are you sure, you would like to leave us?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes, I am", style: .default, handler: { (action: UIAlertAction!) in
            let reloginViewController = ReloginViewController()
            reloginViewController.isDeleteAccount = true
            reloginViewController.delegate = self
            self.present(reloginViewController, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "No, not now", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func doLogout() {
        if let user = UserAuthService.instance.user, !user.isAnonymous {
            let alert = UIAlertController(title: "Confirmation", message: "Are you sure, you would like to logout?", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Yes, I am", style: .default, handler: { (action: UIAlertAction!) in
                //Logout
                UserAuthService.instance.signout()
                self.dismiss(animated: true, completion: nil)
            }))
            
            alert.addAction(UIAlertAction(title: "No, not now", style: .destructive, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    @objc func openCameraActionSheet() {
        let cameraActionSheet: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            
        }
        cameraActionSheet.addAction(cancelActionButton)

        let cameraActionButton = UIAlertAction(title: "Take a selfie", style: .default)
            { _ in
                self.pickerController.sourceType = .camera
                NavigationUtility.presentOverCurrentContext(destination: self.pickerController, style: .fullScreen)
        }
        cameraActionSheet.addAction(cameraActionButton)

        let albumActionButton = UIAlertAction(title: "Camera roll", style: .default)
            { _ in
                self.pickerController.sourceType = .savedPhotosAlbum
                NavigationUtility.presentOverCurrentContext(destination: self.pickerController)
        }
        cameraActionSheet.addAction(albumActionButton)
        
        let photoActionButton = UIAlertAction(title: "Photo library", style: .default)
            { _ in
                self.pickerController.sourceType = .photoLibrary
                NavigationUtility.presentOverCurrentContext(destination: self.pickerController)
        }
        cameraActionSheet.addAction(photoActionButton)
        
        if let popoverController = cameraActionSheet.popoverPresentationController {
          popoverController.sourceView = self.cameraButton
        }
        
        NavigationUtility.presentOverCurrentContext(destination: cameraActionSheet, style: .custom, completion: nil)
    }
    
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)
        
        self.profilePicView.profileImage = image
        self.backGroundImageView.image = image
        
        UserAuthService.instance.save(image: image!) { (success, error) in
            if success {
                self.showToast(message: "Your avatar has been saved successfully")
            }
            else {
                self.showToast(message: error!.localizedDescription)
            }
        }
    }
}

extension UserProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }

    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return self.pickerController(picker, didSelect: nil)
        }
        self.pickerController(picker, didSelect: image)
    }
}

extension UserProfileViewController: AuthServiceDelegate {
    func refreshUser() {
        if let user = UserAuthService.instance.user, !user.isAnonymous {
            self.fullName.text = user.displayName
            self.profilePicView.profilePicURL = user.photoURL?.absoluteString
            self.profilePicView.isUserInteractionEnabled = true
        }
        
        if let url = profilePicView.profilePicURL {
            backGroundImageView.cacheImage(urlString: url)
        }
    }
}

extension UserProfileViewController : ReloginViewDelegate {
    func relogin(authenticated: Bool, isdelete: Bool) {
        if !isdelete {
            UserAuthService.instance.changepassword { (success, error) in
                self.showToast(message: "Password reset link has been sent to your email")
            }
        } else {
            UserAuthService.instance.removeaccount { (success, error) in
                if success {
                    self.showToast(message: "Your account has been removed successfully")
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.showToast(message: error!.localizedDescription)
                }
            }
        }
    }
}

extension UserProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section < 3 {
            return 0.0
        } else {
            return tableView.sectionFooterHeight
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            case 0: return "Display Name"
            case 1: return "Email"
            default: return ""
        }
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch section {
            case 3:
                return "An email with a link to change your password will be delivered. Check your Junk emails before retrying."
            case 4:
                return "You can remove your account from māhita permanently. However, your attendance log and feedback will stay with us for our quality purposes."
            default:
                return ""
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:UserProfileCell = tableView.getCell(with: UserProfileCell.self, at: indexPath) as? UserProfileCell else { preconditionFailure("Invalid cell") }
        cell.delegate = self
        if (indexPath.section == 0) {
            cell.configure(cellType: .DisplayName, titleText: userDisplayName)
        } else if (indexPath.section == 1) {
            cell.configure(cellType: .Email, titleText: userEmailId, isVerified: isEmailVerified)
        } else if (indexPath.section == 2) {
            cell.configure(cellType: .Logout)
        } else if (indexPath.section == 3) {
            cell.configure(cellType: .ChangePassword)
        } else {
            cell.configure(cellType: .RemoveAccount)
        }
        
        return cell
    }
}

extension UserProfileViewController: UserProfileCellDelegate {
    func cellAction(cellValue: String?, cellType: CellType) {
        switch cellType {
        case .DisplayName:
            self.saveFullName(displayName: cellValue)
        case .Email:
            self.doVerifyEmail()
        case .Logout:
            self.doLogout()
        case .ChangePassword:
            self.changepassword()
        case .RemoveAccount:
            self.removeaccount()
        }
    }
}
