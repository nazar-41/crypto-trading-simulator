//
//  CreatorView.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 27/09/2022.
//

import SwiftUI

struct CreatorView: View {
    var body: some View {
            VStack(spacing: 20){
                
                
                Text("more info here...")
                
//                Text("* Junior iOS application developer at [Belli Creative Studio](https://www.bellicreative.com/)")
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .multilineTextAlignment(.leading)
//                    .font(.headline)


//                HStack{
//                    Text("Email: ")
//                        .frame(width: 80, alignment: .leading)
//                        .border(.blue)
//
//                    Text("nazarwelkakayew41@gmail.com")
//
//                }
//
//                HStack{
//                    Text("Github: ")
//                        .frame(width: 80, alignment: .leading)
//                        .border(.blue)
//
//                    Text("[https://github.com/NazarWelkakayew...)](https://github.com/NazarWelkakayew)")
//
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .border(.green)
//
//                HStack{
//                    Text("Linkedin: ")
//                        .frame(width: 80, alignment: .leading)
//                        .border(.blue)
//
//                    Text("[https://www.linkedin.com/in/nazar-velkakayev...](https://www.linkedin.com/in/nazar-velkakayev-254511235/)")
//                }
//
                
                
//                Text("* Github      :    [https://github.com/NazarWelkakayew...)](https://github.com/NazarWelkakayew)")
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .multilineTextAlignment(.leading)
//
//                Text("* Linkedin   :    [https://www.linkedin.com/in/nazar-velkakayev...](https://www.linkedin.com/in/nazar-velkakayev-254511235/)")
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .multilineTextAlignment(.leading)

                
                Spacer()
                
            }
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top)
            .navigationTitle("Contact")
            .padding(.horizontal)
            .accentColor(.orange)
            // .navigationBarTitleDisplayMode(.inline)
    }
}

struct CreatorView_Previews: PreviewProvider {
    static var previews: some View {
        CreatorView()
    }
}
