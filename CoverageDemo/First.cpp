#include "First.hpp"

std::string hello_or_world(bool state)
{
	if(state)
	{
		return "Hello";
	}
	return "World";
}
