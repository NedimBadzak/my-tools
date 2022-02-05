# fuzzy-octo-engine
My fuzzy engine of tools

## Siroce
**Usage:** ./siroce <branch_name>

It will create a new orphan git branch with all files unversioned and will make a new starting, empty commmit so new commit has a baseline. 
The branch name needs to be passed as the parameter.

## Extract
**Usage:** ./extract <file_name> 

A handy console multi purpose extract tool which solves the problem of having to guess whether the compressed directory has a folder inside which you can extract 
or has the files raw inside.
It will first do a check before doing the extraction process, extract the files to a temp directory 
and ultimately rename to a folder named as the compressed directory.

You can also specify the directory and program as additional arguments as follows:
Extract the archive $1 to a directory $2 with the program $3. If the
archive contains a single top-level directory, that directory
becomes $2. Otherwise $2 contains all the files at the root of the
archive.

Supported types: *.zip, *.rar, *.tar, *.tgz, *.tbz2, *.tar.gz, *.tar.bz2, *.tar.xz
