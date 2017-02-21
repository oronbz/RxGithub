//
//  CommentsViewModel.swift
//  RxGithub
//
//  Created by Oron Ben Zvi on 2/21/17.
//  Copyright © 2017 Oron Ben Zvi. All rights reserved.
//

import RxSwift

protocol CommentsViewModeling {
    
    // MARK: - Input
    var submitDidTap: PublishSubject<Void> { get }
    var commentText: PublishSubject<String> { get }
    
    // MARK: - Output
    var submitEnabled: Observable<Bool> { get }
    var comments: Observable<[String]> { get }
}

class CommentsViewModel: CommentsViewModeling {
    
    // MARK: - Input
    var submitDidTap: PublishSubject<Void> = PublishSubject<Void>()
    var commentText: PublishSubject<String> = PublishSubject<String>()
    
    // MARK: - Output
    let submitEnabled: Observable<Bool>
    let comments: Observable<[String]>
    
    private let disposeBag = DisposeBag()
    
    init(commentsService: CommentServicing, username: String) {
        submitEnabled = commentText.map { text in text.characters.count > 0 }
        
        comments = commentsService.comments(for: username)
            .observeOn(MainScheduler.instance)
        
        submitDidTap
            .withLatestFrom(commentText)
            .subscribe(onNext: { comment in
                commentsService.comment(comment, for: username)
            }).disposed(by: disposeBag)
    }
}
