{ ... }:
{
  users.users.root.openssh.authorizedKeys.keys = [
    # Add bootstrap key or remove root SSH access once an admin user exists.
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAVuOKcIS2j32m9jwY32+R4fvctas82v8zRmqZuDRYFY personal-PAR-4WTGP0G6C-20260307"
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDpql/htwN+cGITUFRP44DPPPmv2bFnAiYBgIF2KuYHhbpFjmH6bYkdLsj5qOy3/FmiNSpDh043YwVNT+3Nmh5Vj8p5rVzEvFp9OCoH1/hPxoneC8BIPhkMlbJ/nOkqwc2Sd7i51IMGwS6hur73U5ZlyTwWKx/eD3CyFQrvngkc2CzFYgVH++gWusRtpwwi0fTPg76qmXR3SynZg8g/5LDWpQFtNAo/hDaGVVHRDorf6mHXWt8KP1/mpGdn4J9BMYRz3Ky4QglHU41joRnXXQ8/QZZv6HOme4PdzvJqSlzy0zuhQ7xxBPNliSnLaAh38Bri8140A1P9gmcOrR7mLPeXW+M6ZYNdzCzpJ43DLiD5mugdzJzHdsJHjQ5oq9RTHJKetvBT9fPUQc7Tts5AiXVtOUxkc74B2HtXT0yktPNuWaWSBwtKNzxmHJn3vaPb3YIVsMR/06d1fZzSWKWgbA3Q2JGbaZHcA+c3Xgchn1d7dPHe5lAxxvVkwbDuzjvxOsITHuGwcuXsHJ4YoV6pTa08XcRgKPDvpYr0GZgLT5vPCn0UqzD/liK0Qv3HXk8uK/si/H67QPbnWhFS5b8jJJjtkpHwHej2gqBZuVJ4Bm7vI0ZNvfhtF7gE+38mI7auaVvvjH96FY2eVAGIUJ5RWaZg8dso5bLcLVYw3vSrudKi4w== rochequentin@PAR-4WTGP0G6C"
  ];

  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" ];
    initialHashedPassword = "$2y$12$bc.1FoT3wPWLCObhaR254.ZkSkBySysJEp8ne6rBheX2lrrSUkXPW"; # TODO: delete password: "ChangeMeNow-2026!"
    openssh.authorizedKeys.keys = [
      # Add your SSH public key here.
    ];
  };
}
