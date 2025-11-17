{ pkgs, system }:
let
in
pkgs.dockerTools.buildImage {
  name = "php-ci-formatter";
  tag = "latest";

  # TODO: https://github.com/actions/checkout/issues/334#issuecomment-2009585837

  copyToRoot = pkgs.buildEnv {
    name = "php-ci-formatter";
    paths = [
      pkgs.dockerTools.usrBinEnv
      pkgs.dockerTools.binSh
      pkgs.coreutils
      # pkgs.bash
      # pkgs.prettier
      # pkgs.php84Packages.php-cs-fixer
    ];
  };
}
