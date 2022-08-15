//
//  String + Extensions.swift
//  showUs_draft1
//
//  Created by Mohit on 23/07/22.
//

import Foundation
import UIKit

extension String {
    
    func isValidEmailAddress() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return applyPredicateOnRegex(regexStr: emailRegex)
    }
    
    func isValidPassword(mini: Int = 8, max: Int = 8) -> Bool {
        //Minimum 8 characters at least 1 alphabet and 1 special character:
        var passRegex = ""
        if mini >= max {
            passRegex = "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{\(mini),}$"
        } else {
            passRegex = "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{\(mini), \(max)}$"
        }
        return applyPredicateOnRegex(regexStr: passRegex)
    }
    
    func applyPredicateOnRegex(regexStr: String) -> Bool {
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        let validateOtherString = NSPredicate(format: "SELF MATCHES %@", regexStr)
        let isValidateOtherString = validateOtherString.evaluate(with: trimmedString)
        return isValidateOtherString
    }
    
//    func isValidEmailAddress(_ emailAddress: String) -> Bool {
//        var returnValue = false
//        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
//
//        do {
//            let regex = try NSRegularExpression(pattern: emailRegEx)
//            let nsString = emailAddress as NSString
//            let result = regex.matches(in: emailAddress, range: NSRange(location: 0, length: nsString.length))
//
//            if result.count == 0 {
//                returnValue = false
//            }
//        } catch let error as NSError {
//            print("Invalid regex.")
//            print(error.localizedDescription)
//            returnValue = false
//        }
//
//        return returnValue
//    }
    
}
