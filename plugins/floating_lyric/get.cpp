#include "get.h"

template <typename T>
std::shared_ptr<T> Get::get()
{
    auto controller=controllers[std::string(typeid(T).name())];
    if(controller.has_value())
    {
        return std::any_cast<std::shared_ptr<T>>(controller);
    }
    return nullptr;
}

template <typename T>
std::shared_ptr<T> Get::push(T controller)
{
    static_assert(std::is_base_of<GetController, T>::value, "T must be derived from GetController");
    auto controller=std::make_shared<T>(controller);
    controllers[std::string(typeid(T).name())]=controller;
    return controller;
}