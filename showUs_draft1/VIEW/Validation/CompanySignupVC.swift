//
//  CompanySignupVC.swift
//  showUs_draft1
//
//  Created by Mohit on 22/07/22.
//

import UIKit

class CompanySignupVC: UIViewController {
    
    @IBOutlet weak var companyNameTF: UITextField!
    @IBOutlet weak var companyEmailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var conPasswordTF: UITextField!
    
    @IBOutlet weak var comapnyNameErrorLabel: UILabel!
    @IBOutlet weak var companyEmailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var conPasswordErrorLabel: UILabel!
    @IBOutlet weak var signupStatusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        print("Company sign up View Controller.")
        setup()
    }
    
    func setup() {
        comapnyNameErrorLabel.isHidden = true
        companyEmailErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        conPasswordErrorLabel.isHidden = true
        signupStatusLabel.isHidden = true
    }
    
    @IBAction func signupTapped(_ sender: UIButton) {
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
