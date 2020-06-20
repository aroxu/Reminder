//
//  ReminderBean.swift
//  reminder
//
//  Created by 윤규도 on 2020/06/20.
//  Copyright © 2020 B1ackAnge1. All rights reserved.
//

import SwiftUI

struct ReminderBean: View{
    let title:String?
    let date:Date?
    let sfdo:Bool
    let today = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title ?? "D-Day")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                Text(dateFormatter.string(from: date!))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            if sfdo {
                Text("D+\(self.calcDate(date: date) + 1)")
                    .font(.system(size: 22))
            } else {
                if self.calcDate(date: date) < 0 {
                    Text("D\(self.calcDate(date: date))")
                        .font(.system(size: 22))
                } else if self.calcDate(date: date) == 0 {
                    Text("D-Day")
                        .font(.system(size: 22))
                } else {
                    Text("D+\(self.calcDate(date: date))")
                        .font(.system(size: 22))
                }
            }
        }
    }
    
    func calcDate(date: Date?) -> Int {
        return date!.totalDistance(from: self.today!, resultIn: .day)!
    }
}

struct ReminderBean_Previews: PreviewProvider {
    static var previews: some View {
        ReminderBean(title: "title", date: Date(), sfdo: true)
            .previewLayout(.fixed(width: 375, height: 50))
    }
}
