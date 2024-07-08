@echo off
setlocal enabledelayedexpansion

del /f /s /q *sha1*.*
del /f /s /q *debug*.*

rem 遍历当前目录中的所有 .apk 文件
for /f %%f in ('dir /b *.apk') do (
    rem 提取文件名中的架构部分
    set "filename=%%~nf"
    set "arch=!filename:app-=!"
    set "arch=!arch:-release=!"

    rem 构建新的文件名
    set "newname=listenall-!arch!-android.apk"

    rem 重命名文件
    ren "%%f" "!newname!"
    echo "%%f" renamed to "!newname!"
)

endlocal