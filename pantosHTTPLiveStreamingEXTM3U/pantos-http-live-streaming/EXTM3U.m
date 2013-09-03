//
//  EXTM3U.m
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

#import "EXTM3U.h"
#import "RecordMarkerConstants.h"

@interface EXTM3U()
{
    BOOL _master;
    //! An array of EXTXSTREAMINF objects
    NSArray *_variantPlaylists;

    EXTXVERSION *_version;
    EXTXTARGETDURATION *_targetDuration;
    EXTXMEDIASEQUENCE *_mediaSequence;
    EXTXKEY *_key;
    //! An array of EXTINF objects
    NSArray *_media;
    //! An array of EXTXMEDIA objects
    NSArray *_masterMedia;
    NSString *_playlistContent;

}
@property (nonatomic, strong)NSString *playlistContent;
@end

@implementation EXTM3U
@synthesize master=_master;
@synthesize variantPlaylists=_variantPlaylists;
@synthesize version=_version;
@synthesize targetDuration=_targetDuration;
@synthesize mediaSequence=_mediaSequence;
@synthesize key=_key;
@synthesize media=_media;
@synthesize playlistContent=_playlistContent;
@synthesize masterMedia=_masterMedia;

-(EXTM3U*)initWithString:(NSString*)fileContents
{
    self = [super init];

    if (self)
    {
        if (![fileContents hasPrefix:HASH])
            fileContents =[HASH stringByAppendingString:fileContents];
        NSRange crlfRange = [fileContents rangeOfString:CrLf];
        if (crlfRange.length <=0)
        {
            fileContents = [fileContents stringByReplacingOccurrencesOfString:LF withString:CrLf];
        }
        NSRange start = [fileContents rangeOfString:EXTM3U_RECORDMARKER];
        if (start.length >0)
        {
            NSString *allString = [fileContents substringFromIndex:start.location + start.length];
            NSRange end = [allString rangeOfString:CrLf];
            if (end.location != NSNotFound)
                self.playlistContent = [allString substringFromIndex:end.location + end.length];

            if ([self.playlistContent rangeOfString:EXTXSTREAMINF_RECORDMARKER].length>0)
            {
                self.master =YES;
            }

            if (self.isMaster) // master playlist
            {
                // Check to see if it has #EXT-X-VERSION and/or #EXT-X-MEDIA tags
                // if so let's resolve them first

                NSArray *preStreamInfos = [self.playlistContent componentsSeparatedByString:CrLf];
                self.playlistContent =@"";
                NSMutableArray *allAudioMediaInfos =[NSMutableArray arrayWithCapacity:0];
                for (int index=0;index<preStreamInfos.count;index++)
                {
                    NSString *eachLine = [preStreamInfos objectAtIndex:index];
                    if ([eachLine length]>0)
                    {
                        if ([eachLine hasPrefix:EXTXVERSION_RECORDMARKER])
                        {
                            EXTXVERSION *v = [[EXTXVERSION alloc] initWithString:[eachLine stringByAppendingString:CrLf]];
                            self.version = v;
                        }
                        else if ([eachLine hasPrefix:EXTXMEDIA_RECORDMARKER])
                        {
                            EXTXMEDIA *t =[[EXTXMEDIA alloc] initWithString:[eachLine stringByAppendingString:CrLf]];
                            [allAudioMediaInfos addObject:t];
                        }
                        else
                        {
                            // We've reached the end of all audio sequence
                            if ([self.playlistContent length] <=0)
                            {
                                self.playlistContent =[NSString stringWithFormat:@"%@%@", eachLine, CrLf];
                            }
                            else
                            {
                                self.playlistContent =[NSString stringWithFormat:@"%@%@%@", self.playlistContent,eachLine, CrLf];
                            }
                        }
                    }
                }
                self.masterMedia = allAudioMediaInfos;
                
                NSArray *mediaStreamInfos = [self.playlistContent componentsSeparatedByString:EXTXSTREAMINF_RECORDMARKER];
                if ([mediaStreamInfos count]>0)
                {
                    NSMutableArray *allMediaInfos =[NSMutableArray arrayWithCapacity:mediaStreamInfos.count-1];
                    for (NSString *streamInfo in mediaStreamInfos)
                    {
                        if ([streamInfo length]>0)
                        {
                            EXTXSTREAMINF *streamInfoObj =[[EXTXSTREAMINF alloc] initWithString:[EXTXSTREAMINF_RECORDMARKER stringByAppendingString:streamInfo]];
                            if (streamInfoObj)
                            {
                                [allMediaInfos addObject:streamInfoObj];
//                                NSLog(@"streamInfoObj:%@",streamInfoObj);
                            }
                        }
                    }//end for
                    self.variantPlaylists = allMediaInfos;
                }
            }
            else // variant playlist
            {
                NSArray *variantInfos = [self.playlistContent componentsSeparatedByString:CrLf];
                NSMutableArray *variants =[NSMutableArray arrayWithCapacity:0];
                for (int index=0;index<variantInfos.count;index++)
                {
                    NSString *eachLine = [variantInfos objectAtIndex:index];
                    if ([eachLine length]>0)
                    {
                        if ([eachLine hasPrefix:EXTXVERSION_RECORDMARKER])
                        {
                            EXTXVERSION *v = [[EXTXVERSION alloc] initWithString:[eachLine stringByAppendingString:CrLf]];
                            self.version = v;
                        }
                        else if ([eachLine hasPrefix:EXTXTARGETDURATION_RECORDMARKER])
                        {
                            EXTXTARGETDURATION *t =[[EXTXTARGETDURATION alloc] initWithString:[eachLine stringByAppendingString:CrLf]];
                            self.targetDuration = t;
                        }
                        else if ([eachLine hasPrefix:EXTXMEDIASEQUENCE_RECORDMARKER])
                        {
                            EXTXMEDIASEQUENCE *m = [[EXTXMEDIASEQUENCE alloc] initWithString:[eachLine stringByAppendingString:CrLf]];
                            self.mediaSequence =m;
                        }
                        else if ([eachLine hasPrefix:EXTXKEY_RECORDMARKER])
                        {
                            EXTXKEY *k =[[EXTXKEY alloc] initWithString:[eachLine stringByAppendingString:CrLf]];
                            if ([variants count]>0)
                            {
                                // Append the key to the last variant
                                // This may happen when there is a key change for this variant ts file
                                EXTINF *lastInf =[variants lastObject];
                                lastInf.key = k;
                            }
                            else
                                self.key = k;
                        }
                        else if ([eachLine hasPrefix:EXTINF_RECORDMARKER])
                        {
                            index++;
                            NSString *nextLine = [variantInfos objectAtIndex:index];
                            EXTINF *i=[[EXTINF alloc] initWithString:[NSString stringWithFormat:@"%@%@%@%@",eachLine,CrLf,nextLine,CrLf]];
                            [variants addObject:i];
                        }
                        else
                        {
                            NSAssert(false, @"Not yet implemented! You're welcome to contribute!");
                        }
                    }//end if ([eachLine length]>0)
                }// end for
                self.media =variants;
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
    /*
     #EXTM3U
     #EXT-X-STREAM-INF:PROGRAM-ID=133,BANDWIDTH=440672
     02.m3u8
     #EXT-X-STREAM-INF:PROGRAM-ID=133,BANDWIDTH=748992
     03.m3u8
     #EXT-X-STREAM-INF:PROGRAM-ID=133,BANDWIDTH=1057312
     04.m3u8
     */
    // or
    /*
     #EXTM3U
     #EXT-X-VERSION:4
     #EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="group00",NAME="pri",DEFAULT=YES,AUTOSELECT=YES,URI="08.m3u8"
     #EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="group00",NAME="sec",DEFAULT=NO,AUTOSELECT=YES,URI="11.m3u8"
     #EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="group01",NAME="pri",DEFAULT=YES,AUTOSELECT=YES,URI="09.m3u8"
     #EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="group01",NAME="sec",DEFAULT=NO,AUTOSELECT=YES,URI="12.m3u8"
     #EXT-X-STREAM-INF:PROGRAM-ID=707,BANDWIDTH=452704,AUDIO="group00"
     02.m3u8
     #EXT-X-STREAM-INF:PROGRAM-ID=707,BANDWIDTH=854272,AUDIO="group01"
     03.m3u8
     */
    NSString *finalVariant =[EXTM3U_RECORDMARKER stringByAppendingString:CrLf];
    if (self.isMaster)
    {
        if (self.version)
        {
            finalVariant = [finalVariant stringByAppendingString:[self.version description]];
        }
        // master playlist with audio SAP media
        NSString *allAudioStreamListInfs = [self.masterMedia componentsJoinedByString:@""];
        if ([allAudioStreamListInfs length]>0)
        {
            finalVariant = [finalVariant stringByAppendingString:allAudioStreamListInfs];
        }
        // master playlist with variant info
        NSString *allStreamListInfs = [self.variantPlaylists componentsJoinedByString:@""];
        if ([allStreamListInfs length]>0)
        {
            finalVariant = [finalVariant stringByAppendingString:allStreamListInfs];
        }
    }
    else
    {
        // Variant playlist
        NSString *allPlaylistInfs = [self.media componentsJoinedByString:@""];
        if ([[self.version description] length]>0)
        {
            finalVariant = [finalVariant stringByAppendingString:[self.version description]];
        }
        if ([[self.targetDuration description] length]>0)
        {
            finalVariant = [finalVariant stringByAppendingString:[self.targetDuration description]];
        }
        if ([[self.mediaSequence description] length]>0)
        {
            finalVariant = [finalVariant stringByAppendingString:[self.mediaSequence description]];
        }
        if ([[self.key description] length]>0)
        {
            finalVariant = [finalVariant stringByAppendingString:[self.key description]];
        }
        if ([allPlaylistInfs length]>0)
        {
            finalVariant = [finalVariant stringByAppendingString:allPlaylistInfs];
        }
    }
    return finalVariant;
}

@end
