//
//  AppDelegate.h
//  GTM-Demo-V1
//
//  Created by chao hsin-cheng on 2015/9/6.
//  Copyright (c) 2015年 chao hsin-cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <GoogleTagManager/TAGContainerOpener.h>
#import <GoogleTagManager/TAGManager.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

// GTM
@property (strong, nonatomic) TAGManager *tagManager;
@property (strong, nonatomic) TAGContainer *container;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

