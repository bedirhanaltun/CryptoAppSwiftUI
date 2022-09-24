//
//  ContentView.swift
//  CryptoAppSwiftUI
//
//  Created by Bedirhan Altun on 24.09.2022.
//

import SwiftUI

struct Main: View {
    
    @ObservedObject var cryptoListViewModel: CryptoListViewModel
    
    let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
    
    init(){
        self.cryptoListViewModel = CryptoListViewModel()
    }
    
    var body: some View {
        
        NavigationView{
            
            List(cryptoListViewModel.cryptoList, id: \.id){ crypto in
                VStack{
                    Text(crypto.currency)
                        .font(.title3)
                        .foregroundColor(getRandomColor())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(crypto.price)
                        .foregroundColor(getRandomColor())
                        .frame(maxWidth:.infinity, alignment: .leading)
                }.toolbar(content: {
                    Button {
                        Task.init{
                            cryptoListViewModel.cryptoList = []
                            await cryptoListViewModel.downloadCryptoContinuation(url: url)
                        }
                        
                    } label: {
                        Text("Refresh")
                    }
                    
                })
                
                .navigationTitle("Crypto App")
            }
        }.task {
            await cryptoListViewModel.downloadCryptoContinuation(url: url)
        }
        /*
         .task {
         await cryptoListViewModel.downlaodCryptoAsync(url: url)
         }
         */
        /*
         .onAppear{
         cryptoListViewModel.downloadCrypto(url: url)
         
         }
         */
    }
}

func getRandomColor() -> Color {
    //Generate between 0 to 1
    let red:CGFloat = CGFloat(drand48())
    let green:CGFloat = CGFloat(drand48())
    let blue:CGFloat = CGFloat(drand48())
    
    return Color(red: red, green: green, blue: blue)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
