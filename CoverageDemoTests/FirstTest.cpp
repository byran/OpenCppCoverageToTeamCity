#include "First.hpp"
#include <gmock/gmock.h>

using namespace ::testing;

TEST(First, Outputs_Hello)
{
	ASSERT_EQ(std::string{ "Hello" }, hello_or_world(true));
}

TEST(First, Outputs_World)
{
	ASSERT_EQ(std::string{ "World" }, hello_or_world(false));
}
