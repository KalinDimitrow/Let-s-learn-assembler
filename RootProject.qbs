import qbs

Project
{
    qbsSearchPaths: ["Build"]
    name: "Root"
    references:["1_Hello/1_Hello.qbs",
        "2_Registers/2_Registers.qbs",
        "3_SystemCalls/3_SystemCalls.qbs",
        "4_AddressingModes/4_AddressingModes.qbs",
        "5_Variables/5_Variables.qbs",
        "6_Constants/6_Constants.qbs",
        "7_ArithmeticInstructions/7_ArithmeticInstructions.qbs",
        "8_LogicalInstructions/8_LogicalInstructions.qbs",
        "9_Condition/9_Condition.qbs",
        "A_Loops/A_Loops.qbs",
        "B_Numbers/B_Numbers.qbs",
        "C_Arrays/C_Arrays.qbs",
        "D_Procedures/D_Procedures.qbs",
        "E_Recursion/E_Recursion.qbs",
        "F_Macros/F_Macros.qbs",
        "G_FileManagement/G_FileManagement.qbs",
        "H_MemoryManagement/H_MemoryManagement.qbs"]
}
