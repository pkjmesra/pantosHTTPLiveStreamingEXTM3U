//
//  EXTXMEDIA.m
//  pantosHTTPLiveStreamingEXTM3U
//
//  Created by Praveen Jha on 24/08/13.
//  Copyright (c) 2013 Research2Development. All rights reserved.
//

#import "EXTXMEDIA.h"
#import "RecordMarkerConstants.h"

@interface EXTXMEDIA()
{
    NSString *_type;
    NSString *_groupId;
    NSString *_name;
    NSString *_isDefault;
    NSString *_autoSelect;
    NSString *_uri;
    NSString *_language;
}
@end

@implementation EXTXMEDIA
@synthesize type=_type;
@synthesize groupId=_groupId;
@synthesize name=_name;
@synthesize isDefault=_isDefault;
@synthesize autoSelect=_autoSelect;
@synthesize uri=_uri;
@synthesize language =_language;

-(EXTXMEDIA*)initWithString:(NSString*)extInfRecordMarker
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
        NSRange start = [extInfRecordMarker rangeOfString:EXTXMEDIA_RECORDMARKER];
        if (start.length >0)
        {
            //#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="group00",NAME="pri",DEFAULT=YES,AUTOSELECT=YES,URI="08.m3u8"
            NSString *allString = [extInfRecordMarker substringFromIndex:start.location + start.length];
            NSRange end = [allString rangeOfString:CrLf];
            if (end.location != NSNotFound)
            {
                NSRange typeStart = [allString rangeOfString:MEDIA_TYPE_KEY];
                // Try and extract TYPE
                if (typeStart.location != NSNotFound)
                {
                    NSString *type = [allString substringFromIndex:typeStart.location + typeStart.length];
                    NSRange typeEnd = [type rangeOfString:COMMA];
                    NSRange typeEndCRLF = [type rangeOfString:CR];
                    if (typeEnd.location != NSNotFound)
                    {
                        self.type = [type substringToIndex:typeEnd.location];
                    }else if(typeEndCRLF.location != NSNotFound)
                    {
                        self.type = [type substringToIndex:typeEndCRLF.location];
                    }
                }
                // try and extract group-id
                NSRange groupIdStart = [allString rangeOfString:MEDIA_GROUPID_KEY];
                if (groupIdStart.location != NSNotFound)
                {
                    NSString *groupID = [allString substringFromIndex:groupIdStart.location + groupIdStart.length];
                    NSRange groupIdEnd = [groupID rangeOfString:COMMA];
                    if (groupIdEnd.location != NSNotFound)
                        self.groupId = [groupID substringToIndex:groupIdEnd.location];
                }
                // try and extract NAME
                NSRange nameStart = [allString rangeOfString:MEDIA_NAME_KEY];
                if (nameStart.location != NSNotFound)
                {
                    NSString *name = [allString substringFromIndex:nameStart.location + nameStart.length];
                    NSRange nameEnd = [name rangeOfString:COMMA];
                    if (nameEnd.location != NSNotFound)
                        self.name = [name substringToIndex:nameEnd.location];
                }

                // Try and extract DEFAULT
                NSRange isDefaultStart = [allString rangeOfString:MEDIA_DEFAULT_KEY];
                if (isDefaultStart.location != NSNotFound)
                {
                    NSString *isDefault = [allString substringFromIndex:isDefaultStart.location + isDefaultStart.length];
                    NSRange isDefaultEnd = [isDefault rangeOfString:CrLf];
                    NSRange isDefaultEndComma = [isDefault rangeOfString:COMMA];
                    if (isDefaultEndComma.location != NSNotFound)
                        self.isDefault = [isDefault substringToIndex:isDefaultEndComma.location];
                    else if (isDefaultEnd.location != NSNotFound)
                        self.isDefault = [isDefault substringToIndex:isDefaultEnd.location];
                }
                // Try and extract autoselect
                NSRange autoSelectStart = [allString rangeOfString:MEDIA_AUTOSELECT_KEY];
                if (autoSelectStart.location != NSNotFound)
                {
                    NSString *autoSelect = [allString substringFromIndex:autoSelectStart.location + autoSelectStart.length];
                    NSRange autoSelectEnd = [autoSelect rangeOfString:CrLf];
                    NSRange autoSelectEndComma = [autoSelect rangeOfString:COMMA];
                    if (autoSelectEndComma.location != NSNotFound)
                        self.autoSelect = [autoSelect substringToIndex:autoSelectEndComma.location];
                    else if (autoSelectEnd.location != NSNotFound)
                        self.autoSelect = [autoSelect substringToIndex:autoSelectEnd.location];
                }
                // Try and extract URI
                NSRange uriStart = [allString rangeOfString:MEDIA_URI_KEY];
                if (uriStart.location != NSNotFound)
                {
                    NSString *uri = [allString substringFromIndex:uriStart.location + uriStart.length];
                    NSRange uriEnd = [uri rangeOfString:CrLf];
                    NSRange uriEndComma = [uri rangeOfString:COMMA];
                    if (uriEndComma.location != NSNotFound)
                        self.uri = [uri substringToIndex:uriEndComma.location];
                    else if (uriEnd.location != NSNotFound)
                        self.uri = [uri substringToIndex:uriEnd.location];
                }
                // Try and extract LANGUAGE
                NSRange languageStart = [allString rangeOfString:MEDIA_LANGUAGE_KEY];
                if (languageStart.location != NSNotFound)
                {
                    NSString *language = [allString substringFromIndex:languageStart.location + languageStart.length];
                    NSRange languageEnd = [language rangeOfString:CrLf];
                    NSRange languageEndComma = [language rangeOfString:COMMA];
                    if (languageEndComma.location != NSNotFound)
                        self.language = [language substringToIndex:languageEndComma.location];
                    else if (languageEnd.location != NSNotFound)
                        self.language = [language substringToIndex:languageEnd.location];
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
    //#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="group00",NAME="pri",DEFAULT=YES,AUTOSELECT=YES,URI="08.m3u8"

    NSMutableString* str = [NSMutableString string];
    [str appendFormat:@"%@%@%@%@%@%@",
     EXTXMEDIA_RECORDMARKER,
     MEDIA_TYPE_KEY,
     self.type,
     COMMA,
     MEDIA_GROUPID_KEY,
     self.groupId];
    if(self.name)
    {
        [str appendFormat:@"%@%@%@",COMMA,MEDIA_NAME_KEY,self.name];
    }
    if(self.isDefault)
    {
        [str appendFormat:@"%@%@%@",COMMA,MEDIA_DEFAULT_KEY,self.isDefault];
    }
    if(self.autoSelect)
    {
        [str appendFormat:@"%@%@%@",COMMA,MEDIA_AUTOSELECT_KEY,self.autoSelect];
    }
    if(self.uri)
    {
        [str appendFormat:@"%@%@%@",COMMA,MEDIA_URI_KEY,self.uri];
    }
    if(self.language)
    {
        [str appendFormat:@"%@%@%@",COMMA,MEDIA_LANGUAGE_KEY,self.language];
    }
    [str appendString:CrLf];
    return str;
}

@end
