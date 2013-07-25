//
//  CategoriasViewController.m
//  Inventario v_beta
//
//  Created by Diego Martinez on 24/07/13.
//  Copyright (c) 2013 Diego Martinez. All rights reserved.
//

#import "CategoriasViewController.h"
#import "ProductosViewController.h"
#import "Edit-AddCategoriaViewController.h"

@interface CategoriasViewController ()

@end

@implementation CategoriasViewController

//Busqueda!!*******************************************************************************************************************

NSArray *searchResults;

-(void) filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchText];
    
    searchResults = [_keys filteredArrayUsingPredicate:resultPredicate];
}
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]  objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}



//Inicio tableView

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
    NSMutableArray *detalles1 = [[NSMutableArray alloc] initWithObjects:@"Producto1",@"Producto2",@"Producto3", nil];
    NSMutableArray *detalles2 = [[NSMutableArray alloc] initWithObjects:@"Producto4",@"Producto5",@"Producto6", nil];
    NSMutableArray *detalles3 = [[NSMutableArray alloc] initWithObjects:@"Producto7",@"Producto8",@"Producto9", nil];
    _ejemplo = [[NSMutableDictionary alloc] initWithObjectsAndKeys: detalles1,@"Categoria 1", detalles2,@"Categoria 2", detalles3, @"Categoria 3",   nil] ;
    _keys = [[NSMutableArray alloc ] initWithArray:[_ejemplo allKeys] copyItems:YES];
    int x;
    x=1;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if(_isEditting)
    {
        [self edit: self.navigationItem.leftBarButtonItem];
    }
    UINavigationController *dest = [segue destinationViewController];
    UITableViewCell *cell = (UITableViewCell*) sender;
    int row = cell.tag;
    
    if([segue.identifier isEqualToString:@"llamarListaProductos"])
    {
        
        ProductosViewController *ctrl = [[dest viewControllers] objectAtIndex:0];
        
        
        if([self.searchDisplayController isActive])
        {
            ctrl.listaProductos =  [_ejemplo objectForKey:[searchResults objectAtIndex:row]];
            [self.searchDisplayController setActive:NO animated:NO];
        }
        else
        {
            ctrl.listaProductos =  [_ejemplo objectForKey:[_keys objectAtIndex:row]];
        }
        
        
    }
    else if([segue.identifier isEqualToString:@"AddCategoria"])
    {
        Edit_AddCategoriaViewController* ctrl = [[dest viewControllers] objectAtIndex:0];
        ctrl.llamada = @"Add";
        
    }
    else if([segue.identifier isEqualToString:@"EditCategoria"])
    {
        
    }
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
        return [_ejemplo count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [cell setTag:indexPath.row];
    cell.editingAccessoryType = UITableViewCellEditingStyleNone;    
    [myButton setTag: indexPath.row];
    
    [myButton addTarget:self action:@selector(editSelection:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.editingAccessoryView = myButton;
    
    if(tableView == self.searchDisplayController.searchResultsTableView)
        cell.textLabel.text = [searchResults objectAtIndex:indexPath.row];
    else
        cell.textLabel.text = [_keys objectAtIndex:indexPath.row];
    
    // Configure the cell...
    
    return cell;
}

-(void) editSelection: (id) sender
{
    [self performSegueWithIdentifier:@"EditCategoria" sender:sender];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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


- (IBAction)edit:(UIBarButtonItem *)sender {
    if( [sender.title isEqualToString: @"Edit"] )
    {
        _isEditting = YES;
        [sender setTitle:@"Done"];
        [self setEditing:YES animated:YES];
    }
    else
    {
        _isEditting = NO;
        [sender setTitle:@"Edit"];
        [self setEditing:NO animated:YES];
        
    }
}


@end
