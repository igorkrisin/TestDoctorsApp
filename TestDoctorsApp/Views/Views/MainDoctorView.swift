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
    @State var selectionPage: String = ""
    
    private var networManager: NetworkProtocol = NetworkService()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectionPage) {
                NavigationStack {
                    VStack {
                        VStack{
                            HStack(spacing: 0){
                                Button {
                                    self.isArrowUp.toggle()
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
                                
                                
                                Elements.makeBtn(text: "По стажу", action: print("btn pressed"))
                                Elements.makeBtn(text: "По рейтингу", action: print("btn "))
                                
                            }
                            .frame(maxWidth: .infinity)
                            
                        }
                        .searchable(text: $searchText, prompt: "Поиск")
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .navigationTitle("Педиатры")
                        
                        //            .toolbar {
                        //                ToolbarItem(placement: .principal) {
                        //                    Text("Педиатры")
                        //                        .font(.system(size: 24, weight: .light))
                        //                }
                        //            }
                        .padding(.horizontal, 20)
                        
                        .onAppear{
                            contenVM.getData()
                        }
                        ScrollView {
                            LazyVStack(spacing: 20) { // Задаем отступы между ячейками
                                ForEach(contenVM.doctorsDataArray.indices, id: \.self) { index in
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
                .tag("home")
            }
            HStack {
                VStack {
                    Button {
                        //
                    } label: {
                        Image(.houseTabBar)
                    }
                    Text("Главная")
                        .foregroundStyle(.myPink)
                }
                VStack {
                    Button {
                        //
                    } label: {
                        Image(.houseTabBar)
                    }
                    Text("Главная")
                        .foregroundStyle(.myPink)
                }
                VStack {
                    Button {
                        //
                    } label: {
                        Image(.houseTabBar)
                    }
                    Text("Главная")
                        .foregroundStyle(.myPink)
                }
                VStack {
                    Button {
                        //
                    } label: {
                        Image(.houseTabBar)
                    }
                    Text("Главная")
                        .foregroundStyle(.myPink)
                }

            }
            .padding(.bottom, 15)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
       

    }
}

#Preview {
    MainDoctorView()
}
