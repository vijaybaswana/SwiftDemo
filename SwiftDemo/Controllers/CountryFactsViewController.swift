//
//  CountryFactsViewController.swift
//  SwiftDemo
//
//  Created by Vijay Kumar Baswana on 17/06/18.
//  Copyright © 2018 Vijay Kumar Baswana. All rights reserved.
//

import UIKit

class CountryFactsViewController: BaseViewController {

    let tableView = UITableView()
    
    fileprivate struct Constants {
        static let cellIdentifier = "CountryInfoCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 40
        
        view.add(subView: tableView, insets: .zero)
    }
}

//MARK:- UITableView datasource
extension CountryFactsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

//MARK:- UITableView delegate
extension CountryFactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: Constants.cellIdentifier)
        }
                
        // in case cell is nil. Avoiding forced un-wrap.
        return cell ?? UITableViewCell()
    }
}
