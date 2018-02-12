//
//  switchwrapperwrapper.m
//  RecorderSwift
//
//  Created by Boss on 09/02/2018.
//  Copyright © 2018 Boss. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "switchwrapperwrapper.h"
#import "switch.h"

struct SwitchWrapper {
    Switch *switcher;
};

@implementation switchWrapperWrapper

- (id) init {
    //printf("WAS HERE");
    //self = [super init];
    
    if (self == [super init]) {
        switchwrapper = new struct SwitchWrapper;
        switchwrapper->switcher = new Switch();
        if (switchwrapper == NULL) printf("Not allocated");
    } return self;
}

- (void) dealloc {
    if (switchwrapper->switcher != NULL){
        delete switchwrapper->switcher;
        delete switchwrapper;
    }
}

- (void)printHello{
    switchwrapper->switcher->printHello();
}

/*- (int * ) getCurrentDeviceNameLength{
   // return switchwrapper->switcher->getCurrentDeviceNameLength();
}*/

- (void) findAllInputDevices {
    //NSlog(@"In objC find");
    switchwrapper->switcher->findAllInputDevices();
}

- (const char *) getCurrentInputDevice {
    return switchwrapper->switcher->getCurrentInputDevice();
}

- (void) setDevice: (const char*) requestedname {
    NSString *temp = [NSString stringWithUTF8String:requestedname];
    const char *cString = [temp cStringUsingEncoding:NSASCIIStringEncoding];
    switchwrapper->switcher->setDevice(cString);
}

- (const char*) value{
    return switchwrapper->switcher->value();
}

- (void) initializeDeviceIterator{
    switchwrapper->switcher->initializeDeviceIterator();
}

- (void) advanceDeviceIterator{
    switchwrapper->switcher->advanceDeviceIterator();
}

- (bool) iteratorEnded{
    return switchwrapper->switcher->iteratorEnded();
}

@end
