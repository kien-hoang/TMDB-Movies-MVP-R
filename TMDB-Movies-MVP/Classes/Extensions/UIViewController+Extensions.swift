//
//  UIViewController+Extensions.swift
//  TMDB-Movies-MVP
//
//  Created by Bradley Hoang on 28/12/2022.
//

import UIKit

extension UIViewController {
    static var storyboardName: String {
        let viewControllerName = String(describing: Self.self)
        let name = viewControllerName.components(separatedBy: "ViewController").first
        return name ?? viewControllerName
    }
    
    static func initViewController() -> Self {
        let className = String(describing: Self.self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: className) as! Self
        return controller
    }
    
    func hideKeyboardWhenTappedAround(isCancelTouchInView: Bool = false) {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = isCancelTouchInView
    }
}
