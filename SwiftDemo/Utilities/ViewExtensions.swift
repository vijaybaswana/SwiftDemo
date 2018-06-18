//
//  ViewExtensions.swift
//  SwiftDemo
//
//  Created by Vijay Kumar Baswana on 18/06/18.
//  Copyright © 2018 Vijay Kumar Baswana. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

extension UIView {
    
    func add(subView: UIView, insets: UIEdgeInsets) {
        self.addSubview(subView)
        subView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(insets.top)
            make.left.equalTo(self.snp.left).offset(insets.left)
            make.bottom.equalTo(self.snp.bottom).offset(-insets.bottom)
            make.right.equalTo(self.snp.right).offset(-insets.right)
        }
    }
}
