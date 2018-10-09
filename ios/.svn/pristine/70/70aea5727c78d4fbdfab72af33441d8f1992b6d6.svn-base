//
//  NSDate+mapObject.h
//  TripPlan
//
//  Created by Samuel Huang on 12/25/14.
//  Copyright (c) 2014 畅e行. All rights reserved.
//

#import <Foundation/Foundation.h>


#define ONE_DAY_TIMEINTERVAL (24*60*60)
#define ONE_DAY_HOUR_NUM 24
#define ONE_HOUR_SECOND_TIMEINTERVAL (60*60)
#define ONE_HOUR_MINUTE_TIMEINTERVAL 60


@interface NSDate (mapObject)

+(NSDateComponents *)componentsFromTimeInterval1970:(NSTimeInterval)timeInterval;

+(NSTimeInterval)timeIntervalSince1970byYear:(NSInteger)y Month:(NSInteger)m day:(NSInteger)d hour:(NSInteger)h;

+(NSTimeInterval)timeIntervalSince1970byYear:(NSInteger)y Month:(NSInteger)m day:(NSInteger)d hour:(NSInteger)h min:(NSInteger)min;

+(long)minutesStandForDaysDiff:(NSTimeInterval)startTime endTime:(NSTimeInterval)endTime;

@end
