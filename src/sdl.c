#include "sdl.h"
#include <SDL3/SDL_log.h>
#include <vulkan/vulkan.h>
#include <cglm/vec2.h>


int
sdl_main
(
    int     argc
,   char *  argv[]
)
{
    SDL_Log("Hello, World!") ;


    // VkResult vkEnumerateInstanceVersion(
    // uint32_t*                                   pApiVersion);
    uint32_t vulkan_api_version ;
    VkResult res = vkEnumerateInstanceVersion(&vulkan_api_version) ;

    uint32_t major = VK_VERSION_MAJOR(vulkan_api_version);
    uint32_t minor = VK_VERSION_MINOR(vulkan_api_version);
    uint32_t patch = VK_VERSION_PATCH(vulkan_api_version);

    SDL_Log("major=%d, minor=%d, patch=%d, vulkan_api_version=%d, res=%d", major, minor, patch, vulkan_api_version, res) ;

    vec2 v ;

    return 0 ;
}

