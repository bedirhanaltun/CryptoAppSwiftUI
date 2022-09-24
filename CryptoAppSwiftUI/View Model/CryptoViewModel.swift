//
//  ViewModel.swift
//  CryptoAppSwiftUI
//
//  Created by Bedirhan Altun on 24.09.2022.
//

import Foundation


@MainActor //MainActor bize üstüne yazdığımız sınıfın içerisindeki propertiler main threadde işlem göreceğini garanti eder.
//ObservableObject --> Gözlemlenebilir Obje
class CryptoListViewModel: ObservableObject{
    
    @Published var cryptoList = [CryptoViewModel]()
    
    let service = WebService()
    
    func downloadCryptoContinuation(url: URL) async{
        do{
            let cryptos = try await service.downloadDataContinuation(url: url)
            self.cryptoList = cryptos.map(CryptoViewModel.init)
            /*
            DispatchQueue.main.async {
                self.cryptoList = cryptos.map(CryptoViewModel.init)
            }
             */
        }
        catch{
            print("error")
        }
    }
    
    /*
    func downlaodCryptoAsync(url: URL) async{
        do{
            let cryptos = try await service.downloadDataAsync(url: url)
            DispatchQueue.main.async {
                self.cryptoList = cryptos.map(CryptoViewModel.init)
            }
        }
        catch{
            print("Error")
        }
    }
     */
    
    /*
    func downloadCrypto(url: URL){
        service.downloadData(url: url) { result in
            
            switch result{
            case.failure(let error):
                print(error)
                
            case .success(let cryptos):
                if let cryptos = cryptos{
                    DispatchQueue.main.async {
                        self.cryptoList = cryptos.map(CryptoViewModel.init)
                    }
                }
            }
        }
    }
     */
}




struct CryptoViewModel{
    let crypto: CryptoModel
    
    var id: UUID?{
        crypto.id
    }
    
    var currency: String{
        crypto.currency
    }
    
    var price: String{
        crypto.price
    }
}
