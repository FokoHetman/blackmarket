{lib, nixpkgs, system}: 
let
  distributors = (builtins.fromJSON (builtins.readFile ./distributors.json)).repos;
  lockedRevisions = (builtins.fromJSON (builtins.readFile ./distributors.json.lock)).repos;
  pkgs = nixpkgs.legacyPackages.${system};

  getSrc = name: attrs:
    pkgs.fetchgit {inherit (attrs) url; inherit (lockedRevisions.${name}) rev sha256; fetchSubmodules = attrs.submodules or false;};

  mkDistributor = name: attrs:
    let
      args = {inherit pkgs;};
      expr = import (getSrc name attrs + ("/" + (attrs.file or "")));
    in 
      expr args;
in
  lib.mapAttrs mkDistributor distributors
#hello = nixpkgs.legacyPackages.${system}.writeShellScriptBin "hello" "echo hi!";
