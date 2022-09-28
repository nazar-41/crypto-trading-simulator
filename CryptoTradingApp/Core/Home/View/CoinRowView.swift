//
//  CoinRowView.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 24/09/2022.
//
//test
import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    let showHoldingsColumn: Bool

    
    var body: some View {
        HStack(spacing: 0) {
            leftColumn
            Spacer()
            if showHoldingsColumn {
                centerColumn
            }
            rightColumn
        }
        .padding(.vertical, 1)
        .font(.subheadline)
        .background(
            Color.black.opacity(0.001)
        )

    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin: dev.coin, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)

            CoinRowView(coin: dev.coin, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}


extension CoinRowView {
    
    private var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(.black)
                .frame(minWidth: 30)
           // CoinImageView(coin: coin)
            Circle()
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(.black)
        }
    }
    
    private var centerColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundColor(Color.black)
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundColor(Color.black)
            
            HStack(spacing: 2){
                Image(systemName: (coin.priceChangePercentage24H ?? 0 >= 0) ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                    .foregroundColor((coin.priceChangePercentage24H ?? 0 >= 0) ? .green : .red)
                    .font(.system(size: 13, weight: .regular))
                
                Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                    .foregroundColor(
                        (coin.priceChangePercentage24H ?? 0 >= 0) ?
                        .green :
                        .red
                )
            }
        }
        .frame(width: UIScreen.main.bounds.width / 3, alignment: .trailing)
    }
}
