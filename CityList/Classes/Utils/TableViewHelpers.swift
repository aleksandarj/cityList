import Foundation
import UIKit

class TableViewHelpers: NSObject {
    static func setRowsHidden(rowsHidden: Bool, tableView: UITableView, text: String) {
        if rowsHidden {
            let noCitiesLabel = UILabel()
            noCitiesLabel.textAlignment = NSTextAlignment.center
            noCitiesLabel.textColor = UIColor.lightGray
            noCitiesLabel.text = text
            noCitiesLabel.numberOfLines = 3
            tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            tableView.backgroundView = noCitiesLabel
        } else {
            tableView.backgroundView = nil
            tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        }
    }
}
