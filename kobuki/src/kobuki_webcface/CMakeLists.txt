cmake_minimum_required(VERSION 3.5)
project(kobuki_webcface)
find_package(webcface REQUIRED)
find_package(ament_cmake REQUIRED)
find_package(kobuki_core REQUIRED)

add_executable(${PROJECT_NAME} main.cc)
target_link_libraries(${PROJECT_NAME} PRIVATE
	webcface::webcface
	kobuki_core::kobuki_core
	ecl_threads::ecl_threads
	ecl_time::ecl_time
	ecl_geometry::ecl_geometry
	ecl_exceptions::ecl_exceptions
)

install(TARGETS ${PROJECT_NAME} EXPORT ${PROJECT_NAME}
	RUNTIME DESTINATION bin
)
ament_package()
