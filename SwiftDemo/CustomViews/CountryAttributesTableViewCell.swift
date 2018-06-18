//
//  CountryAttributesTableViewCell.swift
//  SwiftDemo
//
//  Created by Vijay Kumar Baswana on 18/06/18.
//  Copyright © 2018 Vijay Kumar Baswana. All rights reserved.
//

import UIKit
import SDWebImage

class CountryAttributesTableViewCell: UITableViewCell {
    
    private enum ConstraintPriority: Int {
        case low = 0,
        medium,
        high
        
        func getValue() -> Int {
            switch self {
            case .low:
                return 250
            case .medium:
                return 500
            case .high:
                return 1000
            }
        }
    }
    
    let attrImageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    func updateCell(attrViewModel: CountryAttributesViewModel, indexPath: IndexPath) {
        setupUI()
        loadImage(imagePath: attrViewModel.getImageUrl(), indexPath: indexPath)
        loadTitle(title: attrViewModel.getTitle())
        loadDescription(description: attrViewModel.getDescription())
    }

    private func setupUI() {
        // UI configuration
        setupImageView()
        setupLabels()
    }
    
    private func setupImageView() {
        contentView.addSubview(attrImageView)
        // adding constraints
        attrImageView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(5)
            make.centerY.equalTo(contentView.snp.centerY)
            make.top.greaterThanOrEqualTo(contentView.snp.top).offset(5).priority(ConstraintPriority.medium.getValue())
            make.bottom.greaterThanOrEqualTo(contentView.snp.bottom).offset(-5).priority(ConstraintPriority.medium.getValue())
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
    }
    
    private func setupLabels() {
        let container = UIView()
        contentView.addSubview(container)
        // adding constraints
        container.snp.makeConstraints { (make) in
            make.left.equalTo(attrImageView.snp.right).offset(5)
            make.trailing.equalTo(contentView).offset(-5)
            make.top.equalTo(contentView).offset(5)
            make.bottom.equalTo(contentView).offset(-5)
        }
        
        setupTitleLabel(container: container)
        setupDescriptionLabel(container: container)
    }
    
    private func setupTitleLabel(container: UIView) {
        titleLabel.numberOfLines = 0
        container.addSubview(titleLabel)
        // adding constraints
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(container)
            make.leading.equalTo(container)
            make.trailing.equalTo(container)
            make.bottom.equalTo(container).priority(ConstraintPriority.low.getValue())
        }
    }
    
    private func setupDescriptionLabel(container: UIView) {
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.textColor = .lightGray
        container.addSubview(descriptionLabel)
        // adding constraints
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalTo(container)
            make.trailing.equalTo(container)
            make.bottom.equalTo(container)
        }
    }
    
    private func loadImage(imagePath: String?, indexPath: IndexPath) {
        guard let path = imagePath, let imageUrl = URL(string: path) else {
            attrImageView.image = nil
            return
        }
        attrImageView.sd_setHighlightedImage(with: imageUrl, options: [.refreshCached]) { (image, err, cacheType, url) in
            // update image
            self.attrImageView.image = image
            // once image is downloaded, refresh the cell
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    private func loadTitle(title: String) {
        titleLabel.text = title
    }
    
    private func loadDescription(description: String) {
        descriptionLabel.text = description
    }
}
