import qbs
import qbs.FileInfo
import qbs.TextFile
import qbs.ModUtils

ASM
{
    Rule
    {
        id: compiler
        inputs: ["asm"]

        Artifact
        {
            filePath: product.destinationDirectory + "/" + FileInfo.completeBaseName(input.fileName) + ".o"
            fileTags: ["obj"]
        }

        prepare:
        {

            var args = ['-f','elf64',input.filePath,'-o',output.filePath];

            var cmd = new Command("nasm",args);
            cmd.description = 'compiling ' + output.fileName;
            cmd.highlight = 'compiler'
            return cmd;
        }
    }

    Rule
    {
        id: linker
        inputs: ["obj"]
        multiplex: true

        Artifact
        {
            filePath: product.destinationDirectory + "/" + product.name
            fileTags: ["application"]
        }

        prepare:
        {
            var args = ['-m','elf_x86_64','-s','-o',output.filePath];
            for (var i in inputs.obj)
                args.push(inputs.obj[i].filePath);

            var libraries = ModUtils.moduleProperty(product, 'libraries');
            for (var lib in libraries)
                args.push(libraries[lib]);

            var cmd = new Command("ld",args);
            cmd.description = 'linking ' + output.fileName;
            cmd.highlight = 'linker'
            return cmd;
        }
    }

    Rule
    {
        id: linker
        inputs: ["obj"]
        multiplex: true

        Artifact
        {
            filePath: product.destinationDirectory + "/" + "lib" + product.name + ".a"
            fileTags: ["library"]
        }

        prepare:
        {
            var args = ['rcs',output.filePath];
            for (var i in inputs.obj)
                args.push(inputs.obj[i].filePath);
            var cmd = new Command("ar",args);
            cmd.description = 'linking ' + output.fileName;
            cmd.highlight = 'linker'
            return cmd;
        }
    }
}
