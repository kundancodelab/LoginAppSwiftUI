//

//

    import Foundation
    import SwiftUI
    import FirebaseDatabase
    import FirebaseAuth

    class PaymentVM: ObservableObject {
     
        //MARK: Save card data in firebase.......
        func saveCardData(cardNumber: String, expiry: String, cvv: String, country: String, cardType: String, userName: String, isDefaultCard: Bool, comp: @escaping (String?) -> Void) {
            
            let userId = UserDefaults.standard.string(forKey: "UserId") ?? ""
            guard !userId.isEmpty else {
                comp("User ID not found")
                return
            }

            let ref = Database.database().reference()
            let userCardsRef = ref.child("Payments").child(userId).child("C_cards")

            userCardsRef.observeSingleEvent(of: .value) { snapshot, _ in
                if let cards = snapshot.value as? [String: [String: Any]] {
                    let exists = cards.contains { _, value in
                        if let number = value["cardNumber"] as? String {
                            return number.replacingOccurrences(of: " ", with: "") ==
                                   cardNumber.replacingOccurrences(of: " ", with: "")
                        }
                        return false
                    }
                    if exists {
                        comp("Card already exists")
                        return
                    }
                }

                // If this is a default card, unset other defaults
                if isDefaultCard {
                    userCardsRef.observeSingleEvent(of: .value) { snapshot in
                        if let cards = snapshot.value as? [String: [String: Any]] {
                            for (key, _) in cards {
                                userCardsRef.child(key).child("isDefaultCard").setValue(false)
                            }
                        }

                        // Now save the new card
                        let newCardRef = userCardsRef.childByAutoId()
                        let cardDict: [String: Any] = [
                            "id": UUID().uuidString,
                            "cardNumber": cardNumber,
                            "expairy": expiry,
                            "cvv": cvv,
                            "country": country,
                            "cardType": cardType,
                            "userName": userName,
                            "isDefaultCard": isDefaultCard
                        ]

                        newCardRef.setValue(cardDict) { error, _ in
                            if let error = error {
                                comp("Error saving card: \(error.localizedDescription)")
                            } else {
                                comp(nil) // success
                            }
                        }
                    }
                } else {
                    // Save without changing other cards
                    let newCardRef = userCardsRef.childByAutoId()
                    let cardDict: [String: Any] = [
                        "id": UUID().uuidString,
                        "cardNumber": cardNumber,
                        "expairy": expiry,
                        "cvv": cvv,
                        "country": country,
                        "cardType": cardType,
                        "userName": userName,
                        "isDefaultCard": isDefaultCard
                    ]

                    newCardRef.setValue(cardDict) { error, _ in
                        if let error = error {
                            comp("Error saving card: \(error.localizedDescription)")
                        } else {
                            comp(nil) // success
                        }
                    }
                }
            }
        }

        //MARK: Fetch card data from firebase.......
        func fetchUserCards(completion: @escaping ([StoreCardData]?, Error?) -> Void) {
           
            guard let userId = UserDefaults.standard.string(forKey: "UserId"), !userId.isEmpty else {
                completion(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User ID not found"]))
                return
            }

            let ref = Database.database().reference()
            let userCardsRef = ref.child("Payments").child(userId).child("C_cards")
            
            userCardsRef.observeSingleEvent(of: .value) { snapshot in
                var cards: [StoreCardData] = []
                guard snapshot.exists() else {
                    completion([], nil)
                    return
                }
                for child in snapshot.children {
                    if let childSnapshot = child as? DataSnapshot,
                       let value = childSnapshot.value as? [String: Any],
                       let card = StoreCardData(from: value) {
                        cards.append(card)
                    }
                }
              
                completion(cards, nil)
            } withCancel: { error in
                completion(nil, error)
            }
        }
        
        func updateDefaultCardInFirebase(cardNumber: String, isDefault: Bool, completion: @escaping (Bool) -> Void) {
            guard let userId = UserDefaults.standard.string(forKey: "UserId") else {
                completion(false)
                return
            }

            let ref = Database.database().reference()
            let userCardsRef = ref.child("Payments").child(userId).child("C_cards")

            userCardsRef.observeSingleEvent(of: .value) { snapshot in
                guard let cards = snapshot.value as? [String: [String: Any]] else {
                    completion(false)
                    return
                }

                var updateCount = 0
                let totalCards = cards.count
                var success = true

                for (key, value) in cards {
                    if let number = value["cardNumber"] as? String {
                        let isMatch = number.replacingOccurrences(of: " ", with: "") == cardNumber.replacingOccurrences(of: " ", with: "")
                        userCardsRef.child(key).child("isDefaultCard").setValue(isMatch) { error, _ in
                            updateCount += 1
                            if error != nil {
                                success = false
                            }
                            
                            if updateCount == totalCards {
                                completion(success)
                            }
                        }
                    } else {
                        updateCount += 1
                        if updateCount == totalCards {
                            completion(success)
                        }
                    }
                }
            }
        }


    }
