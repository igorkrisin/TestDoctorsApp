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
    @State private var isPriceUp = false
    @State private var isExpipienceUp = false
    @State private var selectOption: SortOption? = nil
    
    
    
    private var networManager: NetworkProtocol = NetworkService()
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var filterDoctor: [Users] {
        if searchText.isEmpty {
            return contenVM.doctorsDataArray
        } else {
            
            return contenVM.doctorsDataArray.filter{
                $0.first_name?.contains(searchText) == true
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
                                CustomSortBtn(text: "По цене", backgroundColor: .white, textColor: .myLightGray, cornerRadius: 5, sortOption: .price, selectOption: selectOption, isArrowUp: isArrowUp,  action: {
                                    
                                    isArrowUp.toggle()
                                    selectOption = .price
                                    contenVM.sortByprice(doctors: contenVM, turn: isPriceUp)
                                    isPriceUp.toggle()
                                    
                                })
                                
                                CustomSortBtn(text: "По стажу", backgroundColor: .white, textColor: .myLightGray, cornerRadius: 5, sortOption: .expirience, selectOption: selectOption, isArrowUp: isArrowUp,  action: {
                                    
                                    isArrowUp.toggle()
                                    selectOption = .expirience
                                    contenVM.sortByExpirience(doctors: contenVM, turn: isExpipienceUp)
                                    isExpipienceUp.toggle()
                                    
                                })
                                
                                
                                CustomSortBtn(text: "По рейтингу", backgroundColor: .white, textColor: .myLightGray, cornerRadius: 5, sortOption: .rating, selectOption: selectOption, isArrowUp: isArrowUp,  action: {
                                    //                                    toggleSingLessMore(doctors: contenVM, turn: isRatingUp)
                                    isArrowUp.toggle()
                                    selectOption = .rating
                                    contenVM.toggleSort(in: &contenVM.doctorsDataArray, by: \Users.ratings_rating, ascending: isRatingUp)
                                    isRatingUp.toggle()
                                    
                                })
                                
                            }
                            .frame(maxWidth: .infinity)
                            
                        }
                        
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .navigationTitle("Педиатры")
                        
                        .padding(.horizontal, 20)
                        
                        .onAppear{
                            contenVM.getJsonData()
                            
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
                .searchable(text: $searchText, prompt: "Поиск")
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
    
}


#Preview {
    MainDoctorView()
}
