#include <unordered_map>
#include <any>
#include <memory>
#include <iostream>
class Get
{
    private:
        std::unordered_map<std::string,std::any> controllers;
    public:
        template <typename T>
        std::shared_ptr<T> get()
        {
            auto controller=controllers[std::string(typeid(T).name())];
            if(controller.has_value())
            {
                return std::any_cast<std::shared_ptr<T>>(controller);
            }
            return nullptr;
        }
        template <typename T,typename... Args>
        std::shared_ptr<T> push(Args&&... args)
        {
            auto controller=std::make_shared<T>(std::forward<Args>(args)...);
            controllers[std::string(typeid(T).name())]=controller;
            return controller;
        }
};