
import Foundation

extension Date {
	/// Return a random date based on the receiver's value.
	///
	/// - Parameters:
	///   - unit: The Component type (only year, month, day, hour, minute are valid) by which to offset the random date calculated. Defaults to day.
	///   - from: The value (based on the first parameter) to offset the start range for the random date. Negative values give you dates in the past, while positive values give you dates in the future. Defaults to today's date.
	///   - upto: The value (based on the first paramter) that will be the upper value for the random date calculated. Negative values give you dates before the start date, while positive values give you dates after the start date. Defaults to different values based on the first paramter.
	/// - Returns: A random date based on the parameters (or defaults)
	func random(unit: Calendar.Component = Calendar.Component.day, from: Int = 0, upto: Int = 0)-> Date?{
		// Get today
		let today = Date()
		// Get start date for random based on passed in value type
		let calendar  = Calendar(identifier: Calendar.Identifier.gregorian)
		guard let start = calendar.date(byAdding: unit, value: from, to: today) else {
			return today
		}
		let temp = calendar.dateComponents(in: TimeZone.current, from: start)
		var comps = DateComponents()
		// Get offset based on unit (allowing for defaults)
		var offset = upto
		switch unit {
		case Calendar.Component.year:
			// Year
			offset = (offset == 0 ? 99 : offset)
			
		case Calendar.Component.month:
			// Month
			offset = (offset == 0 ? 12 : offset)
			
		case Calendar.Component.day:
			// Day
			offset = (offset == 0 ? 30 : offset)
			
		case Calendar.Component.hour:
			// Hour
			offset = (offset == 0 ? 24 : offset)
			
		case Calendar.Component.minute:
			// Minute
			offset = (offset == 0 ? 60 : offset)
			
		default:
			// Non-supported unit, do nothing
			break
		}
		// Get random value, setting back to negative if necessary
		let random = offset.random()
		// Randomize all date components
		comps.year = temp.year! + 99.random()
		comps.month = 12.random() + 1
		if comps.month == 2 {
			comps.day = (isLeapYear() ? 29 : 28) + 1
		} else if [4, 6, 9, 11].contains(comps.month!) {
			comps.day = 30.random() + 1
		} else {
			comps.day = 31.random() + 1
		}
		comps.hour = 24.random() + 1
		comps.minute = 60.random() + 1
		// Set component to be randomized based on input parameter
		switch unit {
		case Calendar.Component.year:
			// Year
			comps.year = temp.year! + random
			
		case Calendar.Component.month:
			// Month
			comps.month = temp.month! + random
			
		case Calendar.Component.day:
			// Day
			comps.day = temp.day! + random
			
		case Calendar.Component.hour:
			// Hour
			comps.hour = temp.hour! + random
			
		case Calendar.Component.minute:
			// Minute
			comps.minute = temp.minute! + random
			
		default:
			// Non-supported unit, do nothing
			break
		}
		let date = calendar.date(from: comps)
		return date
	}
	
	func isLeapYear() -> Bool {
		let calendar  = Calendar(identifier: Calendar.Identifier.gregorian)
		let comps = calendar.dateComponents([.year], from: self)
		guard let year = comps.year else {
			return false
		}
		return ((year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0))
	}
}
