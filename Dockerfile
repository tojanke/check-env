FROM tojanke/test-env:latest
MAINTAINER Tobias Janke <tobias.janke@outlook.com>
RUN apt-get update -qq 1>>/dev/null \
    && apt-get install -y -qq --no-install-recommends clang clang-tools clang-tidy valgrind cppcheck 1>/dev/null \
    && apt-get clean 1>>apt.log && rm -rf /var/lib/apt/lists/*
RUN wget -q https://sourceforge.net/projects/boost/files/boost/1.70.0/boost_1_70_0.tar.gz/download
RUN tar xf download && rm download 
RUN  mv boost_1_70_0/libs /boost/ && mv boost_1_70_0/doc /boost/ && mv boost_1_70_0/tools /boost/
RUN rm -rf boost_1_70_0
WORKDIR /boost
RUN ./bootstrap.sh
RUN ./b2 -j8 toolset=clang --build-type=complete --layout=versioned stage \
	   --with-timer --with-date_time --with-random --with-test --with-thread --with-regex \  	
	&& rm -rf /boost/libs && rm -rf /boost/bin.v2 && rm -rf /boost/doc && rm -rf /boost/tools \
    && ls /boost/stage/lib
RUN clang --version && clang-tidy --version && valgrind --version && cppcheck --version
