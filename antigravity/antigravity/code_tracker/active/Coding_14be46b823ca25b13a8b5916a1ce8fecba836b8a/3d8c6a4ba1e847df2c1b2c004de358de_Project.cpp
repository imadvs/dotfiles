È#include <iostream>
#include <string>
#include <cstdio>

using namespace std;

// Checks if the year is a leap year
bool isLeapYear(short Year) {
    // A year is a leap year if divisible by 4 AND not 100, OR if divisible by 400
    return (Year % 4 == 0 && Year % 100 != 0) || (Year % 400 == 0);
}


// Returns the total number of days in a specific month
short NumberOfDaysInAMonth(short Month, short Year) {
    if (Month < 1 || Month > 12) return 0;

    short days[12] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
    return (Month == 2) ? (isLeapYear(Year) ? 29 : 28) : days[Month - 1];
}

short NumberOfDaysFromTheBeginningOfTheYear(short Day, short Month, short Year) {
    short totalDays = 0;
    for (short m = 1; m < Month; ++m) {
        totalDays += NumberOfDaysInAMonth(m, Year);
    }
    totalDays += Day;
    return totalDays;
}

struct sDate {
    short Day;
    short Month;
    short Year;
};

sDate GetDateFromDaysFromTheBeginningOfTheYear(short DateOrderInYear, short Year) {
    sDate date;
    date.Month = 1;
    date.Year = Year;
    short RemainingDays = DateOrderInYear;
    short MonthDays = NumberOfDaysInAMonth(date.Month, Year);

    while (RemainingDays > MonthDays) {
        RemainingDays -= MonthDays;
        date.Month++;
    }
    date.Day = RemainingDays;
    return date;
}

short ReadDay() {
    short Day;
    cout << "\nPlease enter a day: ";
    cin >> Day;
    return Day;
}

short ReadMonth() {
    short Month;
    cout << "\nPlease enter a month: ";
    cin >> Month;
    return Month;
}

short ReadYear() {
    short Year;
    cout << "\nPlease enter a year: ";
    cin >> Year;
    return Year;
}

int main() {
    short Day = ReadDay();
    short Month = ReadMonth();
    short Year = ReadYear();
    short DaysOrderInYear =
        NumberOfDaysFromTheBeginningOfTheYear(Day, Month, Year);

    cout << "\nNumber of Days from the begining of the year is: " <<
        NumberOfDaysFromTheBeginningOfTheYear(Day, Month, Year
        );

    sDate date = GetDateFromDaysFromTheBeginningOfTheYear(DaysOrderInYear, Year);
    cout << "\nDate for [" << DaysOrderInYear << "] is: ";
    cout << date.Day << "/" << date.Month << "/" << date.Year << endl;

    system("pause>0");
    return 0;
}È"(14be46b823ca25b13a8b5916a1ce8fecba836b8a2.file:///home/imad/Documents/Coding/Project.cpp:"file:///home/imad/Documents/Coding