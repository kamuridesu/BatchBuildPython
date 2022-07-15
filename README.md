# BatchBuildPython
BBP is a script to build a Python standalone package for windows

## Usage
Your file struncture has to be like this:

    .
    ├── main.py
    ├── requirements.txt
    ├── build.bat
    ├── any other files or folders that aren't named Include, Scripts or Lib
    └── ...

The resulting file structure is:

    .
    ├── bin/
    ├── main.py
    ├── main.exe
    ├── requirements.txt
    ├── build.bat
    ├── any other files or folders that aren't named Include, Scripts or Lib
    └── ...
    
Then execute the main.exe to run your file.


## Any reason why I should use this?
This does not compile your code to binary or any other executable format. It justs bundles all things that your program needs to work in one folder and downloads an executable file preconfigured with calls for the python executable.

The main advantage of this approach is that you can modify your program even when the bundle is created, not losing the capacity of doing fast modification nor having to compile it all.
