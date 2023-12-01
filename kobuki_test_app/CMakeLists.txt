cmake_minimum_required(VERSION 3.0)
project(kobuki-test-app)
add_executable(main main.cc)
set(KOBUKI_PREFIX ${CMAKE_CURRENT_LIST_DIR}/../kobuki/install)
target_include_directories(main PRIVATE
	${KOBUKI_PREFIX}/include
	${KOBUKI_PREFIX}/include/eigen3
)
target_link_directories(main PRIVATE ${KOBUKI_PREFIX}/lib)
target_link_libraries(main PRIVATE
	kobuki_core
	ecl_threads
	ecl_time
)
