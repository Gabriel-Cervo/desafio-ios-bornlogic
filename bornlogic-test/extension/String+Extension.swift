//
//  String+Extension.swift
//  bornlogic-test
//
//  Created by João Gabriel Dourado Cervo on 11/05/24.
//

import Foundation

extension String {
    /// Formats current string to readable format
    func asDate(currentFormat: String = "yyyy-MM-dd'T'HH:mm:ss'Z'", toFormat: String = "dd 'de' MMM YYYY") -> String {
        let dateFormatter = DateFormatter.shared
        dateFormatter.dateFormat = currentFormat
        dateFormatter.locale = Locale(identifier: "pt_BR")
        
        let date = dateFormatter.date(from: self) ?? Date()
        dateFormatter.dateFormat = toFormat
        return dateFormatter.string(from: date)
    }
}
