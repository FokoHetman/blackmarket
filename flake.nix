{
  description = "The dark side of Nix. The Flake Blackmarket.";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };
  outputs = { self, nixpkgs }:
    let
      inherit (nixpkgs) lib;
 
      forAllSystems = lib.genAttrs lib.systems.flakeExposed;
    in
    {
      legacyPackages = forAllSystems (system: 
        (import ./. {inherit lib nixpkgs system;})
      );
    };
}



/*
{
  description = "Nix User Repository";



  outputs =
    inputs@{ flake-parts, nixpkgs, ... }:
    let
      inherit (nixpkgs) lib;
      manifest = (builtins.fromJSON (builtins.readFile ./repos.json)).repos;
      overlay = final: prev: {
        nur = import ./default.nix {
          nurpkgs = prev;
          pkgs = prev;
        };
      };
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = builtins.filter (
        system: builtins.hasAttr system nixpkgs.legacyPackages
      ) nixpkgs.lib.platforms.all;
      flake = {
        overlay = lib.warn "nur.overlay has been replaced by nur.overlays.default" overlay; # Added 2024-12-06
        nixosModules.nur = builtins.throw "nur.nixosModules.nur has been replaced by nur.modules.nixos.default"; # Added 2024-12-06
        hmModules.nur = builtins.throw "nur.hmModules.nur has been replaced by nur.modules.homeManager.default"; # Added 2024-12-06

        overlays = {
          default = overlay;
        };
        modules = lib.genAttrs [ "nixos" "homeManager" "darwin" ] (_: {
          default = {
            nixpkgs.overlays = [ overlay ];
          };
        });
      };
      imports = [
        inputs.flake-parts.flakeModules.modules
        inputs.treefmt-nix.flakeModule
      ];*/
/*
      perSystem =
        { pkgs, ... }:
        {
          treefmt.programs.nixfmt.enable = true;
          # legacyPackages is used because nur is a package set
          # This trick with the overlay is used because it allows NUR packages to depend on other NUR packages
          legacyPackages = (pkgs.extend overlay).nur;
        };
    };
}*/
