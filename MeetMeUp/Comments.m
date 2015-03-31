//
//  Comments.m
//  MeetMeUp
//
//  Created by Mert Akanay on 3/30/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "Comments.h"

@implementation Comments

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self.memberName = [dictionary objectForKey:@"member_name"];
    self.time = [dictionary objectForKey:@"time"];
    self.comment = [dictionary objectForKey:@"comment"];
    self.memberID = [dictionary objectForKey:@"member_id"];

    return self;
}

@end
