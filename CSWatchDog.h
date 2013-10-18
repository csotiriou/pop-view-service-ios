//  Created by Christos Sotiriou on 9/28/11.
//  Copyright 2011 Oramind.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
#import <Foundation/Foundation.h>


@class CSWatchDog;
@protocol CSWatchDogDelegate <NSObject>
@optional
- (void)watchDogDidFire:(CSWatchDog *)dog;
- (void)watchDogTimeHasPassed:(CSWatchDog *)dog;
@end


/**
 Wathdog class. Helper for cancelling things or calling selectors after a certain amount of time.
 */
@interface CSWatchDog : NSObject
@property (nonatomic) NSTimeInterval timeInterval;
@property (nonatomic, weak) id<CSWatchDogDelegate> delegate;

@property (nonatomic, readonly) BOOL hasCompleted;
@property (nonatomic, readonly) BOOL isInvalidated;

- (void)fire;

- (id)initWithTimeInterval:(NSTimeInterval)interval;
- (void)update;
- (void)invalidate;
@end