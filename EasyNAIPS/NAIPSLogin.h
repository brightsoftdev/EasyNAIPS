//
//  NAIPSLogin.h
//  taf
//
//  Created by Iain Blair on 26/08/12.
//
//

#import "NAIPSObject.h"

@interface NAIPSLogin : NAIPSObject

-(id) initWithUsername: (NSString*) usernameString AndPassword: (NSString*) passwordString;

@property (nonatomic, strong, readonly) NSString* username;
@property (nonatomic, strong, readonly) NSString* password;


@end
