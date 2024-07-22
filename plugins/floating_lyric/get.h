#pragma once
#include <unordered_map>
#include <any>
#include <memory>
#include <iostream>

class GetController{};
class Get
{
    private:
        std::unordered_map<std::string,GetController> controllers;
    public:
        template <typename T>
        std::shared_ptr<T> get();
        template <typename T>
        std::shared_ptr<T> push(T controller);
};