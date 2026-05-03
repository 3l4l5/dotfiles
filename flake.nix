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

      # Intel Mac: x86_64-darwin
      # Apple Silicon: aarch64-darwin
      system = "aarch64-darwin";

      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations.${username} =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            ./home.nix

            {
              home.username = username;
              home.homeDirectory = "/Users/${username}";
            }
          ];
        };
    };
}
