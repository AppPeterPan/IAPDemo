//
//  IAPManager.swift
//  IAPDemo
//
//  Created by SHIH-YING PAN on 2020/4/28.
//  Copyright © 2020 SHIH-YING PAN. All rights reserved.
//

import StoreKit


class IAPManager: NSObject, ObservableObject {
    
    static let shared = IAPManager()
    @Published var products = [SKProduct]()
    fileprivate var productRequest: SKProductsRequest!
   
    func getProductIDs() -> [String] {
        ["com.peter.IAPDemo.lovestory", "com.peter.IAPDemo.onlytheyoung", "com.peter.IAPDemo.listenonehour"]
    }
    
    func restore() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func getProducts() {
        let productIds = getProductIDs()
        let productIdsSet = Set(productIds)
        productRequest = SKProductsRequest(productIdentifiers: productIdsSet)
        productRequest.delegate = self
        productRequest.start()
    }
 
    
    func buy(product: SKProduct) {
        if SKPaymentQueue.canMakePayments() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        } else {
            // show error
        }
       
    }
    
    
}

extension IAPManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        response.products.forEach {
            print($0.localizedTitle, $0.price, $0.localizedDescription)
        }
        DispatchQueue.main.async {
            self.products = response.products

        }
    }
    
}
extension IAPManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        transactions.forEach {
            print($0.payment.productIdentifier, $0.transactionState.rawValue)
            switch $0.transactionState {
            case .purchased:
                SKPaymentQueue.default().finishTransaction($0)
            case .failed:
                print($0.error ?? "")
                if ($0.error as? SKError)?.code != .paymentCancelled {
                    // show error
                }
                SKPaymentQueue.default().finishTransaction($0)
            case .restored:
                SKPaymentQueue.default().finishTransaction($0)
            case .purchasing, .deferred:
                break
            @unknown default:
                break
            }
            
        }
    }
    
}


