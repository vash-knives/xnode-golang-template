## Golang template

### When using Nix on Docker

```sh
# Build the image 

docker build -t go-nix .

# Run and shell into

docker run -it -v $(pwd):/workspace/ go-nix

```

## Navigate to the root folder and run

```sh

nix flake update


```




