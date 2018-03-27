//
//  String+Extension.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/16/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
enum TNComparison  {
    case equalTo
    case notEqualTo
    case greaterThan
    case lessThan
    case greaterThanOrEqualTo
    case lessThanOrEqualTo
}
extension String {

    func checkLength(comparison: TNComparison, length: Int, shouldChangeCharactersIn range: NSRange? = nil, replacementString string: String? = nil) -> Bool {
        var checkedText = self
        if let string = string, let range = range,  let textRange = Range(range, in: self) {
            checkedText = replacingCharacters(in: textRange, with: string)
        }
        switch comparison {
        case .equalTo:
            return checkedText.count == length
        case .greaterThan:
            return checkedText.count > length
        case .greaterThanOrEqualTo:
            return checkedText.count >= length
        case .lessThan:
            return checkedText.count < length
        case .lessThanOrEqualTo:
            return checkedText.count <= length
        case .notEqualTo:
            return checkedText.count != length
        }
    }

    func prefixAHalf() -> String {
        let splitterLength = Int(ceil(Double(self.count / 2)))
        return String(self.prefix(splitterLength))
    }

    func suffixAHalf() -> String {
        let splitterLength = Int(ceil(Double(self.count / 2)))
        return String(self.suffix(from: Index.init(encodedOffset: splitterLength)))
    }

    func splitTwoPieces() -> (prefix: String, suffix: String) {
        let splitterLength = Int(ceil(Double(self.count)))
        return (prefix: String(self.prefix(splitterLength)), suffix: String(self.suffix(splitterLength-1)))
    }
}
