{ pkgs ? import <nixpkgs> {} }:

(pkgs.buildFHSUserEnv {
  name = "voicebot";
  targetPkgs = pkgs: (with pkgs;
    [
    	ruby_2_6
	gcc
	gnumake
	file
	libtool
	libffi
	pkgconfig
	(callPackage ./gems.nix { })
    ]);
  profile = "export LC_ALL=C; unset LANGUAGE";
  runScript = "./run.sh";
}).env
