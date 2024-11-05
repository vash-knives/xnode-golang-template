{
  buildGo123Module,
  lib,
  ...
}:
buildGo123Module rec {
  pname = "go-app";
  version = "1.0.0";
  src = ../go-app;
  
  #vendorHash = lib.fakeHash;
  vendorHash = "sha256-Heupmi9qWVq64O6d7zyLiR3nRj3D62BQ2Z81vTfTTMM=";

  # Add a buildPhase for debugging
  buildPhase = ''
    echo "Starting build phase"
    ls -la
    go build -v .
    echo "Build phase completed"
  '';

  installPhase = ''
    echo "Starting install phase"
    mkdir -p $out/bin
    echo "Contents of current directory:"
    ls -la
    echo "Searching for built binary:"
    find . -type f -executable
    echo "Trying to copy binary"
    cp -v ./${pname} $out/bin/ || cp -v $(find . -type f -executable) $out/bin/ || echo "Failed to copy binary"
    echo "Contents of $out/bin:"
    ls -la $out/bin
    echo "Install phase completed"
  '';
}