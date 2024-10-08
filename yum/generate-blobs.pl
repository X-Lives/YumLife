#!/usr/bin/env perl
use warnings;
use strict;

use Compress::Zlib qw(compress);

my @files = qw(font_32_64_yum.tga);

open(my $cpp, '>', '../gameSource/yumBlob.cpp') or die("open(yumBlob.cpp): $!\n");
open(my $header, '>', '../gameSource/yumBlob.h') or die("open(yumBlob.h): $!\n");

print $header <<"EOT";
/* This file is auto-generated by yum/generate-blobs.pl */
/* DO NOT EDIT THIS FILE! */

#ifndef YUMBLOB_H
#define YUMBLOB_H

#include <stddef.h>
#include <stdint.h>

struct yumBlob {
    size_t originalSize;
    uint8_t *originalData;
    size_t compressedSize;
    const uint8_t *compressedData;

    uint8_t *getData();
    inline size_t getSize() const { return originalSize; };
    void write(const char *fname);
};

namespace blobs {
EOT

print $cpp <<"EOT";
/* This file is auto-generated by yum/generate-blobs.pl */
/* DO NOT EDIT THIS FILE! */

#include "yumBlob.h"

#include <stdlib.h>
#include <stdio.h>

#include "minorGems/formats/miniz.h"

uint8_t * yumBlob::getData() {
    if (originalData != NULL) {
        return originalData;
    }

    originalData = new uint8_t[originalSize];
    mz_ulong outSize = originalSize;
    int res = mz_uncompress(originalData, &outSize, compressedData, compressedSize);
    if (res != MZ_OK) {
        const char *reason = "unknown error";
        if (res == MZ_DATA_ERROR) {
            reason = "data corrupt or incomplete";
        } else if (res == MZ_BUF_ERROR) {
            reason = "output buffer too small";
        } else if (res == MZ_MEM_ERROR) {
            reason = "not enough memory";
        }
        fprintf(stderr, "mz_uncompress() failed: %s!\\n", reason);
        abort();
    }

    return originalData;
}

void yumBlob::write(const char *fname) {
    FILE *f = fopen(fname, "wb");
    if (f == NULL) {
        fprintf(stderr, "fopen(%s) failed!\\n", fname);
        abort();
    }
    fwrite(getData(), 1, getSize(), f);
    fclose(f);
}

EOT

sub slurp {
    my $fname = shift;
    open(my $f, '<', $fname);
    local $/ = undef;
    my $data = <$f>;
    close($f);
    return $data;
}

for my $f (@files) {
    my $data = slurp($f);
    my $size = length($data);

    my $zData = compress($data, 9);
    my $zSize = length($zData);

    printf "%s: %d / %d (%d%%)\n", $f, $zSize, $size, 100*$zSize/$size;

    my $arrayData = "";
    while ($zData =~ /(.)/gs) {
        if ($arrayData ne '') {
            $arrayData .= ',';
        }
        $arrayData .= ord($1);
    }

    $f =~ s/\..*//;
    print $header "    extern yumBlob $f;\n";
    print $cpp "static uint8_t ${f}_zdata[$zSize] = {$arrayData};\n";
    print $cpp "yumBlob blobs::$f = { $size, NULL, $zSize, ${f}_zdata };\n";
}

print $header <<"EOT";
};
#endif /* YUMBLOB_H */
EOT

close($header);
close($cpp);
