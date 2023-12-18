# webcface-kobuki sample

## 環境構築
* ubuntu20の場合gcc-10必須
```sh
sudo apt install git cmake build-essential gcc-10 g++-10 python3.8-venv
```
* 環境変数に`CC=gcc-10`と`CXX=g++-10`をセット
* ~~windowsの場合、python3.8必須 (`choco install python38`)~~
  * dynamixel_driverのブランチ変えたので3.8じゃなくてもいいかもしれないが試してない
* poetry (必須ではない)
  * https://python-poetry.org/docs/#installing-with-the-official-installer にしたがってインストールし
```sh
poetry config virtualenvs.in-project true
```

## webcface
https://github.com/na-trium-144/webcface

## kobuki
* 参考リンク
  * [install](https://kobuki.readthedocs.io/en/devel/software.html)
  * [creating app](https://kobuki.readthedocs.io/en/devel/applications.html)
* webcfaceをsrcに入れてcolconでいっしょにビルドする。
  * `git submodule update --init --recursive`が必要。
* ubuntu20では
```sh
cd kobuki
source venv.bash
```
<details><summary>windowsではいろいろと修正が必要</summary>

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
colcon build --merge-install --packages-up-to kobuki_webcface --cmake-args -DBUILD_TESTING=OFF
deactivate
```
* windowsでは` --cmake-args -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=ON`を追加
* python3.9以降ではエラーになるがその場合は `pip install setuptools==58.2.0` で通る ([stackoverflow](https://stackoverflow.com/questions/75211362/import-distutils-command-bdist-wininst-as-orig))

## kobuki_test_app
<details><summary>kobukiの動作確認のために作ったが今は不要</summary>

```sh
source kobuki/install/setup.bash
cd kobuki_test_app
cmake -Bbuild
make -Cbuild
./build/main
```
</details>

## kobuki_webcface
* 別でcmakeしていたが、kobuki_coreといっしょにcolconでビルドすることにした

<details><summary>colconをつかわない場合 (今は不要)</summary>

```sh
source kobuki/install/setup.bash
cd kobuki_webcface
CC=gcc-10 CXX=g++-10 cmake -Bbuild
make -Cbuild
./build/main
```
</details>

## dynamixel
* dynamixel_driverは [kindsenior/dynamixel_motor](https://github.com/kindsenior/dynamixel_motor/tree/noetic-support-python3) のコピー (そのままインストールするにはROSが必要だった)

```sh
cd dynamixel
# poetry env use python3.8
poetry install
poetry run jupyter lab
```

## ik
* ロボットモデルを取り出すためにROSが要る。
```sh
rosrun xacro xacro robot.urdf.xacro > robot.urdf
```
* をしたものが ik/robot.urdf


## OpenNI
<details><summary>やめた</summary>
* Visual Studio Installerで「最新の v142 ビルドツール用 C++ MFC (x86 および x64)」を追加する。
* OpenNI/Include/XnPlatform.h の56-58行をコメントアウト
* OpenNI/Platform/Win32/Build/OpenNI.sln を開き、ソリューションのビルド
* OpenNI/Platform/Win32/Driver/Binにあるドライバーをインストールする
<details><summary>READMEの手順どおりにインストールしようとするとうまくいかない</summary>

* OpenNI/Platform/Win32/CreateRedist/RedistMaker.bat の38行目を `python Redist_OpenNi.py %1 %2 %3 %4` にする
```cmd
pip install pywin32
cd OpenNI\Platform\Win32\CreateRedist
RedistMaker.bat y 64 y
```
* めっちゃエラーが出る
</details>
</details>

## Kinect
* ~~[Kinect for Windows SDK v1.8](https://www.microsoft.com/en-us/download/details.aspx?id=40278)~~
  * ~~指示に従ってDeveloper Toolkit もインストール~~
  * ~~Toolkitを起動しサンプルコードをインストール~~
* ↑をして改変したものがColorBasics-D2D/ColorBasics-D2D.sln これを開いてビルド
  * ColorBasics-D2D/webcface に画像送信機能を追加したものがあり、ColorBasics-D2D.slnからそれを参照してビルドしている
  * slnを開く前にそのwebcfaceディレクトリを開いてCMakeする必要がある
