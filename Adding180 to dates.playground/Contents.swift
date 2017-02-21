//: Playground - noun: a place where people can play

import UIKit

// The user's calendar incorporates the user's locale and
// time zone settings, which means it's the one you'll use
// most often.
let userCalendar = Calendar.current

// Let's create a Date for the start of the Stevenote
// where the iPhone was introduced (January 9, 2007, 10:00:00 Pacific time)
// using DateComponents.
var iPhoneStevenoteDateComponents = DateComponents()
iPhoneStevenoteDateComponents.year = 2007
iPhoneStevenoteDateComponents.month = 1
iPhoneStevenoteDateComponents.day = 9
iPhoneStevenoteDateComponents.hour = 10
iPhoneStevenoteDateComponents.timeZone = TimeZone(abbreviation: "PST")
let iPhoneStevenoteDate = userCalendar.date(from: iPhoneStevenoteDateComponents)!

// Let's create a Date for the start of the Stevenote
// where the iPad was introduced (January 27, 2010, 10:00:00 Pacific time)
// using DateFormatter.
var dateMakerFormatter = DateFormatter()
dateMakerFormatter.calendar = userCalendar
dateMakerFormatter.dateFormat = "MMM d, yyyy, hh:mm a zz"
let iPadStevenoteDate = dateMakerFormatter.date(from: "Jan 27, 2010, 10:00 AM PST")!

// Does Valentine's Day come BEFORE St. Patrick's Day?
//valentinesDay < stPatricksDay   // true

// Does Valentine's Day come AFTER St. Patrick's Day?
//valentinesDay > stPatricksDay   // false

// Does St. Patrick's Day come BEFORE Valentine's Day?
//stPatricksDay < valentinesDay   // false

// Did the iPhone Stevenote come BEFORE the iPad Stevenote?
iPhoneStevenoteDate < iPadStevenoteDate   // true

// Did the iPhone Stevenote come AFTER the iPad Stevenote?
iPhoneStevenoteDate > iPadStevenoteDate   // false

// Did the iPad Stevenote come BEFORE the iPhone Stevenote?
iPadStevenoteDate < iPhoneStevenoteDate   // false

// Does the iPad Stevenote come AFTER the iPhone Stevenote?
iPadStevenoteDate > iPhoneStevenoteDate   // true

// Do the iPhone Stevenote and the iPad Stevenote fall on DIFFERENT dates?
iPhoneStevenoteDate == iPadStevenoteDate  // false

// Do the iPhone Stevenote and the iPad Stevenote fall on the SAME date?
iPhoneStevenoteDate != iPadStevenoteDate  // true

// And just for kicks, some trivial comparisons.
iPhoneStevenoteDate == iPhoneStevenoteDate  // true
iPadStevenoteDate == iPadStevenoteDate  // true

// Number of seconds between the iPhone Stevenote and the iPad Stevenote
iPhoneStevenoteDate.timeIntervalSince(iPadStevenoteDate)  // -96249600

// Number of seconds between the iPad Stevenote and the iPhone Stevenote
iPadStevenoteDate.timeIntervalSince(iPhoneStevenoteDate)  // 96249600


let daysBetweenStevenotes = userCalendar.dateComponents([.day],
                                                        from: iPhoneStevenoteDate,
                                                        to: iPadStevenoteDate)
daysBetweenStevenotes.day!  // 1114

// The result in the sidebar should be:
// day: 1114 isLeapMonth: false


// The result in the sidebar should be:
// weekOfYear: 159 isLeapMonth: false
let weeksBetweenStevenotes = userCalendar.dateComponents([.weekOfYear],
                                                         from: iPhoneStevenoteDate,
                                                         to: iPadStevenoteDate)
weeksBetweenStevenotes.weekOfYear!  // 159


// The result in the sidebar should be:
// year: 3 month: 0 day: 18 hour: 0 minute: 0 isLeapMonth: false
let yearsMonthsDaysHoursMinutesBetweenStevenotes = userCalendar.dateComponents([.year, .month, .day, .hour, .minute],
                                                                               from: iPhoneStevenoteDate,
                                                                               to: iPadStevenoteDate)
yearsMonthsDaysHoursMinutesBetweenStevenotes.year!    // 3
yearsMonthsDaysHoursMinutesBetweenStevenotes.month!   // 0
yearsMonthsDaysHoursMinutesBetweenStevenotes.day!     // 18
yearsMonthsDaysHoursMinutesBetweenStevenotes.hour!    // 0
yearsMonthsDaysHoursMinutesBetweenStevenotes.minute!  // 0


// What's the last day of a 180-day warranty that starts today?
userCalendar.date(byAdding: .day, value: 180, to: Date())  // 180 days from now


// What time will it be 4 hours and 30 minutes from now?
// First, we need to define a DateComponents struct representing
// a time interval of 4 hours and 30 minutes
var fourHoursThirtyMinutes = DateComponents()
fourHoursThirtyMinutes.hour = 4
fourHoursThirtyMinutes.minute = 30

// Now add the interval to the Date
let fourHoursThirtyMinutesFromNow = userCalendar.date(byAdding: fourHoursThirtyMinutes, to: Date()) // 4 hours and 30 minutes from now

// What time was it 4 hours and 30 minutes ago?
var minusFourHoursThirtyMinutes = DateComponents()
minusFourHoursThirtyMinutes.hour = -4
minusFourHoursThirtyMinutes.minute = -30
let fourHoursThirtyMinutesAgo = userCalendar.date(byAdding: fourHoursThirtyMinutes, to: Date()) // 4 hours and 30 minutes ago


// Let's define some Dates relative to iPhoneStevenoteDate
let iPhoneStevenotePlusOneSecond = userCalendar.date(byAdding: .second, value: 1, to: iPhoneStevenoteDate)!
let iPhoneStevenotePlusFiveMinutes = userCalendar.date(byAdding: .minute, value: 5, to: iPhoneStevenoteDate)!
let iPhoneStevenotePlusThreeHours = userCalendar.date(byAdding: .hour, value: 3, to: iPhoneStevenoteDate)!

// This returns false, because iPhoneStevenoteDate and iPhoneStevenotePlusOneSecond
// are NOT both within the same SECOND.
userCalendar.compare(iPhoneStevenoteDate,
                     to: iPhoneStevenotePlusOneSecond,
                     toGranularity: .second)
    == .orderedSame

// This returns true, because iPhoneStevenoteDate comes one second BEFORE
// iPhoneStevenotePlusOneSecond, and we're comparing the two at the one-second
// level of granularity.
userCalendar.compare(iPhoneStevenoteDate,
                     to: iPhoneStevenotePlusOneSecond,
                     toGranularity: .second)
    == .orderedAscending

// This returns true, because iPhoneStevenoteDate and iPhoneStevenotePlusOneSecond
// ARE both within the same MINUTE.
userCalendar.compare(iPhoneStevenoteDate,
                     to: iPhoneStevenotePlusOneSecond,
                     toGranularity: .minute)
    == .orderedSame

// This returns true, because iPhoneStevenoteDate and iPhoneStevenotePlusFiveMinutes
// ARE both within the same HOUR.
userCalendar.compare(iPhoneStevenoteDate,
                     to: iPhoneStevenotePlusFiveMinutes, toGranularity: .hour)
    == .orderedSame

// This returns true, because iPhoneStevenotePlusFiveMinutes comes 5 minutes AFTER
// iPhoneStevenoteDate, and we're comparing the two at the one-minute level
// of granularity.
userCalendar.compare(iPhoneStevenotePlusFiveMinutes,
                     to: iPhoneStevenoteDate,
                     toGranularity: .minute)
    == .orderedDescending

// This returns true, because iPhoneStevenoteDate and iPhoneStevenotePlusThreeHours
// ARE both within the same DAY.
userCalendar.compare(iPhoneStevenoteDate,
                     to: iPhoneStevenotePlusThreeHours,
                     toGranularity: .day)
    == .orderedSame

