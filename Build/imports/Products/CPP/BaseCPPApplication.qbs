import qbs
import qbs.FileInfo as FileInfo

BaseCPP
{
	type:["application"]
	files: ["Sources/*.hpp","Sources/*.h","Sources/*.cpp"].concat(Files)
	Group
	 {
		fileTagsFilter: product.type
		qbs.install: true
		qbs.installDir: FileInfo.relativePath(project.sourceDirectory, sourceDirectory)
	}
}
