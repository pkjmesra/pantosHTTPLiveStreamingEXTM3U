//
//  PlayerReader.h
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
// An implementation of the RFC as defined by pantos-http-live-streaming
// See http://tools.ietf.org/html/draft-pantos-http-live-streaming-00 for details
/**
 Implements a protocol for transmitting unbounded streams
 of multimedia data over HTTP.  It specifies the data format of the
 files and the actions to be taken by the server (sender) and the
 clients (receivers) of the streams.  It describes version 1.0 of this
 protocol.
 A multimedia presentation is specified by a URI [RFC3986] to a
 Playlist file, which is an ordered list of additional URIs.  Each URI
 in the Playlist file refers to a media file which is a segment of a
 single contiguous stream.

 To play the stream, the client first obtains the Playlist file and
 then obtains and plays each media file in the Playlist.  It reloads
 the Playlist file as described in the link above to discover
 additional segments.
 Playlists MUST be Extended M3U Playlist files [M3U].

 An M3U Playlist is a text file that consists of individual lines.
 Lines are terminated by either a single LF character or a CR
 character followed by an LF character.  Each line is a URI, a blank,
 or starts with the comment character '#'.  URIs identify media files
 to be played.  Blank lines are ignored.

 Lines that start with the comment character '#' are either comments
 or tags.  Tags begin with #EXT.  All other lines that begin with '#'
 are comments and SHOULD be ignored.

 Implementations SHOULD produce Playlist files encoded in UTF-8
 [RFC3629].  URIs to such Playlist files SHOULD end in .m3u8 and/or
 have the MIME type [RFC2046] application/x-mpegURL.
 
 The Extended M3U file format defines two tags: EXTM3U and EXTINF.  An
 Extended M3U file is distinguished from a basic M3U file by its first
 line, which MUST be #EXTM3U.

 EXTINF is a record marker that describes the media file identified by
 the URI that follows it.  Each media file URI MUST be preceded by an
 EXTINF tag.  Its format is:

 #EXTINF:<duration>,<title>

 "duration" is an integer that specifies the duration of the media
 file in seconds.  Durations SHOULD be rounded to the nearest integer.
 The remainder of the line following the comma is the title of the
 media file.
 */

#import <Foundation/Foundation.h>

@interface PlayerReader : NSObject

- (void)readAndReWriteTheFiles;
@end
