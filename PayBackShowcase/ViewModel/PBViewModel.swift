//
//  PBViewModel.swift
//  PayBackShowcase
//
//  Created by Manish Parihar on 27.06.23.
//

import Foundation

// MARK: - Item
struct Item : Codable {

    let data: [ItemData]
    
    enum CodingKeys: String, CodingKey {
            case data = "items"
        }
}

// MARK: - ItemData
struct ItemData: Codable , Hashable {
    
//    let id: String
    let partnerDisplayName: String
    var alias: Alias?
    let category: Int
    var transactionDetail: TransactionDetail?
    
    static func == (lhs: ItemData, rhs: ItemData) -> Bool {
        return
            lhs.partnerDisplayName == rhs.partnerDisplayName
    }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(partnerDisplayName)
    }
    
}

// MARK: - Alias
struct Alias: Codable {
    let reference: String
}

// MARK: - Transaction Detail
struct TransactionDetail: Codable {
    var description: Description? = nil
    let bookingDate: String
    var value : Value? = nil
}

// MARK: - Description
enum Description: String, Codable {
    case punkteSammeln = "Punkte sammeln"
}

// MARK: - Value
struct Value: Codable {
    let amount : Int
    let currency: String
}

class PBViewModel: ObservableObject {
    @Published var showTransaction : [ItemData] = []
    
    func fetchDataFromAPI() {
        guard let url = Bundle.main.url(forResource: "PBTransactions", withExtension: "json") else {
            print("json file not found")
            return
        }
        
             // Convert to JSON
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let showTransaction = try decoder.decode(Item.self, from: data)
                    DispatchQueue.main.async {
                        self.showTransaction = showTransaction.data
                    }
                }catch {
                    print("Error decoding JSON:", error)
                }
    }
}
