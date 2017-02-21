//
//  UserCellModel.swift
//  RxGithub
//
//  Created by Oron Ben Zvi on 2/21/17.
//  Copyright © 2017 Oron Ben Zvi. All rights reserved.
//

import RxSwift
import RxCocoa

protocol UserCellModeling {
    var image: Observable<UIImage> { get }
    var user: String { get }
}

class UserCellModel: UserCellModeling {
    
    let image: Observable<UIImage>
    let user: String
    
    init(network: Networking, imageUrl: String, user: String) {
        let placeholder = #imageLiteral(resourceName: "user2")
        self.image = Observable.just(placeholder)
            .concat(network.image(url: imageUrl))
            .observeOn(MainScheduler.instance)
            .catchErrorJustReturn(placeholder)
        self.user = user
    }
}
