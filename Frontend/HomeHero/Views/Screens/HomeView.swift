//
//  HomeView.swift
//  HomeHero
//
//  Created by Antonio conopio on 2025-10-25.
//

import SwiftUI
import ComponentsKit

let cardModel = CardVM {
    $0.borderWidth = .none
    $0.cornerRadius = .small
    $0.shadow = .small
    $0.backgroundColor = .white
}

let rommateCardModel = CardVM {
    $0.borderWidth = .none
    $0.cornerRadius = .small
    $0.shadow = .small
    $0.backgroundColor = .white
}

let mockUsers: [Roomate] = [
        Roomate(
            name: "John Doe",
            imageURL: "person.circle.fill",
            status: .online,
            location: .home,
            leader: .leader
        ),
        Roomate(
            name: "Jane Smith",
            imageURL: "person.circle.fill",
            status: .online,
            location: .away,
            leader: .member
        ),
        Roomate(
            name: "Mike Johnson",
            imageURL: "person.circle.fill",
            status: .offline,
            location: .home,
            leader: .member
        )
    ]

struct HomeView: View {

//    let user: AppUser?
//    let homeName: String?
    
    enum Tab {
        case users, alerts, todo
    }
    
    @State private var selectedTab: Tab = .users
    

    var body: some View {
        VStack {
            // Welcome stack and notifcation tray
            HStack {
                VStack(alignment: .leading){
                    Text("Welcome,")
                        .font(Font.title2.bold())
                    Text("User")
                        .font(Font.largeTitle.bold())
                    Text("Here whats happening at home today.")
                }
                
                Spacer()
                
                NavigationLink{
                    NotificationsView()
                }label: {
                    Image(systemName: "tray")
                        .foregroundStyle(Color(.black))
                        .font(Font.title3.bold())
                }
                
                
                
            }
            .padding(10)
            
            GeometryReader{ geo in
                // My home card
                SUCard(model: cardModel) {
                    VStack (alignment: .leading){
                        
                        // Title + Homename
                        HStack{
                            Text("My Home")
                                .font(Font.title3.bold())
                            Spacer()
                            Text("Homename")
                                .font(Font.headline)
                                .foregroundStyle(Color(.gray))
                        }
                        .padding(2)
                        .padding(.bottom, 15)
                        
                        
                        // Tabs
                        HStack {
                            VStack{
                                Button("Users") {
                                    selectedTab = .users
                                }
                                .foregroundColor(selectedTab == .users ? .primary : .secondary)
                                TabIndicator(isActive: selectedTab == .users)
                            }

                            VStack{
                                Button("Alerts") {
                                    selectedTab = .alerts
                                }
                                .foregroundColor(selectedTab == .alerts ? .primary : .secondary)
                                TabIndicator(isActive: selectedTab == .alerts)
                            }

                                
                            VStack{
                                Button("To Do") {
                                    selectedTab = .todo
                                }
                                .foregroundColor(selectedTab == .todo ? .primary : .secondary)
                                TabIndicator(isActive: selectedTab == .todo)
                            }
                        }
                        .buttonStyle(.plain)
                        .animation(.easeInOut(duration: 0.25), value: selectedTab)
                            

                        
                        Divider()
                        ScrollView{
                            ForEach(mockUsers) { user in
                                SUCard(model:rommateCardModel){
                                    HStack{
                                        Image(systemName: user.imageURL)
                                            .font(Font.largeTitle)
                                        VStack (alignment: .leading){
                                            HStack{
                                                Text(user.name)
                                                    .font(.title3.bold())
                                                if (user.leader == .leader){
                                                    Image(systemName: "crown")
                                                        .font(Font.caption.bold())
                                                }
                                            }
                                            
                                            
                                            Text(user.location.rawValue)
                                                .font(.caption.bold())
                                                .foregroundStyle(Color(.gray))
                                        }
                                        Spacer()
                                        if user.status == .online{
                                            Circle()
                                                .foregroundStyle(Color(.green))
                                                .frame(width: 10, height: 10)
                                        }
                                        else {
                                            Circle()
                                                .foregroundStyle(Color(.red))
                                                .frame(width: 10, height: 10)
                                        }
                                    }
                                }
                                .padding(5)
                            }
                        }
                        
                    }
                }
                .frame(height: 2 * geo.size.height / 3)
                
            }
            Spacer()
        }
        
        .padding(10)
        
    }
}

#Preview {
    NavigationStack{
        HomeView()
    }
}
