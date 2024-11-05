## Golang template

### Intro

This template was made with nix in mind. Run the following scripts from the root (where `flake.nix` is located) to build and run the go app. 

```sh
# To build and run the app

nix run


# To test out builds with verbose output

nix build -L

```
On some systems you'll need to add extra flags in order to execute nix run successfully. If this is your case run the following:

```sh
nix run --extra-experimental-features nix-command --extra-experimental-features flakes
```

---
### When using Nix on Docker

#### Build & Run Docker Container

You'll find a `Dockerfile` in this repo for users that cannot install Nix on their local machine but have a Docker runtime on their workstation.

```sh
# Build the image 

docker build -t go-nix .

# Run and shell into

docker run -it \
 --cpus="4" \
 -v $(pwd):/workspace/ go-nix 

```

#### Run nix within Docker Container

`/workspace` directory is where you find `flake.nix` within the docker container

```sh

# An attempt to try to speed  up the build 

nix build --cores 4 --max-jobs 4 -L

```

Tested on
- MacOS Sonoma
- Docker using nixos/nix

Made with 🚀