//
//  ViewController.swift
//  showUs_draft1
//
//  Created by Mohit on 21/07/22.
//

import UIKit
import Firebase

class LoginTableVC: UITableViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var userStatusLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    var keyboardUp: Bool = true
//-------------------------------------------------------------------------------------------------------------
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        checkLogin()
        setup()
    }
    
//-------------------------------------------------------------------------------------------------------------
    //MARK: Setup
    func setup() {
        emailErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        userStatusLabel.isHidden = true
        
        setupKeyboardHiding()
        hideKeyboardWhenTappedAround()
    }
    
//-------------------------------------------------------------------------------------------------------------
    //MARK: Check Login
    private func checkLogin() {
        if UserDefaults.standard.bool(forKey: "USERLOGGEDIN") == true {
            self.moveToMainScreen(false)
        }
    }
    
    
//-------------------------------------------------------------------------------------------------------------
    
    //MARK: Keyboard Action
    func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func KeyboardWillShow() {
        
        if keyboardUp {
            view.frame.origin.y = view.frame.origin.y - 45
            keyboardUp = false
        }
    }
    
    @objc func KeyboardWillHide() {
        view.frame.origin.y = 0
        keyboardUp = true
    }
    
//-------------------------------------------------------------------------------------------------------------
    //MARK: Error Code
    func showError(_ label: UILabel!, text: String, color: UIColor = UIColor.red) {
        label.isHidden = false
        label.text = text
        label.textColor = color
    }
    
    func hideError(_ label: UILabel!) {
        label.isHidden = true
    }
    
//-------------------------------------------------------------------------------------------------------------
    
    //MARK: Button Action
    @IBAction func loginTapped(_ sender: UIButton) {
        checkUser()
    }
    
    @IBAction func signupTapped(_ sender: Any) {
        if let signupVC = self.storyboard?.instantiateViewController(withIdentifier: "SignupVC") as? SignupVC {
            self.navigationController?.pushViewController(signupVC, animated: true)
        }
    }
    
//-------------------------------------------------------------------------------------------------------------
    
//    func login() {
//        if let email = emailTF.text, let password = passwordTF.text {
//
//            if email != "" || password != "" {
//
//                if email != "mohitmarvania@gmail.com" {
//                    showError(emailErrorLabel, text: "Invalid Credentials")
//
//                } else if password != "Mohit@1234" {
//                    hideError(emailErrorLabel)
//                    showError(passwordErrorLabel, text: "Incorrect Password")
//                } else {
//                    hideError(emailErrorLabel)
//                    hideError(passwordErrorLabel)
//                }
//
//            } else {
//
//                showError(userStatusLabel, text: "Please enter proper details")
//            }
//
//        }
//    }
    
    func checkUser() {
        if let email = emailTF.text, let password = passwordTF.text {
            
            if email != "" || password != "" {
                
                hideError(userStatusLabel)
                
                if !email.isValidEmailAddress() {
                    showError(emailErrorLabel, text: "Invalid Credentials")
                    
                } else if !password.isValidPassword() {
                    hideError(emailErrorLabel)
                    showError(passwordErrorLabel, text: "Incorrect Password")
                    
                } else {
                    hideError(passwordErrorLabel)
                    
                    loginUser(email, password)
                    
                }
                
            } else {
                
                showError(userStatusLabel, text: "Please enter proper details")
            }
            
        }
    }
    
    private func loginUser(_ email: String, _ password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, err in
            
            if err != nil {

                self.showError(self.userStatusLabel, text: "FAILED TO LOGIN USER!!")
                return
            }
            
            self.showError(self.userStatusLabel, text: "SUCCESSFULLY LOGGED IN!", color: UIColor.systemGreen)
            CustomToast.show(message: "SUCCEESS!!", bgColor: .darkGray, textColor: .systemGreen, labelFont: .boldSystemFont(ofSize: 15), showIn: .top, controller: self)
            self.moveToMainScreen()
        }
    }
    
    func moveToMainScreen(_ animation: Bool = true) {
        let controller = UIStoryboard(name: "Student", bundle: nil)
        let studentvc = controller.instantiateViewController(withIdentifier: "StudentVC") as? StudentVC
        self.navigationController?.pushViewController(studentvc!, animated: animation)
        
    }
}

