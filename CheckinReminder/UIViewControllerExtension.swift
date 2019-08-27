//
//  UIViewControllerExtension.swift
//  CheckinReminder
//
//  Created by Yue Tong on 8/26/19.
//  Copyright © 2019 Biang Studio. All rights reserved.
//

import UIKit

extension UIViewController{
    /// pop back n viewcontroller
    func popBack(_ nb: Int) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            guard viewControllers.count < nb else {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
                return
            }
        }
    }
}

