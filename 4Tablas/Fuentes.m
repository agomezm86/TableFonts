//
//  Fuentes.m
//  4Tablas
//
//  Created by Alejandro Gomez on 18/12/13.
//  Copyright (c) 2013 Intergrupo. All rights reserved.
//

#import "Fuentes.h"
#import "Constants.h"

@implementation Fuentes

+ (NSArray *)obtenerFuentes
{
    NSMutableArray *fuentes = [[NSMutableArray alloc] init];
    NSArray *lettersArray = [NSArray arrayWithArray:LETTERS];
    for (NSString *string in lettersArray)
    {
        NSArray *sectionArray = [[UIFont familyNames] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF beginswith[c] %@", string]];
        [fuentes addObject:[NSMutableArray arrayWithArray:sectionArray]];
    }
    return [NSArray arrayWithArray:fuentes];
}

+ (NSArray *)obtenerFuentesParaLaFamilia:(NSString *)familia
{
    NSArray *fuentes = [UIFont fontNamesForFamilyName:familia];
    NSArray *fuentes1 = [fuentes sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    return fuentes1;
}

@end
