//
//  DoctorItem.swift
//  TestDoctorsApp
//
//  Created by Игорь Крысин on 16.08.2024.
//

import SwiftUI

struct DoctorItem: View {

    @Binding var item: Users
    @StateObject var contenVM = DoctorsVM()

    var body: some View {
        VStack(spacing: 15) {
            HStack(alignment: .top) {
                HStack(alignment: .top, spacing: 16){
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
                            if let ratings = item.ratings_rating , floor(ratings) <= 5 {
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
                                Text("стаж \(contenVM.dateExpirience(workExp: item.work_expirience)) лет")
                                    .foregroundStyle(.grayText)
                            } else {
                                Text("\(contenVM.giveSpecialization(specializationArr: item.specialization)) • стаж \(contenVM.dateExpirience(workExp: item.work_expirience)) лет")
                                    .foregroundStyle(.grayText)
                            }
                        }
                        Text("от \(contenVM.lessPrise(users: item)) ₽")
                            .font(.system(size: 16, weight: .semibold))
                        
                    }
                }
                Spacer()
                Button {
                    item.is_favorite?.toggle()
                } label: {
                    if item.is_favorite! {
                        Image(systemName: "heart.fill")
                           .resizable()
                           .frame(width: 20, height: 17.1)
                           .foregroundStyle(.myPink)
                    } else {
                        Image(systemName: "heart")
                            .resizable()
                            .frame(width: 20, height: 17.1)
                            .foregroundStyle(.gray)
                    }
                }
                .buttonStyle(PlainButtonStyle())


                
                

            }
            .frame(alignment: .top)
            .padding(.top, 16)
            Elements.makeAppointmentBtn(isHaveAppointment: !item.free_reception_time.isEmpty, action: ())
                .buttonStyle(PlainButtonStyle())

        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
    }
    
    
    
   
}


