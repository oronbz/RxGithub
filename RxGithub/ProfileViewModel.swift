//
//  ProfileViewModel.swift
//  RxGithub
//
//  Created by Oron Ben Zvi on 2/21/17.
//  Copyright © 2017 Oron Ben Zvi. All rights reserved.
//

import RxSwift

protocol ProfileViewModeling {
    
    // MARK: - Input
    var showCommentsDidTap: PublishSubject<Void> { get }
    
    // MARK: - Output
    var image: Observable<UIImage> { get }
    var username: String { get }
}

class ProfileViewModel: ProfileViewModeling {
    
    // MARK: - Input
    let showCommentsDidTap: PublishSubject<Void> = PublishSubject<Void>()
    
    // MARK: - Output
    let image: Observable<UIImage>
    let username: String
    
    init(network: Networking, user: GitHubUser) {
        let placeholder = #imageLiteral(resourceName: "user2")
        image = Observable.just(placeholder)
                .concat(network.image(url: user.avatarUrl))
                .observeOn(MainScheduler.instance)
                .catchErrorJustReturn(placeholder)
        
        username = user.username
    }
    
}
