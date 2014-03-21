//
//  ViewController.m
//  Heartbeat
//
//  Created by Kyle Levin on 2/25/14.
//  Copyright (c) 2014 Kyle Levin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _socketConnection = [[SocketIO alloc] initWithDelegate:self];
    [_socketConnection connectToHost:@"localhost" onPort:3333 withParams:nil withNamespace:@"/ios"];
}

- (void)socketIODidConnect:(SocketIO *)socket
{
    NSLog(@"Socket has connected!");
}

- (void)socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet
{
    // Grab the data from the packet.
    NSDictionary *dict = packet.dataAsJSON;
    
    // Pull out the arguments from the dictionary.
    NSArray *args = dict[@"args"];
    
    // Access the number object at index 0 of the "args" array.
    NSNumber *numberObject = args[0];
    
    // Convert the number object into a standard integer.
    int number = [numberObject intValue];
    
    // %d is a placeholder for a variable of type "int".
    NSLog(@"%d", number);
    
    // Change the background color with the message's number as input.
    [self changeBackgroundColorWithCount:number];
}

- (void)changeBackgroundColorWithCount:(int)count
{
    // Declare an empty color object.
    UIColor *color;
    if(count == 0)
    {
        color = [UIColor blueColor];
    }
    else if(count == 1)
    {
        color = [UIColor redColor];
    }
    else if(count == 2)
    {
        color = [UIColor orangeColor];
    }
    else if(count == 3)
    {
        color = [UIColor purpleColor];
    }
    else
    {
        //If we get here, then the message doesn't recognize the "count" input
        color = [UIColor whiteColor];
    }
    
    self.view.backgroundColor = color;
}


@end
