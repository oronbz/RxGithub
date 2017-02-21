//
//  NetworkSpec.swift
//  RxGithub
//
//  Created by Oron Ben Zvi on 2/21/17.
//  Copyright © 2017 Oron Ben Zvi. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RxCocoa
import Himotoki
@testable import RxGithub

class NetworkSpec: QuickSpec {
    override func spec() {
        var network: Network!
        var disposeBag: DisposeBag!
        
        beforeEach {
            network = Network()
            disposeBag = DisposeBag()
        }
        
        describe("fetch") {
            it("eventually gets JSON data as specified with parameters") {
                var json: [String: Any]? = nil
                let url = "https://httpbin.org/get"
                network.request(method: .get, url: url, parameters: ["a": "b", "x": "y"])
                    .subscribe(onNext: { json = $0 as? [String: Any] })
                    .disposed(by: disposeBag)
                
                expect(json).toEventuallyNot(beNil(), timeout: 5)
                expect((json?["args"] as? [String: Any])?["a"] as? String).toEventually(equal("b"), timeout: 5)
                expect((json?["args"] as? [String: Any])?["x"] as? String).toEventually(equal("y"), timeout: 5)
            }
            
            it("eventually gets an error if the network has a problem") {
                var error: NetworkError? = nil
                let url = "https://non-existing-server.non/"
                network.request(method: .get, url: url, parameters: ["a": "b", "x": "y"])
                    .subscribe(onError: { error = $0 as? NetworkError })
                    .disposed(by: disposeBag)
                
                expect(error).toEventually(equal(NetworkError.NotReachedServer), timeout: 5)
            }
            
            it("eventually emits <null> on 204 response") {
                var null: NSNull? = nil
                
                let url = "https://httpbin.org/status/204"
                network.request(method: .get, url: url, parameters: nil)
                    .subscribe(onNext: {
                        null = $0 as? NSNull
                    })
                    .disposed(by: disposeBag)
                
                expect(null).toEventuallyNot(beNil(), timeout: 5)
            }
        }
        
        describe("generic fetch") {
            it("eventually decode JSON and emits the model") {
                var model: HttpBinResponse? = nil
                let url = "https://httpbin.org/get"
                network.request(method: .get, url: url, parameters: ["id": "12345", "age": "15"], type: HttpBinResponse.self)
                    .subscribe(onNext: { model = $0 })
                    .disposed(by: disposeBag)
                
                expect(model).toEventuallyNot(beNil(), timeout: 5)
                let args = model?.args
                expect(args?.id).toEventually(equal("12345"), timeout: 5)
                expect(args?.age).toEventually(equal("15"), timeout: 5)
            }
            
            it("eventually gets an error while parsing JSON") {
                var error: NetworkError? = nil
                let url = "https://httpbin.org/get"
                network.request(method: .get, url: url, parameters: ["no_id": "12345", "age": "15"], type: HttpBinResponse.self)
                    .subscribe(onError: { error = $0 as? NetworkError })
                    .disposed(by: disposeBag)
                
                expect(error).toEventually(equal(NetworkError.IncorrectDataReturned), timeout: 5)
            }
        }
        
        describe("image") { 
            it("eventually return an image") {
                var image: UIImage? = nil
                let url = "https://placeholdit.imgix.net/~text?txtsize=33&txt=350%C3%97150&w=350&h=150"
                network.image(url: url)
                    .subscribe(onNext: { image = $0 })
                    .disposed(by: disposeBag)
                
                expect(image).toEventuallyNot(beNil(), timeout: 5)
            }
            
            it("eventually gets an error on non image URL") {
                    var error: NetworkError? = nil
                    let url = "https://httpbin.org/get"
                    network.image(url: url)
                        .subscribe(onError: { error = $0 as? NetworkError })
                        .disposed(by: disposeBag)
                    
                    expect(error).toEventually(equal(NetworkError.IncorrectDataReturned), timeout: 5)
            }
        }
        
        
    }
}

struct HttpBinResponse {
    let args: HttpBinArgs
}

extension HttpBinResponse: Decodable {
    static func decode(_ e: Extractor) throws -> HttpBinResponse {
        return try HttpBinResponse(
            args: e <| "args"
        )
    }
}

struct HttpBinArgs {
    let id: String
    let age: String
}

extension HttpBinArgs: Decodable {
    static func decode(_ e: Extractor) throws -> HttpBinArgs {
        return try HttpBinArgs(
            id: e <| "id",
            age: e <| "age"
        )
    }
}
