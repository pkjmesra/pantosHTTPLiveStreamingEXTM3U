//
//  EXTINF.m
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

#import "EXTINF.h"
#import "RecordMarkerConstants.h"

@interface EXTINF()
{
    int         _duration;
    NSString    *_title;
    BOOL        _properInitUsed;
    NSString    *_mediaFileURIExtension;
}
@end

@implementation EXTINF
@synthesize duration=_duration;
@synthesize title=_title;
@synthesize mediaFileURIExtension=_mediaFileURIExtension;

-(EXTINF*)initWithString:(NSString*)extInfRecordMarker
{
    _properInitUsed =YES;
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
        NSRange start = [extInfRecordMarker rangeOfString:EXTINF_RECORDMARKER];
        if (start.length >0)
        {
            NSString *allString = [extInfRecordMarker substringFromIndex:start.location + start.length];
            NSRange end = [allString rangeOfString:COMMA];
            if (end.location != NSNotFound)
                self.duration = [[allString substringToIndex:end.location] intValue];

            start = [extInfRecordMarker rangeOfString:CrLf];
            NSString *titleString = [extInfRecordMarker substringFromIndex:start.location + start.length];
            end = [titleString rangeOfString:CrLf];
            if (end.location != NSNotFound)
            {
                self.title = [titleString substringToIndex:end.location];
                NSArray *fileParts = [self.title componentsSeparatedByString:FILEEXTENSION_MARKER];
                if ([fileParts count]>0)
                {
                    // Assumption is last part is extension
                    self.mediaFileURIExtension =[FILEEXTENSION_MARKER stringByAppendingString:[fileParts objectAtIndex:[fileParts count]-1]];
                }
            }
        }
    }
    return self;
}

- (id)init
{
    if (_properInitUsed)
    {
        return [super init];
    }
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"-init is not a valid initializer for this class"
                                 userInfo:nil];
    return nil;
}

-(NSString*)description
{
    if (self.duration >=0 && [self.title length]>0)
            return [NSString stringWithFormat:@"%@%d%@%@%@%@",EXTINF_RECORDMARKER,self.duration,COMMA,CrLf,self.title,CrLf];
    else if (self.duration >=0)
            return [NSString stringWithFormat:@"%@%d%@",EXTINF_RECORDMARKER,self.duration,CrLf];

     return [NSString stringWithFormat:@"%@%@",EXTINF_RECORDMARKER,CrLf];
}

@end
