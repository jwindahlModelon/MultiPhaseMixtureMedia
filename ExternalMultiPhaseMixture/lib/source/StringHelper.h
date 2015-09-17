/**
 * @file StringHelper.h
 * Header file with string helper functions.
 */

#ifndef STRINGHELPER_H_
#define STRINGHELPER_H_

#include <string>
#include <vector>

namespace StringHelper
{
    /*
     * Split a string at delim and return the vector of components
     */
    std::vector<std::string> split(const char *s, char delim);

    /*
     * Split a string at first occurence of delim and return the pair of components
     */
    std::pair<std::string,std::string> split2(std::string &s, char delim);
}

#endif // STRINGHELPER_H_
