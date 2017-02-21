//
//  CommentServiceSpec.swift
//  RxGithub
//
//  Created by Oron Ben Zvi on 2/21/17.
//  Copyright © 2017 Oron Ben Zvi. All rights reserved.
//

import Quick
import Nimble
import RxSwift
@testable import RxGithub

class CommentServiceSpec: QuickSpec {
    override func spec() {
        var service: CommentService!
        var disposeBag: DisposeBag!
        
        beforeEach {
            service = CommentService()
            disposeBag = DisposeBag()
        }
        describe("comment") { 
            pending("add comment to firebase") {
                service.comment("Best iOS developer", for: "RHKliffer")
            }
            
            it("return comments from firebase") {
                var comments: [String]? = nil
                service.comments(for: "oronbz")
                    .subscribe(onNext: {
                        comments = $0
                    }).disposed(by: disposeBag)
                
                expect(comments?.count).toEventually(beGreaterThan(0), timeout: 5)
                
            }
        }
    }
}
