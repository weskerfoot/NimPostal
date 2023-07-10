import unittest, strformat, sequtils
import nimpostal

test "can parse an address":
  let address1 = "221B Baker St., London, UK"
  let address2 = "221B Baker St. London, UK"
  let address3 = "223B Baker St. London, UK"
  let address4 = "221B Baker Ave. London, UK"
  let address5 = "221 B Baker Ave., London, UK"

  setup_libpostal()
  echo fmt"Testing components for {address1} and {address2}"
  assert toSeq(get_address_components(address1)).len > 0
  assert toSeq(get_address_components(address2)).len > 0

  echo fmt"Expanding {address4}"
  assert toSeq(get_address_expansions(address4)).len > 0

  echo fmt"Expanding {address5}"
  assert toSeq(get_address_expansions(address5)).len > 0

  echo fmt"Testing that {address1} equals {address2}"
  assert addresses_equal(address1, address2)
  assert addresses_equal(address2, address1)

  echo fmt"Testing that {address1} does not equal {address3}"
  assert not addresses_equal(address1, address3)
  assert not addresses_equal(address3, address1)

  echo fmt"Testing that {address1} does not equal {address4}"
  assert not addresses_equal(address1, address4)
  assert not addresses_equal(address4, address1)

  echo fmt"Testing that {address4} equals {address5}"
  assert addresses_equal(address5, address4)
  assert addresses_equal(address4, address5)

  teardown_libpostal()
