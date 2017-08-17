//
//  NetworkManager.swift
//  MyGithub
//
//  Created by Ehab Saifan on 8/15/17.
//  Copyright © 2017 Home. All rights reserved.
//

import Alamofire
import SwiftyJSON

typealias Params = [String : AnyObject]?
typealias JsonResponse = ((_ json : JSON?, _ error : NSError?)->Void)?
typealias successResponse = ((_ success : Bool, _ error : NSError?)->Void)?
typealias ImageResponse = ((_ path : String, _ image : UIImage?, _ error : NSError?)->Void)?

let RootPath = "https://support.magcite.com"
let APIRootPath = RootPath

class NetworkManager: NSObject, URLSessionDataDelegate {
    
    let manager = Alamofire.SessionManager.default
    
    static let currentManager = NetworkManager()
    
    override init() {
        super.init()
    }
}

//MARK: login/signup
extension NetworkManager{
    
    class func getPlaces(params: Params, completion : JsonResponse){
        let path = APIRootPath + "/test.json"
        self.get(path: path, params: params, completion: { (json, error) -> Void in
            self.completion(json: json, error: error, completion: completion)
        })
    }
}

extension NetworkManager{
    
    class func getImage(path: String, params : Params = nil, completion: ImageResponse){
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        NetworkManager.currentManager.manager.request(path, method: .get, parameters: params, encoding: JSONEncoding(options: []), headers: nil).responseData { (responseObj) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if let response = responseObj.response {
                switch response.statusCode {
                case 200:
                    if let completion = completion, let data = responseObj.data {
                        if let image = UIImage(data: data){
                            completion(path, image, nil)
                        }else {
                            let error = NSError.error(message: "Can't Parse Image", code: -1)
                            completion(path, nil, error)
                        }
                    }else{
                        let error = NSError.error(message: "Error parse data")
                        if let completion = completion {
                            completion(path, nil, error)
                        }
                    }
                case let (code):
                        let error = NSError.error(message: "Please try again later", code: code)
                        if let completion = completion {
                            completion(path, nil, error)
                        }
                }// end switch status code
            }else{
                let error = NSError.error(message: "Network is down! Please try again later")
                if let completion = completion {
                    completion(path, nil, error)
                }
            }
        }
    }
    
    class func get(path: String, params : Params = nil, beaconHeader: [String: String]? = nil, completion : JsonResponse){
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        NetworkManager.currentManager.manager.request(path, method: .get, parameters: params, encoding: JSONEncoding(options: []), headers: nil).responseData { (responseObj) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if let response = responseObj.response {
                switch response.statusCode {
                case 200...300:
                    if let data = responseObj.data, let utf8Text = String(data: data, encoding: .utf8){
                        let jsonData = JSON.parse(utf8Text)
                        self.completion(json: jsonData, error: nil, completion: completion)
                    }else{
                        let error = NSError.error(message: "Error parse data")
                        self.completion(json: nil, error: error, completion: completion)
                    }
                case let (code):
                    if let data = responseObj.data, let utf8Text = String(data: data, encoding: .utf8){
                        let jsonData = JSON.parse(utf8Text)
                        let message = jsonData["message"].string ?? ""
                        let error = NSError.error(message: message, code: code)
                        self.completion(json: jsonData, error: error, completion: completion)
                        print("Error: \(error.localizedDescription)")
                    }else{
                        let error = NSError.error(message: "Please try again later", code: code)
                        self.completion(json: nil, error: error, completion: completion)
                    }
                }// end switch status code
            }else{
                let error = NSError.error(message: "Network is down! Please try again later")
                self.completion(json: nil, error: error, completion: completion)
            }
        }// end request
    }
    
    class func post(path: String, params : Params = nil, completion : JsonResponse){
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        NetworkManager.currentManager.manager.request(path, method: .post, parameters: params, encoding: JSONEncoding(options: []), headers: nil).responseData { (responseObj) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if let response = responseObj.response {
                switch response.statusCode {
                case 200...300:
                    if let data = responseObj.data, let utf8Text = String(data: data, encoding: .utf8){
                        let jsonData = JSON.parse(utf8Text)
                        self.completion(json: jsonData, error: nil, completion: completion)
                    }else{
                        let error = NSError.error(message: "Error parse data")
                        self.completion(json: nil, error: error, completion: completion)
                    }
                case let (code):
                    if let data = responseObj.data, let utf8Text = String(data: data, encoding: .utf8){
                        let jsonData = JSON.parse(utf8Text)
                        let message = jsonData["message"].string ?? ""
                        let error = NSError.error(message: message, code: code)
                        self.completion(json: jsonData, error: error, completion: completion)
                        print("Error: \(error.localizedDescription)")
                    }else{
                        let error = NSError.error(message: "Please try again later", code: code)
                        self.completion(json: nil, error: error, completion: completion)
                    }
                }// end switch status code
            }else{
                let error = NSError.error(message: "Network is down!Please try again later")
                self.completion(json: nil, error: error, completion: completion)
            }
        }//end post
    }// end request
}

extension NetworkManager{
    class func completion(json : JSON?, error : NSError?, completion : JsonResponse){
        OperationQueue.main.addOperation { () -> Void in
            if let completion = completion{
                completion(json,error)
            }
        }
    }
    
}

