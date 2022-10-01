//
//  Coin360View.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 01/10/2022.
//

import SwiftUI

struct Coin360View: View {
    var body: some View {
        WebView(url: "https://coin360.com/")
    }
}

struct Coin360View_Previews: PreviewProvider {
    static var previews: some View {
        Coin360View()
    }
}
