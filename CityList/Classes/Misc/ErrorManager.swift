import Foundation
import UIKit
import AFNetworking

struct ErrorStrings {

}

class ErrorManager: NSObject {
    
    static let sharedInstance = ErrorManager()
    let reachabilityManager = AFNetworkReachabilityManager(forDomain: "www.google.com")
    
    private var noInternetAlert = AlertFactory.okAlert(
        NSLocalizedString("No Internet Connection", comment: ""))
    
    override init() {
        super.init()
        
        reachabilityManager.setReachabilityStatusChangeBlock { (status) -> Void in
            if status == .NotReachable {
                self.noInternetAlert.show()
            } else {
                self.noInternetAlert.dismissWithClickedButtonIndex(0, animated: true)
            }
        }
        reachabilityManager.startMonitoring()
    }
    
    func handleError(error: NSError, responseObject: AnyObject?, operationResponse: NSHTTPURLResponse!) {
        if operationResponse == nil {
            return
        }
        
        if let responseObject = responseObject as? [String : AnyObject] {
            if let errorString = responseObject["error"] as? String {
                switch errorString {
                default:
                    break
                }
            }
        }
    }
}