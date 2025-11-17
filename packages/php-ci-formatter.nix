{ pkgs, system }:

pkgs.dockerTools.buildLayeredImage {
  name = "php-ci-formatter";
  tag = "latest";

  contents = [
    pkgs.php84Packages.php-cs-fixer
    pkgs.prettier
  ];
}
