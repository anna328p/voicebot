(with (import <nixpkgs> {});
let
  env = bundlerEnv {
    name = "voicebot-bundler-env";
    inherit ruby;
    gemfile  = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset   = ./gemset.nix;
    gemConfig = defaultGemConfig // {
      opus-ruby = attrs: {
        dontBuild = false;
        postPatch = ''
          substituteInPlace lib/opus-ruby.rb \
            --replace "ffi_lib 'opus'" \
                      "ffi_lib '${libopus}/lib/libopus${stdenv.hostPlatform.extensions.sharedLibrary}'"
        '';
      };
    };
  };
in stdenv.mkDerivation {
  name = "voicebot";
  buildInputs = [ env ruby opusTools libopus libopusenc ];
})
