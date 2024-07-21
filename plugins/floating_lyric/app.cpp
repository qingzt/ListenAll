#include "imgui.h"
#include <windows.h>

void HideWindowFromTaskbar(HWND hwnd)
{
    // 获取当前的窗口扩展样式
    LONG exStyle = GetWindowLong(hwnd, GWL_EXSTYLE);

    if(exStyle&WS_EX_TOOLWINDOW)
    {
        // 如果已经是工具窗口，则不需要再次设置
        return;
    }

    // 添加 WS_EX_TOOLWINDOW 扩展样式
    exStyle |= WS_EX_TOOLWINDOW;

    // 移除 WS_EX_APPWINDOW 扩展样式
    exStyle &= ~WS_EX_APPWINDOW;

    // 设置新的窗口扩展样式
    SetWindowLong(hwnd, GWL_EXSTYLE, exStyle);

    // 强制窗口重新绘制
    ShowWindow(hwnd, SW_HIDE);
    ShowWindow(hwnd, SW_SHOW);
}

bool show = true;

void app(bool &running)
{
    ImGui::Begin("Lyrics",&running);                          // Create a window called "Hello, world!" and append into it.
    ImGui::Text("This is some useful text.");               // Display some text (you can use a format strings too)
    ImGui::End();
    HWND hwnd = FindWindowA(NULL, "Lyrics");
    HideWindowFromTaskbar(hwnd);
}

