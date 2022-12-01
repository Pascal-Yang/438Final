//
//  ReusableValues.swift
//  Scribbly
//
//  Created by Zhiyi Tang on 11/6/22.
//

import Foundation
import UIKit

public enum MyColor {
    static let green1 = #colorLiteral(red: 0.8537771702, green: 0.9962138534, blue: 0.8406556249, alpha: 1)
    static let green2 = #colorLiteral(red: 0.5164914131, green: 0.8128321171, blue: 0.4899054766, alpha: 1)
    static let green3 = #colorLiteral(red: 0.3741974235, green: 0.741466403, blue: 0.329223156, alpha: 1)
    static let darkBlue = #colorLiteral(red: 0.1717210114, green: 0.2214289904, blue: 0.3770936131, alpha: 1)
    static let blue1 = #colorLiteral(red: 0.172457695, green: 0.2236871719, blue: 0.3749298453, alpha: 1)
    static let grey = #colorLiteral(red: 0.8206393123, green: 0.8206391931, blue: 0.8206391931, alpha: 1)

}

public enum Font {
    static let H1 = UIFont.systemFont(ofSize: 17, weight: .semibold)
    static let H2 = UIFont.systemFont(ofSize: 16, weight: .medium)
    static let Body = UIFont.systemFont(ofSize: 14, weight: .medium)
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
