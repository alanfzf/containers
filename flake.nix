{
  description = "";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ] (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        load =
          name:
          import "${name}" {
            inherit pkgs system;
          };
      in
      {
        packages = {
          php-ci-formatter = load ./packages/php-ci-formatter.nix;
        };

        defaultPackage = self.packages.${system}.php-ci-formatter;
      }
    );
}
