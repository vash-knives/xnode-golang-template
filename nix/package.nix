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
}