//
//  Fuentes.h
//  4Tablas
//
//  Created by Alejandro Gomez on 18/12/13.
//  Copyright (c) 2013 Intergrupo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fuentes : NSObject

+ (NSArray *)obtenerFuentes;
+ (NSArray *)obtenerFuentesParaLaFamilia:(NSString *)familia;

@end
