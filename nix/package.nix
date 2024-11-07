{
  buildGo123Module,
  lib,
  ...
}:
let
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
  src = ../go-app;
  
  # vendorHash = lib.fakeHash;
  vendorHash = "sha256-3LBAOYoHID4Jy7fYyfm7b/ZSWrqbwlW/cz9CDFXDliA=";

  buildPhase = ''
    echo "Starting build phase"

    echo "Current working directory:"
    pwd

    echo "Parent directory contents:"
    ls -la ../

    echo "Full directory tree from root:"
    find / -name "cmd" 2>/dev/null
    
    echo "Full directory tree from current:"
    find . -type d

    echo "Source root: $sourceRoot"
    echo "NIX_BUILD_TOP: $NIX_BUILD_TOP"

    echo "Current directory contents:"
    ls -la

    echo "Creating a test directory:"
    mkdir cmd-dos
    echo "Checking again contents"
    ls -la

    echo "Building Go application..."
    go build -C cmd -v -o ${pname}
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