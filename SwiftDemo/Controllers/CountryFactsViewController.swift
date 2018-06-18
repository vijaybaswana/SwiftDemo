//
//  CountryFactsViewController.swift
//  SwiftDemo
//
//  Created by Vijay Kumar Baswana on 17/06/18.
//  Copyright © 2018 Vijay Kumar Baswana. All rights reserved.
//

import UIKit
import SDWebImage

class CountryFactsViewController: BaseViewController {

    fileprivate let tableView = UITableView()
    fileprivate let countryViewModel = CountryDataViewModel()
    fileprivate var countryAttributes: [CountryAttributesViewModel]?
    
    fileprivate struct Constants {
        static let cellIdentifier = "CountryInfoCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseDelegate = self
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareData()
    }
    
    fileprivate func prepareData() {
        showBusy()
        countryViewModel.fetchCountryInfo { (isSuccess, err) in
            // do UI update here
            self.title = self.countryViewModel.getTitle()
            self.countryAttributes = self.countryViewModel.getAttributesViewModels()
            self.tableView.reloadData()
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
        
        // register table view for custom cells
        tableView.register(CountryAttributesTableViewCell.self as AnyClass, forCellReuseIdentifier: Constants.cellIdentifier)
        
        // adding refresh control
        addRefreshControl(associatedView: tableView)
    }
}

//MARK:- BaseVC delegates
extension CountryFactsViewController: BaseViewControllerProtocol {
    func didPullDownRefresh() {
        // do any API call/tasks here after pull down refresh
        prepareData()
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
        
        var cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as? CountryAttributesTableViewCell
        
        if cell == nil {
            cell = CountryAttributesTableViewCell(style: .default, reuseIdentifier: Constants.cellIdentifier)
        }
        cell?.updateCell(attrViewModel: countryAttributes![indexPath.row], indexPath: indexPath)
        
        // in case cell is nil. Avoiding forced un-wrap.
        return cell ?? UITableViewCell()
    }
}
