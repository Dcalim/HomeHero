//
//  TasksView.swift
//  HomeHero
//
//  Created by Antonio conopio on 2025-10-25.
//

import SwiftUI
import ComponentsKit

struct TasksView: View {
    @EnvironmentObject var store: Store
    
    var profile: Profile {
        store.selectProfile()
    }
    
    
    enum Tab {
        case todo, shopping
    }
    
    @State private var selectedTab: Tab = .todo
    
    
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading){
                    Text("Welcome,")
                        .font(Font.title2.bold())
                    Text("\(profile.firstName)")
                        .font(Font.largeTitle.bold())
                    Text("Stay on top of your home tasks.")
                }
                Spacer()
            }
            .padding(10)
            
            SUCard(model: cardModel){
                VStack{
                    HStack {
                        VStack{
                            Button("To-do List") {
                                selectedTab = .todo
                            }
                            .foregroundColor(selectedTab == .todo ? .primary : .secondary)
                            TabIndicator(isActive: selectedTab == .todo)
                        }
                        
                        VStack{
                            Button("Shopping List") {
                                selectedTab = .shopping
                            }
                            .foregroundColor(selectedTab == .shopping ? .primary : .secondary)
                            TabIndicator(isActive: selectedTab == .shopping)
                        }
                        
                    }
                    .buttonStyle(.plain)
                    .animation(.easeInOut(duration: 0.25), value: selectedTab)
                    
                    ScrollView(.vertical, showsIndicators: false){
                        
                    }
                }
                
            }
            
            Spacer()
        }
        .padding(10)
    }
}

#Preview {
    TasksView()
}
