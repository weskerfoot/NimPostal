## Access the libpostal API from Nim and parse or expand addresses!

**Requires you to have libpostal installed**

build dependencies:
* clang
* pkg-config
* libpostal (installed system-wide)

See the tests for detailed examples.

To install, simply add `https://github.com/weskerfoot/NimPostal` to your .nimble file, and make sure the build dependencies are installed. If you installed libpostal using your system package manager (and followed the instructions to download the datasets) it should just work.

If you compiled libpostal from source, then add `switch("passL", "-L./libpostal/src/.libs -lpostal")` to config.nims in your project (customize depending on where you installed it). You may change the path to a more standard path if you did `sudo make install`. Make sure it can find the shared library at runtime (may require setting `LD_LIBRARY_PATH` if you have it in a non-standard location).

For instructions on compiling libpostal see [here](https://github.com/openvenues/libpostal)
