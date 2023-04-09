# cutmidel in V

An experiment to rewrite [cutmidel] from C to V.

The code is shorter and simpler to write, but the size grew substantially.

| Language |  Size [B] |  Speed [ms] |
|----------|----------:|------------:|
| C        |    49,928 |      0.0055 |
| C++      |    53,104 |      0.0055 |
| Rust     |   300,368 |      0.0060 |
| V        |   490,832 |      0.0075 |
| Zig      |   877,054 |      0.0060 |
| Go       | 1,983,776 |      0.0070 |

See the others in [C++], [Rust], [Zig] and [Go].

## Build

    v cutmidel.v
    ./cutmidel longtest 1 2
    v vet .
    v fmt -w .

[cutmidel]: https://github.com/prantlf/cutmidel
[C++]: https://github.com/prantlf/cpp-cutmidel
[Rust]: https://github.com/prantlf/rust-cutmidel
[Go]: https://github.com/prantlf/go-cutmidel
[Zig]: https://github.com/prantlf/zig-cutmidel
