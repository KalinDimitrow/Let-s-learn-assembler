import qbs

Project
{
    qbsSearchPaths: ["Build"]
    name: "Root"
    references:["1_Hello/1_Hello.qbs","2_Registers/2_Registers.qbs","3_SystemCalls/3_SystemCalls.qbs","4_AddressingModes/4_AddressingModes.qbs"]
}
