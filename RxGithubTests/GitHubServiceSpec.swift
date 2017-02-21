//
//  GitHubServiceSpec.swift
//  RxGithub
//
//  Created by Oron Ben Zvi on 2/21/17.
//  Copyright © 2017 Oron Ben Zvi. All rights reserved.
//

import Quick
import Nimble
import RxSwift
@testable import RxGithub

class GitHubServiceSpec: QuickSpec {
    override func spec() {
        var network: Network!
        var disposeBag: DisposeBag!
        var service: GitHubService!
        
        beforeEach {
            network = Network()
            disposeBag = DisposeBag()
            service = GitHubService(network: network)
        }
        
        describe("user search") { 
            it("eventually return user search") {
                var userSearch: GitHubUserSearch? = nil
                
                service.userSearch(query: "oronbz")
                    .subscribe(onNext: {
                        userSearch = $0
                    }).disposed(by: disposeBag)
                
                expect(userSearch?.count).toEventually(beGreaterThanOrEqualTo(1), timeout: 5)
                expect(userSearch?.users.count).toEventually(beGreaterThanOrEqualTo(1), timeout: 5)
            }
        }
    }
}
