//
//  switchwrapperwrapper.h
//  RecorderSwift
//
//  Created by Boss on 09/02/2018.
//  Copyright © 2018 Boss. All rights reserved.
//

#ifndef switchwrapperwrapper_h
#define switchwrapperwrapper_h

#import <Foundation/Foundation.h>


struct switchWrapper;

@interface switchWrapperWrapper: NSObject {
    struct switchWrapper *switchwrapper;
}

- (id) init;
- (void) dealloc;
- (void) findAllInputDevices;
- (const char *) getCurrentInputDevice;
- (void) setDevice: (char*) requestedname;
- (const char*) value;
- (void) initializeDeviceIterator;
- (void) advanceDeviceIterator;
- (bool) iteratorEnded;

@end

#endif /* switchwrapperwrapper_h */
