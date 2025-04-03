{
  buildNpmPackage,
  fetchFromGitHub,
}:

buildNpmPackage rec {
  pname = "triliumnext-server";
  version = "0.92.4";

  src = fetchFromGitHub {
    owner = "TriliumNext";
    repo = "Notes";
    rev = "v${version}";
    hash = "sha256-ttVHJOMRpQmF7dm2tAXRCFTnGFCl5Rq4xR55QdLsW/s=";
  };

  npmDepsHash = "sha256-RlLJfSgtQ6D3rHPyOwgsGbrp5cL988GGkNodJ42TmCo=";

  npmBuildScript = "build:webpack";
  
  dontNpmInstall = true;
  makeCacheWritable = true;
}
