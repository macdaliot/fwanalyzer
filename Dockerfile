FROM golang:1.11

ADD https://github.com/golang/dep/releases/download/v0.5.0/dep-linux-amd64 /usr/bin/dep
RUN chmod +x /usr/bin/dep

RUN curl -sfL https://install.goreleaser.com/github.com/golangci/golangci-lint.sh | sh -s -- -b $(go env GOPATH)/bin v1.15.0

RUN apt update && apt -y install e2tools mtools file squashfs-tools unzip python-setuptools python-lzo
RUN wget https://github.com/crmulliner/ubi_reader/archive/master.zip -O ubireader.zip && unzip ubireader.zip && cd ubi_reader-master && python setup.py install

WORKDIR $GOPATH/src/github.com/cruise-automation/fwanalyzer

COPY . ./

RUN make deps
