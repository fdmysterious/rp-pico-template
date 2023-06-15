Simple pico-sdk template
========================

- Florian Dupeyron
- June 2023

This is a simple template that allows to play around with the [pico-sdk](https://github.com/raspberrypi/pico-sdk),
with the following tools:

- CMake is used as the build system (used by pico-sdk)
- Docker wraps the build environment
- [Just](https://just.systems) adds some shortcuts commands

## Build the project

With `just` and `docker` installed, it should be as simple as:

```bash
just build
```

You should obtain a `build/build.uf2` file that you can flash to your pico

## TODO

- [ ] Debugging support
- [ ] VSCode integration
