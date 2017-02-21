//: Playground - noun: a place where people can play

import UIKit


let now = NSDate()
print(now)
now.timeIntervalSinceReferenceDate

// March 10, 1876 was 3,938,698,800 seconds before the third millennium (January 1, 2001 midnight UTC)
//let firstLandPhoneCallDate = NSDate(timeIntervalSinceReferenceDate: -3_938_698_800.0)

// April 3, 1973 was 875,646,000 seconds before the third millennium
//let firstCellPhoneCallDate = NSDate(timeIntervalSinceReferenceDate: -875_646_000.0)

// January 9, 2007, 18:00 UTC was 190,058,400 seconds after the third millennium
//let iPhoneAnnouncementDate = NSDate(timeIntervalSinceReferenceDate: 190_058_400.0)

// January 27, 2010, 18:00 UTC was 286,308,000 seconds after the third millennium
//let iPadAnnouncementDate = NSDate(timeIntervalSinceReferenceDate: 286_308_000.0)

// The user's calendar incorporates the user's locale and
// time zones settings, so we'll often use it.
let userCalendar = Calendar.current


// March 10, 1876
// In this case, we're using an NSDatesComponents instance
// to represent a date rather than a duration of time.
let firstLandPhoneCallDateComponents = NSDateComponents()

// We don't know the time when Alexander Graham Bell made
// his historic phone call, so we'll simply provide the
// year, month and day.
// We *do* know that he made that call in North America's
// eastern time zone, so we'll specify that.
firstLandPhoneCallDateComponents.year = 1876
firstLandPhoneCallDateComponents.month = 3
firstLandPhoneCallDateComponents.day = 10
firstLandPhoneCallDateComponents.timeZone = NSTimeZone(name: "US/Eastern") as TimeZone?

// We have a calendar and date components. We can now make a date!
// On my system (US/Eastern time zone), the result for the line below is
// "Mar 10, 1876, 12:00 AM"
let firstLandPhoneCallDate = userCalendar.date(from: firstLandPhoneCallDateComponents as DateComponents)


// April 3, 1973
let firstCellularPhoneCallDateComponents = NSDateComponents()
firstCellularPhoneCallDateComponents.year = 1973
firstCellularPhoneCallDateComponents.month = 4
firstCellularPhoneCallDateComponents.day = 3
firstCellularPhoneCallDateComponents.timeZone = NSTimeZone(name: "US/Eastern") as TimeZone?
// On my system (US/Eastern time zone), the result for the line below is
// "Apr 3, 1973, 12:00 AM"
let firstCellularPhoneCallDate = userCalendar.date(from:firstCellularPhoneCallDateComponents as DateComponents)!


// January 9, 2007, 18:00 UTC
let iPhoneAnnouncementDateComponents = NSDateComponents()
// We know that the "Stevenote" when the iPhone was announced
// started at 10:00 am Pacific time.
iPhoneAnnouncementDateComponents.year = 2007
iPhoneAnnouncementDateComponents.month = 1
iPhoneAnnouncementDateComponents.day = 9
iPhoneAnnouncementDateComponents.hour = 13
iPhoneAnnouncementDateComponents.minute = 0
iPhoneAnnouncementDateComponents.timeZone = NSTimeZone(name: "US/Eastern") as TimeZone?
// On my system (US/Eastern time zone), the result for the line below is
// "Jan 9, 2007, 1:00 PM"
let iPhoneAnnouncementDate = userCalendar.date(from: iPhoneAnnouncementDateComponents as DateComponents)!


// January 27, 2010, 18:00 UTC
// We know that the "Stevenote" when the iPad was announced
// started at 10:00 am Pacific time.
let iPadAnnouncementDateComponents = NSDateComponents()
iPadAnnouncementDateComponents.year = 2010
iPadAnnouncementDateComponents.month = 1
iPadAnnouncementDateComponents.day = 27
// Let's set the clock using Pacific Time
iPadAnnouncementDateComponents.hour = 10
iPadAnnouncementDateComponents.minute = 0
iPadAnnouncementDateComponents.timeZone = NSTimeZone(name: "US/Pacific") as TimeZone?
// On my system (US/Eastern time zone), the result for the line below is
// "Jan 27, 2010, 1:00 PM"
let iPadAnnouncementDate = userCalendar.date(from: iPadAnnouncementDateComponents as DateComponents)!
