{lib, python3Packages, fetchFromGitHub, wl-clipboard, tesseract, qt4 }:

python3Packages.buildPythonApplication rec {
  pname = "normcap";
  version = "v0.3.11";
  format = "pyproject";


  #src = fetchPypi {
  #  inherit pname version;
  #  hash = ""; # TODO
  #};

  src = fetchFromGitHub {
    owner = "dynobo";
    repo = "normcap";
    rev = version;
    #rev = "5500e74727f0d3edb37945e46cb4e1ee7590e679";
    sha256 = "sha256-bGfTaJ/jmjZ4c4/4Yzmh6xwysPsk8lx63xPp6VupX6M=";
  };

  #preBuild = ''
  #  cat >setup.py <<'EOF'
  #  from setuptools import setup
  #  setup(
  #    name='normcap',
  #    # ...
  #  )
  #  EOF
  #'';

  nativeBuildInputs = [ tesseract  ];

  buildInputs = [ qt4 wl-clipboard ];

  propagatedBuildInputs = with python3Packages; [
    pytesseract
    poetry
    pyside
    pytest-qt
    pillow
    pysideShiboken
  ];

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
