{
  buildGo122Module,
  lib,
  ...
}:
buildGo122Module rec {
  pname = "go-app";
  version = "1.0.0";
  src = ../go-app;
  
  buildPhase = ''
    echo "woooooahhh"
    exit 1
  '';
  
  # vendorHash = lib.fakeHash;
  vendorHash = "sha256-Heupmi9qWVq64O6d7zyLiR3nRj3D62BQ2Z81vTfTTMM=";
}