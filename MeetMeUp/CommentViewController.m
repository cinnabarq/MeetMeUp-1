//
//  CommentViewController.m
//  MeetMeUp
//
//  Created by Mert Akanay on 23.03.2015.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *commenterLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSDictionary *commentDictionary;
@property NSDictionary *memberDictionary;
@property NSString *eventID;
@property NSMutableArray *topicsArray;
@property NSDictionary *dictionaryAtRow;

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.eventID = [self.rowsDictionary objectForKey:@"id"];

    NSString *commentString = [NSString stringWithFormat:@"https://api.meetup.com/2/event_comments?&event_id=%@&key=2864313b77404018213118225a0211",self.eventID];
    NSURL *url = [NSURL URLWithString:commentString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        self.commentDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

        //there needs to be an array here !!

        self.commenterLabel.text = [self.commentDictionary objectForKey:@"member_name"];

        long utcepoch = [[self.commentDictionary objectForKey:@"time"] longValue];
        self.commentTimeLabel.text = [NSString stringWithFormat:@"%ld",utcepoch];

        self.commentLabel.text = [self.commentDictionary objectForKey:@"comment"];

        NSString *memberID = [self.commentDictionary objectForKey:@"member_id"];

        NSString *memberString = [NSString stringWithFormat:@"https://api.meetup.com/2/members?member_id=%@&key=2864313b77404018213118225a0211",memberID];
        NSURL *memberURL = [NSURL URLWithString:memberString];
        NSURLRequest *memberRequest = [NSURLRequest requestWithURL:memberURL];
        [NSURLConnection sendAsynchronousRequest:memberRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

            self.memberDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

            NSDictionary *dictionary = [self.memberDictionary objectForKey:@"results"];
            self.topicsArray = [dictionary objectForKey:@"topics"];


        }];

    }];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    self.dictionaryAtRow = [self.topicsArray objectAtIndex:indexPath.row];

    cell.textLabel.text = [self.dictionaryAtRow objectForKey:@"name"];

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topicsArray.count;
}

@end
