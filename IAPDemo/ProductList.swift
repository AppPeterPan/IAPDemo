//
//  ContentView.swift
//  IAPDemo
//
//  Created by SHIH-YING PAN on 2020/4/28.
//  Copyright © 2020 SHIH-YING PAN. All rights reserved.
//

import SwiftUI

struct ProductList: View {
    
    @ObservedObject var iapManager = IAPManager.shared
    
    var body: some View {
        
        NavigationView {
            List(iapManager.products, id: \.productIdentifier) { (product)  in
                Button(action: {
                    self.iapManager.buy(product: product)
                    
                }) {
                    HStack {
                        Text(product.localizedTitle)
                        Spacer()
                        Text(product.regularPrice ?? "")
                        
                    }
                }
            }
            .navigationBarTitle("Taylor Swift")
            .navigationBarItems(trailing:
                Button(action: {
                    self.iapManager.restore()
                }) {
                    Text("Restore")
                }
            )
            .onAppear {
                    self.iapManager.getProducts()
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProductList()
    }
}
