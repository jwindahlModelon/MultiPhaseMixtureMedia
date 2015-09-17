// TestCodeGeneration.h : Include file for the test code generation functions.
#ifndef TESTCODEGENERATION_H_
#define TESTCODEGENERATION_H_

#include <iostream>
#include <fstream>
#include <string>
#include <windows.h>
#include <stdio.h>

using namespace std;
using std::string;

extern ofstream logFile;
extern int logCount;

void WriteArrayResult(double arr[], int size, string label);
void WriteOutputDeclarations();

#endif /*TESTCODEGENERATION_H_*/