{
  stdenv,
  ...
}:
stdenv.mkDerivation {
  pname = "go-app";
  version = "v1.0.0";
  src = "../go-app";

  buildPhase = ''
    echo "woooooahhh"
    exit 1
  ''
}