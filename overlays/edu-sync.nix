self: super:

{
  edu-sync = self.rustPlatform.buildRustPackage rec {
    pname = "edu-sync";
    version = "0.3.2";

    src = self.fetchFromGitHub {
      owner = "mkroening";
      repo = "edu-sync";
      rev = "4177e028f3947064f272d3c33627bb7e9b4c98af";
      sha256 = "sha256-hgbODqJgRyGGW9OCaYPHpxu8cQ1AbKL7IAECsEvNLOc=";
    };
    cargoLock.lockFile = "${src}/Cargo.lock";

    cargoSha256 = "0000000000000000000000000000000000000000000000000000";

    meta = with self.lib; {
      description = "Moodle documents sync";
      license = licenses.gpl3;
      maintainers = [ ];
    };
  };
}
