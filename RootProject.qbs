import qbs

Project
{
    qbsSearchPaths: ["Build"]
    name: "Root"
    references:["Hello/Hello.qbs","Registers/Registers.qbs","SystemCalls/SystemCalls.qbs"]
}
