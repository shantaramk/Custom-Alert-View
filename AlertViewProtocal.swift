//
//  AlertViewProtocal.swift
//  CustomAlertView
//
//  Created by Shantaram Kokate on 9/11/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import Foundation
import UIKit
@objc protocol AlertViewDelegate: class {
    @objc optional func alertView(alertView: AlertView, clickedButtonAtIndex buttonIndex: Int)
}
