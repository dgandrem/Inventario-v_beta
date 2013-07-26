//
//  ProductosViewController.m
//  Inventario v_beta
//
//  Created by Diego Martinez on 24/07/13.
//  Copyright (c) 2013 Diego Martinez. All rights reserved.
//

#import "ProductosViewController.h"
#import "DetalleProductoViewController.h"
#import "Edit-AddProductoViewController.h"

@interface ProductosViewController ()

@end

@implementation ProductosViewController

NSArray *searchResults;

//Control Busqueda *****************************************************************************************

-(void) filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchText];
    
    searchResults = [_listaProductos filteredArrayUsingPredicate:resultPredicate];
}
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]  objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}

//CONTROL LOAD VIEW *****************************************************************************************

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    UINavigationController *dest = [segue destinationViewController];
    UITableViewCell *cell = (UITableViewCell*) sender;
    int row = cell.tag;
    
    if([segue.identifier isEqualToString:@"llamarDetalleProducto"])
    {
        
        DetalleProductoViewController *ctrl = [[dest viewControllers] objectAtIndex:0];
        
        
        if([self.searchDisplayController isActive])
        {
            ctrl.nombreProducto =  [searchResults objectAtIndex:row];
            [self.searchDisplayController setActive:NO animated:NO];
        }
        else
        {
            ctrl.nombreProducto =  [_listaProductos objectAtIndex:row];
        }
        
        [ctrl setTitle: ctrl.nombreProducto];

        
    }
    else if([segue.identifier isEqualToString:@"AddProducto"])
    {
        Edit_AddProductoViewController* ctrl = [[dest viewControllers] objectAtIndex:0];
        ctrl.caller = @"Add";
        
    }

}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    if(tableView == self.searchDisplayController.searchResultsTableView)
        return [searchResults count];
    else
        return [_listaProductos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [cell setTag:indexPath.row];
    if(tableView == self.searchDisplayController.searchResultsTableView)
        cell.textLabel.text = [searchResults objectAtIndex:indexPath.row];
    else
        cell.textLabel.text = [_listaProductos objectAtIndex:indexPath.row];
    
    // Configure the cell...
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (IBAction)back:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
