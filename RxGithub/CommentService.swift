//
//  CommentService.swift
//  RxGithub
//
//  Created by Oron Ben Zvi on 2/21/17.
//  Copyright © 2017 Oron Ben Zvi. All rights reserved.
//

import RxSwift
import Firebase

protocol CommentServicing {
    func comments(for username: String) -> Observable<[String]>
    func comment(_ comment: String, for username: String)
}

class CommentService: CommentServicing {
    private let ref = Database.database().reference()
    
    func comments(for username: String) -> Observable<[String]> {
        return Observable.create { observer in
            let commentsRef = self.ref.child("users/\(username)/comments")
            let refHandle = commentsRef.observe(.value, with: { snapshot in
                guard let commentsDict = snapshot.value as? [String: Any] else { return }
                let comments = Array(commentsDict.keys)
                observer.onNext(comments)
            })
            
            return Disposables.create {
                commentsRef.removeObserver(withHandle: refHandle)
            }
        }
    }
    
    func comment(_ comment: String, for username: String) {
        let comment = self.ref.child("users/\(username)/comments/\(comment)")
        comment.setValue(true)
    }
    
}
