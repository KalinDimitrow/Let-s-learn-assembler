import qbs
import qbs.FileInfo
import qbs.TextFile

Module
{

    FileTagger
    {
        patterns: ["*.asm","*.ASM"]
        fileTags: ["asm"]
    }
}
