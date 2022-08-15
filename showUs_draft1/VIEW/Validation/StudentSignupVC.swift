//
//  StudentSignupVC.swift
//  showUs_draft1
//
//  Created by Mohit on 22/07/22.
//

import UIKit
import Firebase

class StudentSignupVC: UIViewController {
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var conPasswordTF: UITextField!
    
    @IBOutlet weak var usernameErrorLabel: UILabel!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var conPasswordErrorLabel: UILabel!
    @IBOutlet weak var signupStatusLabel: UILabel!
    
    var keyboardUp: Bool = true
//-------------------------------------------------------------------------------------------------------------
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
//-------------------------------------------------------------------------------------------------------------
    //MARK: Setup
    func setup() {
        usernameErrorLabel.isHidden = true
        emailErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        conPasswordErrorLabel.isHidden = true
        signupStatusLabel.isHidden = true
        
        setupKeyboardHiding()
        hideKeyboardWhenTappedAround()
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
    //MARK: Error Action
    func showError(_ label: UILabel!, text: String, color: UIColor = UIColor.red) {
        label.isHidden = false
        label.text = text
        label.textColor = color
    }
    
    func hideError(_ label: UILabel!) {
        label.isHidden = true
    }
    
//-------------------------------------------------------------------------------------------------------------
    //MARK: Sign Up
    func signup() {
        if let username = usernameTF.text, let email = emailTF.text, let password = passwordTF.text, let conPassword = conPasswordTF.text {
            
            if username != "" && email != "" && password != "" && conPassword != "" {
                
                hideError(signupStatusLabel)
                
                if !email.isValidEmailAddress() {
                    showError(emailErrorLabel, text: "Invalid Email!")
                    
                } else if !password.isValidPassword() {
                    hideError(emailErrorLabel)
                    
                    showError(passwordErrorLabel, text: "Not a valid password!")
                    
                } else {
                    hideError(passwordErrorLabel)
                    hideError(emailErrorLabel)
                    
                    if conPassword != password {
                        showError(conPasswordErrorLabel, text: "Password didn't matched!")
                    } else {
                        hideError(conPasswordErrorLabel)
                        createNewAccount(username, email, password)
                    }
                }
                
            } else {
                showError(signupStatusLabel, text: "Enter Details!")
                
            }
            
        }
    }
    
    
    /*
     Function which creates an account in firebase, with username, email and password.
     */
    private func createNewAccount(_ username: String,_ email: String, _ password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, err in
            
            if err != nil {
                self.showError(self.signupStatusLabel, text: "FAILED TO CREATE USER!")
                return
            }
            
            self.showError(self.signupStatusLabel, text: "SUCCESSFULLY CREATED USER!", color: UIColor.systemGreen)
            self.saveProfileToDatabase(username) { success in
                if success {
                    self.dismiss(animated: true, completion: nil)
                }
            }

            CustomToast.show(message: "SUCCEESS!!", bgColor: .darkGray, textColor: .systemGreen, labelFont: .boldSystemFont(ofSize: 15), showIn: .top, controller: self)
            self.moveToMainScreen()
            
        }
    }
    
    
    /*
     Function which save the username of the particular user.
     */
    func saveProfileToDatabase(_ username: String, completion: @escaping ((_ success: Bool) -> ())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
        
        let userObject = [
            "username": username
        ] as [String:Any]
        
        databaseRef.setValue(userObject) { error, ref in
            completion(error == nil)
        }
    }
    
    private func moveToMainScreen() {
        let controller = UIStoryboard(name: "Student", bundle: nil)
        let studentvc = controller.instantiateViewController(withIdentifier: "StudentVC") as? StudentVC
        self.navigationController?.pushViewController(studentvc!, animated: true)
        
    }
    
//-------------------------------------------------------------------------------------------------------------
    //MARK: Button Action
    @IBAction func signupTapped(_ sender: UIButton) {
        signup()
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
//-------------------------------------------------------------------------------------------------------------
}
