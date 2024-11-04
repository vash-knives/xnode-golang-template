FROM nixos/nix

# Install basic tools
RUN nix-env -iA nixpkgs.git

# Create work directories
WORKDIR /workspace
# RUN mkdir go-app

# Copy flake
# COPY flake.nix /workspace/

# Set experimental flag
ENV NIX_CONFIG="experimental-features = nix-command flakes"

# Initialize flakes
# RUN nix flake update

# Set default work directory
# WORKDIR /workspace

# Use bash as entry point (so you can switch between environments)
ENTRYPOINT ["bash"]