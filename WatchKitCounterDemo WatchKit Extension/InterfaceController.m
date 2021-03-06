//
//  InterfaceController.m
//  WatchKitCounterDemo WatchKit Extension
//
//  Created by Thai, Kristina on 12/10/14.
//  Copyright (c) 2014 Kristina Thai. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()

@property (nonatomic, assign) int counter;
@end

@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    NSLog(@"%@ awakeWithContext", self);
    self.counter = 0;
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    NSLog(@"%@ will activate", self);
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
}

#pragma mark - Button actions

- (IBAction)incrementCounter {
    self.counter++;
    [self setCounterLabelText];
}
- (IBAction)saveCounter {
    //Send count to parent application
    NSString *counterString = [NSString stringWithFormat:@"%d", self.counter];
    NSDictionary *applicationData = [[NSDictionary alloc] initWithObjects:@[counterString] forKeys:@[@"counterValue"]];
    
    //Handle reciever in app delegate of parent app
    [WKInterfaceController openParentApplication:applicationData reply:^(NSDictionary *replyInfo, NSError *error) {
        NSLog(@"%@ %@",replyInfo, error);
    }];
}
- (IBAction)clearCounter {
    self.counter = 0;
    [self setCounterLabelText];
}

#pragma mark - Helper methods

- (void)setCounterLabelText {
    [self.counterLabel setText:[NSString stringWithFormat:@"%d", self.counter]];
}

@end



