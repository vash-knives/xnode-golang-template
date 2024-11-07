{
  buildGo123Module,
  lib,
  ...
}:
let
  # This was added as directories are not being copied to the clean environment that nix creates when running the buildgomodule
  # Previously you are forced to place your go files on the root go directory (eg. where y ou find go.mod, go.sum, etc)
  # What this does is it creates a path that points to the original source and executes from there. 
  source = builtins.path {
    name = "go-app-source";
    path = ../go-app;
    filter = path: type: 
      let 
        relPath = lib.removePrefix (toString ../go-app + "/") (toString path);
      in
        type == "directory" || 
        lib.hasSuffix ".go" path ||
        lib.hasSuffix "go.mod" path ||
        lib.hasSuffix "go.sum" path;
  };
in
buildGo123Module rec {
  pname = "go-app";
  version = "1.0.0";
  # src = ../go-app;
  src = source;
  
  # # For any change on your app code, uncomment this (vendorHash = lib.fakehash) and comment out the other vendorHash so it generates a new hash 
  # # which you will use to update the second vendorHash variable.
  # vendorHash = lib.fakeHash;
  vendorHash = "sha256-Heupmi9qWVq64O6d7zyLiR3nRj3D62BQ2Z81vTfTTMM=";

  buildPhase = ''
    echo "Starting build phase -- Nov 7 11:37pm"

    echo "Current working directory:"
    pwd

    echo "Current directory contents:"
    ls -la


    # # Explicitly set the proxy. To fix the GOPROXY=off issue
    # Ensure network access
    export GOPROXY="https://proxy.golang.org,direct"
    export GOSUMDB="sum.golang.org"
    export HOME=$TMPDIR
    
    # Debug info
    echo "Current GOPROXY: $GOPROXY"
    echo "Current GOSUMDB: $GOSUMDB"
    echo "Current HOME: $HOME"
    
    go mod download

    echo "Building Go application..."
    go build -o ${pname} ./cmd
    echo "Post-build directory contents:"
    ls -la
    echo "Build phase completed"
  '';

  installPhase = ''
    echo "Starting install phase"
    mkdir -p $out/bin
    echo "Copying binary to $out/bin"
    cp -v ${pname} $out/bin/
    echo "Contents of $out/bin:"
    ls -la $out/bin
    echo "Install phase completed"
  '';

}