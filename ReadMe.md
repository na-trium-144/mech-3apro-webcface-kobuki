# webcface-kobuki sample

## 環境構築
* ubuntu20の場合
```sh
sudo apt install git cmake build-essential gcc-10 g++-10 python3.8-venv
```

## webcface
https://github.com/na-trium-144/webcface

## kobuki
* [install](https://kobuki.readthedocs.io/en/devel/software.html)
* [creating app](https://kobuki.readthedocs.io/en/devel/applications.html)

* ubuntu20では
```sh
cd kobuki
source venv.bash
```
<details><summary>windowsでは</summary>

* windowsでは
	* git for windowsが必要
	* developer command promptでやる
	* venv.bashの代わりに手動で以下のようにやる
```
python3 -m venv .venv
.venv\Scripts\activate
pip install wheel setuptools==45.2.0 vcstool==0.2.14 colcon-common-extensions==0.2.1
```
	* kobuki\src\ecl_core\ecl_ipc\src\ に空のdummy.cppを作成し、kobuki\src\ecl_core\ecl_ipc\src\CMakeLists.txt を修正 (必要ないかも)
```cmake
if(ECL_PLATFORM_HAS_POSIX_THREADS)
  add_subdirectory(lib)
else()
  add_library(${PROJECT_NAME} dummy.cpp)
  set_target_properties(${PROJECT_NAME}
    PROPERTIES
      SOVERSION ${${PROJECT_NAME}_VERSION}
      VERSION ${${PROJECT_NAME}_VERSION}
  )
  install(TARGETS ${PROJECT_NAME} EXPORT ${PROJECT_NAME}
    RUNTIME DESTINATION bin
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
  )
endif()
```
* kobuki\src\ecl_core\ecl_geometry\include\ecl\geometry\angle.hpp の41,55,115,138行目の`ecl_geometry_PUBLIC`を削除
* kobuki\src\kobuki_core\include\kobuki_core\macros.hpp の31行目`kobuki_EXPORTS`→`kobuki_core_EXPORTS`
* kobuki\src\kobuki_core\CMakeLists.txt に`add_compile_options(/permissive-)`追加
* kobuki\src\kobuki_core\include\kobuki_core\logging.hpp に`#undef ERROR`追加
* kobuki\src\kobuki_core\src\driver\kobuki.cpp の57行目`0.0/0.0`→`std::numeric_limits<double>::quiet_NaN()`
* (これでもまだ通らない)
</details>
* 以降共通でビルド
```sh
mkdir src
vcs import src < kobuki_standalone.repos
colcon build --merge-install --packages-up-to kobuki_core --cmake-args -DBUILD_TESTING=OFF --cmake-args -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=ON
deactivate
```
* python3.9以降ではエラーになるがその場合は `pip install setuptools==58.2.0` で通る ([stackoverflow](https://stackoverflow.com/questions/75211362/import-distutils-command-bdist-wininst-as-orig))

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
