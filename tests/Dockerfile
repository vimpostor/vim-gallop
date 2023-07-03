FROM archlinux:base

RUN pacman -Syu --noconfirm gvim neovim make diffutils
COPY . /tmp/vim-gallop
WORKDIR /tmp/vim-gallop/tests
CMD make
