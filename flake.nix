{
  description = "Go with Nix template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            go_1_22        # Go compiler and tools
            gopls         # Go language server
            golangci-lint # Linter
            delve        # Debugger
          ];

          shellHook = ''
            echo "🚀 Go development environment ready!"
            export GOPATH=$PWD/.go
            export PATH=$GOPATH/bin:$PATH
            export GO111MODULE=on
          '';
        };
      });
}