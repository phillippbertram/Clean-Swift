//
// Created by Phillipp Bertram on 03.05.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import ObjectMapper
import RxSwift
import RxAlamofire
import RxSwiftExt

public class BaseApi<DTO:Mappable> {

    private let endPoint: String
    private let scheduler: ConcurrentDispatchQueueScheduler

    init(_ endPoint: String) {
        self.endPoint = endPoint
        self.scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
    }

    func getItems(_ path: String) -> Single<[DTO]> {
        let absolutePath = "\(endPoint)/\(path)"
        return RxAlamofire
                .json(.get, absolutePath)
                .apply(requestPolicy)
                .map({ json -> [DTO] in
                    return Mapper<DTO>().mapArray(JSONObject: json) ?? []
                })
                .asSingle()
    }

    func getItem(_ path: String, itemId: String) -> Single<DTO> {
        let absolutePath = "\(endPoint)/\(path)/\(itemId)"
        return RxAlamofire
                .request(.get, absolutePath)
                .apply(requestPolicy)
                .map({ json -> DTO in
                    return Mapper<DTO>().map(JSONObject: json).unwrap()
                })
                .asSingle()
    }

    func postItem(_ path: String, parameters: [String: Any]) -> Single<DTO> {
        let absolutePath = "\(endPoint)/\(path)"
        return RxAlamofire
                .request(.post, absolutePath, parameters: parameters)
                .apply(requestPolicy)
                .map({ json -> DTO in
                    return Mapper<DTO>().map(JSONObject: json).unwrap()
                })
                .asSingle()
    }

    func updateItem(_ path: String, itemId: String, parameters: [String: Any]) -> Single<DTO> {
        let absolutePath = "\(endPoint)/\(path)/\(itemId)"
        return RxAlamofire
                .request(.put, absolutePath, parameters: parameters)
                .apply(requestPolicy)
                .map({ json -> DTO in
                    return Mapper<DTO>().map(JSONObject: json).unwrap()
                })
                .asSingle()
    }

    func deleteItem(_ path: String, itemId: String) -> Single<DTO> {
        let absolutePath = "\(endPoint)/\(path)/\(itemId)"
        return RxAlamofire
                .request(.delete, absolutePath)
                .apply(requestPolicy)
                .map({ json -> DTO in
                    return Mapper<DTO>().map(JSONObject: json).unwrap()
                })
                .asSingle()
    }

    fileprivate func requestPolicy<E>(_ request: Observable<E>) -> Observable<E> {
        return request
                .retry(.delayed(maxCount: 3, time: 0.1))
                .debug()
                .observeOn(scheduler)
    }
}
