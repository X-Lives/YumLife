# X-Lives/Yumlife
## Language - 语言 - 語言
- [English](https://github.com/X-Lives/YumLife/edit/master/README.md#english)
- [简体中文](https://github.com/X-Lives/YumLife/edit/master/README.md#%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)
- 正體中文

---
### English
# What's this?

YumLife is a mod for OHOL and AHAP based on [hetuw](https://github.com/hetuw/OneLife).
The goals of this mod are to stay up to date with the latest changes to the vanilla
OHOL and AHAP client, fix bugs, and occasionally add useful features.

# Installing (and updating)

## Steam users:

1. Make sure the game is fully updated in Steam.
2. Run the game from Steam once to ensure the Steam login details are properly set up.
3. Download the latest version of the mod from [the Releases page](https://github.com/selb/YumLife/releases). For Windows, this is YumLife_windows.exe.
4. Install the mod into the OHOL/AHAP installation folder (Steam users: right click game > Manage > Browse local files)
5. Run the mod from the OHOL/AHAP installation folder.

## Direct download users:

1. Run the vanilla `OneLife.exe` to download any necessary updates.
2. Confirm that `OneLife.exe` is fully updated by logging in to the tutorial.
3. Download the latest version of the mod from [the Releases page](https://github.com/selb/YumLife/releases). For Windows, this is YumLife_windows.exe.
4. Install the mod into the OHOL/AHAP installation folder (same folder as the vanilla `OneLife.exe`).
5. Run the mod from the OHOL/AHAP installation folder.

# Usage

Press `H` in-game to see everything the mod can do. A `yumlife.cfg` file is
generated in the OHOL/AHAP install folder and can be tweaked to your liking.

# Troubleshooting

## Make sure the base game is updated

If using Steam, launch Steam and make sure there isn't a pending update on the
base game.

If not using Steam, make sure to download the latest package and then run the
vanilla client once to fetch updates. You can download from: `http://onehouronelife.com/ticketServer/server.php?action=show_downloads&ticket_id=YOURKEYHERE`

## Clear cache files

Search the OHOL/AHAP installation folder (Steam users: right click game > Manage >
Browse local files) for any `.fcz` files and delete all of them. They will be
regenerated automatically the next time you launch the game.

## Reinstall

The usual hacks used to keep outdated hetuw (and other mods) running can
interfere with updates and leave your game directory in a state that isn't
readily salvageable. Uninstalling, reinstalling, and then following the
"Installation" section again carefully is the closest thing available to a 100%
certain fix.

## Still not working?

Open a bug report using the Issues tab above.

Note: Unicode aspects were submitted [here](https://github.com/X-Lives/YumLife/issues).
Yumlife functionality issues are submitted at [selb/Yumlife](https://github.com/selb/YumLife/issues).
Still don't know how to submit? Here are some examples.
| **Issues**                                | **X-Lives/Yumlife** | **selb/Yumlife** |
|:-----------------------------------------:|:-------------------:|:----------------:|
| Language(Unicode) interface not displayed | √                   | ×                |
| unopen                                    | √                   | -                |
| Unicode Recommendations                   | √                   | ×                |
| Functional Recommendations                | -                   | √                |
| Function is not available (whatever)      | -                   | √                |

where `√` indicates possible, `×` indicates not recommended and `-` indicates optional.

# Compiling

Compiling on Linux is recommended for release builds, but a native build on Windows is possible for development use.
(If you don’t want to use the following method, the translator also wrote an [automatic script](https://github.com/X-Lives/EasierOLCompile) to compile on Linux.)

## Linux

### Debian/Ubuntu Dependencies

For a Linux build only:

```
sudo apt install g++ make cmake libsdl1.2-dev libglu-dev libgl-dev
```

For a Windows cross build:

```
sudo apt install g++-mingw-w64-i686-win32
```

### Building for Linux

Make and switch to a build directory:

```
mkdir build
cd build
```

Configure and build:

```
cmake .. && make -j8
```

The configuration step may fail due to missing libraries; install these from your distro's package manager and repeat until it succeeds.

### Building for Windows (cross-compiling)

Download and extract [SDL 1.2.15](https://www.libsdl.org/release/SDL-devel-1.2.15-mingw32.tar.gz), placing the `SDL-1.2.15` directory in the root of the repo:

```
curl -O https://www.libsdl.org/release/SDL-devel-1.2.15-mingw32.tar.gz
tar zxvf SDL-devel-1.2.15-mingw32.tar.gz
```

Then build with the included `mingw-cross-toolchain.cmake`, customizing it if necessary if you're on a non-Debian/Ubuntu distro:

```
mkdir crossbuild
cd crossbuild
cmake -DCMAKE_TOOLCHAIN_FILE=../mingw-cross-toolchain.cmake ..
make -j8
```

### Both (for release)

The `build-release.sh` script will perform a fresh build of both Windows and Linux executables in `relbuild/`. If you
symlink your AHAP and/or OHOL directories to `~/ahap` and `~/ohol` respectively, they will be copied there for easy
verification.

## Windows

Download and extract [SDL 1.2.15](https://www.libsdl.org/release/SDL-devel-1.2.15-mingw32.tar.gz), placing the `SDL-1.2.15` directory in the root of the repo.

Install [MSYS2](https://www.msys2.org/) and (optionally) [VS Code](https://code.visualstudio.com/).

In an MSYS2 terminal:

```
pacman -S mingw-w64-i686-{gcc,cmake,make}
```

### VS Code

(If you don't want to use VS Code, jump to the next section.)

Install the CMake plugin and tell it to configure the project, scan for toolkits, then select the `GCC ... i686-w64-mingw32` option.

Pressing F7 or using the "CMake: Build" action will build YumLife_windows.exe in the `build/` directory.

### MSYS2

(If you just want to use VS Code, you can skip this section.)

Launch the "MSYS2 MINGW32" shortcut that MSYS2 installed.

```
$ cd /c/Users/yourname/wherever/you/cloned/this/repo
$ mkdir build
$ cd build
$ cmake ..
$ cmake --build . -j
```

YumLife_windows.exe will be in that `build/` directory.

### Caveats

You will need to copy the libwinpthread-1.dll from MSYS (typically at `C:\msys64\mingw32\bin\libwinpthread-1.dll`) to
your OHOL directory to be able to use a .exe built in this way. Because of this additional dependency introduced by
MSYS, distributing this .exe is not recommended.

# Merging upstream changes

First, set up remotes for Jason's OneLife and minorGems repos. This only needs to be
done once. Note that upstream OHOL is two repos, which YumLife condenses into one for
easier forking.

```
$ git remote add OneLife git@github.com:jasonrohrer/OneLife.git
$ git remote add minorGems git@github.com:jasonrohrer/minorGems.git
```

To merge in changes from the OneLife repo, do a `git pull OneLife master` and resolve any
merge conflicts carefully.

Similarly, the minorGems repo can be merged with `git pull minorGems master`. Note that you
will need to move (as in `git mv`) any _new_ files added to that repo into the `minorGems`
directory.

Since YumLife uses CMake instead of Jason's build scripts, manual updates to `CMakeLists.txt`
are needed when upstream source files are added, removed, or moved.

---
### 简体中文
~~_可恶的 Github 吞我译文。(在译者保存翻译好的 README 时，不小心点到了退出按键，edge 提示译者是否退出，译者选了 "否"，Github 又用全英文弹出了这个类似的标题，没想到选项居然是反的，导致译者痛失译文。此版是直接喂给 Gemini 的潦草之作，原译文译者翻译了近一个小时。如果此版有错误，欢迎指正。）_~~
## 这个是什么？

YumLife 是一个基于 [hetuw](https://github.com/hetuw/OneLife) 的 OHOL 和 AHAP 的模组。

这个模组的目的是保持与最新版本的原版 OHOL 和 AHAP 客户程序同步，修复错误，并偶尔添加一些有用的功能。

## 安装（和更新）

## Steam 用户：

1. 确保游戏在 Steam 中已完全更新。
2. 从 Steam 运行游戏一次，以确保 Steam 登录详细信息已正确设置。
3. 从 [发布页面](https://github.com/selb/YumLife/releases) 下载最新版本的模组。对于 Windows 系统，它是 YumLife_windows.exe。
4. 将模组安装到 OHOL/AHAP 的安装文件夹（Steam 用户：右键单击游戏 > 管理 > 浏览本地文件）
5. 从 OHOL/AHAP 的安装文件夹运行模组。

## 直接下载用户：

1. 运行原版 `OneLife.exe` 下载任何必要的更新。
2. 通过登录教程确认 `OneLife.exe` 已完全更新。
3. 从 [发布页面](https://github.com/selb/YumLife/releases) 下载最新版本的模组。对于 Windows 系统，它是 YumLife_windows.exe。
4. 将模组安装到 OHOL/AHAP 的安装文件夹（与原版 `OneLife.exe` 相同的文件夹）。
5. 从 OHOL/AHAP 的安装文件夹运行模组。

## 使用

游戏内按下 `H` 键查看模组的所有功能。 `yumlife.cfg` 文件会生成在 OHOL/AHAP 的安装文件夹中，可以根据您的喜好进行调整。

## 故障排除

## 确保基础游戏已更新

如果使用 Steam，请启动 Steam 并确保基础游戏没有待更新的补丁。

如果不使用 Steam，请确保下载最新的安装包，然后运行一次原版客户端以获取更新。您可以从以下网址下载： `http://onehouronelife.com/ticketServer/server.php?action=show_downloads&ticket_id=YOURKEYHERE`

## 清除缓存文件

在 OHOL/AHAP 的安装文件夹中搜索任何 `.fcz` 文件（Steam 用户：库 > 右键单击游戏 > 点击右侧"齿轮"图标 > 管理 > 浏览本地文件），然后删除所有这些 `.fcz` 文件。
下次启动游戏时，它们将自动重新生成。

## 重新安装

用于保持过时的 hetuw（和其他模组）运行的常用方法可能会干扰更新，并使您的游戏目录处于无法轻易挽救的状态。
卸载、重新安装，然后仔细遵循“安装”部分，是接近 100% 确定修复的方法。

## 仍然无法工作？

使用上面的 `issues` 标签打开错误报告。

注意: Unicode 方面在[这里](https://github.com/X-Lives/YumLife/issues)提交。
而 Yumlife 功能方面问题在 [selb/Yumlife](https://github.com/selb/YumLife/issues) 提交。
还是不知道这么提交? 以下是一些例子:
| **Issues**       | **X-Lives/Yumlife** | **selb/Yumlife** |
|:----------------:|:-------------------:|:----------------:|
| 中文(Unicode) 无法显示 | √                   | ×                |
| 无法打开             | √                   | -                |
| Unicode 建议       | √                   | ×                |
| 功能建议             | -                   | √                |
| 功能不可用(无论什么)      | -                   | √                |


其中，`√` 表示可以，`×` 表示不建议，`-` 表示可选。

## 编译

建议在 Linux 上编译用于发布版本，但在 Windows 上也可以进行编译以用于开发。
(如果你不想用以下方法，译者也写了一个[自动脚本](https://github.com/X-Lives/EasierOLCompile)以在 Linux 上编译。)

## Linux

### Debian/Ubuntu 依赖项

仅适用于 Linux 编译：

```
sudo apt install g++ make cmake libsdl1.2-dev libglu-dev libgl-dev
```

适用于 Windows 交叉编译：

```
sudo apt install g++-mingw-w64-i686-win32
```

### 在 Linux 上编译

创建并切换到构建目录：

```
mkdir build
cd build
```

配置并编译：

```
cmake .. && make -j8
```

由于缺少库，配置步骤可能会失败；从您的发行版包管理器安装这些库并重复，直到它成功。

### 在 Windows 上编译（交叉编译）

下载并解压 [SDL 1.2.15](https://www.libsdl.org/release/SDL-devel-1.2.15-mingw32.tar.gz)，将 `SDL-1.2.15` 目录放在仓库的根目录下：

```
curl -O https://www.libsdl.org/release/SDL-devel-1.2.15-mingw32.tar.gz
tar zxvf SDL-devel-1.2.15-mingw32.tar.gz
```

然后使用包含的 `mingw-cross-toolchain.cmake` 进行编译，如果您使用的是非 Debian/Ubuntu 发行版，可以根据需要进行自定义：

```
mkdir crossbuild
cd crossbuild
cmake -DCMAKE_TOOLCHAIN_FILE=../mingw-cross-toolchain.cmake ..
make -j8
```

### 两者（用于发布）

`build-release.sh` 脚本将在 `relbuild/` 中执行 Windows 和 Linux 可执行文件的全新编译。如果您将 AHAP 和/或 OHOL 目录的符号链接分别指向 `~/ahap` 和 `~/ohol`，它们将被复制到那里，便于验证。

## Windows

下载并解压 [SDL 1.2.15](https://www.libsdl.org/release/SDL-devel-1.2.15-mingw32.tar.gz)，将 `SDL-1.2.15` 目录放在仓库的根目录下。

安装 [MSYS2](https://www.msys2.org/) 和（可选）[VS Code](https://code.visualstudio.com/)。

在 MSYS2 终端中：

```
pacman -S mingw-w64-i686-{gcc,cmake,make}
```

### VS Code

（如果您不想使用 VS Code，请跳到下一部分。）

安装 CMake 插件并指示它配置项目、扫描工具包，然后选择 `GCC ... i686-w64-mingw32` 选项。

按 F7 或使用 “CMake: Build” 操作将在 `build/` 目录中构建 YumLife_windows.exe。

### MSYS2

（如果您只想使用 VS Code，可以跳过此部分。）

启动 MSYS2 安装的 “MSYS2 MINGW32” 快捷方式。

```
$ cd /c/Users/yourname/wherever/you/cloned/this/repo
$ mkdir build
$ cd build
$ cmake ..
$ cmake --build . -j
```

YumLife_windows.exe 将位于该 `build/` 目录中。

### 注意事项

您需要将 libwinpthread-1.dll 从 MSYS（通常位于 `C:\msys64\mingw32\bin\libwinpthread-1.dll`）复制到您的 OHOL 目录才能使用此方式构建的 .exe。由于 MSYS 引入了此额外的依赖项，因此不建议分发此 .exe。

## 合并上游更改

首先，为 Jason 的 OneLife 和 minorGems 存储库设置远程存储库。这只需要做一次。请注意，上游 OHOL 是两个存储库，YumLife 将其合并为一个以简化分叉。

```
$ git remote add OneLife git@github.com:jasonrohrer/OneLife.git
$ git remote add minorGems git@github.com:jasonrohrer/minorGems.git
```

要合并来自 OneLife 存储库的更改，请执行 `git pull OneLife master` 并仔细解决任何合并冲突。
(这应该不会很难，只需保证 Yumlife 修改的代码不被更改即可。)

类似地，可以使用 `git pull minorGems master` 合并 minorGems 存储库。请注意，您需要将添加到该存储库的任何 _新_ 文件（如 `git mv`）移动到 `minorGems` 目录中。

由于 YumLife 使用 CMake 而不是 Jason 的构建脚本，因此当上游源文件添加、删除或移动时，需要手动更新 `CMakeLists.txt`。
