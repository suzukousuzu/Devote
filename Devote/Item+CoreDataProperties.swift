//
//  Item+CoreDataProperties.swift
//  Devote
//
//  Created by 鈴木航太 on 2024/02/21.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var task: String?
    @NSManaged public var timestamp: Date?

}

extension Item : Identifiable {

}
