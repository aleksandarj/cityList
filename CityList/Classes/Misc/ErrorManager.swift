import Foundation
import UIKit
import AFNetworking

struct ErrorStrings {
    //TODO: define specific error strings if any
}

class ErrorManager: NSObject {
    
    static let sharedInstance = ErrorManager()
    let reachabilityManager = AFNetworkReachabilityManager(forDomain: "www.google.com")
    
    private var noInternetAlert = AlertFactory.okAlert(
        message: NSLocalizedString("No Internet Connection", comment: ""))
    
    override init() {
        super.init()
        
        reachabilityManager.setReachabilityStatusChange { (status) -> Void in
            if status == .notReachable {
                self.noInternetAlert.show()
            } else {
                self.noInternetAlert.dismiss(withClickedButtonIndex: 0, animated: true)
            }
        }
        reachabilityManager.startMonitoring()
    }
    
    func handleError(error: NSError, responseObject: AnyObject?, operationResponse: HTTPURLResponse!) {
        if operationResponse == nil {
            return
        }
        
        if let responseObject = responseObject as? [String : AnyObject] {
            if let errorString = responseObject["error"] as? String {
                switch errorString {
                    //TODO: handle specific errors if any
                default:
                    break
                }
            }
        }
    }
}
