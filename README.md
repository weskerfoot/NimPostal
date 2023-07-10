## Access the libpostal API from Nim and parse or expand addresses!

Example
```nim
```

See the tests for more detailed examples.

To install, simply add `https://github.com/weskerfoot/NimPostal` to your .nimble file, and make sure clang is installed, and add `switch("passL", "-L./libpostal/src/.libs -lpostal")` to config.nims in your project (or pass the linker flag manually). You may change the path to a more standard path if you're not compiling libpostal from source. Make sure it can find the shared library at runtime (may require setting `LD_LIBRARY_PATH` if you have it in a non-standard location).

For instructions on compiling libpostal see [here](https://github.com/openvenues/libpostal)
