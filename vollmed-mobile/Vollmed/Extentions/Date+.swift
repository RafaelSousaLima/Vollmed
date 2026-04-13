//
//  Date+.swift
//  Vollmed
//
//  Created by Rafael Lima on 22/05/25.
//

import Foundation

extension Date {
    func convertToString(format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
