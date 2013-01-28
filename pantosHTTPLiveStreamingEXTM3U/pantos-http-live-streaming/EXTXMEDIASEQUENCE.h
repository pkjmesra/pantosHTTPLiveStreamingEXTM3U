//
//  EXTXMEDIASEQUENCE.h
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
/**
 Each media file URI in a Playlist has a unique sequence number.  The
 sequence number of a URI is equal to the sequence number of the URI
 that preceded it plus one.  The EXT-X-MEDIA-SEQUENCE tag indicates
 the sequence number of the first URI that appears in a Playlist file.
 Its format is:

 #EXT-X-MEDIA-SEQUENCE:<number>

 If the Playlist file does not contain an EXT-X-MEDIA-SEQUENCE tag
 then the sequence number of the first URI in the playlist SHALL be
 considered to be 1.
 
 Loading the Playlist file:
 Every time a Playlist file is loaded or reloaded from the Playlist
 URI:

 The client SHOULD check that the Playlist file begins with #EXTM3U
 and refuse to continue if it does not.  The client SHOULD ignore
 any tags it does not recognize.

 The client MUST determine the next media file to load.

 If the Playlist contains the EXT-X-MEDIA-SEQUENCE tag, the client
 SHOULD assume that each media file in it will become unavailable at
 the time that the Playlist file was loaded plus the duration of the
 Playlist file.  The duration of a Playlist file is the sum of the
 durations of the media files within it.
 
 The client MUST examine the Playlist file every time it is loaded or
 reloaded to determine the next media file to load.

 The first file to load MUST be the file that the client has chosen to
 play first.

 If the first file to be played has been loaded and the Playlist file
 does not contain the EXT-X-MEDIA-SEQUENCE tag then the client MUST
 verify that the current Playlist file contains the URI of the last
 loaded media file at the offset it was originally found at, halting
 playback if it does not.  The next media file to load MUST be the
 first media file URI following the last-loaded URI in the Playlist.

 If the first file to be played has been loaded and the Playlist file
 contains the EXT-X-MEDIA-SEQUENCE tag then the next media file to
 load SHALL be the one with the lowest sequence number that is greater
 than the sequence number of the last media file loaded.
 
 The client SHALL choose which media file to play first from the
 Playlist when playback starts.  If the Playlist file contains the
 EXT-X-ENDLIST tag, any file in the Playlist MAY be played first.  If
 the EXT-X-ENDLIST tag is not present, any file except for the last
 and second-to-last files in the Playlist MAY be played first.

 Once the first media file to play has been chosen, subsequent media
 files in the Playlist MUST be loaded in the order that they appear
 and played in the order that they are loaded.

 The client SHOULD attempt to load media files in advance of when they
 will be required for uninterrupted playback to compensate for
 temporary variations in latency and throughput.

 If the Playlist file contains the EXT-X-ALLOW-CACHE tag and its value
 is NO, the client MUST NOT cache downloaded media files after they
 have been played.  Otherwise the client MAY cache downloaded media
 files indefinitely for later replay.

 The client MAY use the value of the EXT-X-PROGRAM-DATE-TIME tag to
 display the program origination time to the user.  If the value
 includes time zone information the client SHALL take it into account,
 but if it does not the client MUST NOT infer an originating time
 zone.

 The client MUST NOT depend upon the correctness or the consistency of
 the value of the EXT-X-PROGRAM-DATE-TIME tag.
 */
#import <Foundation/Foundation.h>

@interface EXTXMEDIASEQUENCE : NSObject
@property (nonatomic, assign) int number;

-(id)init __attribute__((unavailable("init not available for this class")));
-(EXTXMEDIASEQUENCE*)initWithString:(NSString*)extInfRecordMarker;
@end
