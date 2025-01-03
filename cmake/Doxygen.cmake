if(${PROJECT_NAME}_ENABLE_DOXYGEN)
    # Setting Doxygen configuration options
    set(DOXYGEN_CALLER_GRAPH YES)
    set(DOXYGEN_CALL_GRAPH YES)
    set(DOXYGEN_EXTRACT_ALL YES)
    set(DOXYGEN_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/docs)

    # Check if Doxygen is available
    find_package(Doxygen REQUIRED dot)
    if(NOT DOXYGEN_FOUND)
        message(FATAL_ERROR "Doxygen is required but was not found.")
    endif()

    # Add a target to generate documentation
    doxygen_add_docs(doxygen-docs ${PROJECT_SOURCE_DIR})

    # Prompt the user
    verbose_message("Doxygen has been setup and documentation is now available.")
endif()
