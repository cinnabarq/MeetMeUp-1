//
//  Comments.h
//  MeetMeUp
//
//  Created by Mert Akanay on 3/30/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comments : NSObject

@property NSString *memberName;
@property NSNumber *time;
@property NSString *comment;
@property NSString *memberID;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
