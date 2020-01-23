FROM tojanke/build-env:latest
MAINTAINER Tobias Janke <tobias.janke@outlook.com>
RUN apt-get update -qq 1>>/dev/null \
    && apt-get install -y -qq --no-install-recommends clang clang-tools clang-tidy valgrind cppcheck 1>/dev/null \
    && apt-get clean 1>>apt.log && rm -rf /var/lib/apt/lists/*
RUN wget -q https://dl.bintray.com/boostorg/release/1.72.0/source/boost_1_72_0.tar.gz \
	&& tar xf boost_1_72_0.tar.gz && rm boost_1_72_0.tar.gz \
	&& mv boost_1_72_0/libs /boost/ && mv boost_1_72_0/doc /boost/ && mv boost_1_72_0/tools /boost/ \
	&& rm -rf boost_1_72_0 \
	&& cd /boost && ./bootstrap.sh --with-toolset=clang \
	&& ./b2 -j8 toolset=clang --build-type=complete --layout=versioned stage \
	   --with-timer --with-date_time --with-random --with-test --with-thread --with-regex \  	
	&& rm -rf /boost/libs && rm -rf /boost/bin.v2 && rm -rf /boost/doc && rm -rf /boost/tools \
    && ls /boost/stage/lib
RUN clang --version && clang-tidy --version && valgrind --version && cppcheck --version
