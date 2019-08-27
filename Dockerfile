FROM tojanke/test-env:latest
MAINTAINER Tobias Janke <tobias.janke@outlook.com>
RUN apt-get update -qq 1>>/dev/null \
    && apt-get install -y -qq --no-install-recommends clang clang-tidy valgrind cppcheck 1>/dev/null \
    && apt-get clean 1>>apt.log && rm -rf /var/lib/apt/lists/* \
    && clang --version && clang-tidy --version && valgrind --version && cppcheck --version
