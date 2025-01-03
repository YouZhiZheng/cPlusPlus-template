set(sources
    src/clockdatabase.cpp
    src/kmeans.cpp
    src/legalization.cpp
    src/delays.cpp
)

set(exe_sources
		src/main.cpp
		${sources}
)

set(headers
    include/clockdatabase.hpp
    include/kmeans.hpp
    include/node.hpp
    include/kdtree.hpp
    include/legalization.hpp
    include/delays.hpp
    include/mytime.hpp
    include/mymath.hpp
)

set(test_sources
  src/tmp_test.cpp
)
