//
//  String+.swift
//  Vollmed
//
//  Created by Rafael Lima on 22/05/25.
//

import Foundation

extension String {
    func convertDateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = dateFormatter.date(from: self) else { return "" }
        dateFormatter.dateFormat = "dd/MM/yyyy 'às' HH:mm"
        return dateFormatter.string(from: date)
    }
    
}
