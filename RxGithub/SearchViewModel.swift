//
//  SearchViewModel.swift
//  RxGithub
//
//  Created by Oron Ben Zvi on 2/21/17.
//  Copyright © 2017 Oron Ben Zvi. All rights reserved.
//

import RxSwift
import RxCocoa

protocol SearchViewModeling {
    
    // MARK: - Input
    var searchText: PublishSubject<String> { get }
    var cellDidSelect: PublishSubject<Int> { get }
    
    // MARK: - Output
    var cellModels: Observable<[UserCellModel]> { get }
    var resultCountLabel: Observable<String> { get }
}

class SearchViewModel: SearchViewModeling {
    
    // MARK: - Input
    let searchText: PublishSubject<String> = PublishSubject<String>()
    let cellDidSelect: PublishSubject<Int> = PublishSubject<Int>()
    
    // MARK: - Output
    let cellModels: Observable<[UserCellModel]>
    let resultCountLabel: Observable<String>
    
    init(network: Networking, gitHubService: GitHubServicing) {
        
        let searchResults = searchText
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { query in
                gitHubService.userSearch(query: query).catchErrorJustReturn(GitHubUserSearch(count: 0, users: []))
            }.observeOn(MainScheduler.instance)
            .startWith(GitHubUserSearch(count: 0, users: []))
            .shareReplay(1)
        
        cellModels = searchResults.map { userSearch in
                userSearch.users.map { user in
                    UserCellModel(network: network, imageUrl: user.avatarUrl, username: user.username)
                }
            }
        
        resultCountLabel = searchResults.map { "\($0.users.count) result(s)" }
    }
    
}
