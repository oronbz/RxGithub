//
//  SearchViewController.swift
//  RxGithub
//
//  Created by Oron Ben Zvi on 2/20/17.
//  Copyright © 2017 Oron Ben Zvi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var resultsLabel: UILabel!
    
    var viewModel: SearchViewModeling!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
    }
    
    private func setupBindings() {
        searchBar.rx.text.orEmpty
            .bindTo(viewModel.searchText)
            .disposed(by: disposeBag)
        
        viewModel.cellModels
            .bindTo(tableView.rx.items(cellIdentifier: "UserCell", cellType: UserCell.self)) {
                i, cellModel, cell in
                cell.viewModel = cellModel
            }.disposed(by: disposeBag)
        
        viewModel.resultCountLabel
            .bindTo(resultsLabel.rx.text)
            .disposed(by: disposeBag)
 
    }

}


// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
