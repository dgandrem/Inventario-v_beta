//
//  ProductosViewController.h
//  Inventario v_beta
//
//  Created by Diego Martinez on 24/07/13.
//  Copyright (c) 2013 Diego Martinez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductosViewController : UITableViewController

@property NSMutableArray *listaProductos;
- (IBAction)back:(UIBarButtonItem *)sender;

@end
