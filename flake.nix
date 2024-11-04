{
  description = "Go with Nix template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: 
  let 
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; }; # shorthand of nixpkgs { system = system; }
  in {
    packages.${system} = {
      default = pkgs.callPackage ../nix/package.nix {};
    };
  };
    
}