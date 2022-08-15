//
//  SignUpVC.swift
//  showUs_draft1
//
//  Created by Mohit on 22/07/22.
//

import UIKit

class SignupVC: UIViewController {
    
    @IBOutlet weak var studentView: UIView!
    @IBOutlet weak var companyView: UIView!
    
    
    let studentVC = StudentSignupVC()
    let companyVC = CompanySignupVC()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            studentView.alpha = 1
            companyView.alpha = 0
        } else {
            studentView.alpha = 0
            companyView.alpha = 1
        }
    }
    
}
