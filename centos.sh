#Run to get packages for CentOS
sudo yum install libevent-devel ncurses-devel -y


wget https://github.com/tmux/tmux/releases/download/2.4/tmux-2.4.tar.gz
tar -xvzf tmux-2.4.tar.gz
cd tmux-2.4
LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local
make
sudo make install
