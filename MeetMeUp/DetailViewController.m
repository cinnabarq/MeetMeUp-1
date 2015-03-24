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

    self.groupName =[self.rowsDictionary objectForKey:@"group"];
    self.groupNameLabel.text = [self.groupName objectForKey:@"name"];

    NSNumber *number = [self.rowsDictionary objectForKey:@"yes_rsvp_count"];
    self.participantNumLabel.text = [NSString stringWithFormat:@"%@",number];

    self.eventDescLabel.text = [self.rowsDictionary objectForKey:@"description"];

    self.navigationItem.title = [self.rowsDictionary objectForKey:@"name"];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    WebViewController *webVC = [segue destinationViewController];
    webVC.rowDictionary = self.rowsDictionary;

    CommentViewController *commentVC = [segue destinationViewController];
    commentVC.rowsDictionary = self.rowsDictionary;
}

@end
