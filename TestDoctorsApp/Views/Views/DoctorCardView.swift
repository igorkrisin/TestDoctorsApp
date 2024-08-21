//
//  DoctorCardView.swift
//  TestDoctorsApp
//
//  Created by Игорь Крысин on 18.08.2024.
//

import SwiftUI

struct DoctorCardView: View {
    
    var item: Users
    var contentVM = DoctorsVM()
    
    var jobPlace: String = "Детская клиника “РебёнОК”"

    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .center){
                Text(contentVM.giveSpecialization(user: item))
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 10)
            .padding(.top, 100)
                .multilineTextAlignment(.center)
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
                        .foregroundStyle(.gray)
                }
                VStack(alignment: .leading) {
                    Text(item.last_name ?? "")
                        .font(.system(size: 16, weight: .semibold))
                        .lineLimit(1)
                    Text("\(String(describing: item.first_name ?? "")) \(String(describing: item.patronymic ?? ""))")
                        .font(.system(size: 16, weight: .semibold))
                        .lineLimit(1)
                }
               
            }
            
            VStack(alignment: .leading, spacing: 10) {
                HStack{
                    Image(.clockIcon)
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("Опыт работы: \(contentVM.dateExpirience(users: item)) лет")
                }
                HStack {
                    Image(.caseIcon)
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("\(contentVM.giveSpecialization(user: item))")
                }
                HStack{
                    Image(.hatIcon)
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("\(contentVM.giveEducationTypeLabel(users: item))")
                }
                HStack{
                    Image(.locationIcon)
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("\(jobPlace)")
                }
            }
            .foregroundStyle(.gray)
            Elements.createPriceHstack(leftV: "Стоимость услуг", rightV: String(contentVM.lessPrise(users: item)), weightFont: .semibold)
           
            VStack{
                Text("Проводит диагностику и лечение терапевтических больных. Осуществляет расшифровку и снятие ЭКГ. Дает рекомендации по диетологии. Доктор имеет опыт работы в России и зарубежом. Проводит консультации пациентов на английском языке.")
            }
            .font(.system(size: 14, weight: .regular))
            .lineSpacing(12)
            Spacer()
            NavigationLink{
                if !item.free_reception_time.isEmpty {
                    AppointmentView(item: item)
                    
                }
            } label: {
            Text(!item.free_reception_time.isEmpty ? "Записаться" : "Нет свободного расписания")
                .frame(maxWidth: .infinity)
                .frame(height: 47)
                .background(!item.free_reception_time.isEmpty ? Color.myPink : Color.bordingGray)
                .foregroundColor(!item.free_reception_time.isEmpty ? .white : .black)
                .font(.system(size: 16, weight: .semibold))
                .clipShape(.rect(cornerRadius: 8))
                .padding(.bottom, 100)
            
        }
        .disabled(item.free_reception_time.isEmpty)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.horizontal, 16)
        .background(.myLightGray)
        .ignoresSafeArea()
        
    }
}


