import qbs

ASMBase
{
    type:"library"

    Export
    {
        Depends { name: "ASM" }
        ASM.libraries:[product.destinationDirectory + "/lib" + product.name + ".a"]
    }
}
