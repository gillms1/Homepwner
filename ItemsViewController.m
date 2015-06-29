//
//  ItemsViewController.m
//  Homepwner
//
//  Created by Sunny on 27/05/2015.
//  Copyright (c) 2015 Sunny. All rights reserved.
//

#import "ItemsViewController.h"
#import "ItemStore.h"
#import "BNRItem.h"

@interface ItemsViewController ()

@property (nonatomic, strong) IBOutlet UIView *headerView;

@end

@implementation ItemsViewController

-(instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
    
    UIView *header = self.headerView;
    [self.tableView setTableHeaderView:header];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[ItemStore sharedStore] allItems]count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //Get a new or recycled cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    NSArray *items = [[ItemStore sharedStore] allItems];
    BNRItem *item = items[indexPath.row];
    
    cell.textLabel.text = [item description];
    
    return cell;
}

-(UIView *)headerView
{
    //If you have not loaded the headerview yet
    if (!_headerView){
        //Load HeaderView.xib
        [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
    }
    
    return _headerView;
}

-(IBAction)addNewItem:(id)sender
{

    //Create a new BNRItem and add it to the store
    BNRItem *newItem = [[ItemStore sharedStore]createItem];
    
    //Figure out where the item is in the array
    NSInteger lastRow = [[[ItemStore sharedStore] allItems] indexOfObject:newItem];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    //Insert this new row into the table
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    
}

-(IBAction)toggleEditingMode:(id)sender
{
    //If you are currently in editing mode
    if (self.isEditing) {
        //change the text of button to inform user of state
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        
        //Turn off editing mode
        [self setEditing:NO animated:YES];
    } else {
        
        //change the text of button to inform user of state
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        
        //Enter editing mode
        [self setEditing:YES animated:YES];
        
    }
    
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //If the table view is asking to commit a delete command...
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSArray *items = [[ItemStore sharedStore]allItems];
        BNRItem *item = items[indexPath.row];
        [[ItemStore sharedStore] removeItem:item];
        
        //Also remove that row from the tablie view with an animation
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }

}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[ItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return @"Remove";
}

@end
