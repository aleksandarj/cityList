import UIKit
import AFNetworking

typealias SuccessCallback = (_ operation: AFHTTPRequestOperation, _ responseObject: AnyObject!) -> Void
typealias FailureCallback = (_ operation: AFHTTPRequestOperation, _ error: Error!) -> Void
typealias APICallback = (_ error: NSError?) -> ()

class NetworkDatasource: NSObject {
    
    private let manager: AFHTTPRequestOperationManager
    private let errorHandler = MainAssembly.sharedInstance.errorHandler()
    
    static let sharedInstance = NetworkDatasource()
    
    override init() {
        let baseURL = NSURL(string: Constants.Network.baseUrl)
        manager = AFHTTPRequestOperationManager(baseURL: baseURL as! URL)
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.requestSerializer.timeoutInterval = 30
        
        super.init()
    }
    
    func GET(endpoint: String,
        parameters: [String : AnyObject]?,
        success: @escaping SuccessCallback,
        failure: @escaping FailureCallback) -> AFHTTPRequestOperation? {
            print("GET:\(endpoint) P:\(parameters)")
        return manager.get(endpoint, parameters: parameters,
                success: { (operation: AFHTTPRequestOperation!,
                    responseObject: Any!) in
                    print("success GET:\(endpoint) P:\(responseObject)")
                    success(operation, responseObject as AnyObject)
                },
                failure: { [weak self] (operation: AFHTTPRequestOperation!,
                    error: Error!) in
                    self?.errorHandler.handleError(error: error as! NSError,
                                                   responseObject: operation.responseObject as AnyObject,
                        operationResponse: operation.response)
                    print("fail GET:\(endpoint) P:\(error)")
                    print("error response object \(operation.responseObject)")
                    failure(operation, error)
                }
            )
    }
    
    func POST(endpoint: String,
        parameters: [String : AnyObject]?,
        success: @escaping SuccessCallback,
        failure: @escaping FailureCallback) -> AFHTTPRequestOperation? {
            print("POST:\(endpoint) P:\(parameters)")
        return manager.post(endpoint, parameters: parameters,
                success: { (operation: AFHTTPRequestOperation!,
                    responseObject: Any!) in
                    print("success POST:\(endpoint) P:\(responseObject)")
                    success(operation, responseObject as AnyObject)
                },
                failure: { [weak self] (operation: AFHTTPRequestOperation!,
                    error: Error!) in
                    self?.errorHandler.handleError(error: error as! NSError,
                                                   responseObject: operation.responseObject as AnyObject,
                        operationResponse: operation.response)
                    print("fail POST:\(endpoint) P:\(error)")
                    failure(operation, error)
                }
            )
    }
    
    func PUT(endpoint: String,
        parameters: [String : AnyObject]?,
        success: @escaping SuccessCallback,
        failure: @escaping FailureCallback) -> AFHTTPRequestOperation? {
        return manager.put(endpoint, parameters: parameters,
                success: { (operation: AFHTTPRequestOperation!,
                    responseObject: Any!) in
                    success(operation, responseObject as AnyObject)
                },
                failure: { [weak self] (operation: AFHTTPRequestOperation!,
                    error: Error!) in
                    self?.errorHandler.handleError(error: error as! NSError,
                                                   responseObject: operation.responseObject as AnyObject,
                        operationResponse: operation.response)
                    print("fail PUT:\(endpoint) P:\(error) headers \(operation.request.allHTTPHeaderFields)")
                    failure(operation, error)
                }
            )
    }
    
    func DELETE(endpoint: String,
        parameters: [String : AnyObject]?,
        success: @escaping SuccessCallback,
        failure: @escaping FailureCallback) -> AFHTTPRequestOperation? {
        return manager.delete(endpoint, parameters: parameters,
                success: { (operation: AFHTTPRequestOperation!,
                    responseObject: Any!) in
                    success(operation, responseObject as AnyObject)
                },
                failure: { [weak self] (operation: AFHTTPRequestOperation!,
                    error: Error!) in
                    self?.errorHandler.handleError(error: error as! NSError,
                                                   responseObject: operation.responseObject as AnyObject,
                        operationResponse: operation.response)
                    print("fail DELETE:\(endpoint) P:\(error)")
                    failure(operation, error)
                }
            )
    }
    
    func addAppIdToUrlString(urlString: String) -> String {
        let suffix = String(format: Constants.Network.appIdParam, arguments: [Constants.Network.openWeatherAppId])
        let newString = "\(urlString)\(suffix)"
        return newString
    }
}


