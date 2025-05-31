// this CardDetailDM 


import Foundation

struct CardDM: Identifiable {
    var id: UUID = UUID()
    var userName: String
    var cardNumber: String
    var expairy: String
    var country: String
    var cardTpe: CardType
    var isDefaultCard : Bool?
    
    static var cardSampleData: [CardDM] = [
        .init(userName: "JENNER ANNE", cardNumber: "XXXX-XXXX-XXXX-2563 ", expairy: "05/34", country: "Canada", cardTpe: .masterCard, isDefaultCard: false),
        .init(userName: "JENNER ANNE", cardNumber: "XXXX-XXXX-XXXX-1111", expairy: "10/28", country: "Canada", cardTpe: .visa, isDefaultCard: true),
    ]
}


struct StoreCardData: Identifiable {
    var id: UUID = UUID()
    var cardNumber: String
    var expairy: String
    var cvv: String
    var country: String
    var cardType: String
    var userName: String
    var isDefaultCard:Bool?

    init(id: UUID = UUID(), cardNumber: String, expairy: String, cvv: String, country: String, cardType: String, userName: String,isDefaultCard:Bool) {
        self.id = id
        self.cardNumber = cardNumber
        self.expairy = expairy
        self.cvv = cvv
        self.country = country
        self.cardType = cardType
        self.userName = userName
        self.isDefaultCard = isDefaultCard
    }

    // Add this initializer for Firebase dictionary parsing
    init?(from dict: [String: Any]) {
        guard let cardNumber = dict["cardNumber"] as? String,
              let expairy = dict["expairy"] as? String,
              let cvv = dict["cvv"] as? String,
              let country = dict["country"] as? String,
              let cardType = dict["cardType"] as? String,
              let userName = dict["userName"] as? String else {
            return nil
        }
        let isDefaultCard = dict["isDefaultCard"] as? Bool
        self.id = UUID()
        self.cardNumber = cardNumber
        self.expairy = expairy
        self.cvv = cvv
        self.country = country
        self.cardType = cardType
        self.userName = userName
        self.isDefaultCard = isDefaultCard
    }
}

