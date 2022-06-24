//
//  ConverterView.swift
//  Valyuta kurslari
//
//  Created by Anvarjon Khojimatov on 2022/05/18.
//

import SwiftUI

struct ConverterView: View {
    
    @StateObject var viewModel = ViewModel()
    @State var firstCurrency = ""
    @State var secondCurrency = "100"
    @State var showPicker = false
    @State var pickerName = "USD"
    @FocusState var nameIsFocused: Bool
    @State var changeUZS = false
    
    var body: some View {
        Section {
            VStack(alignment: .leading, spacing: 9) {
                if changeUZS {
                    HStack {
                        viewModel.number(secondCurrency: secondCurrency, pickerName:pickerName, changeUZS: changeUZS)
                            .font(.title2)
                        Spacer()
                        Divider()
                            .padding(.vertical, -16)
                        HStack(alignment: .center) {
                            Menu {
                                Picker(selection: $pickerName, label: EmptyView()) {
                                    ForEach(flags) { i in
                                        Text("\(i.flag)  \(i.currency)")
                                            .tag(i.currency)
                                    }
                                }
                            } label: {
                                HStack(spacing: 4) {
                                    Text(viewModel.textFieldLabel(name: pickerName))
                                        .font(.title)
                                    Text(pickerName)
                                    
                                    Image(systemName: "chevron.down")
                                        .font(.caption)
                                }
                                .foregroundColor(Color("blackWhite"))
                                
                            }
                            
                        }.animation(nil)
                        
                    }
                    .padding()
                    .padding(.trailing, -6)
                    .overlay(RoundedRectangle(cornerRadius:10).stroke(Color.gray.opacity(0.5)))
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            self.secondCurrency = "100"
                            changeUZS.toggle()
                        }, label: {
                            Image(systemName: "arrow.up.arrow.down")
                        })
                        .font(.title2)
                        .buttonStyle(BorderedButtonStyle())
                        Spacer()
                    }
                    
                    HStack {
                        TextField(secondCurrency, text: $secondCurrency)
                            .font(.title2)
                            .keyboardType(.decimalPad)
                            .focused($nameIsFocused)
                        Divider()
                            .padding(.vertical, -16)
                        HStack {
                            Text("🇸🇱")
                                .font(.title)
                            Text("UZS   ")
                        }
                        
                    }
                    .padding()
                    .padding(.trailing, -6)
                    .overlay(RoundedRectangle(cornerRadius:10).stroke(Color.gray.opacity(0.5)))
                }
                else {
                    HStack {
                        viewModel.number(secondCurrency: secondCurrency, pickerName:pickerName, changeUZS: changeUZS)
                            .font(.title2)
                        Spacer()
                        Divider()
                            .padding(.vertical, -16)
                        HStack {
                            Text("🇸🇱")
                                .font(.title)
                            Text("UZS   ")
                        }
                    }
                    .padding()
                    .padding(.trailing, -6)
                    .overlay(RoundedRectangle(cornerRadius:10).stroke(Color.gray.opacity(0.5)))
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            self.secondCurrency = "100000"
                            changeUZS.toggle()
                        }, label: {
                            Image(systemName: "arrow.up.arrow.down")
                        })
                        .font(.title2)
                        .buttonStyle(BorderedButtonStyle())
                        Spacer()
                    }
                    
                    HStack {
                        TextField(secondCurrency, text: $secondCurrency)
                            .font(.title2)
                            .keyboardType(.decimalPad)
                            .focused($nameIsFocused)
                            
                        Divider()
                            .padding(.vertical, -16)
                        HStack(alignment: .center) {
                            Menu {
                                Picker(selection: $pickerName, label: EmptyView()) {
                                    ForEach(flags) { i in
                                        Text("\(i.flag)  \(i.currency)")
                                            .tag(i.currency)
                                    }
                                }
                            } label: {
                                HStack(spacing: 4) {
                                    Text(viewModel.textFieldLabel(name: pickerName))
                                        .font(.title)
                                    Text(pickerName)
                                    
                                    Image(systemName: "chevron.down")
                                        .font(.caption)
                                        .foregroundColor(.blue)
                                }
                                .foregroundColor(Color("blackWhite"))
                                
                            }
                            
                        }.animation(nil)
                    }
                    .padding()
                    .padding(.trailing, -6)
                    .overlay(RoundedRectangle(cornerRadius:10).stroke(Color.gray.opacity(0.5)))
                }
            }
            .padding(.vertical)
        }
    }
}

struct ConverterView_Previews: PreviewProvider {
    static var previews: some View {
        ConverterView()
    }
}
