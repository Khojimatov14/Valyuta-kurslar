//
//  SettingsView.swift
//  cinemaUZ
//
//  Created by Anvarjon Khojimatov on 2022/04/21.
//

import SwiftUI

struct SettingsView: View {
    
    var body: some View {
        Form {
            Section {
                VStack {
                    Image("bankLogoPNG")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 10)
                        .background(Color("grayOpacityWhite"))
                        .cornerRadius(10)
                    
                    Text("    O‘zbekiston Respublikasi Markaziy banki valyuta operatsiyalari bo‘yicha buxgalteriya hisobi, statistik va boshqa hisobotlarni yuritish, shuningdek bojxona va boshqa majburiy to‘lovlar uchun xorijiy valyutalarning so‘mga nisbatan ushbu qiymatini belgiladi. \n    Valyuta qiymatini belgilash chog‘ida O‘zbekiston Respublikasi Markaziy banki mazkur valyutalarni ushbu qiymatda sotish yoki sotib olish majburiyatini olmagan.")
                    
                        .font(.callout)
                }
                .padding(.vertical, 10)
                
                HStack {
                    Text("Veb sayt: ")
                    Spacer()
                    Link(destination: URL(string: "https://cbu.uz/uz/")!, label: {
                        HStack {
                            Text("cbu.uz")
                            Image(systemName: "link")
                        }
                    })
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
            
            Section {
                HStack {
                    Text("versiya:")
                    Spacer()
                    Text("1.0")
                }
                
                HStack {
                    Text("dasturchi:")
                    Spacer()
                    Text(verbatim: "khojimatov14@gmail.com")
                        .font(.callout)
                        
                }
            }
        }
        .navigationTitle("Malumotlar")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
