FROM centos:7

RUN yum -y update \
 && yum -y install epel-release.noarch \
 && yum -y install \
    audit-libs-devel \
    automake \
    binutils-devel \
    bzip2-devel \
    dbus-devel \
    dpkg \
    elfutils-devel \
    elfutils-libelf-devel \
    expect \
    file-devel \
    gcc-c++ \
    gettext-devel \
    git \
    glibc-devel \
    glibc-devel.i686 \
    gnupg1 \
    gnupg2 \
    ima-evm-utils-devel \
    libX11-devel \
    libX11-devel.i686 \
    libXext-devel \
    libXext-devel.i686 \
    libXtst-devel \
    libXtst-devel.i686 \
    libXv-devel \
    libXv-devel.i686 \
    libacl-devel \
    libarchive-devel \
    libcap-devel \
    libselinux-devel \
    libstdc++-devel \
    libstdc++-devel.i686 \
    libstdc++-static \
    libstdc++-static.i686 \
    libtool \
    libxcb-devel \
    libxcb-devel.i686 \
    libzstd-devel \
    lua-devel \
    make \
    mesa-libEGL-devel \
    mesa-libEGL-devel.i686 \
    mesa-libGL-devel \
    mesa-libGL-devel.i686 \
    mesa-libGLU-devel \
    mesa-libGLU-devel.i686 \
    ncurses-devel \
    ocl-icd-devel \
    https://negativo17.org/repos/nvidia/epel-7/x86_64/ocl-icd-2.2.12-1.el7.i686.rpm \
    https://negativo17.org/repos/nvidia/epel-7/x86_64/ocl-icd-devel-2.2.12-1.el7.i686.rpm \
    openssl-devel \
    perl-ExtUtils-MakeMaker \
    popt-devel \
    python2-devel \
    python3-devel \
    readline-devel \
    redhat-rpm-config \
    rpm-build \
    wget \
    xcb-util-keysyms-devel \
    xcb-util-keysyms-devel.i686 \
    xz-devel \
    zstd \
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
 && wget https://dl.rockylinux.org/vault/rocky/8.4/BaseOS/source/tree/Packages/rpm-4.14.3-13.el8.src.rpm \
 && rpmbuild --rebuild rpm-4.14.3-13.el8.src.rpm \
 && popd \
 && rm -rf ~/rpm \
 && pushd ~/rpmbuild/RPMS/x86_64 \
 && rpm -Uvh rpm-4* rpm-libs-* rpm-build-* python2-rpm-* rpm-sign-* \
 && popd \
 && rm -rf ~/rpmbuild \
 && git clone --depth=1 https://gitlab.com/debsigs/debsigs.git ~/src/debsigs \
 && pushd ~/src/debsigs \
 && git fetch --tags \
 && git checkout debsigs-0.1.18-debian \
 && echo -e '--- a/debsigs\n+++ b/debsigs\n@@ -101,7 +101,7 @@ sub cmd_sign($) {\n   #  my $gpgout = forktools::forkboth($arfd, $sigfile, "/usr/bin/gpg",\n   #"--detach-sign");\n \n-  my @cmdline = ("gpg", "--openpgp", "--detach-sign");\n+  my @cmdline = ("gpg1", "--openpgp", "--detach-sign");\n \n   if ($key) {\n     push (@cmdline, "--default-key", $key);' >patch \
 && patch -p1 <patch \
 && perl Makefile.PL \
 && make install \
 && popd \
 && rm -rf ~/src \
 && yum -y autoremove \
    audit-libs-devel \
    automake \
    binutils-devel \
    bzip2-devel \
    db4-cxx \
    dbus-devel \
    elfutils-devel \
    elfutils-libelf-devel \
    file-devel \
    gdbm-devel \
    gettext-devel \
    ima-evm-utils-devel \
    libacl-devel \
    libarchive-devel \
    libcap-devel \
    libselinux-devel \
    libtool \
    libzstd-devel \
    lua-devel \
    ncurses-devel \
    openssl-devel \
    perl-ExtUtils-MakeMaker \
    popt-devel \
    python2-devel \
    python3-devel \
    readline-devel \
    xz-devel \
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
