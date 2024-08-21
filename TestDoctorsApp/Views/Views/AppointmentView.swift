//
//  DoctorCardView.swift
//  TestDoctorsApp
//
//  Created by Игорь Крысин on 18.08.2024.
//


import SwiftUI

struct AppointmentView: View {
    var timeAppointment: Int = 30
    var item: Users
    var contentmVM: DoctorsVM = DoctorsVM()
    
    
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 16){
                Text("Стоимость услуг")
                VStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 12){
                        Text("Видеоконсультация")
                            .font(.system(size: 16, weight: .semibold))
                        Elements.createPriceHstack(leftV: "\(timeAppointment) min", rightV: String(item.video_chat_price ?? 0))
                    }
                    VStack(alignment: .leading, spacing: 12){
                        Text("Чат с врачом")
                            .font(.system(size: 16, weight: .semibold))
                        Elements.createPriceHstack(leftV: "\(timeAppointment) min", rightV: String(item.text_chat_price ?? 0))
                    }
                    VStack(alignment: .leading, spacing: 12){
                        Text("Приём в клинике")
                            .font(.system(size: 16, weight: .semibold))
                        Elements.createPriceHstack(leftV: "В клинике", rightV: String(item.hospital_price ?? 0))
                    }
                   
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
           
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, 16)
        .background(.myLightGray)
        
    }
}


