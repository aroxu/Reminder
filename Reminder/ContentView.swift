//
//  ContentView.swift
//  reminder
//
//  Created by 윤규도 on 2020/06/20.
//  Copyright © 2020 B1ackAnge1. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: Reminder.fetchAllItems()) var reminderDatas: FetchedResults<Reminder>

    @State private var showAddView = false
    
    let today = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
    
    var body: some View {
        NavigationView {
            List {
                ForEach(reminderDatas) { reminderData in
                    ReminderBean(title: reminderData.title, date: reminderData.date, sfdo: reminderData.startFromDayOne)
                }
                .onDelete { indexPath in
                    let target = self.reminderDatas[indexPath.first!]
                    self.moc.delete(target)
                    do {
                        try self.moc.save()
                    } catch {
                        print(error)
                    }
                }
            }
            .navigationBarTitle("할 일 목록")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {self.showAddView.toggle()}) {
                HStack {
                    Text("할 일 추가")
                    Image(systemName: "plus")
                }
            })
                .sheet(isPresented: $showAddView) {
                    AddReminderView().environment(\.managedObjectContext, self.moc)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
