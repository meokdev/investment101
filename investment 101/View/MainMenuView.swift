

import SwiftUI
import XCAStocksAPI

struct MainMenuView: View {
    @State private var selectedTab: Int = 0
    @StateObject var appVM = AppViewModel()
    
    @State private var showCourseWalkthrough = !UserDefaults.standard.bool(forKey: "hasViewedCourseWalkthrough")
    @State private var showStockWalkthrough = !UserDefaults.standard.bool(forKey: "hasViewedStockWalkthrough")
    var body: some View {
        
        TabView(selection: $selectedTab) {
            //courses
            NavigationStack{
                UnitsView()
            }
            .tabItem {
                Image(systemName: "book.fill")
                Text("Learn")
            }
            .sheet(isPresented: $showCourseWalkthrough) {
                CourseTutorialView()
            }
            
            .tag(0)
            //stockview
            NavigationStack{
                redirectview()
                    .onAppear()
            }
            .environmentObject(appVM)
            .tabItem {
                Image(systemName: "chart.bar.fill")
                Text("Stocks")
            }
            .sheet(isPresented: $showStockWalkthrough) {
                StockTutorialView()
            }
            
            .tag(1)
            
            NavigationStack{
                //profile view
                profile2()
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }
            
            .tag(2)
        }
        .navigationBarBackButtonHidden(true)
    }
}

//struct MainMenuView: View {
//    @State private var selectedTab = 1
//    
//
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 0) {
//                Spacer()
//                
//                switch selectedTab {
//                case 0:
//                    MainListView()
//                        .navigationTitle("Profile")
//                case 1:
//                    UnitsView()
//                        .navigationTitle("Courses")
//                default:
//                    EmptyView()
//                }
//                
//                Spacer()
//                
//                HStack {
//                    Spacer()
//                    TabBarButton(imageName: "person.fill", text: "Profile", isSelected: selectedTab == 0) {
//                        selectedTab = 0
//                    }
//                    .foregroundColor(selectedTab == 0 ? .primary : .gray) // Gray when not selected
//                        
//                    Spacer()
//                    Spacer()
//
//                    TabBarButton(imageName: "book.fill", text: "Courses", isSelected: selectedTab == 1) {
//                        selectedTab = 1
//                    }
//                    .foregroundColor(selectedTab == 1 ? .primary : .gray) // Gray when not selected
//                    Spacer()
//
//                }
//                .padding(.horizontal)
//                .padding(.vertical, 10)
//                .background(Color.white.shadow(radius: 2))
//            }
//            .edgesIgnoringSafeArea(.bottom)
//            
//            
//        }
//        .navigationBarHidden(true)
//        .navigationBarBackButtonHidden(true)
//    }
//}


//struct TabBarButton: View {
//    let imageName: String
//    let text: String
//    let isSelected: Bool
//    let action: () -> Void
//    
//    var body: some View {
//        Button(action: action) {
//            VStack(spacing: 4) {
//                Image(systemName: imageName)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 20, height: 20)
//                
//                Text(text)
//                    .font(.caption)
//                    .foregroundColor(isSelected ? .blue : .gray)
//            }
//            .padding(.vertical, 6)
//        }
//        .navigationBarHidden(true)
//        .navigationBarBackButtonHidden(true)
//    }
//}

struct MainMenuView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainMenuView()
    }
}
