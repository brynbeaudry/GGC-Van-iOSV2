//
// EventGuest.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import EVReflection

open class EventGuest: EVObject {

    public var eventId: Int32 = 0
    public var event: Event = Event();
    public var guestId: String = ""
    public var guest: ApplicationUser = ApplicationUser()

    //public init() {}

}
