# FROM ubuntu:18.04
FROM debian:9

RUN apt-get update
RUN apt-get install -yqq golang
RUN apt-get install -yqq git

RUN mkdir /gopath
ENV GOPATH=/gopath
ENV PATH=$PATH:/gopath/bin

RUN mkdir -p /gopath/src/github.com/purpleidea/mgmt
WORKDIR /gopath/src/github.com/purpleidea/mgmt

# check if dependencies need update, do this separate from the other codebase to better utilize docker cache
COPY misc/make-deps.sh /gopath/src/github.com/purpleidea/mgmt/misc/make-deps.sh
RUN misc/make-deps.sh

# copy in current codebase to use for building
COPY . /gopath/src/github.com/purpleidea/mgmt/
RUN go get -d -v

# build a fake release for testing
RUN git tag -f 0.0.0
RUN make releases/0.0.0/deb/mgmt_0.0.0_amd64.deb

# test if newly build .deb package works

# works
FROM ubuntu:18.04
COPY --from=0 /gopath/src/github.com/purpleidea/mgmt/releases/0.0.0/deb/mgmt_0.0.0_amd64.deb /
RUN apt-get update
RUN apt-get install -yqq /mgmt_0.0.0_amd64.deb
RUN /usr/bin/mgmt

# broken
FROM ubuntu:16.04
COPY --from=0 /gopath/src/github.com/purpleidea/mgmt/releases/0.0.0/deb/mgmt_0.0.0_amd64.deb /
RUN apt-get update
RUN apt-get install -yqq /mgmt_0.0.0_amd64.deb
RUN /usr/bin/mgmt

#broken
FROM debian:9
COPY --from=0 /gopath/src/github.com/purpleidea/mgmt/releases/0.0.0/deb/mgmt_0.0.0_amd64.deb /
RUN apt-get update
RUN apt-get install -yqq /mgmt_0.0.0_amd64.deb
RUN /usr/bin/mgmt
