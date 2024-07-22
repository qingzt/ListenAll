cmake_minimum_required(VERSION 3.10)
project(FloatingLyrics)

# 设置C++标准
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(OpenGL REQUIRED)

# 添加imgui库
add_library(imgui
    imgui/imgui.cpp
    imgui/imgui_demo.cpp
    imgui/imgui_draw.cpp
    imgui/imgui_tables.cpp
    imgui/imgui_widgets.cpp
    imgui/backends/imgui_impl_opengl3.cpp
    imgui/backends/imgui_impl_win32.cpp
    app.cpp
    style.cpp
)

# 添加imgui头文件目录
target_include_directories(imgui PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/imgui)

# 添加可执行文件
add_executable(FloatingLyrics main.cpp)

# 链接imgui库
target_link_libraries(FloatingLyrics imgui OpenGL::GL dwmapi)