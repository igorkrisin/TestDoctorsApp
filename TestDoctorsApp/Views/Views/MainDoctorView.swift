//
//  ContentView.swift
//  TestDoctorsApp
//
//  Created by Игорь Крысин on 16.08.2024.
//

import SwiftUI

struct  MainDoctorView: View {
    
    @State private var searchText = ""
    @State private var isArrowUp = false
    @StateObject var contenVM = DoctorsVM()
    @State var selectionPage: String = "house.fill"
    @State private var isRatingUp = false
    
    
    
    private var networManager: NetworkProtocol = NetworkService()
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var filterDoctor: [Users] {
        if searchText.isEmpty {
            return contenVM.doctorsDataArray
        } else {
            
            return contenVM.doctorsDataArray.filter{
                $0.first_name?.localizedCaseInsensitiveContains(searchText) == true
            }
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectionPage) {
                NavigationStack {
                    VStack {
                        VStack{
                            HStack(spacing: 0){
                                Button {
                                    self.isArrowUp.toggle()
                                    print("по цене")
                                } label: {
                                    HStack{
                                        Text("По цене")
                                            .font(.system(size: 14, weight: .semibold))
                                        
                                        Image(systemName: isArrowUp ? "arrow.up" : "arrow.down")
                                            .resizable()
                                            .frame(maxWidth: 10, maxHeight: 10)
                                    }
                                }
                                //.padding()
                                .frame(maxWidth: .infinity, maxHeight: 32)
                                .foregroundStyle(.white)
                                .padding(.horizontal, 10)
                                .background(.myPink)
                                .clipShape(.rect(cornerRadius: 5))
                                
                                
                                CustomSortBtn(text: "По стажу", action: {
                                }, backgroundColor: .white, textColor: .myLightGray, cornerRadius: 5)
                                CustomSortBtn(text: "По рейтингу", action: {
                                    toggleSingLessMore(doctors: contenVM, turn: isRatingUp)
                                    isRatingUp.toggle()
                                    
                                }, backgroundColor: .white, textColor: .myLightGray, cornerRadius: 5)
                                
                            }
                            .frame(maxWidth: .infinity)
                            
                        }
                        .searchable(text: $searchText, prompt: "Поиск")
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .navigationTitle("Педиатры")
                        
                        .padding(.horizontal, 20)
                        
                        .onAppear{
                            contenVM.getData()
                        }
                        ScrollView {
                            LazyVStack(spacing: 20) { // Задаем отступы между ячейками
                                ForEach(filterDoctor.indices, id: \.self) { index in
                                    VStack {
                                        DoctorItem(item: $contenVM.doctorsDataArray[index])
                                    }
                                    .background(Color.white) // Устанавливаем фоновый цвет для ячейки
                                    .cornerRadius(8) // Добавляем скругление углов ячейки
                                    .padding(.horizontal) // Добавляем горизонтальные отступы для ячейки
                                }
                            }
                            .padding(.vertical, 20) // Отступы сверху и снизу для всего LazyVStack
                        }
                        .background(Color(.myLightGray)) // Общий фон для ScrollView
                        
                        
                    }
                    .background(.myLightGray)
                }
                .tabItem {
                }
                .tag("house.fill")
                ProfilePage(selectedTag: $selectionPage)
                    .tag("person.fill")
                MessagePage(selectedTag: $selectionPage)
                    .tag("message.fill")
                AppointmentPage(selectedTag: $selectionPage)
                    .tag("calendar")
                    
            }
            HStack {
                ForEach(contenVM.arrayTabView) { page in
                    Spacer()
                    TabViewItem(selectionPage: $selectionPage, page: page)
                    Spacer()
                    
                }
            }
            .padding(.bottom, 25)
            .padding(.top, 15)
            .background(.white)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        
        
    }
    
    
    func toggleSingLessMore(doctors: DoctorsVM, turn: Bool) {
        if turn {
            return doctors.doctorsDataArray.sort {
                $0.ratings_rating ?? 0 > $1.ratings_rating ?? 0
            }
        } else {
            return doctors.doctorsDataArray.sort {
                $0.ratings_rating ?? 0 < $1.ratings_rating ?? 0
            }
        }
    }
}

#Preview {
    MainDoctorView()
}
