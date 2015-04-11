/* Date validator -- @Authour: Abdul Halim */

//This funtion called from custome validation control that passes two arguments, sender and args
//It validates a control by comparing date values from calling control with value from other control that has an ID 'txtStartDate'
function compareDateValues(sender, args) {
    var date1, date2, now;
    now = new Date();
    var dateString1 = document.getElementById('txtStartDate').value;
    //var dateString2 = document.getElementById('endDate').value;
    var dateString2 = args.Value;

    if (dateString1 == "") //If only end-date specified then only check if end-date is not in the past
    {
        if (!isValidDate(dateString2) || (stringToDate(dateString2) < now))
            args.IsValid = false;
        else
            args.IsValid = true;
    }

        //There is value in start-date do we need to compare both dates
    else if (isValidDate(dateString1) && isValidDate(dateString2)) {
        date1 = stringToDate(dateString1);
        date2 = stringToDate(dateString2);
        if (date1 < now)
            args.IsValid = false;
        else if (date2 < date1)
            args.IsValid = false;
        else
            args.IsValid = true;
    }
    else
        args.IsValid = false;

}

function isValidDate(dateString) {
    var dateVal = dateString;
    if (dateVal == "") //Check if empty string
        return false;

    //define a regex matching date pattern "dd/MM/yyyy HH:mm"
    var datePatern = /^((0?[1-9])|([1-2]\d)|(3[0-1]))\/((0?[1-9])|(1[0-2]))\/(\d{2}|\d{4})[\s]{1}(((0|1){1}\d)|2[0-3])\:([0-5]{1}\d)$/;

    if (!datePatern.test(dateVal))
        return false;

    //split the string for each section
    var delimiter = /\/|\:|\s/;
    var dtArray = dateVal.split(delimiter);

    //Checks for dd/mm/yyyy format.
    var day = dtArray[0];
    var month = dtArray[1];
    var year = dtArray[2];
    //hour and minutes should be valid after regex match

    if (month < 1 || month > 12)
        return false;
    else if (day < 1 || day > 31)
        return false;
    else if ((month == 4 || month == 6 || month == 9 || month == 11) && day == 31)
        return false;
    else if (month == 2) {
        var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
        if (day > 29 || (day == 29 && !isleap))
            return false;
    }
    return true;
}    


//A function that returns date object from a validated date string as 'dd/MM/yyyy HH:mm' format
function stringToDate(dateString) {

    var delimiter = /\/|\:|\s/;
    var dtArray = dateString.split(delimiter);
    var date = new Date();
    //Date string is  "dd/mm/yyyy HH:mm" format.
    var day = dtArray[0];
    var month = dtArray[1];
    var year = dtArray[2];
    var hours = dtArray[3];
    var minutes = dtArray[4];
    date.setFullYear(year, month - 1, day);
    date.setHours(hours);
    date.setMinutes(minutes);
    return date;
}


//Method for checking a single date input from customvalidation parameters
function isValidDateValue(sender, args)
{
    var inputDate;
    var dateString = args.Value;
    if (isValidDate(dateString)) {
        inputDate = stringToDate(dateString);
        now = new Date();
        if (inputDate < now)
            args.IsValid = false;
        else
            args.IsValid = true;
    }
    else
        args.IsValid = false;
}