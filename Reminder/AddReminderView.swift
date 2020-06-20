//
//  AddReminderView.swift
//  reminder
//
//  Created by 윤규도 on 2020/06/20.
//  Copyright © 2020 B1ackAnge1. All rights reserved.
//

import SwiftUI

struct AddReminderView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var date = Date()
    @State private var startFromDayOne = true
    
    @State private var showAlert = false
    
    var rangeWhenTrue: ClosedRange<Date> {
        var components: DateComponents {
            var limit = DateComponents()
            limit.year = 1972
            limit.month = 11
            limit.day = 21
            return limit
        }
        
        let min = Calendar.current.date(from: components)!
        return min...Date()
    }
    var rangeWhenFalse: ClosedRange<Date> {
        var components: DateComponents {
            var limit = DateComponents()
            limit.year = 3972
            limit.month = 11
            limit.day = 21
            return limit
        }
        
        let max = Calendar.current.date(from: components)!
        return Date()...max
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("제목")) {
                    TextField("디데이 제목", text: $title)
                }
                Section(header: Text("날짜 선택")) {
                    Toggle(isOn: $startFromDayOne) {
                        Text("1일부터 시작")
                    }
                    DatePicker(selection: $date, in: startFromDayOne ? rangeWhenTrue : rangeWhenFalse, displayedComponents: .date) {
                        Text("")
                    }.labelsHidden()
                }
            }
        .navigationBarTitle("디데이 추가")
            .navigationBarItems(leading: Button("취소") {
                self.presentationMode.wrappedValue.dismiss()
            }, trailing: Button("저장") {
                if self.title != "" {
                    let newReminder = Reminder(context: self.moc)
                    newReminder.title = self.title
                    newReminder.date = self.date
                    newReminder.startFromDayOne = self.startFromDayOne
                    
                    try? self.moc.save()
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.showAlert.toggle()
                }
            })
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("제목 없음"), message: Text("제목을 입력하세요."), dismissButton: .default(Text("확인")))
                }
        }
    }
}

struct AddReminderView_Previews: PreviewProvider {
    static var previews: some View {
        AddReminderView()
    }
}
