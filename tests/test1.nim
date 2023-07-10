# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest, strformat
import nimpostal

test "can parse an address":
  setup_libpostal()
  for component in get_address_components("221B Baker St., London, England"):
    echo $component
  echo ""
  for component in get_address_components("221B Baker St., London, UK"):
    echo $component


  echo "Expanding 221B Baker Street., London, UK"
  for expansion in get_address_expansions("221B Baker Street., London, UK"):
    echo fmt"Expansion = {$expansion}"
  echo ""

  echo "Expanding 221B Baker St. London, UK"
  for expansion in get_address_expansions("221B Baker St. London, UK"):
    echo fmt"Expansion = {$expansion}"
