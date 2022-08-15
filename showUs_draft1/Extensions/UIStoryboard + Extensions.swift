//
//  UIStoryboard + Extensions.swift
//  showUs_draft1
//
//  Created by Mohit on 24/07/22.
//

import Foundation
import UIKit

/*
 This file is not used in the code right now.
 */

enum AppStoryboard: String {
    // All the storyboard ids goes over here.
    case Validation = "Validation"
    case Student = "Student"
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("viewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile: \(FILE.self)\nLine Number: \nFunction: ")
        }
        return scene
    }
    
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}

extension UIViewController {
    
    class var storyboardID: String {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
}

