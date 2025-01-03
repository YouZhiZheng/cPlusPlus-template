#include <iostream>

int main(int argc, char* argv[])
{
  std::cout << "- INFO - Hello Sym-CTS!" << std::endl;

  // 存储各种文件路径
  std::string def_file_path;
  std::string constraint_file_path;
  std::string output_file_path = "./solution.def";

  for (int i = 1; i < argc; ++i)
  {
    if (std::string(argv[i]) == "-def_file" && i + 1 < argc)
    {
      def_file_path = argv[i + 1];
    }
    else if (std::string(argv[i]) == "-constraint" && i + 1 < argc)
    {
      constraint_file_path = argv[i + 1];
    }
    else if (std::string(argv[i]) == "-output" && i + 1 < argc)
    {
      output_file_path = argv[i + 1];
    }
  }

  return 0;
}