//


import Foundation

class CardVM : ObservableObject {
    
    
    func getCardType(cardNumber: String) -> String {
        if cardNumber.hasPrefix("4") {
            return "Visa"
        } else if let firstTwo = Int(cardNumber.prefix(2)),
                  (51...55).contains(firstTwo) {
            return "Mastercard"
        } else if let firstFour = Int(cardNumber.prefix(4)),
                  (2221...2720).contains(firstFour) {
            return "Mastercard"
        } else if cardNumber.hasPrefix("34") || cardNumber.hasPrefix("37") {
            return "American Express"
        } else if cardNumber.hasPrefix("6011") || cardNumber.hasPrefix("65") {
            return "Discover"
        } else {
            return "Unknown"
        }
    }
    
    func formatCardNumber(_ number: String) -> String {
        let trimmed = number.replacingOccurrences(of: " ", with: "")
        let limited = String(trimmed.prefix(16))  // Limit to 16 digits
        let groups = stride(from: 0, to: limited.count, by: 4).map {
            let start = limited.index(limited.startIndex, offsetBy: $0)
            let end = limited.index(start, offsetBy: 4, limitedBy: limited.endIndex) ?? limited.endIndex
            return String(limited[start..<end])
        }
        return groups.joined(separator: " ")
    }

}

