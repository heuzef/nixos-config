{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (python3.withPackages (ps: with ps; [
      jupyter
      ipykernel
      notebook
      numpy
      pandas
      matplotlib
      scipy
      scikit-learn
      requests
      beautifulsoup4
      python-dotenv
      # langchain-mistralai
      yt-dlp
    ]))
  ];
}
