//
//  Reminder.swift
//  reminder
//
//  Created by 윤규도 on 2020/06/20.
//  Copyright © 2020 B1ackAnge1. All rights reserved.
//

import Foundation
import CoreData

public class Reminder: NSManagedObject, Identifiable {
    @NSManaged public var date: Date?
    @NSManaged public var title: String?
    @NSManaged public var startFromDayOne: Bool
}

extension Reminder {
    static func fetchAllItems() -> NSFetchRequest<Reminder> {
        let request: NSFetchRequest<Reminder> = Reminder.fetchRequest() as! NSFetchRequest<Reminder>
        
        request.sortDescriptors = [NSSortDescriptor(key: "startFromDayOne", ascending: true), NSSortDescriptor(key: "date", ascending: true)]
          
        return request
    }
}
