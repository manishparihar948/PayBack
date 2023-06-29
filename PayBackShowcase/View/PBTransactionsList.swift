//
//  PBTransactionsList.swift
//  PayBackShowcase
//
//  Created by Manish Parihar on 27.06.23.
//

import SwiftUI

struct PBTransactionsList: View {
        
    @ObservedObject var networkManager = NetworkManager()
    @StateObject var viewModel = PBViewModel()
    
    
    @State private var selectedIndex = 0
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .systemBlue
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.systemBlue], for: .normal)
    }
    
    
    // ItemData sorted date wise
    var sortedTransactions: [ItemData] {
        return viewModel.showTransaction.sorted { (transaction1, transaction2) -> Bool in
            if let date1 = Helper.convertStringToDate(dateString: transaction1.transactionDetail?.bookingDate ?? ""),
               let date2 = Helper.convertStringToDate(dateString: transaction2.transactionDetail?.bookingDate ?? "") {
                return date1 > date2
            }
            return false
        }
    }
     
    
    // Transactions Sum
    var filteredTransactionsSum: Double {
        var sum = 0.0
        if selectedIndex == 0 {
            let category1Transactions = sortedTransactions.filter { $0.category == 1 }
            sum = category1Transactions.reduce(0.0) { $0 + Double($1.transactionDetail?.value?.amount ?? 0) }
        } else if selectedIndex == 1 {
            let category2Transactions = sortedTransactions.filter { $0.category == 2 }
            sum = category2Transactions.reduce(0.0) { $0 + Double($1.transactionDetail?.value?.amount ?? 0) }
        }
        return sum
    }
    
    // MARK: - Body (List sort by Booking Date)
    var body: some View {
        NavigationView {
            VStack {
                Picker("Select Category", selection: $selectedIndex) {
                    Text("Category One").tag(0)
                    Text("Category Two").tag(1)
                }
                .pickerStyle(.segmented)
                .padding(.bottom,5)
                
                // Rounding Sum up to 2 digits after decimal
                let formattedSum = String(format: "%.2f", filteredTransactionsSum)
                Text("Sum: \(formattedSum)")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.gray)
                
                if $viewModel.isLoading.wrappedValue {
                    // Show a loading indicator while loading transactions
                    ProgressView()
                } else if let error = viewModel.error {
                    VStack {
                        Text("Error: \(error.localizedDescription)")
                            .foregroundColor(.red)
                            .padding()
                        Button("Retry") {
                            viewModel.fetchDataFromAPI()
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    .padding()
                } else {
                    if selectedIndex == 0 {
                        let category1Transactions = sortedTransactions.filter { $0.category == 1 }
                        List(category1Transactions, id: \.self) { itemData in
                            NavigationLink(destination: PBTransactionDetailList(itemData: itemData)) {
                                PBTransactionRow(itemData: itemData)
                            }
                        }
                    } else if selectedIndex == 1 {
                        let category2Transactions = sortedTransactions.filter { $0.category == 2 }
                        List(category2Transactions, id: \.self) { itemData in
                            NavigationLink(destination: PBTransactionDetailList(itemData: itemData)) {
                                PBTransactionRow(itemData: itemData)
                            }
                        }
                    }
                }
                
            }
            .navigationTitle("PAYBACK")
            .onAppear {
                viewModel.fetchDataFromAPI()
            }
            
            if !networkManager.isConnected {
                VStack {
                    Text("Network Error. Please Retry")
                        .foregroundColor(.red)
                        .padding()
                    Button("Retry") {
                        viewModel.fetchDataFromAPI()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .padding()
            }
        }
    }
    
}

// MARK: - Previews
struct PBTransactionsList_Previews: PreviewProvider {
    static var previews: some View {
        PBTransactionsList()
    }
}

// MARK: - List Row
struct PBTransactionRow: View {
    let itemData: ItemData
        
    var body: some View {
        VStack(alignment: .leading) {
            Text(itemData.partnerDisplayName)
                .font(.system(size: 16, weight: .bold, design: .monospaced))
                .foregroundColor(.blue)
                .padding(.bottom, 2)
            
            HStack {
                if let amount = itemData.transactionDetail?.value?.amount {
                    Text("Amount: \(String(amount))")
                } else {
                    Text("N/A")
                }
                Text(itemData.transactionDetail?.value?.currency ?? "")
            }
            .padding(.bottom, 2)
            .font(.system(size: 14, weight: .medium, design: .monospaced))
            .foregroundColor(.black)
            
            Text(itemData.transactionDetail?.description?.rawValue ?? "")
                .padding(.bottom, 2)
                .font(.system(size: 14, weight: .medium, design: .monospaced))
                .foregroundColor(.black)
            
            HStack {
                if let date = Helper.convertStringToDate(dateString: itemData.transactionDetail?.bookingDate ?? "") {
                    let formattedDate = Helper.formatDate(date: date)
                    Text("Booking Date: \(formattedDate)")
                } else {
                    Text("Invalid Date")
                }
            }
            .padding(.trailing, 10)
            .font(.system(size: 12, weight: .medium, design: .monospaced))
            .foregroundColor(.black)
        }
        .frame(height: 80)
    }
}


