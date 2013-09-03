//
//  EXTXSTREAMINF.m
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

#import "EXTXSTREAMINF.h"

#import "RecordMarkerConstants.h"

@interface EXTXSTREAMINF()
{
    int                     _bandwidth;
    int                     _programId;
    NSString                *_codecs;
    NSString                *_audio;
    NSString                *_variantPlaylistURI;
    NSString                *_resolution;
    NSString                *_playlistURIExtension;
}
@end

@implementation EXTXSTREAMINF
@synthesize bandwidth=_bandwidth;
@synthesize programID=_programId;
@synthesize codecs=_codecs;
@synthesize audio=_audio;
@synthesize variantPlaylistURI=_variantPlaylistURI;
@synthesize resolution=_resolution;
@synthesize playlistURIExtension=_playlistURIExtension;

-(EXTXSTREAMINF*)initWithString:(NSString*)extInfRecordMarker
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
        NSRange start = [extInfRecordMarker rangeOfString:EXTXSTREAMINF_RECORDMARKER];
        if (start.length >0)
        {
            NSString *allString = [extInfRecordMarker substringFromIndex:start.location + start.length];
            NSRange bandwidthStart = [allString rangeOfString:STREAMINF_BANDWIDTH_KEY];
            // Try and extract bandwidth
            if (bandwidthStart.location != NSNotFound)
            {
                NSString *bandwidth = [allString substringFromIndex:bandwidthStart.location + bandwidthStart.length];
                NSRange bandwidthEnd = [bandwidth rangeOfString:COMMA];
                NSRange bandwidthEndCRLF = [bandwidth rangeOfString:CR];
                if (bandwidthEnd.location != NSNotFound)
                {
                    self.bandwidth = [[bandwidth substringToIndex:bandwidthEnd.location] intValue];
                }else if(bandwidthEndCRLF.location != NSNotFound)
                {
                    self.bandwidth = [[bandwidth substringToIndex:bandwidthEndCRLF.location] intValue];
                }
            }
            // try and extract program-id
            NSRange programIdStart = [allString rangeOfString:STREAMINF_PROGRAMID_KEY];
            if (programIdStart.location != NSNotFound)
            {
                NSString *programID = [allString substringFromIndex:programIdStart.location + programIdStart.length];
                NSRange programIdEnd = [programID rangeOfString:COMMA];
                if (programIdEnd.location != NSNotFound)
                    self.programID = [[programID substringToIndex:programIdEnd.location] intValue];
            }
            // try and extract RESOLUTION
            NSRange resolutionStart = [allString rangeOfString:STREAMINF_RESOLUTION_KEY];
            if (resolutionStart.location != NSNotFound)
            {
                NSString *resolution = [allString substringFromIndex:resolutionStart.location + resolutionStart.length];
                NSRange resolutionEnd = [resolution rangeOfString:COMMA];
                if (resolutionEnd.location != NSNotFound)
                    self.resolution = [resolution substringToIndex:resolutionEnd.location];
            }
            
            // Try and extract codecs
            NSRange codecsStart = [allString rangeOfString:STREAMINF_CODECS_KEY];
            if (codecsStart.location != NSNotFound)
            {
                NSString *codecs = [allString substringFromIndex:codecsStart.location + codecsStart.length];
                NSRange codecsEnd = [codecs rangeOfString:CrLf];
                if (codecsEnd.location != NSNotFound)
                    self.codecs = [codecs substringToIndex:codecsEnd.location];
            }
            // Try and extract audio
            NSRange audioStart = [allString rangeOfString:STREAMINF_AUDIO_KEY];
            if (audioStart.location != NSNotFound)
            {
                NSString *audios = [allString substringFromIndex:audioStart.location + audioStart.length];
                NSRange audiosEnd = [audios rangeOfString:CrLf];
                if (audiosEnd.location != NSNotFound)
                    self.audio = [audios substringToIndex:audiosEnd.location];
            }

            NSRange startcrlf = [extInfRecordMarker rangeOfString:CrLf];
            NSString *titleString = [extInfRecordMarker substringFromIndex:startcrlf.location + startcrlf.length];
            NSRange endcrlf = [titleString rangeOfString:CrLf];
            if (endcrlf.location != NSNotFound)
            {
                self.variantPlaylistURI = [titleString substringToIndex:endcrlf.location];
                NSArray *fileParts = [self.variantPlaylistURI componentsSeparatedByString:FILEEXTENSION_MARKER];
                if ([fileParts count]>0)
                {
                    // Assumption is last part is extension
                    self.playlistURIExtension =[FILEEXTENSION_MARKER stringByAppendingString:[fileParts objectAtIndex:[fileParts count]-1]];
                }
            }
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
    //#EXT-X-STREAM-INF:PROGRAM-ID=119,BANDWIDTH=748992,RESOLUTION=544x480,CODECS="avc1.42e01e,mp4a.40.2"
    //03.m3u8
    //    return [NSString stringWithFormat:@"%@%@%d%@%@%d%@%@%@%@%@%@%@%@%@",
    //            EXTXSTREAMINF_RECORDMARKER,
    //            STREAMINF_PROGRAMID_KEY,
    //            self.programID,
    //            COMMA,
    //            STREAMINF_BANDWIDTH_KEY,
    //            self.bandwidth,
    //            COMMA,
    //            STREAMINF_RESOLUTION_KEY,
    //            self.resolution,
    //            COMMA,
    //            STREAMINF_CODECS_KEY,
    //            self.codecs,
    //            CrLf,
    //            self.variantPlaylistURI,
    //            CrLf];
    NSMutableString* str = [NSMutableString string];
    [str appendFormat:@"%@%@%d%@%@%d",
     EXTXSTREAMINF_RECORDMARKER,
     STREAMINF_PROGRAMID_KEY,
     self.programID,
     COMMA,
     STREAMINF_BANDWIDTH_KEY,
     self.bandwidth];
    if(self.resolution)
    {
        [str appendFormat:@"%@%@%@",COMMA,STREAMINF_RESOLUTION_KEY,self.resolution];
    }
    if(self.codecs)
    {
        [str appendFormat:@"%@%@%@",COMMA,STREAMINF_CODECS_KEY,self.codecs];
    }
    if(self.audio)
    {
        [str appendFormat:@"%@%@%@",COMMA,STREAMINF_AUDIO_KEY,self.audio];
    }
    [str appendString:CrLf];
    [str appendString:self.variantPlaylistURI];
    [str appendString:CrLf];
    return str;
}

@end
