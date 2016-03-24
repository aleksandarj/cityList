import Foundation
import UIKit

class TableViewHelpers: NSObject {
    static func setRowsHidden(rowsHidden: Bool, tableView: UITableView, text: String) {
        if rowsHidden {
            let noCitiesLabel = UILabel()
            noCitiesLabel.textAlignment = NSTextAlignment.Center
            noCitiesLabel.textColor = UIColor.lightGrayColor()
            noCitiesLabel.text = text
            noCitiesLabel.numberOfLines = 3
            tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            tableView.backgroundView = noCitiesLabel
        } else {
            tableView.backgroundView = nil
            tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        }
    }
}