//
//  RocketAppDelegate.h
//  Rocket
//
//  Created by Tim Storey on 13/06/2011.
//  Copyright 2011 Lateral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKParallaxViewController.h"


@interface RocketAppDelegate : NSObject <UIApplicationDelegate> {

    RKParallaxViewController *pViewController;
    
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) RKParallaxViewController *pViewController;

@end
