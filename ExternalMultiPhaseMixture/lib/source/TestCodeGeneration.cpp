#include "TestCodeGeneration.h"

ofstream logFile;
int logCount = 0;

void WriteArrayResult(double arr[], int size, string label)
{
    if (logFile.is_open())
    {
        logFile << label << logCount << "[" << size << "] = {" ;
        for(int i = 0; i < size; i++)
        {
            if(i > 0)
                logFile << ",";

            logFile << arr[i];
        }
        logFile <<  "}\n" ;
    }
}

void WriteOutputDeclarations()
{
    logFile << "// outputs\n";
    logFile << "double p_overall_out"           << logCount                             << ";\n";
    logFile << "double T_overall_out"           << logCount                             << ";\n";
    logFile << "double d_overall_out"           << logCount                             << ";\n";
    logFile << "double h_overall_out"           << logCount                             << ";\n";
    logFile << "double s_overall_out"           << logCount                             << ";\n";
    logFile << "double d_1ph_out"               << logCount << "[NUM_PHASES]"           << ";\n";
    logFile << "double h_1ph_out"               << logCount << "[NUM_PHASES]"           << ";\n";
    logFile << "double s_1ph_out"               << logCount << "[NUM_PHASES]"           << ";\n";
    logFile << "double Pr_1ph_out"              << logCount << "[NUM_PHASES]"           << ";\n";
    logFile << "double a_1ph_out"               << logCount << "[NUM_PHASES]"           << ";\n";
    logFile << "double beta_1ph_out"            << logCount << "[NUM_PHASES]"           << ";\n";
    logFile << "double cp_1ph_out"              << logCount << "[NUM_PHASES]"           << ";\n";
    logFile << "double cv_1ph_out"              << logCount << "[NUM_PHASES]"           << ";\n";
    logFile << "double kappa_1ph_out"           << logCount << "[NUM_PHASES]"           << ";\n";
    logFile << "double lambda_1ph_out"          << logCount << "[NUM_PHASES]"           << ";\n";
    logFile << "double eta_1ph_out"             << logCount << "[NUM_PHASES]"           << ";\n";
    logFile << "double dpdT_dN_1ph_out"         << logCount << "[NUM_PHASES]"           << ";\n";
    logFile << "double dpdd_TN_1ph_out"         << logCount << "[NUM_PHASES]"           << ";\n";
    logFile << "int nbrOfPresentPhases_out"     << logCount                             << ";\n";
    logFile << "int presentPhaseIndex_out"      << logCount                             << ";\n";
    logFile << "double phaseCompositions_out"   << logCount << "[NUM_PHASES * size_X" << logCount << "]"  << ";\n";
    logFile << "double phaseFractions_out"      << logCount << "[NUM_PHASES * size_X" << logCount << "]"  << ";\n";
    logFile << "\n";
}
