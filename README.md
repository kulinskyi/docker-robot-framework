# Robot Framework docker image

## What is image?

This Docker image contain a Robot Framework installation and Firefox ESR, Mozilla Webdriver, Selenium library for Robot Framework. The test cases and reports should be mounted as volumes.

## Where to file issues

Did you find issue? Leave information about it:

- [GITHUB: docker-robotframework/issues](https://github.com/kulinskyi/docker-robotframework/issues)

## The versions used software

* Robot Framework 3.1.1
* Robot Framework SeleniumLibrary 3.3.1
* Firefox ESR 60.4.0-r1
* Mozilla Webdriver 0.24.0

## How to use this image

### Running the container

A container based on this image can be running using the following command:

    docker container run --rm \
        -v <local path to reports>:/robotframework/output \
        -v <local path to tests>:/robotframework/tests \
        gnazar/robotframework:<version>

### Passing additional options

RobotFramework supports many options such as `--exclude`, `--variable`, `--loglevel`, etc.
These can be passed by using the `ROBOT_OPTIONS` environment variable, for example:

    docker container run --rm \
        -e ROBOT_OPTIONS="--loglevel DEBUG" \
        gnazar/robotframework:<version>

### Installation of additional modules

In the directory with test files you need to place a file `requirements.txt` with dependent modules. Before running the tests, this module will be installed.