//
//  Family+CoreDataProperties.swift
//  CoreDataTestApp
//
//  Created by Brotecs on 13/1/21.
//
//

import Foundation
import CoreData


extension Family {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Family> {
        return NSFetchRequest<Family>(entityName: "Family")
    }

    @NSManaged public var name: String?
    @NSManaged public var people: Person?

}

extension Family : Identifiable {

}
