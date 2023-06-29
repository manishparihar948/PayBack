//
//  Helper.swift
//  PayBackShowcase
//
//  Created by Manish Parihar on 29.06.23.
//

import Foundation

class Helper {
    
  static  func convertStringToDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
      // Format of the input date string
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: dateString) {
            return date
        } else {
            return nil
        }
    }
    
  static  func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
      // Choose the desired date style
        dateFormatter.dateStyle = .medium
        
        return dateFormatter.string(from: date)
    }
}
