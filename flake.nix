{
  description = "Ryusei's Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      username = "ryusei";

      mkHome = { system, homeDirectory }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};

          modules = [
            ./home.nix

            {
              home.username = username;
              home.homeDirectory = homeDirectory;
            }
          ];
        };
    in
    {
      homeConfigurations = {
        ryusei = mkHome {
          system = "aarch64-darwin";
          homeDirectory = "/Users/${username}";
        };

        ryusei-linux = mkHome {
          system = "aarch64-linux";
          homeDirectory = "/home/${username}";
        };
      };
    };
}