FROM ubuntu:18.04

RUN apt update
RUN apt install -yqq golang
RUN apt install -yqq git

RUN mkdir $HOME/gopath
ENV GOPATH=$HOME/gopath

RUN mkdir -p $GOPATH/src/github.com/purpleidea/
WORKDIR $GOPATH/src/github.com/purpleidea/
RUN git clone --recursive https://github.com/purpleidea/mgmt/
WORKDIR $GOPATH/src/github.com/purpleidea/mgmt

ENV PATH=$PATH:$GOPATH/bin

RUN make deps
RUN make build

RUN git tag -f 0.0.0
RUN make releases/0.0.0/deb/mgmt_0.0.0_amd64.deb

FROM ubuntu:18.04

COPY --from=0 /gopath/src/github.com/purpleidea/mgmt/releases/0.0.0/deb/mgmt_0.0.0_amd64.deb /

RUN apt-get install /mgmt_0.0.0_amd64.deb

WORKDIR /

ENTRYPOINT /usr/bin/mgmt
