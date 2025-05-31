// This is Card information section 


enum CardType: String {
    case visa = "VISA"
    case masterCard = "MASTERCARD"
    case americanExpress = "AMERICAN EXPRESS"
    case discover = "DISCOVER"
}


import SwiftUI

struct CardCell: View {
    var cardNumber = "1111-2222-3333-2563"
    var cardHolderName = "JENNER ANNE"
    var expiryDate = "05/26"
    var cardT: CardType = .masterCard
    @Binding var isSelected: Bool
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    
                    HStack {
                        Button(action: {
                            print("Card selected:", isSelected)
                            isSelected.toggle()
                            print("Card selected:", isSelected)
                        }) {
                            Image(systemName: isSelected ? "inset.filled.circle" : "circle")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.black.opacity(0.7))
                        }
                        
                        Text("Select as default")
                            .font(.system(size: 17, weight: .medium, design: .default))
                            .foregroundColor(.gray)
                        
                        Spacer()
                    }
                    
                    
                    ZStack {
                        Image(getCardImageName())
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width - 50, height: UIScreen.main.bounds.width * 0.53)
                            .clipped()
                            .cornerRadius(16)
                            .shadow(radius: 8)
                    
                        VStack{
                            HStack{
                                Text(maskCardNumber(cardNumber))
                                    .font(.system(size: 25, weight: .bold, design: .monospaced))
                                    .foregroundColor(.white)
                                    
                                    
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, UIScreen.main.bounds.width * 0.15)
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("NAME")
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.7))
                                    Text(cardHolderName)
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.white)
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .trailing, spacing: 4) {
                                    Text("VALID TILL")
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.7))
                                    Text(expiryDate)
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(.white)
                                }
                            }
                            .padding(.top)
                          
                            
                        }
                        .padding()
                    }
                }
            }
            .frame(width: 350, height: 260)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black.opacity(0.4), lineWidth: 2)
                    .frame(width: UIScreen.main.bounds.width - 25, height: 270)
            )
        }
        .frame(maxWidth: .infinity)
    }
}


extension CardCell {
    
    private func getCardImageName() -> String {
        switch cardT {
        case .visa:
            return "VisaCard"
        case .masterCard:
            return "MasterCard"
        case .americanExpress:
            return "AmexCard"
        case .discover:
            return "DiscoverCard"
        }
    }
    
    func maskCardNumber(_ cardNumber: String) -> String {
        let components = cardNumber.components(separatedBy: " ")
        var masked = components.map { _ in "XXXX" }
        if let last = components.last {
            masked[masked.count - 1] = last
        }
        return masked.joined(separator: "-")
    }
}


// #Preview {
//     PaymentView()
// }



struct Card_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContainer()
            .previewLayout(.sizeThatFits)
    }

    struct PreviewContainer: View {
        @State private var isSelected: Bool = false

        var body: some View {
            CardCell(cardT: .masterCard, isSelected: $isSelected)
        }
    }
}

