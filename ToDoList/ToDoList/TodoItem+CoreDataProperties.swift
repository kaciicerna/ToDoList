//
//  TodoItem+CoreDataProperties.swift
//  ToDoList
//
//  Created by Kateřina Černá on 27.06.2023.
//
//

import Foundation
import CoreData


extension TodoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoItem> {
        return NSFetchRequest<TodoItem>(entityName: "TodoItem")
    }

    @NSManaged public var dueDate: Date?
    @NSManaged public var title: String?
    @NSManaged public var itemDescription: String?
    @NSManaged public var state: Bool
    @NSManaged public var attachments: NSObject?
    @NSManaged public var latLocation: Double
    @NSManaged public var longLocation: Double

}

extension TodoItem : Identifiable {

}
