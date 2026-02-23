# Run with nix-shell
let
  pkgs = import <nixpkgs> {};
in
pkgs.mkShell {
  packages = [
    (pkgs.python313.withPackages (ps: with ps; [
      pip
      jupyter
      ipykernel
      notebook
      ## requirements.txt here : ##
      fastapi
      uvicorn
      starlette
      pydantic
      #############################
    ]))
  ];

  shellHook = ''
    export LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib.outPath}/lib:${pkgs.pythonManylinuxPackages.manylinux2014Package}/lib:$LD_LIBRARY_PATH";
    echo "Environnement prêt ! Lancer l'éditeur de code ou Jupyter avec : jupyter notebook notebook.ipynb"
  '';
}
