import qbs
import qbs.FileInfo
import qbs.TextFile

Module
{
    property stringList libraries:[]

    FileTagger
    {
        patterns: ["*.asm","*.ASM"]
        fileTags: ["asm"]
    }
}
