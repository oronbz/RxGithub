//
//  Network.swift
//  RxGithub
//
//  Created by Oron Ben Zvi on 2/21/17.
//  Copyright © 2017 Oron Ben Zvi. All rights reserved.
//

import RxSwift
import RxCocoa
import Alamofire
import Himotoki

enum NetworkMethod {
    case get, post, put, delete
}

protocol Networking {
    func request<D: Himotoki.Decodable>(method: NetworkMethod, url: String, parameters: [String : Any]?, type: D.Type) -> Observable<D>
    func request(method: NetworkMethod, url: String, parameters: [String : Any]?) -> Observable<Any>
    func image(url: String) -> Observable<UIImage>
}

final class Network: Networking {
    private let queue = DispatchQueue(label: "RxGithub.Network.Queue")
    
    func request<D: Himotoki.Decodable>(method: NetworkMethod, url: String, parameters: [String : Any]?, type: D.Type) -> Observable<D> {
        return request(method: method, url: url, parameters: parameters)
            .map {
                do {
                    return try D.decodeValue($0)
                } catch {
                    throw NetworkError.IncorrectDataReturned
                }
        }
    }
    
    func request(method: NetworkMethod, url: String, parameters: [String : Any]?) -> Observable<Any> {
        return Observable.create { observer in
            let method = method.httpMethod()
            
            let request = Alamofire.request(url, method: method, parameters: parameters)
                .validate()
                .responseJSON(queue: self.queue) { response in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(NetworkError(error: error))
                    }
                }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func image(url: String) -> Observable<UIImage> {
        return Observable.create { observer in
            let request = Alamofire.request(url, method: .get)
                .validate()
                .response(queue: self.queue, responseSerializer: Alamofire.DataRequest.dataResponseSerializer()) { response in
                    switch response.result {
                    case .success(let data):
                        guard let image = UIImage(data: data) else {
                            observer.onError(NetworkError.IncorrectDataReturned)
                            return
                        }
                        observer.onNext(image)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}

fileprivate extension NetworkMethod {
    func httpMethod() -> HTTPMethod {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        case .put:
            return .put
        case .delete:
            return .delete
        }
    }
}
