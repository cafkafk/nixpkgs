{ lib
, stdenv
, fetchFromGitHub
, pkg-config
, cmake
, util-linux
, boost
# , fetchpatch, autoreconfHook
# , expat, flex, fontconfig, gd, gts, libjpeg, libpng, libtool, pango, bash, bison
# , xorg, ApplicationServices, python3, fltk, exiv2, withXorg ? true
}:

let inherit (lib) optional optionals optionalString;
in stdenv.mkDerivation rec {
  pname = "diagon";
  version = "unstable-2023-05-15";

  src = fetchFromGitHub {
    owner = "ArthurSonzogni";
    repo = "Diagon";
    rev = "81d56ea7402f15813ffc7ca0a309b84c7b366035";
    hash = "sha256-3nkMNcOOi0C9xtYM6Tzv5+INgDv9FArmlulrUkqHkWA=";
  };

  nativeBuildInputs = [
    pkg-config
    cmake
    util-linux
    boost
  ];

  # buildInputs = [
  #   libpng
  #   libjpeg
  #   expat
  #   fontconfig
  #   gd
  #   gts
  #   pango
  #   bash
  # ] ++ optionals withXorg (with xorg; [ libXrender libXaw libXpm ])
  # ++ optionals stdenv.isDarwin [ ApplicationServices ];

  # hardeningDisable = [ "fortify" ];

  # configureFlags = [
  #   "--with-ltdl-lib=${libtool.lib}/lib"
  #   "--with-ltdl-include=${libtool}/include"
  # ] ++ optional (xorg == null) "--without-x";

  # enableParallelBuilding = true;

  # CPPFLAGS = optionalString (withXorg && stdenv.isDarwin)
  #   "-I${cairo.dev}/include/cairo";

  # doCheck = false; # fails with "Graphviz test suite requires ksh93" which is not in nixpkgs

  # preAutoreconf = "./autogen.sh";

  # postFixup = optionalString withXorg ''
  #   substituteInPlace $out/bin/vimdot \
  #     --replace '"/usr/bin/vi"' '"$(command -v vi)"' \
  #     --replace '"/usr/bin/vim"' '"$(command -v vim)"' \
  #     --replace /usr/bin/vimdot $out/bin/vimdot \
  # '';

  # passthru.tests = {
  #   inherit (python3.pkgs) pygraphviz;
  #   inherit fltk exiv2;
  # };

  meta = with lib; {
    homepage = "https://arthursonzogni.com/Diagon/";
    description = "Interactive ASCII art diagram generators";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ cafkafk ];
  };
}
