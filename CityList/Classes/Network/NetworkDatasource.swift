import UIKit
import AFNetworking

typealias SuccessCallback = (operation: AFHTTPRequestOperation, responseObject: AnyObject!) -> ()
typealias FailureCallback = (operation: AFHTTPRequestOperation, error: NSError!) -> ()
typealias APICallback = (error: NSError?) -> ()

class NetworkDatasource: NSObject {
    
    private let manager: AFHTTPRequestOperationManager
    private let errorHandler = MainAssembly.sharedInstance.errorHandler()
    
    static let sharedInstance = NetworkDatasource()
    
    override init() {
        let baseURL = NSURL(string: Constants.Network.baseUrl)
        manager = AFHTTPRequestOperationManager(baseURL: baseURL)
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.responseSerializer.acceptableContentTypes?.insert("text/html")
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.requestSerializer.timeoutInterval = 30
        
        super.init()
    }
    
    func GET(endpoint: String,
        parameters: [String : AnyObject]?,
        success: SuccessCallback,
        failure: FailureCallback) -> AFHTTPRequestOperation? {
            print("GET:\(endpoint) P:\(parameters)")
            return manager.GET(endpoint, parameters: parameters,
                success: { (operation: AFHTTPRequestOperation!,
                    responseObject: AnyObject!) in
                    print("success GET:\(endpoint) P:\(responseObject)")
                    success(operation: operation, responseObject: responseObject)
                },
                failure: { [weak self] (operation: AFHTTPRequestOperation!,
                    error: NSError!) in
                    self?.errorHandler.handleError(error,
                        responseObject: operation.responseObject,
                        operationResponse: operation.response)
                    print("fail GET:\(endpoint) P:\(error)")
                    print("error response object \(operation.responseObject)")
                    failure(operation: operation, error: error)
                }
            )
    }
    
    func POST(endpoint: String,
        parameters: [String : AnyObject]?,
        success: SuccessCallback,
        failure: FailureCallback) -> AFHTTPRequestOperation? {
            print("POST:\(endpoint) P:\(parameters)")
            return manager.POST(endpoint, parameters: parameters,
                success: { (operation: AFHTTPRequestOperation!,
                    responseObject: AnyObject!) in
                    print("success POST:\(endpoint) P:\(responseObject)")
                    success(operation: operation, responseObject: responseObject)
                },
                failure: { [weak self] (operation: AFHTTPRequestOperation!,
                    error: NSError!) in
                    self?.errorHandler.handleError(error,
                        responseObject: operation.responseObject,
                        operationResponse: operation.response)
                    print("fail POST:\(endpoint) P:\(error)")
                    failure(operation: operation, error: error)
                }
            )
    }
    
    func PUT(endpoint: String,
        parameters: [String : AnyObject]?,
        success: SuccessCallback,
        failure: FailureCallback) -> AFHTTPRequestOperation? {
            return manager.PUT(endpoint, parameters: parameters,
                success: { (operation: AFHTTPRequestOperation!,
                    responseObject: AnyObject!) in
                    success(operation: operation, responseObject: responseObject)
                },
                failure: { [weak self] (operation: AFHTTPRequestOperation!,
                    error: NSError!) in
                    self?.errorHandler.handleError(error,
                        responseObject: operation.responseObject,
                        operationResponse: operation.response)
                    print("fail PUT:\(endpoint) P:\(error) headers \(operation.request.allHTTPHeaderFields)")
                    failure(operation: operation, error: error)
                }
            )
    }
    
    func DELETE(endpoint: String,
        parameters: [String : AnyObject]?,
        success: SuccessCallback,
        failure: FailureCallback) -> AFHTTPRequestOperation? {
            return manager.DELETE(endpoint, parameters: parameters,
                success: { (operation: AFHTTPRequestOperation!,
                    responseObject: AnyObject!) in
                    success(operation: operation, responseObject: responseObject)
                },
                failure: { [weak self] (operation: AFHTTPRequestOperation!,
                    error: NSError!) in
                    self?.errorHandler.handleError(error,
                        responseObject: operation.responseObject,
                        operationResponse: operation.response)
                    print("fail DELETE:\(endpoint) P:\(error)")
                    failure(operation: operation, error: error)
                }
            )
    }
    
    func addAppIdToUrlString(urlString: String) -> String {
        let suffix = String(format: Constants.Network.appIdParam, arguments: [Constants.Network.openWeatherAppId])
        let newString = "\(urlString)\(suffix)"
        return newString
    }
}


