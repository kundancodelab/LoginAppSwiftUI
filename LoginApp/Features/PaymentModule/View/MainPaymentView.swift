// this is main PaymentView screen on which added creadit cards are being shown if there are no cards the we are adding it.

//

import SwiftUI

struct MainPaymentView: View {
   
    @Environment(\.presentationMode) var presentationMode
    @State private var cardData: [StoreCardData] = []
    @State private var isAddCard: Bool = false
    @State private var selectedCardID: String?
    @StateObject private var paymentVM = PaymentVM()
    @AppStorage("defaultCardID") private var defaultCardID: String?
    @State private var isLoading: Bool = false
   
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            
         //   NavigationStack {
                ZStack {
                    Color("systemBG")
                        .ignoresSafeArea(.all)
                    
                    VStack(spacing: 5) {
                        TopBarView
                        
                        DocomentationView
                            .frame(width: screenWidth * 0.95)
                            .padding(.top)
                        
                        CardList
                            .frame(width: screenWidth * 0.95)
                        
                        Spacer()
                        
                        AddNewButton
                            .frame(width: screenWidth)
                    }
                    .onAppear {
                        if let savedID = UserDefaults.standard.value(forKey: "defaultCardID") as? String {
                            selectedCardID = savedID
                            print("default card number: \(selectedCardID ?? "none")")
                        } else {
                            print("No default cards found")
                        }
                         fetchCardData()
                        
                    }
                    .frame(width: screenWidth)
                }
                
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                .navigationBarTitleDisplayMode(.inline)
                .sheet(isPresented: $isAddCard, onDismiss: {
                   // fetchCardData()
                    fetchCardData()
                }) {
                    AddCardView()
                        .presentationDetents([.height(620)])
                        .presentationDragIndicator(.visible)
                }
            if isLoading {
                CustomLoader()
            }
           // }
        }
    }
}

extension MainPaymentView {
    
    var TopBarView: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .frame(width: 40, height: 30)
                    .padding(.leading)
            }
            Spacer()
            Text("Payment Methods")
                .font(.system(size: 20, weight: .semibold))
                .padding(.leading)
            Spacer()
            Button(action: {
                // Optional right button action
            }) {
                Image("")
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .frame(width: 40, height: 30)
                    .padding(.leading)
            }
        }
    }
    
    var DocomentationView: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Your Payment Method")
                .font(.system(size: 18, weight: .semibold))
            Text("Manage and update your payment methods securely and efficiently. This section allows you to add, remove, and modify your preferred payment options, ensuring a seamless and convenient transaction experience.")
                .font(.system(size: 16, weight: .light))
                .foregroundColor(.black.opacity(0.6))
                .minimumScaleFactor(0.5)
        }
    }
    
    var CardList: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Saved Credit Card")
                .font(.system(size: 18, weight: .semibold))
                .padding([.leading, .top], 5)
            
            if cardData.isEmpty {
                Spacer()
                Text("No Card found! \nPlease add your Card")
                    .font(.system(size: 20, weight: .semibold))
                    .multilineTextAlignment(.center)
                Spacer()
            } else {
                List {
                    ForEach(cardData, id: \.id) { card in
                        cardRow(for: card)
                    }
                } 
                .listStyle(.plain)
                .background(Color.clear)
                .scrollContentBackground(.hidden)
            }
        }
    }
    
    @ViewBuilder
    func cardRow(for card: StoreCardData) -> some View {
       // let card = cardData[index]
        CardCell(
            cardNumber: card.cardNumber,
            cardHolderName: card.userName,
            expiryDate: card.expairy,
            cardT: getCardType(type: card.cardType),
            isSelected: .constant(card.isDefaultCard ?? false)
        )
        .onTapGesture {
            print(card.cardNumber)
            isLoading = true
            selectOnlyCard(cardNumber: card.cardNumber)
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
    }
    
    @MainActor
    func selectOnlyCard(cardNumber: String) {
        // First update local state immediately for responsive UI
        for i in cardData.indices {
//            cardData[i].isDefaultCard = (cardData[i].cardNumber == cardNumber)
        }
        
        // Then update Firebase
        paymentVM.updateDefaultCardInFirebase(cardNumber: cardNumber, isDefault: true) { success in
            isLoading = false
            if success {
                // Refresh data from Firebase to ensure consistency
           
                self.paymentVM.fetchUserCards { cardData, error in
                    if let cardData = cardData {
                        DispatchQueue.main.async {
                            self.cardData = cardData.reversed()
                        }
                    }
                }
            }
        }
    }
    var AddNewButton: some View {
        Button(action: {
            isAddCard.toggle()
        }) {
            HStack(spacing: 2) {
                Image(systemName: "plus")
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                Text("Add New")
                    .font(.system(size: 18))
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 1)
            )
        }
        .padding(.horizontal)
    }
    
    func getCardType(type: String) -> CardType {
        switch type.uppercased() {
        case "VISA":
            return .visa
        case "MASTERCARD":
            return .masterCard
        case "AMERICAN EXPRESS":
            return .americanExpress
        case "DISCOVER":
            return .discover
        default:
            return .visa
        }
    }
    
    func fetchCardData() {
       // if forceRefresh { isLoading = true }
        
        paymentVM.fetchUserCards { result, error in
            if let error = error {
                print("Error fetching cards:", error.localizedDescription)
            } else if let cards = result {
                print("Fetched cards:", cards)
                UserDefaults.standard.set(true, forKey: "isCreaditCardAdded")
                self.cardData = cards.reversed()
               
            } else {
                UserDefaults.standard.set(false, forKey: "isCreaditCardAdded")
                print("No cards found.")
            }
           
        }
    }
}

#Preview {
    MainPaymentView()
}
