//
//  DetailViewController.m
//  MeetMeUp
//
//  Created by Mert Akanay on 23.03.2015.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "DetailViewController.h"
#import "WebViewController.h"
#import "CommentViewController.h"
#import "Meetup.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *groupNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *participantNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventDescLabel;
@property (weak, nonatomic) IBOutlet UILabel *webPageLabel;

@property NSDictionary *groupName;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    Meetup *newMeetup;

    for (int i = 0; i < self.meetups.count; i++)
    {
        newMeetup = self.meetups[i];
    }

    self.groupNameLabel.text = newMeetup.groupName;
    NSNumber *number = newMeetup.rsvp;
    self.participantNumLabel.text = [NSString stringWithFormat:@"%@",number];
    self.eventDescLabel.text = newMeetup.description;
    self.navigationItem.title = newMeetup.name;

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if ([sender isKindOfClass:[UITapGestureRecognizer class]])
//    {
    WebViewController *webVC = [segue destinationViewController];
    webVC.meetups = self.meetups;
//    }else{
//    CommentViewController *commentVC = [segue destinationViewController];
//    commentVC.rowsDictionary = self.rowsDictionary;
//    }
}

@end
