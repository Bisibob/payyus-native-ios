//
//  AppResponeData.swift
//  MVVMTemplate
//
//  Created by Thuỳ Nguyễn on 2/26/18.
//  Copyright © 2018 NUS Technology. All rights reserved.
//

import Foundation
import EVReflection

class ResponeResult: ModelType {

    var status: Int = 0
    var message: String = ""
    var error: String = ""
    var data: String = ""

}

class DataValue: ModelType {

    var data: String = ""
    var value: String = ""

}

class AppResponeData {
    static func convertResponeData<T>(data: Data, completionHandler: @escaping ((Result<T>) -> Void)) where T : ModelType{
        let value = T(data: data, conversionOptions: T.conversionDeserializeOptions(), forKeyPath: T.singularKeyPath())
        completionHandler(.success(value))
    }



    static func convertArrayResponeData<T>(data: Data, completionHandler: @escaping ((Results<T>) -> Void)) where T : ModelType{
        let value = [T](data: data, conversionOptions: T.conversionDeserializeOptions(), forKeyPath: T.pluralKeyPath())
        completionHandler(.success(value))
    }


    
    static func checkErrorResponeData(data: Data, successHandler:@escaping ((String, Data) -> Void), errorHandler:@escaping ((String) -> Void)){
        let result = ResponeResult(data: data)
        //TODO: Check error here
        if !result.error.isEmpty {
            errorHandler(result.error)
        }else {
            if result.status == -1 {
                errorHandler(result.message)
            } else {
                successHandler(result.message, data)
            }
        }
    }
    
}
