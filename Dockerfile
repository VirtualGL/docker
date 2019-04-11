FROM centos:6

RUN yum -y update \
 && yum -y install epel-release.noarch \
 && yum -y install \
    cmake.x86_64 \
    dpkg.x86_64 \
    expect.x86_64 \
    gcc-c++.x86_64 \
    gnupg.x86_64 \
    glibc-devel.x86_64 \
    glibc-devel.i686 \
    git.x86_64 \
    libgcc.i686 \
    libstdc++-devel.x86_64 \
    libstdc++-devel.i686 \
    libX11-devel.x86_64 \
    libX11-devel.i686 \
    libXext-devel.x86_64 \
    libXext-devel.i686 \
    libXtst-devel.x86_64 \
    libXtst-devel.i686 \
    libXv-devel.x86_64 \
    libXv-devel.i686 \
    libxcb-devel.x86_64 \
    libxcb-devel.i686 \
    xcb-util-keysyms-devel.x86_64 \
    xcb-util-keysyms-devel.i686 \
    make.x86_64 \
    mesa-libGL-devel.x86_64 \
    mesa-libGL-devel.i686 \
    mesa-libEGL-devel.x86_64 \
    mesa-libEGL-devel.i686 \
    mesa-libGLU-devel.x86_64 \
    mesa-libGLU-devel.i686 \
    redhat-rpm-config \
    rpm-build.x86_64 \
    wget.x86_64 \
    perl-ExtUtils-MakeMaker \
 && mkdir ~/src \
 && git clone --depth=1 https://gitlab.com/debsigs/debsigs.git ~/src/debsigs \
 && pushd ~/src/debsigs \
 && git checkout debsigs-0.1.15%7Eroam1 \
 && perl Makefile.PL \
 && make install \
 && popd \
 && rm -rf ~/src \
 && yum -y remove perl-ExtUtils-MakeMaker gdbm-devel db4-cxx \
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
