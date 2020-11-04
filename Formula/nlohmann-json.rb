class NlohmannJson < Formula
  desc "JSON for modern C++"
  homepage "https://github.com/nlohmann/json"
  url "https://github.com/nlohmann/json/archive/v3.9.1.tar.gz"
  sha256 "4cf0df69731494668bdd6460ed8cb269b68de9c19ad8c27abc24cd72605b2d5b"
  license "MIT"
  revision 1
  head "https://github.com/nlohmann/json.git", branch: "develop"

  bottle do
    cellar :any_skip_relocation
    sha256 "b541218f118a50a5f95f7f3650e520be58398619bbc6073d7b36cb320bf212c7" => :catalina
    sha256 "fe00728aa85f032016788a0ec770b47a0e8e4b7cf2fc1547aa4ecf774bf1028c" => :mojave
    sha256 "43b0bfd3b8d202358ab4141a01a11588f1b90c9ecf0a71c5764d97ac546f5fde" => :high_sierra
  end

  depends_on "cmake" => :build

  conflicts_with "homebrew/core/nlohmann-json", :because => "it is now integrated with homebrew-core"

  def install
    mkdir "build" do
      system "cmake", "..", "-DJSON_BuildTests=OFF", "-DJSON_MultipleHeaders=ON", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    (testpath/"test.cc").write <<~EOS
      #include <iostream>
      #include <nlohmann/json.hpp>

      using nlohmann::json;

      int main() {
        json j = {
          {"pi", 3.141},
          {"name", "Niels"},
          {"list", {1, 0, 2}},
          {"object", {
            {"happy", true},
            {"nothing", nullptr}
          }}
        };
        std::cout << j << std::endl;
      }
    EOS

    system ENV.cxx, "test.cc", "-I#{include}", "-std=c++11", "-o", "test"
    std_output = <<~EOS
      {"list":[1,0,2],"name":"Niels","object":{"happy":true,"nothing":null},"pi":3.141}
    EOS
    assert_match std_output, shell_output("./test")
  end
end
