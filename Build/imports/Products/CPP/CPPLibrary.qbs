import qbs
import qbs.FileInfo as FileInfo

BaseCPP
{
    Group
     {
        fileTagsFilter: ["hpp",".h"].concat(product.type)
        qbs.install: true
        qbs.installDir: FileInfo.relativePath(project.sourceDirectory, sourceDirectory)
    }

    Export
    {
        Depends { name: "cpp" }
        cpp.defines: product.Defines
            cpp.includePaths: ["./Public"].concat(product.Includes)
    }
}
