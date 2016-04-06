import qbs

Product
{
    property stringList Files:[]
    files: ["Sources/*.asm","Sources/*.ASM"].concat(Files)
    Depends { name: "ASM" }
}
