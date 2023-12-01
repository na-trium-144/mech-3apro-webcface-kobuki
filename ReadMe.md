## webcface
https://github.com/na-trium-144/webcface
```sh
sudo apt install cmake gcc-10 g++-10 libspdlog-dev
git submodule update --init --recursive
cd webcface
CC=gcc-10 CXX=g++-10 cmake -Bbuild
make -Cbuild -j8
sudo make -Cbuild install
curl -LO https://github.com/na-trium-144/webcface-webui/releases/download/v1.0.7/webcface-webui_1.0.7.tar.gz
tar zxvf webcface-webui*.tar.gz
sudo rm -rf /usr/local/share/webcface
sudo mkdir /usr/local/share/webcface
sudo mv dist /usr/local/share/webcface/dist
```

## kobuki
* [install](https://kobuki.readthedocs.io/en/devel/software.html)
* [creating app](https://kobuki.readthedocs.io/en/devel/applications.html)
```sh
sudo apt install python3.8-venv
cd kobuki
source venv.bash
mkdir src
vcs import ./src < kobuki_standalone.repos
colcon build --merge-install --cmake-args -DBUILD_TESTING=OFF
deactivate
```

## kobuki_test_app
```sh
source kobuki/install/setup.bash
cd kobuki_test_app
cmake -Bbuild
make -Cbuild
./build/main
```

## kobuki_webcface
```sh
source kobuki/install/setup.bash
cd kobuki_webcface
CC=gcc-10 CXX=g++-10 cmake -Bbuild
make -Cbuild
./build/main
```

別ターミナルで `webcface-server`
