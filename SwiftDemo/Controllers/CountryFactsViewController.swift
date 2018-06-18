//
//  CountryFactsViewController.swift
//  SwiftDemo
//
//  Created by Vijay Kumar Baswana on 17/06/18.
//  Copyright © 2018 Vijay Kumar Baswana. All rights reserved.
//

import UIKit

class CountryFactsViewController: BaseViewController {

    fileprivate let tableView = UITableView()
    fileprivate let countryViewModel = CountryDataViewModel()
    
    fileprivate struct Constants {
        static let cellIdentifier = "CountryInfoCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showBusy()
        countryViewModel.fetchCountryInfo { (isSuccess, err) in
            // do something
            self.hideBusy()
        }
    }
    
    private func setupViews() {
        // table view initialisation
        tableView.delegate = self
        tableView.dataSource = self
        // using automatic dimensions to adjust cell height as per the content
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 40
        view.add(subView: tableView, insets: .zero)
        
        // adding refresh control
        addRefreshControl(associatedView: tableView)
    }
}

//MARK:- BaseVC delegates
extension CountryFactsViewController: BaseViewControllerProtocol {
    func didPullDownRefresh() {
        // do any API call/tasks here after pull down refresh
    }
}

//MARK:- UITableView datasource
extension CountryFactsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return countryViewModel.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryViewModel.getNumberOfRows()
    }
}

//MARK:- UITableView delegate
extension CountryFactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: Constants.cellIdentifier)
        }
                
        // in case cell is nil. Avoiding forced un-wrap.
        return cell ?? UITableViewCell()
    }
}
