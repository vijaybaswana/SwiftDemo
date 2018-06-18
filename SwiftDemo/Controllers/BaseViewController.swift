//
//  BaseViewController.swift
//  SwiftDemo
//
//  Created by Vijay Kumar Baswana on 17/06/18.
//  Copyright © 2018 Vijay Kumar Baswana. All rights reserved.
//

import UIKit
import SwiftOverlays
import SnapKit

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
    
    func showFailureOverlay(message: String) {
        let container = UIView()
        container.backgroundColor = .darkGray
        let messageLabel = UILabel()
        container.addSubview(messageLabel)
        
        messageLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(container).offset(10)
            make.trailing.equalTo(container).offset(-10)
            make.top.equalTo(container).offset(10)
            make.bottom.equalTo(container).offset(-10)
        }
        messageLabel.numberOfLines = 3
        messageLabel.text = message
        messageLabel.textColor = .white
        
        UIViewController.showOnTopOfStatusBar(container, duration: 5)
    }
}
