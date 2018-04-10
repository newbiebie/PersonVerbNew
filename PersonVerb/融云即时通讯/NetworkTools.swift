//
//  AFNetWork.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/4/2.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit
import AFNetwork

import AFNetworking

enum HTResqustMethod : String {
    
    case Post = "post"
    case Get = "get"
}

class NetworkTools: AFHTTPSessionManager {
    
    static let shardTools : NetworkTools = {
        
        let tools = NetworkTools()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tools
    }()
    
    
    
    
    func request(method: HTResqustMethod , urlString: String, parameters: AnyObject?,resultBlock : @escaping([String : Any]?, Error?) -> ()){
        
        // 定义一个请求成功之后要执行的闭包
        // 成功闭包
        let successBlock = { (task: URLSessionDataTask, responseObj: Any?) in
            resultBlock(responseObj as? [String : Any], nil)
        }
        
        // 失败的闭包
        let failureBlock = { (task: URLSessionDataTask?, error: Error) in
            resultBlock(nil, error)
        }
        
        // Get 请求
        if method == .Get {
            get(urlString, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        }
        
        // Post 请求
        if method == .Post {
            post(urlString, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        }
        
        
    }
}
