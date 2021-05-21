FROM tojanke/build-env:testing
MAINTAINER Tobias Janke <tobias.janke@outlook.com>
RUN apt-get update -qq 1>/dev/null \
    && apt-get install -y -qq --no-install-recommends clang clang-tools clang-tidy valgrind cppcheck python3 python3-pip 1>/dev/null \
    && pip install yaml && apt-get clean 1>/dev/null && rm -rf /var/lib/apt/lists/*
RUN wget -q https://boostorg.jfrog.io/artifactory/main/release/1.76.0/source/boost_1_76_0.tar.gz \
	&& tar xf boost_1_76_0.tar.gz && rm boost_1_76_0.tar.gz \
	&& mv boost_1_76_0/libs /boost/ && mv boost_1_76_0/doc /boost/ && mv boost_1_76_0/tools /boost/ \
	&& rm -rf boost_1_76_0 \
	&& cd /boost && ./bootstrap.sh --with-toolset=clang 1>/dev/null \
	&& ./b2 -j8 toolset=clang --build-type=complete --layout=versioned stage \
	   --with-timer --with-date_time --with-random --with-system --with-test --with-thread --with-regex 1>/dev/null \  	
	&& rm -rf /boost/libs && rm -rf /boost/bin.v2 && rm -rf /boost/doc && rm -rf /boost/tools
