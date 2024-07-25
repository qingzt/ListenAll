#pragma once
#include <unordered_map>
#include <any>
#include <memory>
#include <iostream>

class GetController{};

class GetControllerWithState
{
private:
    bool &inMemory;
    std::shared_ptr<GetController> controller;
public:
    GetControllerWithState(bool &inMemory,std::shared_ptr<GetController> controller):inMemory(inMemory),controller(controller){}
    bool isInMemory(){return inMemory;}
    std::shared_ptr<GetController> getController(){return controller;}
};
class Get
{
    private:
        std::unordered_map<std::string,std::shared_ptr<GetController>> controllers;
    public:
        template <typename T>
        std::shared_ptr<T> get();
        template <typename T, typename... Args>
        std::shared_ptr<T> add(bool &inMemory,Args&&... args);
};