//
//  UINavigationController+Orientation.swift
//  pagemenu
//
//  Created by mara shen on 13/7/15.
//  Copyright (c) 2015 mara shen. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    public override func supportedInterfaceOrientations() -> Int {
        return visibleViewController.supportedInterfaceOrientations()
    }
}