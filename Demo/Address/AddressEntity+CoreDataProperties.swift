//
//  AddressEntity+CoreDataProperties.swift
//  
//
//  Created by Neosoft on 08/09/23.
//
//

import Foundation
import CoreData


extension AddressEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AddressEntity> {
        return NSFetchRequest<AddressEntity>(entityName: "AddressEntity")
    }

    @NSManaged public var address: String?
    @NSManaged public var landmark: String?
    @NSManaged public var city: String?
    @NSManaged public var zipcode: String?
    @NSManaged public var state: String?
    @NSManaged public var country: String?

}
