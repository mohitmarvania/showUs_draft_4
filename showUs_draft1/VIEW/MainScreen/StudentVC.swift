//
//  StudentVC.swift
//  showUs_draft1
//
//  Created by Mohit on 24/07/22.
//

import UIKit
import Firebase

class StudentVC: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        title = "SHOW US"
        
        storeDefaults()
        welcomeName()
    }
    
    private func storeDefaults() {
        UserDefaults.standard.set(true, forKey: "USERLOGGEDIN")
    }

    private func welcomeName() {
        let ref = Database.database().reference()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ref.child("users").child("profile").child(uid).observe(.value) { snapshot in
            if let dictionary = snapshot.value as? [String: Any] {
                let username = dictionary["username"] as! String
                
                self.welcomeLabel.text = "Welcome \(username.uppercased()) to Show US"
            }
        } withCancel: { error in
            // Error occured for no user.
        }
    }
}
