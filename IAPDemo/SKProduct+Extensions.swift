//
//  SKProduct+Extensions.swift
//  IAPDemo
//
//  Created by SHIH-YING PAN on 2020/5/1.
//  Copyright © 2020 SHIH-YING PAN. All rights reserved.
//

import StoreKit

extension SKProduct {
    var regularPrice: String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = self.priceLocale
        return formatter.string(from: self.price)
    }
}
