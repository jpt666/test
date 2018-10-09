//
//  NSDate+mapObject.m
//  TripPlan
//
//  Created by Samuel Huang on 12/25/14.
//  Copyright (c) 2014 畅e行. All rights reserved.
//

#import "NSDate+ZXAdd.h"

@implementation NSDate (mapObject)

+(NSDateComponents *)componentsFromTimeInterval1970:(NSTimeInterval)timeInterval
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal;
    return  [cal components:unitFlags fromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
}

+(NSTimeInterval)timeIntervalSince1970byYear:(NSInteger)y Month:(NSInteger)m day:(NSInteger)d hour:(NSInteger)h
{
    return [NSDate timeIntervalSince1970byYear:y Month:m day:d hour:h min:0];
}

+(NSTimeInterval)timeIntervalSince1970byYear:(NSInteger)y Month:(NSInteger)m day:(NSInteger)d hour:(NSInteger)h min:(NSInteger)min
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    [comp setYear:y];
    [comp setMonth:m];
    [comp setDay:d];
    [comp setHour:h];
    [comp setMinute:min];
    
    return [[cal dateFromComponents:comp] timeIntervalSince1970];
}

+(long)minutesStandForDaysDiff:(NSTimeInterval)startTime endTime:(NSTimeInterval)endTime
{
    if (startTime >= endTime) {
        return 0;
    }
    NSDateComponents *compStart = [self componentsFromTimeInterval1970:startTime];
    NSDateComponents *compEnd = [self componentsFromTimeInterval1970:endTime];
    
    double diffSec = endTime - startTime;
    if (diffSec/ONE_HOUR_SECOND_TIMEINTERVAL >= ONE_DAY_HOUR_NUM) {
        //大于24小时
        
        NSInteger diffDay = (NSInteger)(diffSec/ONE_DAY_TIMEINTERVAL);
        NSTimeInterval nextDayTime = startTime+diffDay * ONE_DAY_TIMEINTERVAL;
        NSDateComponents *compNextDay = [self componentsFromTimeInterval1970:nextDayTime];
        
        if ([compNextDay day] == [compEnd day]) {
            return diffDay * ONE_DAY_HOUR_NUM*ONE_HOUR_MINUTE_TIMEINTERVAL;
        } else {
            return (diffDay+1) * ONE_DAY_HOUR_NUM*ONE_HOUR_MINUTE_TIMEINTERVAL;
        }
    } else {
        //小于24小时
        if ([compStart day] == [compEnd day]) {
            NSInteger diffhour = compEnd.hour-compStart.hour;
            if (diffhour == 0) {
                return compEnd.minute-compStart.minute;
            } else {
                return diffhour*ONE_HOUR_MINUTE_TIMEINTERVAL;
            }
        } else {
            return 24*ONE_HOUR_MINUTE_TIMEINTERVAL;
        }
    }

}

@end
