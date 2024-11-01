{
  pkgs,
  server,
}:
pkgs.dockerTools.buildImage {
  fromImage = pkgs.callPackage ./nix {};

  name = "cliquet";
  tag = "latest";

  copyToRoot = [
    (pkgs.buildEnv {
      name = "root";
      paths = [server];
      pathsToLink = ["/bin"];
    })
  ];

  config = {
    Cmd = ["cliquet" "-p" "8000" "-H" "localhost"];
    Port = ["8000"];
  };
}
