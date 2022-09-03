{ lib, stdenv
, buildPythonPackage
, fetchFromGitHub
, gcc10
, gmp
, mpfr
, cmake
, boost17x
, icu
, swig
, pcre
, opencascade-occt
, opencollada
, libxml2
}:

buildPythonPackage rec {
  pname = "ifcopenshell";
  version = "220823";
  format = "other";

  src = fetchFromGitHub {
    owner  = "IfcOpenShell";
    repo   = "IfcOpenShell";
    rev    = "blenderbim-${version}";
    fetchSubmodules = true;
    sha256 = "sha256-QONveZ0pbiZ73qjMKiDxm9y96qSZxR6KkU7lO2qhH2Q=";
  };

  nativeBuildInputs = [ gcc10 cmake ];

  buildInputs = [
    mpfr
    boost17x
    gmp
    icu
    pcre
    libxml2
  ];

  preConfigure = ''
    cd cmake
  '';

  PYTHONUSERBASE=".";
  cmakeFlags = [
    "-DUSERSPACE_PYTHON_PREFIX=ON"
    "-DOCC_INCLUDE_DIR=${opencascade-occt}/include/opencascade"
    "-DOCC_LIBRARY_DIR=${opencascade-occt}/lib"
    "-DOPENCOLLADA_INCLUDE_DIR=${opencollada}/include/opencollada"
    "-DOPENCOLLADA_LIBRARY_DIR=${opencollada}/lib/opencollada"
    "-DGMP_LIBRARY_DIR=${gmp}/lib"
    "-DGMP_INCLUDE_DIR=${gmp.dev}/include"
    "-DMPFR_LIBRARY_DIR=${mpfr}/lib"
    "-DSWIG_EXECUTABLE=${swig}/bin/swig"
    "-DLIBXML2_INCLUDE_DIR=${libxml2.dev}/include/libxml2"
    "-DLIBXML2_LIBRARIES=${libxml2.out}/lib/libxml2${stdenv.hostPlatform.extensions.sharedLibrary}"
  ];

  meta = with lib; {
    broken = stdenv.isDarwin;
    description = "Open source IFC library and geometry engine";
    homepage    = "http://ifcopenshell.org/";
    license     = licenses.lgpl3;
    maintainers = with maintainers; [ fehnomenal ];
  };
}
