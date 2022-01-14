FROM centos:6

RUN rpm -Uvh https://vault.centos.org/6.10/updates/x86_64/Packages/openssl-1.0.1e-58.el6_10.x86_64.rpm \
 && cat /etc/yum.repos.d/CentOS-Base.repo | sed s/^mirrorlist=/#mirrorlist=/g | sed 's@^#baseurl=http://mirror\.centos\.org/centos/\$releasever@baseurl=https://vault.centos.org/6.10@g' >/etc/yum.repos.d/CentOS-Base.repo.new \
 && mv -f /etc/yum.repos.d/CentOS-Base.repo.new /etc/yum.repos.d/CentOS-Base.repo \
 && cat /etc/yum.repos.d/CentOS-fasttrack.repo | sed s/^mirrorlist=/#mirrorlist=/g | sed 's@^#baseurl=http://mirror\.centos\.org/centos/\$releasever@baseurl=https://vault.centos.org/6.10@g' >/etc/yum.repos.d/CentOS-fasttrack.repo.new \
 && mv -f /etc/yum.repos.d/CentOS-fasttrack.repo.new /etc/yum.repos.d/CentOS-fasttrack.repo \
 && yum -y update \
 && yum -y install epel-release.noarch \
 && yum -y install \
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
    ocl-icd-devel.x86_64 \
    ocl-icd-devel.i686 \
    redhat-rpm-config \
    rpm-build.x86_64 \
    wget.x86_64 \
    perl-ExtUtils-MakeMaker \
    https://www.rpmfind.net/linux/remi/enterprise/6/remi/x86_64/gnupg1-1.4.23-1.el6.remi.x86_64.rpm \
 && mkdir ~/src \
 && pushd /opt \
 && wget --no-check-certificate https://cmake.org/files/v3.15/cmake-3.15.7-Linux-x86_64.tar.gz \
 && tar xf cmake-3.15.7-Linux-x86_64.tar.gz \
 && rm cmake-3.15.7-Linux-x86_64.tar.gz \
 && mv cmake-3.15.7-Linux-x86_64 cmake \
 && for i in /opt/cmake/bin/*; do ln -fs $i /usr/bin/; done \
 && wget 'https://developer.arm.com/-/media/Files/downloads/gnu-a/9.2-2019.12/binrel/gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu.tar.xz?revision=61c3be5d-5175-4db6-9030-b565aae9f766&hash=CB9A16FCC54DC7D64F8BBE8D740E38A8BF2C8665' \
 && tar xf 'gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu.tar.xz?revision=61c3be5d-5175-4db6-9030-b565aae9f766&hash=CB9A16FCC54DC7D64F8BBE8D740E38A8BF2C8665' \
 && rm 'gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu.tar.xz?revision=61c3be5d-5175-4db6-9030-b565aae9f766&hash=CB9A16FCC54DC7D64F8BBE8D740E38A8BF2C8665' \
 && mv gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu gcc.arm64 \
 && rm -rf /opt/gcc.arm64/aarch64-none-linux-gnu/bin/ld.gold \
           /opt/gcc.arm64/aarch64-none-linux-gnu/lib64/*atomic* \
           /opt/gcc.arm64/aarch64-none-linux-gnu/lib64/*fortran* \
           /opt/gcc.arm64/aarch64-none-linux-gnu/lib64/*gomp* \
           /opt/gcc.arm64/aarch64-none-linux-gnu/lib64/*san* \
           /opt/gcc.arm64/aarch64-none-linux-gnu/libc/usr/bin \
           /opt/gcc.arm64/aarch64-none-linux-gnu/libc/usr/lib64/*atomic* \
           /opt/gcc.arm64/aarch64-none-linux-gnu/libc/usr/lib64/*fortran* \
           /opt/gcc.arm64/aarch64-none-linux-gnu/libc/usr/lib64/*gomp* \
           /opt/gcc.arm64/aarch64-none-linux-gnu/libc/usr/lib64/*san* \
           /opt/gcc.arm64/bin/*fortran* \
           /opt/gcc.arm64/bin/*gcov* \
           /opt/gcc.arm64/bin/*gdb* \
           /opt/gcc.arm64/bin/*ld.gold* \
           /opt/gcc.arm64/lib/gcc/aarch64-none-linux-gnu/9.2.1/*gcov* \
           /opt/gcc.arm64/lib/gcc/aarch64-none-linux-gnu/9.2.1/plugin \
           /opt/gcc.arm64/libexec/gcc/aarch64-none-linux-gnu/9.2.1/f951 \
           /opt/gcc.arm64/libexec/gcc/aarch64-none-linux-gnu/9.2.1/lto* \
           /opt/gcc.arm64/libexec/gcc/aarch64-none-linux-gnu/9.2.1/plugin \
           /opt/gcc.arm64/share \
 && chown -R root:root gcc.arm64 \
 && mkdir arm64 \
 && pushd arm64 \
 && rpm2cpio http://mirror.centos.org/altarch/7/updates/aarch64/Packages/glibc-2.17-325.el7_9.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/updates/aarch64/Packages/glibc-devel-2.17-325.el7_9.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/libglvnd-1.0.1-0.8.git5baa1e5.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/libglvnd-devel-1.0.1-0.8.git5baa1e5.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/libglvnd-egl-1.0.1-0.8.git5baa1e5.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/libglvnd-glx-1.0.1-0.8.git5baa1e5.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/libglvnd-opengl-1.0.1-0.8.git5baa1e5.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/libstdc++-4.8.5-44.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/updates/aarch64/Packages/libX11-1.6.7-4.el7_9.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/updates/aarch64/Packages/libX11-devel-1.6.7-4.el7_9.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/libXau-1.0.8-2.1.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/libxcb-1.13-1.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/libxcb-devel-1.13-1.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/libXext-1.3.3-3.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/libXext-devel-1.3.3-3.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/libXi-1.7.9-1.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/libXi-devel-1.7.9-1.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/libXtst-1.2.3-1.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/libXtst-devel-1.2.3-1.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/libXv-1.0.11-1.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/libXv-devel-1.0.11-1.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/updates/aarch64/Packages/mesa-khr-devel-18.3.4-12.el7_9.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/updates/aarch64/Packages/mesa-libEGL-18.3.4-12.el7_9.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/updates/aarch64/Packages/mesa-libEGL-devel-18.3.4-12.el7_9.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/updates/aarch64/Packages/mesa-libGL-18.3.4-12.el7_9.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/updates/aarch64/Packages/mesa-libGL-devel-18.3.4-12.el7_9.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/mesa-libGLU-9.0.0-4.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/mesa-libGLU-devel-9.0.0-4.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/xcb-util-keysyms-0.4.0-1.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/xcb-util-keysyms-devel-0.4.0-1.el7.aarch64.rpm | cpio -idv \
 && rpm2cpio http://mirror.centos.org/altarch/7/os/aarch64/Packages/xorg-x11-proto-devel-2018.4-1.el7.noarch.rpm | cpio -idv \
 && popd \
 && popd \
 && ln -fs /opt/arm64/usr/lib64/libm.so /opt/gcc.arm64/aarch64-none-linux-gnu/libc/usr/lib64/libm.so \
 && mkdir ~/rpm \
 && pushd ~/rpm \
 && rpm2cpio http://mirror.centos.org/altarch/7/updates/aarch64/Packages/rpm-4.11.3-48.el7_9.aarch64.rpm | cpio -idv \
 && mv usr/lib/rpm/platform/aarch64-linux /usr/lib/rpm/platform \
 && popd \
 && rm -rf ~/rpm \
 && git clone --depth=1 https://gitlab.com/debsigs/debsigs.git ~/src/debsigs \
 && pushd ~/src/debsigs \
 && git checkout debsigs-0.1.15%7Eroam1 \
 && echo -e '--- a/debsigs\n+++ b/debsigs\n@@ -101,7 +101,7 @@ sub cmd_sign($) {\n   #  my $gpgout = forktools::forkboth($arfd, $sigfile, "/usr/bin/gpg",\n   #"--detach-sign");\n \n-  my @cmdline = ("gpg", "--openpgp", "--detach-sign");\n+  my @cmdline = ("gpg1", "--openpgp", "--detach-sign");\n \n   if ($key) {\n     push (@cmdline, "--default-key", $key);' >patch \
 && patch -p1 <patch \
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
