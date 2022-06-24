//
//  ViewModel.swift
//  Valyuta
//
//  Created by Anvarjon Khojimatov on 2022/05/06.
//

import Foundation
import SwiftUI

struct FlagModel: Identifiable, Hashable {
    var id = UUID()
    var currency: String
    var flag: String
}

struct ValyutaModel: Hashable, Codable {
    var id: Int
    var Code: String
    var Ccy: String
    var CcyNm_RU: String
    var CcyNm_UZ: String
    var CcyNm_UZC: String
    var CcyNm_EN: String
    var Nominal: String
    var Rate: String
    var Diff: String
    var Date: String

}

struct ValyutaModelChange: Hashable {
    var id: Int
    var Ccy: String
    var Nominal: String
    var Rate: String
    var Diff: String
    var Date: String
    var Flag: String
    var Color: Color
    var Image: String
    var CcyNm_UZ: String
    
}

class ViewModel: ObservableObject {
    @Published var valyutalar: [ValyutaModel] = []
    
    func fetch() {
        guard let url = URL(string: "https://cbu.uz/en/arkhiv-kursov-valyut/json/") else {
            return
        }
         
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let valyutalar = try JSONDecoder().decode([ValyutaModel].self, from: data)
                DispatchQueue.main.async {
                    self.valyutalar = valyutalar
                    
                }
            }
            catch {
                print(error)
            }

        }
        task.resume()
    }
    
    func change(ccy: String) -> Double {
        var bat = 0.0
        for i in valyutaChange() {
            if i.Ccy == ccy {
                bat = Double(i.Rate)!
                break
            }
        }
        return bat
    }
    
    func textFieldLabel(name: String) -> String {
        var bat = ""
        for i in flags {
            if name == i.currency {
                bat = "\(i.flag)"
                break
            }
        }
        return bat
    }
    
    func changeData() -> String {
        var changeData = ""
        for i in valyutalar {
            changeData = i.Date
            break
        }
        return changeData
    }
    
    func valyutaChange() -> [ValyutaModelChange] {
        fetch()
        var fetchingValyuta = [ValyutaModelChange]()
        for i in valyutalar {
            var flag = ""
            let checkDiff = Float(i.Diff)!
            var diff = ""
            var color = Color.red
            var changeimage = ""
            if checkDiff < 0 {
                diff = "\(i.Diff)"
                color = Color.red
                changeimage = "arrow.down.forward"
            } else if checkDiff == 0 {
                diff = "\(i.Diff)"
                color = Color.gray
                changeimage = "minus"
            } else {
                diff = "+\(i.Diff)"
                color = Color.green
                changeimage = "arrow.up.forward"
            }
                
            for item in flags {
                if i.Ccy == item.currency {
                    flag = item.flag
                }
            }
            fetchingValyuta.append(ValyutaModelChange(id: i.id,
                                                      Ccy: i.Ccy,
                                                      Nominal: i.Nominal,
                                                      Rate: i.Rate,
                                                      Diff: diff,
                                                      Date: i.Date,
                                                      Flag: flag,
                                                      Color: color,
                                                      Image: changeimage,
                                                      CcyNm_UZ: i.CcyNm_UZ
                                                     )
            )
            flag = ""
            diff = ""
            color = Color.red
        }
        return fetchingValyuta
    }
    
    func number(secondCurrency: String, pickerName: String, changeUZS: Bool) -> Text {
        guard let firstCurrency = Double(secondCurrency) else {
            return Text("0")
                .font(.title2)
                .foregroundColor(.secondary)
        }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        if changeUZS {
            return Text(numberFormatter.string(from: NSNumber(value: firstCurrency / change(ccy: pickerName)))!)
        } else {
            return Text(numberFormatter.string(from: NSNumber(value: firstCurrency * change(ccy: pickerName)))!)
        }
    }
}
