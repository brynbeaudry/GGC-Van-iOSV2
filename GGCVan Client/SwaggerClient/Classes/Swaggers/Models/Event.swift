//
// Event.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import EVReflection

//Converting String to date
//https://stackoverflow.com/questions/36861732/swift-convert-string-to-date

open class Event: EVObject {

    public var id: Int32 = 0
    public var title: String?
    public var creator: ApplicationUser = ApplicationUser
    public var startTime: Date = Date(fromDateTimeString: "")
    public var endTime: Date = Date(fromDateTimeString: "")
    public var latitude: Double = 0
    public var longitude: Double = 0
    public var description: String
    public var host: String
    public var locationDescription: String
    public var eventGuests: [EventGuest] = []
    public var gameId: Int32 = 0
    public var game: Game = Game()

    //public init() {}

}
