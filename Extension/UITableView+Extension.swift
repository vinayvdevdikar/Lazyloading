/*
Created by Vinay Devdikar on 22/01/22.
 
Abstract:

*/

import UIKit
extension UITableView {
    
    func dequeReusableCell<T: UITableViewCell>(_:T.Type) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("\(T.self) cell should first register before use")
        }
        return cell
    }
    
    func register<T: UITableViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.reuseIdentifier)
    }
}


extension UITableViewCell: ViewIdentifiers { }

protocol ViewIdentifiers: AnyObject {
    static var reuseIdentifier: String { get }
}

extension ViewIdentifiers {
    static var reuseIdentifier: String {
        let identifier = NSStringFromClass(self)
        return identifier
    }
}
