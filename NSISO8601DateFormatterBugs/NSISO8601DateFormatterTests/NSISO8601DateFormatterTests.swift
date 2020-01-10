//
//  NSISO8601DateFormatterTests.swift
//  NSISO8601DateFormatterTests
//
//  Created by Robin Kunde on 11/2/19.
//  Copyright © 2019 Recoursive. All rights reserved.
//

import Foundation
import XCTest

class NSISO8601DateFormatterTests: XCTestCase {
    private let date = Date(timeIntervalSince1970: 1577807769)
    private let tz = TimeZone(identifier: "UTC")!

    private func string(withOptions options: ISO8601DateFormatter.Options) -> String {
        return ISO8601DateFormatter.string(from: self.date, timeZone: self.tz, formatOptions: options)
    }

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWithYear() {
        // According to docs:
        // The date representation includes the year. The format for year is inferred based on the other specified options.
        // If withWeekOfYear is specified, YYYY is used.
        // Otherwise, yyyy is used.

        // By itself, yyyy should be used, but output is empty instead
        let options1: ISO8601DateFormatter.Options = [.withYear]
        XCTAssertEqual(string(withOptions: options1), "2019", "[.withYear] should return 2019 (yyyy)")

        // combine it with any other option, including one that doesn't affect output and it works correctly
        let options2: ISO8601DateFormatter.Options = [.withYear, .withColonSeparatorInTime]
        XCTAssertEqual(string(withOptions: options2), "2019", "[.withYear, .withColonSeparatorInTime] should return 2019 (yyyy)")

        let options3: ISO8601DateFormatter.Options = [.withYear, .withWeekOfYear]
        XCTAssertEqual(string(withOptions: options3), "2020W01", "[.withYear, .withWeekOfYear] should return 2020W01 (YYYY'W'ww)")
        let options4: ISO8601DateFormatter.Options = [.withYear, .withWeekOfYear, .withDashSeparatorInDate]
        XCTAssertEqual(string(withOptions: options4), "2020-W01", "[.withYear, .withWeekOfYear, .withDashSeparatorInDate] should return 2020-W01 (YYYY-'W'ww)")
        let options5: ISO8601DateFormatter.Options = [.withYear, .withWeekOfYear, .withDay]
        XCTAssertEqual(string(withOptions: options5), "2020W0102", "[.withYear, .withWeekOfYear, .withDay] should return 2020W0102 (YYYY'W'wwee)")
        let options6: ISO8601DateFormatter.Options = [.withYear, .withWeekOfYear, .withDay, .withDashSeparatorInDate]
        XCTAssertEqual(string(withOptions: options6), "2020-W01-02", "[.withYear, .withWeekOfYear, .withDay, .withDashSeparatorInDate] should return 2020-W01-02 (YYYY-'W'ww-ee)")
    }

    func testWithMonth() {
        // According to docs:
        // The date representation includes the month. The format for month is MM.

        // By itself, MM should be used, but output is empty instead
        let options1: ISO8601DateFormatter.Options = [.withMonth]
        XCTAssertEqual(string(withOptions: options1), "12", "[.withMonth] should return 11 (MM)")

        // combine it with any other option, including one that doesn't affect output and it works correctly
        let options2: ISO8601DateFormatter.Options = [.withMonth, .withColonSeparatorInTime]
        XCTAssertEqual(string(withOptions: options2), "12", "[.withMonth, .withColonSeparatorInTime] should return 12 (MM)")
    }

    func testWithDay() {
        // According to docs:
        // The date representation includes the day. The format for day is inferred based on provided options:
        // If withMonth is specified, dd is used.
        // If withWeekOfYear is specified, ee is used.
        // Otherwise, DDD is used.

        // By itself, DDD should be used, but output is empty instead
        let options1: ISO8601DateFormatter.Options = [.withDay]
        XCTAssertEqual(string(withOptions: options1), "365", "[.withDay] should return 365 (DDD)")

        // combine it with any other option, including one that doesn't affect output and it works correctly
        let options2: ISO8601DateFormatter.Options = [.withDay, .withColonSeparatorInTime]
        XCTAssertEqual(string(withOptions: options2), "365", "[.withDay, .withColonSeparatorInTime] should return 365 (DDD)")

        let options3: ISO8601DateFormatter.Options = [.withMonth, .withDay]
        XCTAssertEqual(string(withOptions: options3), "1231", "[.withMonth, .withDay] should return 1231 (MMdd)")

        let options4: ISO8601DateFormatter.Options = [.withWeekOfYear, .withDay]
        XCTAssertEqual(string(withOptions: options4), "W0102", "[.withWeekOfYear, .withDay] should return W0102 ('W'wwee)")
    }

    func testWithFullDate() {
        // According to docs:
        // The date representation includes the year, month, and day. Equivalent to specifying withYear, withMonth, and withDay

        // In contradiction of the docs, withFullDate seems to also include withDashSeparatorInDate. Should there be another option called "withDate"?
        let options1: ISO8601DateFormatter.Options = [.withFullDate]
        let str1 = string(withOptions: options1)
        XCTAssertEqual(str1, "20191231", "[.withFullDate] should return 20191231")

        let options2: ISO8601DateFormatter.Options = [.withYear, .withMonth, .withDay]
        let str2 = string(withOptions: options2)
        XCTAssertEqual(str2, "20191231", "[.withYear, .withMonth, .withDay] should return 20191231")

        XCTAssertEqual(str1, str2, "[.withFullDate] should be equivalent to [.withYear, .withMonth, .withDay]")
    }

    func testWithTime() {
        // According to docs:
        // The date representation includes the time. The format for time is HH:mm:ss.

        // Appears to be implemented as "HHmmss" instead, which makes sense given the existence of withFullTime.

        // By itself, HH:mm:ss should be used, but output is empty instead
        let options1: ISO8601DateFormatter.Options = [.withTime]
        let str1 = string(withOptions: options1)
        XCTAssertEqual(str1, "15:56:09", "[.withTime] should return 15:56:09 (HH:mm:ss)")

        // combine it with any other option, including one that doesn't affect output and it produces output, but the output is not as documented
        let options2: ISO8601DateFormatter.Options = [.withTime, .withDashSeparatorInDate]
        let str2 = string(withOptions: options2)
        XCTAssertEqual(str2, "15:56:09", "[.withTime, .withDashSeparatorInDate] should return 15:56:09 (HH:mm:ss)")

        let options3: ISO8601DateFormatter.Options = [.withTime, .withColonSeparatorInTime]
        let str3 = string(withOptions: options3)
        XCTAssertEqual(str3, "15:56:09", "[.withTime, .withDashSeparatorInDate] should return 15:56:09 (HH:mm:ss)")
    }

    func testWithFullTime() {
        // According to docs:
        // The date representation includes the hour, minute, and second.

        // Appears to be implemented as [.withTime, .withColonSeparatorInTime, .withTimeZone, .withColonSeparatorInTimeZone] instead.

        // The docs mention nothing about withTimeZone or withColonSeparatorInTime, but they are included
        let options1: ISO8601DateFormatter.Options = [.withFullTime]
        let str1 = string(withOptions: options1)
        XCTAssertEqual(str1, "15:56:09Z", "[.withFullTime]")

        let options2: ISO8601DateFormatter.Options = [.withTime, .withColonSeparatorInTime, .withTimeZone, .withColonSeparatorInTimeZone]
        let str2 = string(withOptions: options2)
        XCTAssertEqual(str1, "15:56:09Z", "[.withTime, .withColonSeparatorInTime, .withTimezone, .withColonSeparatorInTimeZone]")

        XCTAssertEqual(str1, str2, "[.withFullTime] is equivalent to [.withTime, .withColonSeparatorInTime, .withTimezone, .withColonSeparatorInTimeZone]")

        let options3: ISO8601DateFormatter.Options = [.withFullTime]
        let str3 = ISO8601DateFormatter.string(from: self.date, timeZone: TimeZone(abbreviation: "PST")!, formatOptions: options3)
        XCTAssertEqual(str3, "07:56:09-08:00", "[.withFullTime] PST")

        let options4: ISO8601DateFormatter.Options = [.withTime, .withColonSeparatorInTime, .withTimeZone, .withColonSeparatorInTimeZone]
        let str4 = ISO8601DateFormatter.string(from: self.date, timeZone: TimeZone(abbreviation: "PST")!, formatOptions: options4)
        XCTAssertEqual(str4, "07:56:09-08:00", "[.withTime, .withColonSeparatorInTime, .withTimeZone, .withColonSeparatorInTimeZone] PST")

        XCTAssertEqual(str3, str4, "[.withFullTime] is equivalent to [.withTime, .withColonSeparatorInTime, .withTimezone, .withColonSeparatorInTimeZone]")
    }

    func testWithTimezone() {
        // According to docs:
        // The date representation includes the timezone. The format for timezone is ZZZZZ.

        // By itself, ZZZZZ should be used, but output is empty instead
        let options1: ISO8601DateFormatter.Options = [.withTimeZone]
        let str1 = string(withOptions: options1)
        XCTAssertEqual(str1, "Z", "[.withTimeZone] should return Z (ZZZZZ)")

        // combine it with any other option, including one that doesn't affect output and it works correctly
        let options2: ISO8601DateFormatter.Options = [.withTimeZone, .withDashSeparatorInDate]
        let str2 = string(withOptions: options2)
        XCTAssertEqual(str2, "Z", "[.withTimeZone, .withDashSeparatorInDate] should return Z (ZZZZZ)")

        // According to http://www.unicode.org/reports/tr35/tr35-31/tr35-dates.html#Date_Format_Patterns, "ZZZZZZ" should include colons
        // but that would make withColonSeparatorInTimeZone redundant, so it appears the actual format used is "Z" when the timezone is not GMT/UTC.
        let options3: ISO8601DateFormatter.Options = [.withTimeZone, .withDashSeparatorInDate]
        let str3 = ISO8601DateFormatter.string(from: self.date, timeZone: TimeZone(abbreviation: "PST")!, formatOptions: options3)
        XCTAssertEqual(str3, "-0800", "[.withTimeZone] returns -0800 (Z)")

        let options4: ISO8601DateFormatter.Options = [.withTimeZone, .withColonSeparatorInTimeZone]
        let str4 = ISO8601DateFormatter.string(from: self.date, timeZone: TimeZone(abbreviation: "PST")!, formatOptions: options4)
        XCTAssertEqual(str4, "-08:00", "[.withTimeZone, .withColonSeparatorInTimeZone] should return -08:00 (ZZZZZ)")
    }

    func testWithInternetDateTime() {
        // According to docs:
        // The format used for internet date times, according to the RFC 3339 standard.
        // Equivalent to specifying withFullDate, withFullTime, withDashSeparatorInDate, withColonSeparatorInTime, and withColonSeparatorInTimeZone.

        let options1: ISO8601DateFormatter.Options = [.withInternetDateTime]
        let str1 = string(withOptions: options1)
        XCTAssertEqual(str1, "2019-12-31T15:56:09Z", "[.withInternetDateTime] should return 2019-12-31T15:56:09Z")

        let options2: ISO8601DateFormatter.Options = [.withFullDate, .withFullTime, .withDashSeparatorInDate, .withColonSeparatorInTime, .withColonSeparatorInTimeZone]
        let str2 = string(withOptions: options2)
        XCTAssertEqual(str2, "2019-12-31T15:56:09Z", "[.withFullDate, .withFullTime, .withDashSeparatorInDate, .withColonSeparatorInTime, .withColonSeparatorInTimeZone] should return 2019-12-31T15:56:09Z")

        XCTAssertEqual(str1, str2, "[.withInternetDateTime] should be equivalent to [.withFullDate, .withFullTime, .withDashSeparatorInDate, .withColonSeparatorInTime, .withColonSeparatorInTimeZone]")

        let options3: ISO8601DateFormatter.Options = [.withInternetDateTime]
        let str3 = ISO8601DateFormatter.string(from: self.date, timeZone: TimeZone(abbreviation: "PST")!, formatOptions: options3)
        XCTAssertEqual(str3, "2019-12-31T07:56:09-08:00", "[.withInternetDateTime] should return 2019-12-31T07:56:09-08:00")

        let options4: ISO8601DateFormatter.Options = [.withFullDate, .withFullTime, .withDashSeparatorInDate, .withColonSeparatorInTime, .withColonSeparatorInTimeZone]
        let str4 = ISO8601DateFormatter.string(from: self.date, timeZone: TimeZone(abbreviation: "PST")!, formatOptions: options4)
        XCTAssertEqual(str4, "2019-12-31T07:56:09-08:00", "[.withFullDate, .withFullTime, .withDashSeparatorInDate, .withColonSeparatorInTime, .withColonSeparatorInTimeZone] should return 2019-12-31T07:56:09-08:00")

        XCTAssertEqual(str3, str4, "[.withInternetDateTime] should be equivalent to [.withFullDate, .withFullTime, .withDashSeparatorInDate, .withColonSeparatorInTime, .withColonSeparatorInTimeZone]")
    }

    func testWithSpaceBetweenDateAndTime() {
        let options1: ISO8601DateFormatter.Options = [.withFullDate, .withFullTime, .withSpaceBetweenDateAndTime]
        let str1 = string(withOptions: options1)
        XCTAssertEqual(str1, "2019-12-31 15:56:09Z", "[.withFullDate, .withFullTime, .withSpaceBetweenDateAndTime] should return 2019-12-31 15:56:09Z")

        let options2: ISO8601DateFormatter.Options = [.withFullDate, .withFullTime, .withSpaceBetweenDateAndTime]
        let str2 = ISO8601DateFormatter.string(from: self.date, timeZone: TimeZone(abbreviation: "PST")!, formatOptions: options2)
        XCTAssertEqual(str2, "2019-12-31 07:56:09-08:00", "[.withFullDate, .withFullTime, .withSpaceBetweenDateAndTime] should return 2019-12-31 07:56:09-08:00")
    }

    func testWithFractionalSeconds() {
        // Undocumented, so I'll just include current behavior here

        let options1: ISO8601DateFormatter.Options = [.withTime, .withFractionalSeconds]
        let str1 = string(withOptions: options1)
        XCTAssertEqual(str1, "155609.000", "[.withTime, .withFractionalSeconds] returns 155609.000")

        let options2: ISO8601DateFormatter.Options = [.withFullTime, .withFractionalSeconds]
        let str2 = string(withOptions: options2)
        XCTAssertEqual(str2, "15:56:09.000Z", "[.withFullTime, .withFractionalSeconds] returns 15:56:09.000Z")
    }

    func testDocumentationExample() {
        // testing example from documentation, even though the options contain redundancies

        let formatter = ISO8601DateFormatter()
        let str1 = formatter.string(from: self.date)

        let GMT = TimeZone(abbreviation: "GMT")!
        let options1: ISO8601DateFormatter.Options = [.withInternetDateTime, .withDashSeparatorInDate, .withColonSeparatorInTime, .withTimeZone]
        let str2 = ISO8601DateFormatter.string(from: self.date, timeZone: GMT, formatOptions: options1)

        XCTAssertEqual(str1, str2, "hmmm")
    }

    func testDefaultValue() {
        // Default value for the formatOptions property is not documented, so I'm including a test for current behavior

        let options: ISO8601DateFormatter.Options = [.withYear, .withMonth, .withDay, .withTime, .withTimeZone, .withDashSeparatorInDate, .withColonSeparatorInTime, .withColonSeparatorInTimeZone]
        let formatter = ISO8601DateFormatter()
        XCTAssertEqual(options, formatter.formatOptions, "Default value for formatOptions should be equivalent to [.withYear, .withMonth, .withDay, .withTime, .withTimeZone, .withDashSeparatorInDate, .withColonSeparatorInTime, .withColonSeparatorInTimeZone]")
    }
}
