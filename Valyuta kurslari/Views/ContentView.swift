//
//  ContentView.swift
//  Valyuta
//
//  Created by Anvarjon Khojimatov on 2022/05/05.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var monitor = NetworkMonitor()
    @StateObject var viewModel = ViewModel()
    @State var isProgress = false
    @FocusState var nameIsFocused: Bool
    @State private var showToast = false
    @State private var toastText = "No text"
    @State private var ToastCurrency = "No text"
    @State var changeUZS = false
    

    var body: some View {
        NavigationView {
            if !monitor.isConnected && viewModel.valyutalar.isEmpty {
                VStack {
                    Image(systemName: "wifi.slash")
                        .font(.system(size: 70))
                        .offset(y: -70)
                    Text("Qurilmangizda internet yoqilmagan!!!")
                }
            } else {
                ZStack {
                    List {
                        ConverterView(nameIsFocused: _nameIsFocused)
                        
                        Section("O'zgarishlar vaqti: \(viewModel.changeData())") {
                            ForEach(viewModel.valyutaChange(), id:\.self) { valyuta in
                                HStack {
                                    Text(valyuta.Flag)
                                        .font(.system(size: 50))
                                        .shadow(color: .gray, radius: 3)
                                    VStack(alignment: .leading, spacing: 5) {
                                        HStack(spacing: 5) {
                                            Text("\(valyuta.Nominal)  \(valyuta.Ccy)")
                                                .font(.title3)
                                                .fontWeight(.bold)
                                            Text("= \(valyuta.Rate)")
                                                .fontWeight(.semibold)
                                            
                                            Text("so'm")
                                                .font(.callout)
                                            Spacer()
                                            
                                        }
                                        Text(valyuta.Diff)
                                            .font(.system(size: 16))
                                            .foregroundColor(valyuta.Color)
                                        
                                    }
                                    Image(systemName: valyuta.Image)
                                        .foregroundColor(valyuta.Color)
                                        .font(.title2)
                                }
                                .onTapGesture() {
                                    withAnimation(.easeInOut) {
                                        toastText = valyuta.CcyNm_UZ
                                        ToastCurrency = valyuta.Ccy
                                        showToast.toggle()
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .navigationTitle("Valyuta kurslari")
                    .navigationBarItems(trailing: NavigationLink(destination: {
                        SettingsView()
                    }, label: {
                        Image(systemName: "info.circle")
                    })
                    )
                    .onTapGesture {
                        nameIsFocused = false
                    }
                    if viewModel.valyutalar.isEmpty {
                        ProgressView()
                    }
                    
                    VStack {
                        Spacer()
                        HStack {
                            if showToast {
                                Text(ToastCurrency)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding(.vertical, 8)
                                
                                Text(toastText)
                            }
                            
                        }
                        .frame(minWidth: 0, maxWidth: 300)
                        .background(Color("whiteGray"))
                        .cornerRadius(10)
                        .shadow(color:Color("grayWhite"), radius: 3)
                    
                    }
                }
                .onChange(of: showToast) { newValue in
                    if newValue {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation(.easeInOut) {
                                showToast.toggle()
                            }
                        }
                        
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
