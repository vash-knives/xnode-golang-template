FROM nixos/nix

# Install basic tools
RUN nix-env -iA nixpkgs.git

# Create work directories
WORKDIR /workspace
# RUN mkdir go-app

# Copy flake
# COPY flake.nix /workspace/

# Optimize Nix configuration
RUN mkdir -p /etc/nix && \
    echo 'substituters = https://cache.nixos.org' >> /etc/nix/nix.conf && \
    echo 'trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=' >> /etc/nix/nix.conf && \
    echo 'max-jobs = auto' >> /etc/nix/nix.conf && \
    echo 'cores = 0' >> /etc/nix/nix.conf && \
    echo 'experimental-features = nix-command flakes' >> /etc/nix/nix.conf


# Set experimental flag
ENV NIX_CONFIG="experimental-features = nix-command flakes"

# Initialize flakes
# RUN nix flake update

# Set default work directory
# WORKDIR /workspace

# Use bash as entry point (so you can switch between environments)
ENTRYPOINT ["bash"]