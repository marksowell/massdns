FROM alpine:edge

# Install necessary packages and dependencies
RUN apk add --no-cache \
    build-base \
    git \
    python3 \
    python3-dev \
    py3-pip \
    musl-dev \
    linux-headers \
    py3-dnspython \
    py3-psutil \
    py3-virtualenv

# Clone and build MassDNS
RUN git clone --depth=1 https://github.com/blechschmidt/massdns.git \
    && cd massdns \
    && make

WORKDIR /massdns/

# Create and activate a virtual environment
RUN python3 -m virtualenv venv \
    && venv/bin/pip install --no-cache --upgrade pip setuptools \
    && venv/bin/pip install --no-cache tqdm \
    && venv/bin/pip install --no-cache dnspython \
    && venv/bin/pip install --no-cache psutil

# Set the entry point to start inside the virtual environment and pass arguments
ENTRYPOINT ["venv/bin/python", "-m"]
