import UIKit

class AlertFactory: NSObject {
    
    static func okAlert(message: String) -> UIAlertView {
        let alertView = UIAlertView(title: nil,
            message: message,
            delegate: nil,
            cancelButtonTitle: NSLocalizedString("OK", comment: ""))
        
        return alertView
    }
}
