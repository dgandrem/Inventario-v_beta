//
//  DetalleProductoViewController.h
//  Inventario v_beta
//
//  Created by Diego Martinez on 24/07/13.
//  Copyright (c) 2013 Diego Martinez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetalleProductoViewController : UITableViewController

@property NSString *nombreProducto; //cambiar por clase producto
@property NSString *accionStock;

- (IBAction)back:(UIBarButtonItem *)sender;
- (IBAction)controlStock:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControlStock;



@end
