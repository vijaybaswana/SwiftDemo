//
//  BaseViewController.swift
//  SwiftDemo
//
//  Created by Vijay Kumar Baswana on 17/06/18.
//  Copyright © 2018 Vijay Kumar Baswana. All rights reserved.
//

import UIKit
import SwiftOverlays

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

//MARK:- UI Elements
extension BaseViewController {
    func showBusy() {
        showWaitOverlayWithText("loading.title".localizedText())
    }
    
    func hideBusy() {
        removeAllOverlays()
    }
}
