//
//  EXTXTARGETDURATION.m
//  PlayerFileParsing
//
/**
 Copyright (c) 2011, Research2Development Inc.
 All rights reserved.

 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:

 Redistributions of source code must retain the above copyright notice, this list
 of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this
 list of conditions and the following disclaimer in the documentation and/or other
 materials provided with the distribution.
 Neither the name of the Research2Development Inc. nor the names of its contributors may be
 used to endorse or promote products derived from this software without specific
 prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 OF THE POSSIBILITY OF SUCH DAMAGE."
 **/
//
//

#import "EXTXTARGETDURATION.h"
#import "RecordMarkerConstants.h"

@interface EXTXTARGETDURATION()
{
    int         _duration;
}
@end

@implementation EXTXTARGETDURATION
@synthesize duration=_duration;

-(EXTXTARGETDURATION*)initWithString:(NSString*)extInfRecordMarker
{
    self = [super init];

    if (self)
    {
        if (![extInfRecordMarker hasPrefix:HASH])
            extInfRecordMarker =[HASH stringByAppendingString:extInfRecordMarker];
        NSRange crlfRange = [extInfRecordMarker rangeOfString:CrLf];
        if (crlfRange.length <=0)
        {
            extInfRecordMarker = [extInfRecordMarker stringByReplacingOccurrencesOfString:LF withString:CrLf];
        }
        NSRange start = [extInfRecordMarker rangeOfString:EXTXTARGETDURATION_RECORDMARKER];
        if (start.length >0)
        {
            NSString *allString = [extInfRecordMarker substringFromIndex:start.location + start.length];
            NSRange end = [allString rangeOfString:CrLf];
            if (end.location != NSNotFound)
                self.duration = [[allString substringToIndex:end.location] intValue];
        }
    }
    return self;
}

- (id)init
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"-init is not a valid initializer for this class"
                                 userInfo:nil];
    return nil;
}

-(NSString*)description
{
    // #EXT-X-TARGETDURATION:15
    return [NSString stringWithFormat:@"%@%d%@",EXTXTARGETDURATION_RECORDMARKER,self.duration>0?self.duration:1,CrLf];
}

@end
