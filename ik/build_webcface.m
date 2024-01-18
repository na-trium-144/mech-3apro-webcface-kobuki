if ispc
    % Set up compiler - Microsoft Visual C++ 2019
    mex -setup:MSVCPP160;

    interfaceGenerationFiles = "..\kobuki\src\webcface\src\include\webcface\c_wcf.h";
    libraries = [
        ... "..\kobuki\src\webcface\out\build\x64-Release\spdlog.dll", ...
        ... "..\kobuki\src\webcface\out\build\x64-Release\webcface5.dll"
        "C:\Program Files\WebCFace\bin\webcface5.dll"
    ];
    do_copy = 0;
    outputFolder = ".";
elseif isunix
    % Set up compiler - g++
    mex -setup:g++;

    interfaceGenerationFiles = "../kobuki/src/webcface/src/include/webcface/c_wcf.h";
    libraries = [
        "../kobuki/src/webcface/build/libwebcface.so", ...
        "../kobuki/src/webcface/build/_deps/spdlog-build/libspdlog.so"
    ];
    do_copy = 1;
    outputFolder = ".";
else
    error('ライブ タスクは現在のプラットフォーム用に構成されていません')
end

overwriteExistingDefinitionFiles = true;

% Generate definition file for C++ library
clibgen.generateLibraryDefinition(interfaceGenerationFiles, ...
    "Libraries",libraries, ...
    "OutputFolder",outputFolder, ...
    "PackageName","webcface", ...
    "OverwriteExistingDefinitionFiles",overwriteExistingDefinitionFiles, ...
    "TreatConstCharPointerAsCString",true, ...
    "Verbose",true);

addpath webcface
try
    clibConfiguration('webcface').unload
catch exception
end
rmdir webcface s

libraryDefinitionFromTask = definewebcface2(libraries);
summary(libraryDefinitionFromTask)

build(libraryDefinitionFromTask)
additionalRuntimeDependencies = ""; % Optionally specify run-time dependencies needed per platform
additionalRuntimeFolders = ""; % Optionally specify run-time folders needed per platform
if isunix
    additionalRuntimeDependencies = [
        "../kobuki/src/webcface/build/libwebcface.so.2", ...
        "../kobuki/src/webcface/build/_deps/spdlog-build/libspdlog.so.1.12"
    ];
end
if do_copy == 1
    libraryDefinitionFromTask.copyRuntimeDependencies( ...
        AdditionalRuntimeDependencies=additionalRuntimeDependencies, ...
        AdditionalRuntimeFolders=additionalRuntimeFolders, ...
        Verbose=true);
end
