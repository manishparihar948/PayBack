//
//  PBTransactionDetailList.swift
//  PayBackShowcase
//
//  Created by Manish Parihar on 28.06.23.
//

import SwiftUI

struct PBTransactionDetailList: View {
        
    var itemData: ItemData
    
    let helper = Helper()

    var body: some View {
        VStack(alignment: .center) {
            // Display Picture
            Text(helper.getInitials(name: itemData.partnerDisplayName))
                .background(
                    Color(uiColor:.gray)
                        .frame(width: 100, height: 100)
                            .clipShape(Circle())
                )
                .frame(alignment: .center)
                    .font(.headline)
                        .foregroundColor(.white)
                            .padding(.top,5)
                                .padding(.trailing,5)
                                    .padding(.bottom,100)
            
            
            // Display Name
            Text(itemData.partnerDisplayName)
                .font(.title)
                    .padding(.bottom,10)
         
            // Descriptions
            if let transactionDetail = itemData.transactionDetail {
                Text("Description: \(transactionDetail.description?.rawValue ?? "Not Available")")
                
            }
            Spacer()
        }
    }
}

struct PBTransactionDetailList_Previews: PreviewProvider {
    static var previews: some View {
        PBTransactionDetailList(itemData: ItemData(partnerDisplayName: "Example", alias: nil, category: 0, transactionDetail: nil))
    }
}

