#include "get.h"

template <typename T>
std::shared_ptr<T> Get::get()
{
    auto controller=controllers[std::string(typeid(T).name())];
    if(controller!=nullptr)
    {
        return std::any_cast<std::shared_ptr<T>>(controller);
    }
    return nullptr;
}

template <typename T, typename... Args>
std::shared_ptr<T> Get::add(bool &inMemory,Args&&... args)
{
    static_assert(std::is_base_of<GetController, T>::value, "T must be derived from GetController");
    auto res=get<T>();
    if (res!=nullptr){
        if(inMemory){
            return res;
        }
        else{
            controllers.erase(std::string(typeid(T).name()));
            return nullptr;
        }
    }
    else{
        if(inMemory){
            auto controller=std::make_shared<T>(std::forward<Args>(args)...);
            controllers[std::string(typeid(T).name())]=controller;
            return controller;
        }
        else{
            return nullptr;
        }
    }
    return nullptr;
}