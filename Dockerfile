FROM ghcr.io/hyperk/hk-meta-externals:main

COPY . /usr/local/hk/hk-ToolApp

RUN --mount=type=ssh mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts

WORKDIR /usr/local/hk
# Install hkToopApp, then enable all tools, then reinstall for proper linkage
RUN --mount=type=ssh . /usr/local/hk/hk-pilot/setup.sh &&\
    hkp install -r -e hk-ToolApp &&\
    hkp select --all &&\
    hkp install hk-ToolApp
