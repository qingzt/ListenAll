# pragma once
#include "imgui.h"
class Fonts {
public:
    Fonts();
    ImFont* largeFont;
};

class Style {
public:
    Fonts fonts;
};