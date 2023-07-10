import system, strformat, strutils

const clangResourceDir = staticExec("clang -print-resource-dir").strip

switch("passL", "-L./libpostal/src/.libs -lpostal")
switch("d", fmt"clangResourceDir={clangResourceDir}")
