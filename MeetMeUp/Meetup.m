//
//  Meetup.m
//  MeetMeUp
//
//  Created by Mert Akanay on 3/30/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "Meetup.h"

@implementation Meetup

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self.name = [dictionary objectForKey:@"name"];
    self.venue = [dictionary objectForKey:@"venue"];
    self.address = [self.venue objectForKey:@"address_1"];
    self.eventURL = [dictionary objectForKey:@"event_url"];
    self.rsvp = [dictionary objectForKey:@"yes_rsvp_count"];
    self.eventDescription = [dictionary objectForKey:@"description"];
    self.groupName = [[dictionary objectForKey:@"group"] objectForKey:@"name"];
    self.timeSince1970 = [dictionary objectForKey:@"time"];

    return self;
}

-(NSString *)time
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"MM/dd/yy HH:mm";
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.timeSince1970.doubleValue/1000];
    return [formatter stringFromDate:date];
}


+(void)retrieveMeetupsWithCompletion:(void (^)(NSArray *))complete
{
    NSURL *url = [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=94101&text=mobile&time=,1w&text_format=plain&key=2864313b77404018213118225a0211"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        NSDictionary *meetupDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *meetupArray = [meetupDictionary objectForKey:@"results"];
        NSMutableArray *meetupMutableArray = [NSMutableArray arrayWithCapacity:meetupArray.count];
        for (NSDictionary *dict in meetupArray)
        {
            [meetupMutableArray addObject:[[Meetup alloc]initWithDictionary:dict]];
        }
        complete(meetupMutableArray);
    }];
}


@end
