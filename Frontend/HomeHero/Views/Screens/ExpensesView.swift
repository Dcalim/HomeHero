//
//  ExpensesView.swift
//  HomeHero
//
//  Created by Antonio conopio on 2025-10-25.
//

import SwiftUI
import ComposableArchitecture

struct ExpensesView: View {
    let store: StoreOf<AppFeature>
    
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading){
                    Text("Welcome,")
                        .font(Font.title2.bold())
                    Text("\(store.config.data.profile.firstName)")
                        .font(Font.largeTitle.bold())
                    Text("Track and split your home expenses.")
                }
                Spacer()
            }
            .padding(10)
            
            
            Spacer()
        }
        .padding(10)
    }
}

#Preview {
    ExpensesView(store: HomeHeroApp.store)
}
