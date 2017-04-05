FROM centos:5

RUN cat /etc/yum.repos.d/CentOS-Base.repo | sed s/^mirrorlist=/#mirrorlist=/g | sed 's@^#baseurl=http://mirror\.centos\.org/centos/\$releasever@baseurl=http://vault.centos.org/5.11@g' >/etc/yum.repos.d/CentOS-Base.repo.new \
 && mv -f /etc/yum.repos.d/CentOS-Base.repo.new /etc/yum.repos.d/CentOS-Base.repo \
 && cat /etc/yum.repos.d/libselinux.repo | sed s/^mirrorlist=/#mirrorlist=/g | sed 's@^#baseurl=http://mirror\.centos\.org/centos/\$releasever@baseurl=http://vault.centos.org/5.11@g' >/etc/yum.repos.d/libselinux.repo.new \
 && mv -f /etc/yum.repos.d/libselinux.repo.new /etc/yum.repos.d/libselinux.repo \
 && yum -y update \
 && yum -y install epel-release.noarch \
 && yum -y install \
    cmake28.x86_64 \
    dpkg.x86_64 \
    expect.x86_64 \
    gcc-c++.x86_64 \
    gnupg.x86_64 \
    glibc-devel \
    git.x86_64 \
    libgcc.i386 \
    libstdc++-devel.i386 \
    libX11-devel \
    libXext-devel \
    libXv-devel \
    make.x86_64 \
    mesa-libGL-devel \
    mesa-libGLU-devel \
    redhat-rpm-config \
    rpm-build.x86_64 \
    wget.x86_64 \
 && ln -fs /usr/bin/ccmake28 /usr/bin/ccmake \
 && ln -fs /usr/bin/cmake28 /usr/bin/cmake \
 && ln -fs /usr/bin/cpack28 /usr/bin/cpack \
 && ln -fs /usr/bin/ctest28 /usr/bin/ctest \
 && git clone --depth=1 https://gitlab.com/debsigs/debsigs.git -b debsigs-0.1.15%7Eroam1 ~/src/debsigs \
 && pushd ~/src/debsigs \
 && perl Makefile.PL \
 && make install \
 && popd \
 && rm -rf ~/src \
 && cd / \
 && yum clean all \
 && find /usr/lib/locale/ -mindepth 1 -maxdepth 1 -type d -not -path '*en_US*' -exec rm -rf {} \; \
 && find /usr/share/locale/ -mindepth 1 -maxdepth 1 -type d -not -path '*en_US*' -exec rm -rf {} \; \
 && localedef --list-archive | grep -v -i ^en | xargs localedef --delete-from-archive \
 && mv /usr/lib/locale/locale-archive /usr/lib/locale/locale-archive.tmpl \
 && /usr/sbin/build-locale-archive \
 && echo "" >/usr/lib/locale/locale-archive.tmpl \
 && find /usr/share/{man,doc,info} -type f -delete \
 && rm -rf /etc/ld.so.cache \ && rm -rf /var/cache/ldconfig/* \
 && rm -rf /tmp/*

# Set default command
CMD ["/bin/bash"]
