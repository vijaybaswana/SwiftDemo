//
//  BaseViewController.swift
//  SwiftDemo
//
//  Created by Vijay Kumar Baswana on 17/06/18.
//  Copyright © 2018 Vijay Kumar Baswana. All rights reserved.
//

import UIKit
import SwiftOverlays

@objc protocol BaseViewControllerProtocol {
    @objc func didPullDownRefresh()
}

class BaseViewController: UIViewController {
    
    private let refreshControl = UIRefreshControl()
    var baseDelegate: BaseViewControllerProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @objc fileprivate func refresh() {
        refreshControl.endRefreshing()
        baseDelegate?.didPullDownRefresh()
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
    
    func addRefreshControl(associatedView: UIView) {
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        associatedView.addSubview(refreshControl)
    }
}
