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
    
    @EnvironmentObject var store: Store
    
    @State private var hasHome: Bool = true
    @State private var isExpanded = false
    @State private var selectedDetent: PresentationDetent = .height(200)
    
    var profile: Profile {
        store.selectProfile()
    }
    
    enum Tab {
        case users, alerts, todo
    }
    
    @State private var selectedTab: Tab = .users
    

    var body: some View {
        ZStack(alignment: .bottom) {
            // Main content layer
            VStack {
                // Welcome stack and notification tray
                HStack {
                    VStack(alignment: .leading){
                        Text("Welcome,")
                            .font(Font.title2.bold())
                        Text("\(profile.firstName)")
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
                    if hasHome {
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
                                        .padding(3)
                                    }
                                }
                            }
                        }
                        .frame(height: 2 * geo.size.height / 3)  // Use full height
                    } else {
                        SUCard(model: cardModel) {
                            VStack {
                                Spacer()
                                Text("You are not in a home yet. \n Create one or join one!")
                                
                                Spacer()
                                Button(action: {
                                    
                                }) {
                                    Text("Create home")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .frame(height: 55)
                                        .frame(maxWidth: .infinity)
                                        .background(Color.white)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 50)
                                                .stroke(Color.gray, lineWidth: 2)
                                        )
                                        .cornerRadius(50)
                                }
                                
                                Button(action: {
                                    
                                }) {
                                    Text("Join home")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .frame(height: 55)
                                        .frame(maxWidth: .infinity)
                                        .background(Color.white)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 50)
                                                .stroke(Color.gray, lineWidth: 2)
                                        )
                                        .cornerRadius(50)
                                }
                            }
                        }
                        .frame(height: geo.size.height)
                    }
                }
                .padding(.bottom, 80)
                
                
                Spacer()
            }
            .padding(10)
            
            // Bottom sheet layer (overlaid on top)
            VStack(alignment: .leading, spacing: 0) {
                // Drag handle
                Capsule()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 40, height: 6)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 8)
                    .padding(.bottom, 8)
                
                
                Button(action: {
                    
                }) {
                    Text("Quick Add +")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        .cornerRadius(50)
                }
                .padding(.horizontal, 10)
                
                HStack {
                    
                    
                    
                    Button(action: {
                        
                    }) {
                        Image(systemName: "person.2")
                            .font(Font.title)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {
                        
                    }) {
                        Image(systemName: "house")
                            .font(Font.title)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding()
                
                
                Spacer()
            }
            .frame(height: isExpanded ? 500 : 250)
            .frame(maxWidth: .infinity)
            .background(
                UnevenRoundedRectangle(
                    topLeadingRadius: 20,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 20
                )
                .fill(Color.white)
                .shadow(color: .black.opacity(0.01), radius: 1, x: -3, y: -12)  // Left shadow
                    .shadow(color: .black.opacity(0.05), radius: 1, x: 1, y: -1)   // Right shadow
            )
            .padding(.horizontal, 10)
            .onTapGesture {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                    isExpanded.toggle()
                }
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    NavigationStack{
        HomeView()
    }
}
