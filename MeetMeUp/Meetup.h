//
//  Meetup.h
//  MeetMeUp
//
//  Created by Mert Akanay on 3/30/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Meetup : NSObject

@property NSString *name;
@property NSString *groupName;
@property NSString *address;
@property NSDictionary *venue;
@property NSString *eventURL;
@property NSNumber *rsvp;
@property NSString *eventDescription;
@property (nonatomic) NSString *time;
@property NSNumber *timeSince1970;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
+(void)retrieveMeetupsWithCompletion:(void (^)(NSArray *))complete;
//+(void)retrieveSearchResultsWithCompletion:(void (^)(NSArray *))complete;

@end
