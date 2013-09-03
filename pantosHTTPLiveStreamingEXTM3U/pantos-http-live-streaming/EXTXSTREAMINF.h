//
//  EXTXSTREAMINF.h
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
 EXT-X-STREAM-INF:
 The EXT-X-STREAM-INF tag indicates that the next URI in the Playlist
 file identifies another Playlist file.  Its format is:

 #EXT-X-STREAM-INF:[attribute=value][,attribute=value]*
 <URI>

 The following attributes are defined for the EXT-X-STREAM-INF tag:

 BANDWIDTH=<n>

 where n is an approximate upper bound of the stream bitrate,
 expressed as a number of bits per second.

 PROGRAM-ID=<i>

 where i is a number that uniquely identifies a particular
 presentation within the scope of the Playlist file.

 A Playlist file MAY contain multiple EXT-X-STREAM-INF URIs with the
 same PROGRAM-ID to describe variant streams of the same presentation.

 CODECS="[format][,format]*"

 where each format specifies a media sample type that is present in a
 media file in the Playlist file.

 Valid format identifiers are those in the ISO File Format Name Space
 defined by RFC 4281 [http://tools.ietf.org/html/rfc4281].
 
 Providing variant streams:
 A server MAY offer multiple Playlist files to provide different
 encodings of the same presentation.  If it does so it SHOULD provide
 a variant Playlist file that lists each variant stream to allow
 clients to switch between encodings dynamically.

 Variant Playlists MUST contain an EXT-X-STREAM-INF tag for each
 variant stream.  Each EXT-X-STREAM-INF tag for the same presentation
 MUST have the same PROGRAM-ID attribute value.  The PROGRAM-ID value
 for each presentation MUST be unique within the variant Playlist.

 If an EXT-X-STREAM-INF tag contains the CODECS attribute, the
 attribute value MUST include every format defined by [RFC4281] that
 is present in any media file that appears or will appear in the
 Playlist file.

 The server MUST meet the following constraints when producing variant
 streams:

 Each variant stream MUST consist of the same content, including
 content which is not part of the main presentation.

 The server MUST make the same period of content available for all
 variant streams, within an accuracy of the smallest target
 duration of the streams.

 The media files of variant streams MUST be either MPEG-2 Transport
 Streams or MPEG-2 Program Streams.  Their sample timestamps MUST
 match the timestamps of corresponding content in all other variant
 streams.

 In addition, all variant streams SHOULD contain the same audio
 encoding.  This allows clients to switch between streams without
 audible glitching.

 Example:
 Variant Playlist file


 #EXTM3U
 #EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1280000
 http://example.com/low.m3u8
 #EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2560000
 http://example.com/mid.m3u8
 #EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=7680000
 http://example.com/hi.m3u8
 #EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=65000,CODECS="mp4a.40.5"
 http://example.com/audio-only.m3u8
 #EXT-X-STREAM-INF:PROGRAM-ID=707,BANDWIDTH=452704,AUDIO="group00"
 02.m3u8
 */

#import <Foundation/Foundation.h>

@interface EXTXSTREAMINF : NSObject

@property (nonatomic, assign) int bandwidth;
@property (nonatomic, assign) int programID;
@property (nonatomic, strong) NSString *audio;
@property (nonatomic, strong) NSString *codecs;
@property (nonatomic, strong) NSString *variantPlaylistURI;
@property (nonatomic, strong) NSString *resolution;
@property (nonatomic, strong) NSString *playlistURIExtension;

-(id)init __attribute__((unavailable("init not available for this class")));
-(EXTXSTREAMINF*)initWithString:(NSString*)extInfRecordMarker;

@end
