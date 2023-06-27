//
//  Item+CoreDataProperties.swift
//  ToDoList
//
//  Created by Kateřina Černá on 27.06.2023.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var timestamp: Date?
    @NSManaged public var title: String?
    @NSManaged public var itemDescription: String?
    @NSManaged public var state: String?
    @NSManaged public var attachments: NSObject?
    @NSManaged public var latLocation: Double
    @NSManaged public var longLocation: Double

}

extension Item : Identifiable {

}
