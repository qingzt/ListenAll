#include "imgui.h"
#include "style.h"
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

void app(bool &running)
{
    ImGui::Begin("Lyrics", &running,ImGuiWindowFlags_NoCollapse); // 创建一个名为 "Lyrics" 的窗口

    // 获取窗口大小
    ImVec2 windowSize = ImGui::GetWindowSize();
    ImGui::SetWindowFontScale(1.5f);
    // 获取文本大小
    const char* text = "This is some useful text.";
    ImVec2 textSize = ImGui::CalcTextSize(text);

    // 计算文本位置，使其居中
    ImVec2 textPos = ImVec2((windowSize.x - textSize.x) / 2.0f, (windowSize.y - textSize.y) / 2.0f);

    // 设置光标位置
    ImGui::SetCursorPos(textPos);
    // 切换到大字体
    

    // 显示文本
    ImGui::Text("%s", text);

    // 恢复默认字体
    ImGui::SetWindowFontScale(1.0f);

    ImGui::End();

    // 查找窗口句柄并隐藏任务栏图标
    HWND hwnd = FindWindowA(NULL, "Lyrics");
    if (hwnd)
    {
        HideWindowFromTaskbar(hwnd);
    }
}

void Home(bool show){}