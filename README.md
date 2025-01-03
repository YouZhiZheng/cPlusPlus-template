# cPlusPlus-template

## 使用工具

本开发模板使用了以下工具：

* **Clang-Format**： 用于统一代码风格。安装好此工具后，并在VScode中安装`Clang-Format`插件即可使用。
* **Clang-tidy**： 用于静态分析代码。Clang-Tidy的详解介绍可参考该[blog](https://blog.csdn.net/stallion5632/article/details/139545885)。
* **Ccache**：用于加速重构时间。
* **Doxygen**：用于生成项目的技术文档。`Doxygen`的详解介绍可参考该[blog](https://blog.csdn.net/FSKEps/article/details/125137129)。

## 前置条件

* 版本大于 `3.15` 的 **`CMake`**
* C++编译器，至少需要支持 **`C++ 17`** 标准

## .cmake 文件介绍

`.cmake` 是 `CMake` 的配置文件，主要作用是定义项目的构建指令、依赖项或配置细节。可以把它看作 `CMake` 如何处理源码的“配方”。

### SourcesAndHeaders.cmake

该文件用于配置项目的源文件、头文件、以及测试的源文件。按照该文件中的样例格式进行对应修改即可。

### StandardSettings.cmake

该文件用于控制是否启用`clang-tidy`、`doxygen`、`ccache`以及其他参数等。

### StaticAnalyzers.cmake

用于配置静态分析工具 `clang-tidy` 和 `cppcheck`

### Utils.cmake

编写开启详细信息打印的提示函数，以及`clang-format`的相关定义（已注释，因为我已通过 `clang-format` 和对应的 `VScode` 插件自动格式化了代码）

### Doxygen.cmake

用于配置 `Doxygen`。

### CompilerWarnings.cmake

用于配置编译器警告信息。

## 使用步骤

1. 修改顶层项目目录下的 **`CMakeLists.txt`** 文件中的以下内容：

    ```bash
    project(
    ExampleProject
    VERSION 0.1.0
    LANGUAGES CXX
    )
    ```

    将 `ExampleProject` 修改为自己的项目名，`VERSION` 用于版本控制。

2. 修改 `StandardSettings.cmake` 中的相关内容，比如是否启动`doxygen`工具、生成可执行文件、启动静态分析工具等。
3. 修改 `SourcesAndHeaders.cmake` 中的相关内容，指定参与编译的头文件和源文件。
4. 如果要添加第三方库，则在 **`CMakeLists.txt`** 文件中的 `Model project dependencies` 部分进行添加。
5. 修改项目顶层目录下的`Makefile`文件中的`CXX_COMPILER`和`LINKER`变量值，指定使用的编译器和链接器。
6. 以上文件对应内容都配置好后，直接在项目顶层目录下执行命令 `make` 即可查看对应编译命令及其作用（该命令等价于 `make help`）。常用命令有 `make debug` 、`make release`、`make static`。  
7. 如果只是修改了已有文件，想要重新构建只需在build目录下执行命令：`cmake --build build --config Debug` or `cmake --build build --config Release`
8. 启用调试功能前需要修改 **`launch.json`** 文件中的 `"program"`、`"MIMode"`、`"miDebuggerPath"`参数值。
