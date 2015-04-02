//
//  ViewController.m
//  MeetMeUp
//
//  Created by Mert Akanay on 23.03.2015.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"
#import "Meetup.h"

@interface RootViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic)  NSArray *allMeetups;
@property (nonatomic) NSMutableArray *meetupsToDisplay;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSURL *url;
//@property BOOL isFiltered;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [Meetup retrieveMeetupsWithCompletion:^(NSArray *array)
     {
         self.allMeetups = array;
         self.meetupsToDisplay = [self.allMeetups mutableCopy];
     }];

//    self.isFiltered = NO;

}

-(void)setMeetupsToDisplay:(NSMutableArray *)meetupsToDisplay
{
    _meetupsToDisplay = meetupsToDisplay;
    [self.tableView reloadData];
}
//-(void)setMeetups:(NSArray *)meetups
//{
//    _allMeetups = meetups;
//    [self.tableView reloadData];
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];

    Meetup *newMeetup = [self.meetupsToDisplay objectAtIndex:indexPath.row];

//    if (self.isFiltered) {
//        newMeetup = [self.filteredMeetups objectAtIndex:indexPath.row];
//    }else
//    {
//        newMeetup = [self.meetups objectAtIndex:indexPath.row];
//    }

    cell.textLabel.text = newMeetup.name;
    cell.detailTextLabel.text = newMeetup.address;
    cell.detailTextLabel.numberOfLines=0;

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (self.isFiltered) {
//        return self.filteredMeetups.count;
//    }else
//    {
//        return self.meetups.count;
//    }

    return self.meetupsToDisplay.count;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{

  if(searchText.length == 0)
  {
//      self.isFiltered = NO;
      self.meetupsToDisplay = [self.allMeetups mutableCopy];
  }else
  {
//      self.isFiltered = YES;
      [self.meetupsToDisplay removeAllObjects];
//     NSMutableArray *filteredMeetups = [NSMutableArray new];
      for (Meetup *meetup in self.allMeetups)
      {
          NSRange nameRange = [meetup.name rangeOfString:self.searchBar.text options:NSCaseInsensitiveSearch];
          if (nameRange.location != NSNotFound) {
              [self.meetupsToDisplay addObject:meetup];
          }
      }
  }
    [self.tableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *detailVC = [segue destinationViewController];
    detailVC.meetups = self.allMeetups;
}


@end
