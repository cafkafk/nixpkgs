{ lib
, python3Packages
, fetchFromGitHub
, wl-clipboard
, tesseract
, python3
, liblo
, cmake
, pysideApiextractor
, qt4
#, qtbase
#, qttools
#, wrapQtAppsHook
}:

let
  myPython = python3.withPackages (pkgs: with pkgs; [ pyqt5 liblo pyliblo pyxdg ]);
in
python3Packages.buildPythonApplication rec {
  pname = "normcap";
  version = "v0.3.11";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "dynobo";
    repo = "normcap";
    rev = version;
    #rev = "5500e74727f0d3edb37945e46cb4e1ee7590e679";
    sha256 = "sha256-bGfTaJ/jmjZ4c4/4Yzmh6xwysPsk8lx63xPp6VupX6M=";
  };

  nativeBuildInputs = [ 
    myPython
    tesseract
    cmake
    #wrapQtAppsHook
    #qttools
    #qttools
    wl-clipboard
  ];

  #buildInputs = [ 
  #];

  py = python3.override {
    packageOverrides = self: super: {
      pyqt5 = super.pyqt5.override {
        withLocation = true;
      };
    };
  };

  pythonBuildInputs = with py.pkgs; [
    pytesseract
    poetry
    pyside
    pytest-qt
    pillow
    pysideShiboken
  ];

  propagatedBuildInputs =  [
    myPython
    pysideApiextractor
    qt4
    #qtbase
  ] ++ pythonBuildInputs;

  dontWrapQtApps = true;

  # NOTE I assumed this is right because no tests exist
  #doCheck = false;

  meta = with lib; {
    description = "OCR powered screen-capture tool to capture information instead of images";
    longDescription =
      '' OCR powered screen-capture tool to capture information instead of images.
      '';
    homepage = "https://dynobo.github.io/normcap/";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ cafkafk ];
    platforms = platforms.unix;
  };
}
