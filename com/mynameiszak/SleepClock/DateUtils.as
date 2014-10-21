package com.mynameiszak.SleepClock {
	
	public class DateUtils
	{
		private static var tempDate:Date;
		
		public function DateUtils()
		{
			tempDate = new Date();
		}
		
		public static function getNumMonths(theStartDate:Date, theEndDate:Date):int{
			var numYears:int = theEndDate.getFullYear() - theStartDate.getFullYear();
			var startMonth:int = theStartDate.getMonth();
			var endMonth:int = theEndDate.getMonth();
			var yearMonths:int = (numYears - 1) * 12;
			if(numYears < 1){
				yearMonths = 0;
			}
			var numMonths:int;
			if(numYears > 1){
				numMonths = yearMonths + (12 - startMonth) + endMonth;
			} else if (numYears == 1) {
				numMonths = endMonth - startMonth + 12;
			} else if (numYears == 0) {
				numMonths = endMonth - startMonth;
			}
			numMonths = numMonths + 1; //makes the number inclusive, ie. January to January is 13 months inclusive, 13 months displayed
			return numMonths;
		}
		
		public static function getNumDays(theStartDate:Date, theEndDate:Date):int{
			var numDays:int = 0;
			var numMonths:int = getNumMonths(theStartDate, theEndDate);
			var startDay:int = theStartDate.getDate();
			var startMonth:int = theStartDate.getMonth();
			var startYear:int = theStartDate.getFullYear();
			var endDay:int = theEndDate.getDate();
			var endMonth:int = theEndDate.getMonth();
			var endYear:int = theEndDate.getFullYear();
			var currentMonth:int = startMonth;
			var currentYear:int = theStartDate.getFullYear();
			if(startMonth == endMonth && startYear == endYear){
				numDays = endDay - startDay;
			} else {
				for(var i:uint = 0; i < numMonths; i++){
					if(currentMonth == endMonth && currentYear == endYear){
						numDays = numDays+endDay;
					} else if(currentMonth == startMonth && currentYear == startYear){
						numDays = numDays+(getDaysInMonth(currentMonth,currentYear) - startDay);
					} else {
						numDays = numDays + getDaysInMonth(currentMonth,currentYear);
					}
					//trace(currentMonth + ", " + currentYear + " = numDays = " + numDays);
					if(currentMonth == 11){
						currentMonth = 0;
						currentYear++;
					} else {
						currentMonth++;
					}
				}
			}
			numDays++;
			return numDays;
		}
		
		public static function getNumHours(theStartDate:Date, theEndDate:Date):Number{
			var time:Number = theEndDate.time - theStartDate.time;
			var numHours:Number = Math.floor((((time*.001)/60)/60));
			return numHours;
		}
		
		public static function getNumMinutes(theStartDate:Date, theEndDate:Date):Number{
			var time:Number = theEndDate.time - theStartDate.time;
			var numMinutes:Number = Math.floor(((time*.001)/60));
			return numMinutes;
		}
		
		public static function getNumSeconds(theStartDate:Date, theEndDate:Date):Number{
			var time:Number = theEndDate.time - theStartDate.time;
			var numSeconds:Number = time * .001;
			return numSeconds;
		}	
		
		public static function getDaysInMonth(theMonth:int, theYear:int):int {
			var monthNum:int = 0;
			var intYear:int = theYear;
			var leapYear:Boolean = isLeapYear(intYear);
			switch (theMonth) {
				case 0:
					monthNum = 31;
					break;
				case 1:
					if (leapYear) {
						monthNum = 29;
					} else {
						monthNum = 28;
					}
					break;
				case 2:
					monthNum = 31;
					break;
				case 3:
					monthNum = 30;
					break;
				case 4:
					monthNum = 31;
					break;
				case 5:
					monthNum = 30;
					break;
				case 6:
					monthNum = 31;
					break;
				case 7:
					monthNum = 31;
					break;
				case 8:
					monthNum = 30;
					break;
				case 9:
					monthNum = 31;
					break;
				case 10:
					monthNum = 30;
					break;
				case 11:
					monthNum = 31;
					break;
				default :
					trace("DateUtils:GetDaysInMonth - Error - Month: " + theMonth + ", Year: " + theYear);
					break;
			}
			return monthNum;
		}
				
		public static function getDayOfWeek(date:int, month:int, year:int):int{
			tempDate.date = date;
			tempDate.month = month;
			tempDate.fullYear = year;
			return tempDate.day;
		}
		
		private static function isLeapYear(year:int):Boolean{
			if (year % 4 == 0) {
				if (year % 100 == 0) {
					if (year % 400) {
						return true;
					} else {
						return false;
					}
				} else {
					return true;
				}
			} else {
				return false;
			}
		}
		
		public static function getCenterDate(sDate:Date,eDate:Date):Date{
			var cDate:Date = new Date();
			var splitTime:Number = (eDate.time - sDate.time) * .5;
			cDate.time = sDate.time + splitTime;
			return cDate; 
		}
		
		//Time Functions
		
		public static function setToMidnight(sDate:Date):Date{
			var returnDate:Date = new Date();
			returnDate.time = sDate.time;
			returnDate.hours = 0;
			returnDate.minutes = 0;
			returnDate.seconds = 0;
			returnDate.milliseconds = 0;
			return returnDate;
		}
		
		public static function setToNoon(sDate:Date):Date{
			var returnDate:Date = new Date();
			returnDate.time = sDate.time;
			returnDate.hours = 12;
			returnDate.minutes = 0;
			returnDate.seconds = 0;
			returnDate.milliseconds = 0;
			return returnDate;
		}
		
		//Increment Functions
		
		public static function incrementByYear(sDate:Date, amount:int = 1):Date{
			var returnDate:Date = new Date();
			returnDate.time = sDate.time;
			returnDate.fullYear = sDate.fullYear + amount;
			trace("sDate year = " + sDate.fullYear + ", eDate year = " + returnDate.fullYear);
			return returnDate;
		}
		
		public static function incrementByMonth(sDate:Date, amount:int = 1):Date{
			var returnDate:Date = new Date();
			returnDate.time = sDate.time;
			var date:int = sDate.getDate();
			var month:int = sDate.getMonth();
			var year:int = sDate.getFullYear();
			var lastDay:Boolean;
			if(date == getDaysInMonth(month,year)){
				lastDay = true;
			} else {
				lastDay = false;
			}
			if(amount > 0){
				for(var i:uint = 0; i < amount; i++){
					month++;
					if(month > 11){
						month = 0;
						year++;
					}
					if(lastDay){
						date = getDaysInMonth(month,year);
					}
				}
			} else if(amount < 0){
				for(var j:int = 0; j > amount; j--){
					month--;
					if(month < 0){
						month = 11;
						year--;
					}
					if(lastDay){
						date = getDaysInMonth(month,year);
					}
				}
			}
			returnDate.setFullYear(year,month,date);
			return returnDate;
		}
		
		public static function incrementByDay(sDate:Date, amount:int = 1):Date{
			var returnDate:Date = new Date();
			returnDate.time = sDate.time;
			var day:int = sDate.getDate();
			var month:int = sDate.getMonth();
			var year:int = sDate.getFullYear();
			var monthDays:int = getDaysInMonth(month, year);
			if(amount > 0){
				for(var i:uint = 0; i < amount; i++){
					day++;
					if(day > monthDays){
						day = 1;
						month++;
						if(month > 11){
							month = 0;
							year++;
						}
						monthDays = getDaysInMonth(month, year);
					}
				}
			} else if(amount < 0){
				for(var j:int = 0; j > amount; j--){
					day--;
					if(day < 1){
						month--;
						if(month < 0){
							month = 11;
							year--;
						}
						monthDays = getDaysInMonth(month, year);
						day = monthDays;
					}
				}
			}
			returnDate.setFullYear(year,month,day);
			return returnDate;
		}
		
		public static function incrementByHour(sDate:Date, amount:int = 1):Date{
			var returnDate:Date = new Date();
			returnDate.time = sDate.time + (amount * 3600000);
			return returnDate;
		}
		
		public static function incrementByMinute(sDate:Date, amount:int = 1):Date{
			var returnDate:Date = new Date();
			returnDate.time = sDate.time + (amount * 60000);
			return returnDate;
		}
		
		public static function convertMonthNameToNumber(month:String):int{
			switch(month){
				case "January":
					return 0;
					break;
				case "February":
					return 1;
					break;
				case "March":
					return 2;
					break;
				case "April":
					return 3;
					break;
				case "May":
					return 4;
					break;
				case "June":
					return 5;
					break;
				case "July":
					return 6;
					break;
				case "August":
					return 7;
					break;
				case "September":
					return 8;
					break;
				case "October":
					return 9;
					break;
				case "November":
					return 10;
					break;
				case "December":
					return 11;
					break;
				default:
					return -1;
					break;
			}
		}
		
		public static function convertMonthNumberToName(month:int):String{
			switch(month){
				case 0:
					return "January";
					break;
				case 1:
					return "February";
					break;
				case 2:
					return "March";
					break;
				case 3:
					return "April";
					break;
				case 4:
					return "May";
					break;
				case 5:
					return "June";
					break;
				case 6:
					return "July";
					break;
				case 7:
					return "August";
					break;
				case 8:
					return "September";
					break;
				case 9:
					return "October";
					break;
				case 10:
					return "November";
					break;
				case 11:
					return "December";
					break;
				default:
					return "Error";
					break;
			}
		}
		
		public static function getFormattedDate(d:Date):String{
			return String(d.month + 1) + "/" + String(d.date) + "/" + String(d.fullYear).substr(2);
		}
		
		public static function getFormattedTime(d:Date, militaryTime:Boolean = false):String{
			if(militaryTime){
				return getTwoDigitNumber(d.hours) + ":" + getTwoDigitNumber(d.minutes);
			} else {
				if(d.hours == 0){
					return "12:" + getTwoDigitNumber(d.minutes) + " AM";
				} else if(d.hours == 12){
					return "12:" + getTwoDigitNumber(d.minutes) + " PM";
				} else if(d.hours > 12){
					return (d.hours - 12) + ":" + getTwoDigitNumber(d.minutes) + " PM";
				} else {
					return getTwoDigitNumber(d.hours) + ":" + getTwoDigitNumber(d.minutes) + " AM";
				}
			}
		}

		public static function getFormattedHour(d:Date, militaryTime:Boolean = false):String{
			if(militaryTime){
				return getTwoDigitNumber(d.hours) + ":" + getTwoDigitNumber(d.minutes);
			} else {
				if(d.hours == 0){
					return "12" + "a";
				} else if(d.hours > 12){
					return (d.hours - 12) + "p";
				} else {
					return d.hours +"a";
				}
			}
		}		

		public static function formatTime ( time:Number ):String
		{
			var remainder:Number;
			
			var hours:Number = time / ( 60 * 60 );
			
			remainder = hours - (Math.floor ( hours ));
			
			hours = Math.floor ( hours );
			
			var minutes:Number = remainder * 60;
			
			remainder = minutes - (Math.floor ( minutes ));
			
			minutes = Math.floor ( minutes );
			
			var seconds:Number = remainder * 60;
			
			remainder = seconds - (Math.floor ( seconds ));
			
			seconds = Math.floor ( seconds );
			
			var hString:String = hours < 10 ? "0" + hours : "" + hours;	
			var mString:String = minutes < 10 ? "0" + minutes : "" + minutes;
			var sString:String = seconds < 10 ? "0" + seconds : "" + seconds;
			
			if ( time < 0 || isNaN(time)) return "00:00";			
			
			if ( hours > 0 ){			
				return hString + ":" + mString + ":" + sString;
			}else{
				return mString + ":" + sString;
			}
		}
		
		private static function getTwoDigitNumber(num:int):String{
			if(num < 10){
				return "0" + String(num);
			} else {
				return String(num);
			}
		}
		
		public static function getRangeOfDates(startDate:Date, endDate:Date):Vector.<Date>{
			var dateRange:Vector.<Date> = new Vector.<Date>;
			var tempDate:Date = new Date();
			tempDate.time = startDate.time;
			dateRange.push(tempDate);
			if(startDate.time < endDate.time){
				var tempTime:Number;
				var numDays:int = getNumDays(startDate,endDate);
				for(var i:uint = 0; i < numDays - 1; i++){
					tempTime = tempDate.time;
					tempDate = new Date();
					tempDate.time = tempTime;
					tempDate.seconds += 86400;
					dateRange.push(tempDate);
				}
			} else {
				trace("Error: DateUtils.getRangeOfDates - end date is prior to or same as start date");
			}
			
			return dateRange;
		}
		
		public static function replaceDateText(originalText:String, originalDate:Date, newDate:Date):String{
			var dateFormat:String = "none";
			var dateText:String;
			var dateIndex:int;
			var monthFormat:String = "none";
			var monthText:String;
			var monthIndex:int;
			var yearFormat:String = "none";
			var yearText:String;
			var yearIndex:int;
			
			var replacementDate:String;
			var replacementMonth:String;
			var replacementYear:String;
			
			var monthStringLong:String = convertMonthNumberToName(originalDate.month);
			var monthStringShort:String = monthStringLong.substr(0,3) + ".";
			var yearStringLong:String = String(originalDate.fullYear);
			var yearStringShort:String = yearStringLong.substring(2);
			
			dateIndex = originalText.search(String(originalDate.date))
			if(dateIndex > -1){
				dateFormat = "number";
				dateText = String(originalDate.date);
			}
			
			
			if(originalText.search(monthStringLong) > -1){
				monthIndex = originalText.search(monthStringLong);
				monthFormat = "long";
				monthText = monthStringLong;
			} else if(originalText.search(monthStringShort) > -1){
				monthIndex = originalText.search(monthStringShort);
				monthFormat = "short";
				monthText = monthStringShort;
			}
			
			if(originalText.search(yearStringLong) > -1){
				yearIndex = originalText.search(yearStringLong);
				yearFormat = "long";
				yearText = yearStringLong;
			} else if(originalText.search(yearStringShort) > -1){
				yearIndex = originalText.search(yearStringLong);
				yearFormat = "short";
				yearText = yearStringShort;
			}
			
			var output:String = originalText;
			if(dateFormat == "number"){
				output = output.replace(dateText, String(newDate.date));
				//trace("replace " + dateText + " with " + String(newDate.date));
			}
			
			if(monthFormat == "long"){
				output = output.replace(monthText, convertMonthNumberToName(newDate.month));
				//trace("replace " + monthText + " with " + convertMonthNumberToName(newDate.month));
			} else if(monthFormat == "short"){
				if(newDate.month == 4){
					output = output.replace(monthText, convertMonthNumberToName(newDate.month).substr(0,3));
				} else {
					output = output.replace(monthText, convertMonthNumberToName(newDate.month).substr(0,3) + ".");
				}
				
				//trace("replace " + monthText + " with " + convertMonthNumberToName(newDate.month).substr(0,3) + ".");
			}
			
			if(yearFormat == "long"){
				output = output.replace(yearText, String(newDate.fullYear));
				//trace("replace " + yearText + " with " + String(newDate.fullYear));
			} else if(yearFormat == "short"){
				output = output.replace(yearText, String(newDate.fullYear).substr(2));
				///trace("replace " + yearText + " with " + String(newDate.fullYear).substr(2));
			}
			
			return output;
		}
		
		//Static Functions
		
		public static function convertStringToDate(date:String):Date{
			var fullStringParse:Array = date.split(" ");
			var timeString:String = "13:00";
			var dateString:String;
			var yearNum:int;
			var tempDate:Date;
			
			if(fullStringParse.length == 2){
				dateString = fullStringParse[0];
				timeString = fullStringParse[1];
			} else {
				dateString = date;
			}
			
			var dateStringParse:Array = dateString.split("_");
			var timeStringParse:Array = timeString.split(":");
			
			if(dateStringParse.length < 2){
				dateStringParse = dateStringParse[0].split("/");
				yearNum = int(dateStringParse[2]);
				if(yearNum < 50){
					yearNum = yearNum + 2000;
				} else if(yearNum < 100){
					yearNum = yearNum + 1900;
				}
				tempDate = new Date(yearNum,int(dateStringParse[0]) - 1, int(dateStringParse[1]),int(timeStringParse[0]), int(timeStringParse[1]));
			} else {
				tempDate = new Date(int(dateStringParse[0]),int(dateStringParse[1]) - 1, int(dateStringParse[2]),int(dateStringParse[3]), int(dateStringParse[4]));
			}
			//trace(date + " = " + tempDate.toString());
			return tempDate;
		}
		
		public static function convertDateToString(date:Date):String{
			if(date){
				return String(date.fullYear) + "_" + String(date.month + 1) + "_" + String(date.date) + "_" + String(date.hours) + "_" + String(date.minutes);
			} else {
				return "none";
			}
		}
		
		public static function getFormattedDateTime(d:Date):String{
			var dString:String = "null";
			if(d){
				dString = String(d.month + 1) + "/" + String(d.date) + "/" + String(d.fullYear).substr(2);
				dString += " ";
				if(d.hours < 10){
					dString += "0" + String(d.hours) + ":";
				} else {
					dString += String(d.hours) + ":";
				}
				if(d.minutes < 10){
					dString += "0" + String(d.minutes);
				} else {
					dString += String(d.minutes);
				}
			}
			return dString;
		}
		
		public static function datesContainedInRange(startDate:Date, endDate:Date, rangeStartDate:Date, rangeEndDate:Date):Boolean{
			var sTime:Number = startDate.time;
			var eTime:Number = endDate.time;
			var rsTime:Number = rangeStartDate.time;
			var reTime:Number = rangeEndDate.time;
			if(sTime >= rsTime && sTime <= reTime){
				return true;
			}
			if(eTime >= rsTime && eTime <= reTime){
				return true;
			}
			if(sTime < rsTime && eTime > reTime){
				return true;
			}
			return false;
		}
	}
	
}