import qbs

Product
{
	property stringList Defines:[]
	property stringList Includes:[]
	property stringList Files:[]


	files: ["Public/*.hpp","Public/*.h","Private/*.cpp","Private/*.hpp","Private/*.h"].concat(Files)
	Depends { name: "bundle" }
	Depends { name: "cpp" }

	cpp.defines: product.Defines
	cpp.includePaths: ["./Public"].concat(product.Includes)
}
