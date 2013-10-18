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

#import "CSWatchDog.h"

@interface CSWatchDog ()
@property (nonatomic) dispatch_source_t timer;
@property (nonatomic) SEL selector;
@property (nonatomic, weak) id target;

@end

@implementation CSWatchDog
- (id)initWithTimeInterval:(NSTimeInterval)interval
{
    self = [super init];
    if (self) {
		self.timeInterval = interval;
		_hasCompleted = NO;
		_isInvalidated = NO;
    }
    return self;
}


- (void)fire
{
	if (_isInvalidated) {
		@throw [NSException exceptionWithName:@"Invalid Invocation" reason:@"error: timer is already invalidated" userInfo:nil];
	}
	if (_hasCompleted) {
		@throw [NSException exceptionWithName:@"Invalid Invocation" reason:@"error: timer is already finished" userInfo:nil];
	}
	
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	
	// create our timer source
	self.timer = dispatch_source_create( DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
	
	dispatch_source_set_timer(self.timer, dispatch_time(DISPATCH_TIME_NOW, self.timeInterval * NSEC_PER_SEC), DISPATCH_TIME_FOREVER, 0);
	
	dispatch_source_set_event_handler(self.timer, ^{
		if ([self.delegate respondsToSelector:@selector(watchDogTimeHasPassed:)]) {
			[self.delegate watchDogTimeHasPassed:self];
		}
		[self update];
		_hasCompleted = YES;
		dispatch_source_cancel(self.timer);
	});
	
	if ([self.delegate respondsToSelector:@selector(watchDogDidFire:)]) {
		[self.delegate watchDogDidFire:self];
	}

	dispatch_resume(self.timer);
}

- (void)invalidate
{
	if (!_isInvalidated && !_hasCompleted) {
		dispatch_source_cancel(self.timer);
		_isInvalidated = YES;
	}
}

- (void)update
{
	@throw [NSException exceptionWithName:@"InvalidCallException" reason:@"You must subclass CSWatchdog and override the -update function" userInfo:nil];
}

- (void)dealloc
{
	NSLog(@"deallocating watchdog...");
    dispatch_release(self.timer);
}
@end
