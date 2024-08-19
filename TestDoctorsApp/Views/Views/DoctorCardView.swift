//
//  DoctorCardView.swift
//  TestDoctorsApp
//
//  Created by Игорь Крысин on 18.08.2024.
//

import SwiftUI

struct DoctorCardView: View {
    var skill: Int = 12
    var rank: String = "Врач высшей категории"
    var university: String = "1-й ММИ им. И.М.Сеченова"
    var jobPlace: String = "Детская клиника “РебёнОК”"
    var price: Int = 600
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 16) {
                Image(.car)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(.circle)
                VStack(alignment: .leading) {
                    Text("secondName")
                        .font(.system(size: 16, weight: .semibold))
                        .lineLimit(1)
                    Text("firstName patronymic")
                        .font(.system(size: 16, weight: .semibold))
                        .lineLimit(1)
                }
               
            }
            VStack(alignment: .leading, spacing: 10) {
                HStack{
                    Image(systemName: "plus")
                    Text("Опыт работы: \(skill) лет")
                }
                HStack {
                    Image(systemName: "plus")
                    Text("\(rank)")
                }
                HStack{
                    Image(systemName: "plus")
                    Text("\(university)")
                }
                HStack{
                    Image(systemName: "plus")
                    Text("\(jobPlace)")
                }
            }
            .foregroundStyle(.gray)
            VStack{
                HStack {
                    Text("Стоимость услуг")
                    Spacer()
                    Text("от \(price) ₽")
                }
                .font(.system(size: 16, weight: .semibold))
                .padding(16)
                .frame(height: 60)
            }
            .background(.white)
            .frame(maxWidth: .infinity)
            .clipShape(.rect(cornerRadius: 8))
            
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.bordingGray, lineWidth: 1)
            )
            VStack{
                Text("Проводит диагностику и лечение терапевтических больных. Осуществляет расшифровку и снятие ЭКГ. Дает рекомендации по диетологии. Доктор имеет опыт работы в России и зарубежом. Проводит консультации пациентов на английском языке.")
            }
            .font(.system(size: 14, weight: .regular))
            .lineSpacing(12)
            Spacer()
            Elements.makeAppointmentBtn(isHaveAppointment: true, action: ())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.horizontal, 16)
        .background(.myLightGray)
        
    }
}

#Preview {
    DoctorCardView()
}
