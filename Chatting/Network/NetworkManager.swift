//
//  NetworkManager.swift
//  Chatting
//
//  Created by Soso on 01/03/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import Foundation
import RxSwift
import Moya

struct NetworkManager {
    static let baseURL: String = "https://api.myservice.com"
    private static let disposeBag = DisposeBag()
    
    static func request<T: Codable>(
        _ token: MultiTarget,
        onSuccess: @escaping (T) -> Void,
        onError: @escaping (Error) -> Void) {
//        let provider = MoyaProvider<MultiTarget>()
        // fake request
        let provider = MoyaProvider<MultiTarget>(stubClosure: MoyaProvider.delayedStub(3))
        provider.rx
            .request(token)
            .map(APIResponse<T>.self)
            .subscribe(onSuccess: { response in
                let error = ErrorType(statusCode: response.statusCode)
                if error == .none, let data = response.data {
                    onSuccess(data)
                } else {
                    onError(error)
                }
            }, onError: { error in
                onError(error)
            })
            .disposed(by: disposeBag)
    }
    
}
