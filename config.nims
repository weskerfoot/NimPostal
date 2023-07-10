import system, strformat, strutils

const clangResourceDir = staticExec("clang -print-resource-dir").strip

switch("passL", staticExec("pkg-config --libs libpostal").strip)
switch("d", fmt"clangResourceDir={clangResourceDir}")
