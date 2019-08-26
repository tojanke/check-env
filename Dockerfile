FROM tojanke/test-env:latest
MAINTAINER Tobias Janke <tobias.janke@outlook.com>
RUN apt-get update -qq 1>>/dev/null && apt-get install -y -qq --no-install-recommends clang valgrind 1>/dev/null
