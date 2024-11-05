## Golang template

### Intro

This template was made with nix in mind. Run the following scripts from the root (where `flake.nix` is located) to build and run the go app. 

```sh
# To build and run the app

nix run


# To test out builds with verbose output

nix build -L

```

You'll find a `Dockerfile` in this repo for users that cannot install Nix on their local machine but have a Docker runtime on their workstation.

### When using Nix on Docker

```sh
# Build the image 

docker build -t go-nix .

# Run and shell into

docker run -it \
 --cpus="4" \
 -v $(pwd):/workspace/ go-nix 


```

## Navigate to the root folder and run

Root folder is where you find `flake.nix`

```sh

# An attempt to try to speed  up the build 

nix build --cores 4 --max-jobs 4 -L

```




