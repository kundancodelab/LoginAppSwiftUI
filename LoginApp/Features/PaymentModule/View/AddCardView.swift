// this is CardCell similar to Xib in tableView in ukit 


//

import SwiftUI

struct AddCardView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var cardNumber: String = ""
    @State private var expiryDate: String = ""
    @State private var securityCode: String = ""
    @State private var cardHolderName: String = ""
    @State private var acceptTerms: Bool = false
    @State private var makeDefault: Bool = false
    @State private var selectedCountry: String = "United States"
    @State private var phoneNumber: String = ""
    @State private var selectedFlag: String = "🇺🇸"
    @State private var isSaveCrad: Bool = false
    @State private var isSaving = false
    
    @StateObject private var cardVM = CardVM()
    @StateObject private var paymentVM = PaymentVM()
   
    
    var body: some View {
       // NavigationView {
            VStack(alignment: .leading) {
                // Header
                VStack {
                    HStack(alignment: .center){
                        Text("Add a new card")
                            .font(.system(size: 25, weight: .medium))
                            .padding([.leading, .top, .bottom])
                
                        Spacer()
                        
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 23, weight: .medium))
                                .foregroundColor(.black)
                        }
                        .padding([.trailing,.top,.bottom])
                    }
                    .frame(maxHeight: 40)
                    
                    Divider()
                        .frame(height: 2)
                        .background(Color.black.opacity(0.8))
                        .frame(maxWidth: UIScreen.main.bounds.width)
                        .padding(.top, 8)
                    
                }
              
                .frame(maxWidth: .infinity, maxHeight: 50)
                VStack(alignment: .leading, spacing: 20) {
                    //print(cardVM.getCardType(cardNumber: cardNumber))
                    // Card Number Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Card Number")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.primary)
                        HStack{
                            TextField("1234 1234 1234 1234", text: $cardNumber)
                                .padding(.horizontal)
                                .keyboardType(.numberPad)
                                .frame(height: 50)
                                .keyboardType(.numberPad)
                                .onChange(of: cardNumber) { _,newValue in
                                    let formatted = cardVM.formatCardNumber(newValue)
                                    if formatted != cardNumber {
                                        let limited = String(formatted.prefix(19))
                                        print(limited)
                                        cardNumber = formatted
                                    }
                                }
                            // Show image based on card type
                            Group {
                                let cardType = cardVM.getCardType(cardNumber: cardNumber)
                                if cardType == "Visa" {
                                    Image("VisaC")
                                        .resizable()
                                        .frame(width: 50, height: 18)
                                        .padding(.trailing, 10)
                                } else if cardType == "Mastercard" {
                                    Image("MasterC")
                                        .resizable()
                                        .frame(width: 50, height: 30)
                                        .padding(.trailing, 10)
                                } else if cardType == "American Express" {
                                    Image("AmexC")
                                        .resizable()
                                        .frame(width: 50, height: 30)
                                        .padding(.trailing, 10)
                                    
                                } else if cardType == "Discover" {
                                    Image("DiscoverC")
                                        .resizable()
                                        .frame(width: 50, height: 40)
                                        .padding(.trailing, 10)
                                }
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.6), lineWidth: 1)
                        )
                    }
                    
                    // Expiry Date and Security Code
                    HStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Expiry Date")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.primary)
                            TextField("MM/YY", text: $expiryDate)
                                .padding(.horizontal)
                                .keyboardType(.numberPad)
                                .frame(height: 50)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.6), lineWidth: 1)
                                )
                                .keyboardType(.numbersAndPunctuation)
                                .onChange(of: expiryDate) { _,newValue in
                                    let raw = newValue.replacingOccurrences(of: "/", with: "")
                                    let limited = String(raw.prefix(4))
                                    if limited.count <= 2 {
                                        expiryDate = limited
                                    } else {
                                        let mm = limited.prefix(2)
                                        let yy = limited.suffix(from: limited.index(limited.startIndex, offsetBy: 2))
                                        expiryDate = "\(mm)/\(yy)"
                                    }
                                }
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Security Code")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.primary)
                            SecureField("CVC", text: $securityCode)
                                .keyboardType(.numberPad)
                                .padding(.horizontal)
                                .frame(height: 50)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.6), lineWidth: 1)
                                )
                                .onChange(of: securityCode) { _,newValue in
                                    let filtered = newValue.filter { $0.isNumber }
                                    securityCode = String(filtered.prefix(3))
                                }
                                
                        }
                    }
                    
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Card Holder's Name")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.primary)
                        
                        TextField("Jon Doe", text: $cardHolderName)
                            .padding(.horizontal)
                            .frame(height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.6), lineWidth: 1)
                            )
                      
                    }
                   
                      
                    

                    // Terms Checkbox
                    HStack(alignment: .top, spacing: 10) {
                        Text("By providing your card information, you allow BidRush to charge your card for future payments in accordance with their terms.")
                            .font(.system(size: 15))
                            .foregroundColor(.gray)
                    }
                    
                    
                    HStack(spacing: 10) {
                        Toggle("", isOn: $makeDefault)
                            .toggleStyle(CheckboxToggleStyle())
                            .frame(width: 20)
                        
                        Text("Make this my default payment method")
                            .font(.system(size: 17, weight: .medium))
                    }
                   
                    //MARK:  Add Payment Button Actions
                    Button(action: {
                        isSaving = true

                        saveInFirebase(
                            cardNumber: cardNumber,
                            expiry: expiryDate,
                            cvv: securityCode,
                            cardHolderName: cardHolderName,
                            cardType: cardType(card: cardVM.getCardType(cardNumber: cardNumber)),
                            isDefaultCard: makeDefault
                        )
                    }) {
                        ZStack {
                            if isSaving {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            } else {
                                Text("Add Payment")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.black)
                        )
                    }
                    .disabled(isSaving)

               
                }
                .padding()
                .simultaneousGesture(
                    TapGesture().onEnded {
                        hideKeyboard()
                    }
                )
                
            }
            .frame(width: UIScreen.main.bounds.width, height: 620)
            .padding(.horizontal)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
      // }
    }
}



extension AddCardView {
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func cardType(card: String) -> String{
        if card == "Visa" {
            return "VISA"
        } else if card == "Mastercard" {
            return "MASTERCARD"
        } else if card == "American Express" {
            return "AMERICAN EXPRESS"
        } else if card == "Discover" {
            return "DISCOVER"
        } else {
            return "Unknown"
        }
    }
    
    
    //  return "American Express"
//} else if cardNumber.hasPrefix("6011") || cardNumber.hasPrefix("65") {
//    return "Discover"
                
    func saveInFirebase(cardNumber: String, expiry: String, cvv: String, cardHolderName: String, cardType: String, isDefaultCard:Bool){
        paymentVM.saveCardData(cardNumber: cardNumber,
                               expiry: expiry,
                               cvv: cvv,
                               country: "+1",
                               cardType: cardType,
                               userName: cardHolderName, isDefaultCard: isDefaultCard) { result in
          if let error = result {
              print(" Card couldn't saved error --> : \(error)")
          } else {
              let isCardAdded = UserDefaults.standard.bool(forKey: "isCreaditCardAdded")
              if !isCardAdded {
                  UserDefaults.standard.set(true, forKey: "isCreaditCardAdded")
              }
              print("Card saved successfully.")
              presentationMode.wrappedValue.dismiss()
          }
      }

    }
}



// Custom Checkbox Style
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(configuration.isOn ? .black : .gray)
            }
        }
    }
}


struct AddCardView_Previews: PreviewProvider {
    static var previews: some View {
        AddCardView()
    }
}

