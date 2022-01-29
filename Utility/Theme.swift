/*
Created by Vinay Devdikar on 22/01/22.
 
Abstract:
All colors and dimension 
*/

import UIKit
enum Theme {
    
    enum dimension {
        static let baseUnit: CGFloat = 8.0
        static let padding: CGFloat = 16.0
        static let cornerRadius: CGFloat = 16.0
    }
    
    enum colors {
        static let backgroundColor: UIColor = UIColor(red:  0.9647, green:  0.9647, blue:  0.9647, alpha: 1.0)
        static let textColor: UIColor = UIColor(red: 0.2039, green: 0.2039, blue: 0.2039, alpha: 1.0)
        static let borderColor: UIColor = UIColor(red: 0.3529, green: 0.5372, blue: 0.1607, alpha: 1.0)
    }
    
}
