#!/bin/bash

find . -path ./gmock-1.7.0 -prune -o -type f -name '*.[ch]pp' -exec /c/Program\ Files\ \(x86\)/LLVM/bin/clang-format.exe -i {} \;
