//
//  Helper.swift
//  PayBackShowcase
//
//  Created by Manish Parihar on 29.06.23.
//

import Foundation

class Helper {
    
   // Convert String to Date
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
    
    // Format Date
    static  func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
      // Choose the desired date style
        dateFormatter.dateStyle = .medium
        
        return dateFormatter.string(from: date)
    }
    
    // Helper method to extract the initials from the name
    func getInitials(name: String) -> String {
        let names = name.components(separatedBy: " ")
        var initials = ""
        for name in names {
            if let firstLetter = name.first {
                initials.append(firstLetter.uppercased())
            }
        }
        return initials
    }
}
