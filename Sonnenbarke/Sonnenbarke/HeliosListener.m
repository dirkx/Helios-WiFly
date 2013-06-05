//
//  HeliosListener.m
//  Sonnenbarke
//
//  Created by Dirk-Willem van Gulik on 03-06-13.
//  Copyright (c) 2013 Dirk-Willem van Gulik. All rights reserved.
//

#import "HeliosListener.h"

#define HELIOSPORT (12345)

typedef struct {
    uint16_t version;
    uint16_t lux;
    uint16_t cct;
    uint16_t red, green, blue;
    uint16_t temp;
}  __attribute__((packed)) heliosPacket;

NSString * kHeliosDeviceUpdated = @"HeliosDeviceUpdated";

@interface HeliosListener () {
    GCDAsyncUdpSocket *udpSocket;
}
@end

@implementation HeliosListener

-(id)init {
    return [self initWithPort:HELIOSPORT];
}

-(id)initWithPort:(NSInteger)port {
    
    self = [super init];
    if (!self) return nil;
    
    udpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self
                                              delegateQueue:dispatch_get_main_queue()];
    NSError *error = nil;
    
    if (![udpSocket bindToPort:port error:&error])
    {
        NSLog(@"Error binding: %@", error);
        return nil;
    }
    if (![udpSocket beginReceiving:&error])
    {
        NSLog(@"Error beginReceiving: %@", error);
        return nil;
    }
    
    return self;
}


- (void)udpSocket:(GCDAsyncUdpSocket *)sock
   didReceiveData:(NSData *)data
      fromAddress:(NSData *)address
withFilterContext:(id)filterContext
{
    NSString *host = nil;
    uint16_t port = 0;
    [GCDAsyncUdpSocket getHost:&host port:&port fromAddress:address];
    
    if ([data length] != sizeof(heliosPacket)) {
        
        NSLog(@"%s RECV: Unknown message from: %@:%hu (length %d) - ignored", __PRETTY_FUNCTION__, host, port, [data length]
              );
        return;
    }
    
    heliosPacket * packet = (heliosPacket*)[data bytes];
    
    if (((packet->version) >> 8) != 1) {
        NSLog(@"%s RECV: Unknown version from: %@:%hu - ignored", __PRETTY_FUNCTION__, host, port);
        return;
    }
    
    HeliosGadget * dev = [[HeliosGadget alloc] init];
    
    dev.lux = 1.0 * ntohs(packet->lux);
    dev.cct = 1.0 * ntohs(packet->cct);
    
    dev.red = 1.0 * ntohs(packet->red);
    dev.green = 1.0 * ntohs(packet->green);
    dev.blue = 1.0 * ntohs(packet->blue);

    // simple normalize
    double nc = MAX(dev.red, MAX(dev.blue, dev.green));
    dev.red /= nc;
    dev.blue /= nc;
    dev.green /= nc;
    
    dev.temp = 1.0 * ntohs(packet->temp);

    [[NSNotificationCenter defaultCenter] postNotificationName:kHeliosDeviceUpdated
                                                        object:dev];
    
    NSLog(@"Got Lux=%f and cct=%f", dev.lux, dev.cct);
}


@end
