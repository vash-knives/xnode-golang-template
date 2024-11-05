{
  buildGoModule,
  lib,
  ...
}:
buildGoModule rec {
  pname = "go-app";
  version = "1.0.0";
  src = ../go-app;
  
  #vendorHash = lib.fakeHash;
  vendorHash = "sha256-Heupmi9qWVq64O6d7zyLiR3nRj3D62BQ2Z81vTfTTMM=";

  buildPhase = ''
    echo "Starting build phase"
    echo "Current directory contents:"
    ls -la
    echo "Building Go application..."
    go build -v -o ${pname}
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