add_executable(hello main.cpp)

if(DEFINED CMAKE_DEBUG_POSTFIX)
    set_target_properties(hello
        PROPERTIES
            DEBUG_POSTFIX ${CMAKE_DEBUG_POSTFIX}
    )
endif()
