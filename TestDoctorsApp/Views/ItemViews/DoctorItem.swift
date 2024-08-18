//
//  DoctorItem.swift
//  TestDoctorsApp
//
//  Created by Игорь Крысин on 16.08.2024.
//

import SwiftUI

struct DoctorItem: View {
    
    var jobTitle = "Педиатор"
    var price = 600
    var isHaveAppointment: Bool = false
    @Binding var item: Users
    
    
    
    var expirience = 12
    
    var body: some View {
        VStack(spacing: 15) {
            HStack(alignment: .top) {
                HStack(alignment: .top, spacing: 16){
//                    Image(.car)
//                        .resizable()
//                        .frame(width: 50, height: 50)
//                        .clipShape(.circle)
                    if let urlString = item.avatar, let url = URL(string: urlString) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(.circle)
                            
                        }
                    placeholder: {
                        ProgressView()
                    }
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(.circle)
                            .foregroundStyle(.myLightGray)
                    }
                    VStack(alignment: .leading) {
                        
                        if let secondName = item.last_name{
                            Text(secondName)
                                .font(.system(size: 16, weight: .semibold))
                                .lineLimit(1)
                        }
                        if let firstName = item.first_name, let patronymic = item.patronymic {
                            Text("\(firstName) \(patronymic)")
                                .font(.system(size: 16, weight: .semibold))
                                .lineLimit(1)
                        }
                        
                        HStack {
                            if let ratings = item.ratings_rating , ratings <= 5 {
                                ForEach(0..<Int(ratings), id: \.self) { _ in
                                    
                                    Image(.orangeStar)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 12, height: 12)
                                    
                                }
                                ForEach(0..<5 - Int(ratings), id: \.self) { _ in
                                    
                                    Image(.grayStar)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 12, height: 12)
                                    
                                }
                            }
                           
                        }
                        HStack {
                            if item.work_expirience.isEmpty {
                                Text("")
                                    .foregroundStyle(.grayText)
                            } else if item.specialization.isEmpty {
                                Text("стаж \(dateExpirience(workExp: item.work_expirience)) лет")
                                    .foregroundStyle(.grayText)
                            } else {
                                Text("\(giveSpecialization(specializationArr: item.specialization)) • стаж \(dateExpirience(workExp: item.work_expirience)) лет")
                                    .foregroundStyle(.grayText)
                                
                            }
                           
                            
                        }
                        Text("от \(lessPrise(users: item)) ₽")
                            .font(.system(size: 16, weight: .semibold))
                        
                    }
                }
                Spacer()
                Button {
                    item.is_favorite?.toggle()
                } label: {
                        Image(systemName: "heart")
                           .resizable()
                           .frame(width: 20, height: 17.1)
                           .foregroundStyle(item.is_favorite ?? false ? .myPink : .myLightGray)
                }
                .buttonStyle(PlainButtonStyle())


                
                

            }
            .frame(alignment: .top)
            .padding(.top, 16)
            Elements.makeAppointmentBtn(isHaveAppointment: !item.free_reception_time.isEmpty, action: print("Apointment btn"))
                .buttonStyle(PlainButtonStyle())

        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
    }
    
    func dateExpirience(workExp: [WorkExp?]) -> Int {
        var summ = 0
        for date in workExp {
            
            guard let date = date, let startDate = date.start_date, let endDate = date.end_date else { return 0 }
            summ += endDate - startDate
        }
        return summ / 31556925
    }
    
    func giveSpecialization(specializationArr: [Specialization?]) -> String {
        for specialization in specializationArr {
            guard let spepecialization = specialization?.name else { return ""}
            return spepecialization
        }
        return ""
    }
    
    func lessPrise(users: Users) -> Int {
       
        guard let videoPrice = users.video_chat_price, let chatPrice = users.text_chat_price, let hospitalPrise = users.home_price else { return 0}
        let priceArray: [Int] = [chatPrice, hospitalPrise]
        var lessPrice = videoPrice
        
        for price in priceArray {
            if price < lessPrice {
                lessPrice = price
            }
        }
        
        return lessPrice
    }
    
}


