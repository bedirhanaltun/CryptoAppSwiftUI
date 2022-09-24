//
//  WebService.swift
//  CryptoAppSwiftUI
//
//  Created by Bedirhan Altun on 24.09.2022.
//

import Foundation

class WebService{
    
    enum DownloadError: Error{
        case WrongUrl
        case NoData
        case ParseError
    }
    /*
    //Do-Try-Catch içerisine almak istemiyorsam fonksiyonumu async yerine async throws şeklinde yazmalıyım.
    func downloadDataAsync(url: URL) async throws -> [CryptoModel]{
        
        let (data, response) = try await URLSession.shared.data(from: url)
        let currencies = try? JSONDecoder().decode([CryptoModel].self, from: data)
        return currencies ?? []
        
    }
     */
    
    func downloadDataContinuation(url: URL) async throws -> [CryptoModel]{
    //Continuation --> Güncel task'i suspend etmek(duraklatmak).Herhangi bir fonk. async olmasa bile async hale getirip istediğimiz zaman duraklatıp devam ettirebiliyoruz. Hatta manuel olarak devam ettireceğimiz yeri belirticez. Ama sistem karar veriyor buna.
        
        try await withCheckedThrowingContinuation({ continuation in
            
            //Continuation sayesinde async olmayan bir fonksiyonu async yapabiliyoruz.
            downloadData(url: url) { result in
                switch result{
                case.success(let cryptos):
                    continuation.resume(returning: cryptos ?? [])
                case.failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        })
    }
    
    
    func downloadData(url: URL, completion: @escaping (Result<[CryptoModel]?,DownloadError >) -> Void ){
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.WrongUrl))
            }
            
            guard let data = data, error == nil else {
                return completion(.failure(.NoData))
            }

            guard let currencies = try? JSONDecoder().decode([CryptoModel].self, from: data) else{
                return completion(.failure(.ParseError))
            }
            
            completion(.success(currencies))
            
            
        }.resume()
    }
     
}
