FROM mcr.microsoft.com/devcontainers/cpp:1-ubuntu-22.04

ARG REINSTALL_CMAKE_VERSION_FROM_SOURCE="none"

RUN apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
        ca-certificates \
        curl \
        wget \
        file \
        git \
        software-properties-common

# Optionally install the cmake for vcpkg
COPY .devcontainer/reinstall-cmake.sh /tmp/
COPY .devcontainer/setup-cross-compile-env.sh /tmp/
COPY .toolchain/oecore-x86_64-core2-64-toolchain-10.0.sh /tmp/

RUN if [ "${REINSTALL_CMAKE_VERSION_FROM_SOURCE}" != "none" ]; then \
        chmod +x /tmp/reinstall-cmake.sh && /tmp/reinstall-cmake.sh ${REINSTALL_CMAKE_VERSION_FROM_SOURCE}; \
    fi \
    && rm -f /tmp/reinstall-cmake.sh

# [Optional] Uncomment this section to install additional vcpkg ports.
# RUN su vscode -c "${VCPKG_ROOT}/vcpkg install <your-port-name-here>"

RUN chmod +x /tmp/oecore-x86_64-core2-64-toolchain-10.0.sh \
    && /tmp/oecore-x86_64-core2-64-toolchain-10.0.sh -y

RUN chmod +x /tmp/setup-cross-compile-env.sh \
    && /tmp/setup-cross-compile-env.sh \
    && rm -f /tmp/oecore-x86_64-core2-64-toolchain-10.0.sh \
    && rm -f /tmp/setup-cross-compile-env.sh

RUN wget -qO- https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - \
    && add-apt-repository "deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy main" \
    && apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
        clang-tidy \
        clang-format \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
