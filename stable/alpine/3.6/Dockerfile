FROM alpine:3.6 as builder

ARG GECKO_DRIVER_VERSION="v0.24.0"

RUN apk add --no-cache wget ca-certificates

# Create Robot work directory
RUN mkdir /robotframework \
          /robotframework/webdrivers \
          /robotframework/tests \
          /robotframework/output

# Copy files in image
COPY . /robotframework

# Download Mozilla WebDriver
RUN wget -nv -O /tmp/geckodriver-$GECKO_DRIVER_VERSION-linux64.tar.gz \
    https://github.com/mozilla/geckodriver/releases/download/$GECKO_DRIVER_VERSION/geckodriver-$GECKO_DRIVER_VERSION-linux64.tar.gz && \
    tar xzf /tmp/geckodriver-$GECKO_DRIVER_VERSION-linux64.tar.gz -C /robotframework/webdrivers && \
    rm /tmp/geckodriver-$GECKO_DRIVER_VERSION-linux64.tar.gz

# Creating main image
FROM alpine:3.6

LABEL name="docker-robotframework" \
      description="Docker image for Robot Framework with Selenium Library and Mozilla Webdriver"

ARG ROBOT_VERSION="3.1.1" 
ARG SELENIUM_LIBRARY_VERSION="3.3.1"
ARG FIREFOX_VERSION="60.4.0-r1"

# Install Python 2.7, PyPi, Robot Framework with library
RUN set -xe && \
    sed -i -e 's/v[[:digit:]]\.[[:digit:]]/edge/g' /etc/apk/repositories && \
    apk update && \
    apk add --no-cache \
        curl ca-certificates python2 py2-pip openssh-client git \
        firefox-esr==$FIREFOX_VERSION &&\
    pip install --upgrade pip && \
    pip install \
    robotframework==$ROBOT_VERSION \
    robotframework-seleniumlibrary==$SELENIUM_LIBRARY_VERSION

# Robot variables
ENV PATH="/robotframework/webdrivers:$PATH" \
    ROBOT_OPTIONS=""

# Copy files from temporary image
COPY --from=builder /robotframework /robotframework

WORKDIR /robotframework
VOLUME ["/robotframework/output", "/robotframework/tests"]

CMD ["./entrypoint.sh"]