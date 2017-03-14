# https://www.automatak.com/opendnp3/docs/guide/current/build/cmake/
#
# Start with ubuntu base
FROM ubuntu:latest

# Update apt and install dependencies
RUN apt-get update && \
    apt-get install -y git build-essential cmake findutils libasio-dev

# Pull DNP3 source code
RUN cd /usr/local/src && \
    git clone --recursive https://github.com/sintax1/dnp3.git

# Compile source code
RUN cd /usr/local/src/dnp3 && \
    cmake -DDNP3_DEMO=true . && \
    make

# Copy the binary
RUN cd /usr/local/src/dnp3 && \
    cp outstation-demo /usr/local/bin

# Open DNP3 port
EXPOSE 20000

# Start the outstation
ENTRYPOINT /usr/local/bin/outstation-demo
