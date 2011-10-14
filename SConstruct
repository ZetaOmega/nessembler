import re

env = Environment(CPPFLAGS = ["-g", "-DDEBUG"])
env.VariantDir("obj/", ".", duplicate = 0)

target = "nessembler"

srcDir = []
srcDir.append(".")

env.CFile("obj/parser.tab.c", "parser.y", YACCFLAGS = "-d")
env.CFile(target = "obj/scanner.yy.c", source = "scanner.l", YACCFLAGS = "-d")

sources = [ ]
for x in srcDir:
    env.Append(CPPPATH = [x])
    sources.extend(Glob("obj/" + x + "/*.c"))

env.Append(LIBS = ["fl"])

env.Program(target, sources)

