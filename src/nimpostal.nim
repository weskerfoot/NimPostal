# Copyright (C) 2023-2023 Wesley Kerfoot
# MIT License, see license.txt

import system, strutils, sequtils, strformat, options, futhark, locks, sets
export options

const clangResourceDir {.strdefine.}: string = staticExec("clang -print-resource-dir").strip
importc:
  sysPath fmt"{clangResourceDir}/include"
  path: "/usr/local/include/libpostal/"
  "libpostal.h"

proc `$`*(cst : ptr cschar) : string {.inline.} =
  result = $cast[cstring](cst)

proc setup_libpostal*() =
  if not (libpostalSetup() and libpostalSetupParser() and libpostal_setup_language_classifier()):
    writeLine(stderr, "Failed to setup libpostal")
    quit(1)

proc teardown_libpostal*() =
  libpostalTeardown()
  libpostalTeardownParser()
  libpostalTeardownLanguageClassifier()

iterator get_address_components*(address: string) : (string, string) =
  let options : libpostal_address_parser_options_t = libpostalGetAddressParserDefaultOptions()
  let parsed : ptr libpostal_address_parser_response_t = libpostalParseAddress(address, options)

  for i in countup(0, parsed.num_components.int-1):
      let component = cast[ptr ptr cschar](cast[int](parsed.components) + cast[int](i * parsed.components.sizeof))
      let label = cast[ptr ptr cschar](cast[int](parsed.labels) + cast[int](i * parsed.labels.sizeof))
      yield ($label[], $component[])

  libpostalAddressParserResponseDestroy(parsed)

iterator get_address_expansions*(address: string) : string =
  let options : libpostal_normalize_options_t = libpostalGetDefaultOptions()
  var num_expansions: csize_t
  let expansions : ptr ptr cschar = libpostalExpandAddress(address.cstring, options, num_expansions.addr)

  for i in countup(0, num_expansions.int-1):
      let expansion = cast[ptr ptr cschar](cast[int](expansions) + cast[int](i * expansions.sizeof))
      yield $expansion[]

  libpostalExpansionArrayDestroy(expansions, num_expansions)

proc addresses_equal*(address1: string, address2: string) : bool =
  let expansionsLeft = toHashSet(toSeq(get_address_expansions(address1)))
  let expansionsRight = toHashSet(toSeq(get_address_expansions(address2)))

  return intersection(expansionsLeft, expansionsRight).len > 0
