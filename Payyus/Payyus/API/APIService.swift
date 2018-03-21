//
//  APIService.swift
//  MVVMTemplate
//
//  Created by Thuỳ Nguyễn on 2/7/18.
//  Copyright © 2018 NUS Technology. All rights reserved.
//

import Foundation
import Alamofire



class APIService {
    //MARK: Request functions

    static func getAPIURLString(apiName: String)-> String {
        if AppConfiguration.shared.baseURL().hasSuffix("/") {
            return  AppConfiguration.shared.baseURL() + apiName
        }
        return  AppConfiguration.shared.baseURL() + "/" + apiName
    }

    static func request<T>(url: String, method: HTTPMethod, parameters: Parameters?, responeType: T.Type, completionHandler:@escaping ((Result<T>) -> Void)) -> DataRequest? where T : ModelType {
        return self.requestCheckErrorData(url: url, method: method, parameters: parameters, completionHandler: { (message, data) in
            AppResponeData.convertResponeData(data: data, completionHandler: completionHandler)
        }) { (error) in
            completionHandler(.error(error))
        }
    }



    static func requestArray<T>(url: String, method: HTTPMethod, parameters: Parameters?, responeType: T.Type, completionHandler:@escaping ((Results<T>) -> Void)) -> DataRequest? where T : ModelType  {
        return self.requestCheckErrorData(url: url, method: method, parameters: parameters, completionHandler: { (message, data) in
            AppResponeData.convertArrayResponeData(data: data, completionHandler: completionHandler)
        }) { (error) in
            completionHandler(.error(error))
        }
    }

    static func requestCheckErrorData(url: String, method: HTTPMethod, parameters: Parameters?, completionHandler:@escaping ((String, Data) -> Void), errorHandler: @escaping((String) -> Void )) -> DataRequest? {
        return self.request(url: url, method: method, parameters: parameters, completionHandler: { (data) in
            AppResponeData.checkErrorResponeData(data: data, successHandler: { (message, successData) in
                completionHandler(message, successData)
            }) { (error) in
                errorHandler(error)
            }
        }) { (error) in
            errorHandler(error)
        }
    }

    static func request(url: String, method: HTTPMethod, parameters: Parameters?, completionHandler:@escaping ((Data) -> Void), errorHandler: @escaping((String) -> Void )) -> DataRequest?  {
        guard let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            errorHandler("Unrecognized the link")
            return nil
        }

        let dataRequest = Alamofire.request(urlString, method: method, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if let error = response.error {
                errorHandler(error.localizedDescription)
                return
            }
            if let data = response.data {
                completionHandler(data)
                return
            }else {
                errorHandler("Have no respone data")
                return
            }
        }
        return dataRequest
    }
}

//protocol APIServiceType{
//    func resourceName() -> String
//
//}
//
//protocol Creatable {
//    func createValue() -> [String : Any]
//}
//
//protocol Updateable {
//    func idValue() -> String
//    func updateValue() -> [String : Any]
//}

enum Result<T> {
    case success(T)
    case error(String)
}

enum Results<T> {
    case success([T])
    case error(String)
}
