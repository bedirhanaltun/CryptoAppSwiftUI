//
//  CryptoModel.swift
//  CryptoAppSwiftUI
//
//  Created by Bedirhan Altun on 24.09.2022.
//

import Foundation

struct CryptoModel: Hashable, Identifiable, Decodable{
    
    let id = UUID()
    let price: String
    let currency: String
    
    private enum CodingKeys: String, CodingKey{
        case currency = "currency"
        case price = "price"
    }
}
