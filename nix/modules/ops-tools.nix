{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    tmux
    python3
  ];
}
