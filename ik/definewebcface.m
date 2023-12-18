%% About definewebcface.m
% This file defines the MATLAB interface to the library |webcface|.
%
% Commented sections represent C++ functionality that MATLAB cannot automatically define. To include
% functionality, uncomment a section and provide values for <SHAPE>, <DIRECTION>, etc. For more
% information, see helpview(fullfile(docroot,'matlab','helptargets.map'),'cpp_define_interface') to "Define MATLAB Interface for C++ Library".



%% Setup
% Do not edit this setup section.
function libDef = definewebcface()
libDef = clibgen.LibraryDefinition("webcfaceData.xml");

%% OutputFolder and Libraries 
libDef.OutputFolder = "C:\Users\mech-user\3a_pro\ik";
libDef.Libraries = [ "C:\Users\mech-user\3a_pro\kobuki\src\webcface\out\build\x64-Debug\webcface.dll" "C:\Users\mech-user\3a_pro\kobuki\src\webcface\out\build\x64-Debug\spdlogd.dll" ];

%% C++ class |typedef void* wcfClient| with MATLAB name |clib.webcface.wcfClient| 
addOpaqueType(libDef, "typedef void* wcfClient", "MATLABName", "clib.webcface.wcfClient", ...
    "Description", "clib.webcface.wcfClient    C++ opaque type."); % Modify help description values as needed.

%% C++ class |wcfMultiVal| with MATLAB name |clib.webcface.wcfMultiVal| 
wcfMultiValDefinition = addClass(libDef, "wcfMultiVal", "MATLABName", "clib.webcface.wcfMultiVal", ...
    "Description", "clib.webcface.wcfMultiVal    Representation of C++ class wcfMultiVal."); % Modify help description values as needed.

%% C++ class constructor for C++ class |wcfMultiVal| 
% C++ Signature: wcfMultiVal::wcfMultiVal(wcfMultiVal const & input1)

wcfMultiValConstructor1Definition = addConstructor(wcfMultiValDefinition, ...
    "wcfMultiVal::wcfMultiVal(wcfMultiVal const & input1)", ...
    "Description", "clib.webcface.wcfMultiVal Constructor of C++ class wcfMultiVal."); % Modify help description values as needed.
defineArgument(wcfMultiValConstructor1Definition, "input1", "clib.webcface.wcfMultiVal", "input");
validate(wcfMultiValConstructor1Definition);

%% C++ class constructor for C++ class |wcfMultiVal| 
% C++ Signature: wcfMultiVal::wcfMultiVal()

wcfMultiValConstructor2Definition = addConstructor(wcfMultiValDefinition, ...
    "wcfMultiVal::wcfMultiVal()", ...
    "Description", "clib.webcface.wcfMultiVal Constructor of C++ class wcfMultiVal."); % Modify help description values as needed.
validate(wcfMultiValConstructor2Definition);

%% C++ class public data member |as_int| for C++ class |wcfMultiVal| 
% C++ Signature: int wcfMultiVal::as_int

addProperty(wcfMultiValDefinition, "as_int", "int32", ...
    "Description", "int32    Data member of C++ class wcfMultiVal."); % Modify help description values as needed.

%% C++ class public data member |as_double| for C++ class |wcfMultiVal| 
% C++ Signature: double wcfMultiVal::as_double

addProperty(wcfMultiValDefinition, "as_double", "double", ...
    "Description", "double    Data member of C++ class wcfMultiVal."); % Modify help description values as needed.

%% C++ class public data member |as_str| for C++ class |wcfMultiVal| 
% C++ Signature: char const * wcfMultiVal::as_str

addProperty(wcfMultiValDefinition, "as_str", "string", "nullTerminated", ...
    "Description", "string    読み取り専用 Data member of C++ class wcfMultiVal."); % Modify help description values as needed.

%% C++ function |wcfInit| with MATLAB name |clib.webcface.wcfInit|
% C++ Signature: wcfClient wcfInit(char const * name,char const * host,int port = 7530)

wcfInitDefinition = addFunction(libDef, ...
    "wcfClient wcfInit(char const * name,char const * host,int port = 7530)", ...
    "MATLABName", "clib.webcface.wcfInit", ...
    "Description", "clib.webcface.wcfInit Representation of C++ function wcfInit."); % Modify help description values as needed.
defineArgument(wcfInitDefinition, "name", "string", "input", "nullTerminated");
defineArgument(wcfInitDefinition, "host", "string", "input", "nullTerminated");
defineArgument(wcfInitDefinition, "port", "int32");
defineOutput(wcfInitDefinition, "RetVal", "clib.webcface.wcfClient", 1);
validate(wcfInitDefinition);

%% C++ function |wcfIsInstance| with MATLAB name |clib.webcface.wcfIsInstance|
% C++ Signature: int wcfIsInstance(wcfClient wcli)

wcfIsInstanceDefinition = addFunction(libDef, ...
    "int wcfIsInstance(wcfClient wcli)", ...
    "MATLABName", "clib.webcface.wcfIsInstance", ...
    "Description", "clib.webcface.wcfIsInstance Representation of C++ function wcfIsInstance."); % Modify help description values as needed.
defineArgument(wcfIsInstanceDefinition, "wcli", "clib.webcface.wcfClient", "input", 1); % <MLTYPE> can be "clib.webcface.wcfClient", primitive type, user-defined type, or a clib.array type.
defineOutput(wcfIsInstanceDefinition, "RetVal", "int32");
validate(wcfIsInstanceDefinition);

%% C++ function |wcfClose| with MATLAB name |clib.webcface.wcfClose|
% C++ Signature: int wcfClose(wcfClient wcli)

wcfCloseDefinition = addFunction(libDef, ...
    "int wcfClose(wcfClient wcli)", ...
    "MATLABName", "clib.webcface.wcfClose", ...
    "Description", "clib.webcface.wcfClose Representation of C++ function wcfClose."); % Modify help description values as needed.
defineArgument(wcfCloseDefinition, "wcli", "clib.webcface.wcfClient", "input", 1); % <MLTYPE> can be "clib.webcface.wcfClient", primitive type, user-defined type, or a clib.array type.
defineOutput(wcfCloseDefinition, "RetVal", "int32");
validate(wcfCloseDefinition);

%% C++ function |wcfStart| with MATLAB name |clib.webcface.wcfStart|
% C++ Signature: int wcfStart(wcfClient wcli)

wcfStartDefinition = addFunction(libDef, ...
    "int wcfStart(wcfClient wcli)", ...
    "MATLABName", "clib.webcface.wcfStart", ...
    "Description", "clib.webcface.wcfStart Representation of C++ function wcfStart."); % Modify help description values as needed.
defineArgument(wcfStartDefinition, "wcli", "clib.webcface.wcfClient", "input", 1); % <MLTYPE> can be "clib.webcface.wcfClient", primitive type, user-defined type, or a clib.array type.
defineOutput(wcfStartDefinition, "RetVal", "int32");
validate(wcfStartDefinition);

%% C++ function |wcfSync| with MATLAB name |clib.webcface.wcfSync|
% C++ Signature: int wcfSync(wcfClient wcli)

wcfSyncDefinition = addFunction(libDef, ...
    "int wcfSync(wcfClient wcli)", ...
    "MATLABName", "clib.webcface.wcfSync", ...
    "Description", "clib.webcface.wcfSync Representation of C++ function wcfSync."); % Modify help description values as needed.
defineArgument(wcfSyncDefinition, "wcli", "clib.webcface.wcfClient", "input", 1); % <MLTYPE> can be "clib.webcface.wcfClient", primitive type, user-defined type, or a clib.array type.
defineOutput(wcfSyncDefinition, "RetVal", "int32");
validate(wcfSyncDefinition);

%% C++ function |wcfValueSet| with MATLAB name |clib.webcface.wcfValueSet|
% C++ Signature: int wcfValueSet(wcfClient wcli,char const * field,double value)

wcfValueSetDefinition = addFunction(libDef, ...
    "int wcfValueSet(wcfClient wcli,char const * field,double value)", ...
    "MATLABName", "clib.webcface.wcfValueSet", ...
    "Description", "clib.webcface.wcfValueSet Representation of C++ function wcfValueSet."); % Modify help description values as needed.
defineArgument(wcfValueSetDefinition, "wcli", "clib.webcface.wcfClient", "input", 1); % <MLTYPE> can be "clib.webcface.wcfClient", primitive type, user-defined type, or a clib.array type.
defineArgument(wcfValueSetDefinition, "field", "string", "input", "nullTerminated");
defineArgument(wcfValueSetDefinition, "value", "double");
defineOutput(wcfValueSetDefinition, "RetVal", "int32");
validate(wcfValueSetDefinition);

%% C++ function |wcfValueSetVecD| with MATLAB name |clib.webcface.wcfValueSetVecD|
% C++ Signature: int wcfValueSetVecD(wcfClient wcli,char const * field,double const * values,int size)

wcfValueSetVecDDefinition = addFunction(libDef, ...
    "int wcfValueSetVecD(wcfClient wcli,char const * field,double const * values,int size)", ...
    "MATLABName", "clib.webcface.wcfValueSetVecD", ...
    "Description", "clib.webcface.wcfValueSetVecD Representation of C++ function wcfValueSetVecD."); % Modify help description values as needed.
defineArgument(wcfValueSetVecDDefinition, "wcli", "clib.webcface.wcfClient", "input", 1); % <MLTYPE> can be "clib.webcface.wcfClient", primitive type, user-defined type, or a clib.array type.
defineArgument(wcfValueSetVecDDefinition, "field", "string", "input", "nullTerminated");
defineArgument(wcfValueSetVecDDefinition, "values", "clib.array.webcface.Double", "input", "size"); % <MLTYPE> can be "clib.array.webcface.Double", or "double"
defineArgument(wcfValueSetVecDDefinition, "size", "int32");
defineOutput(wcfValueSetVecDDefinition, "RetVal", "int32");
validate(wcfValueSetVecDDefinition);

%% C++ function |wcfFuncRun| with MATLAB name |clib.webcface.wcfFuncRun|
% C++ Signature: wcfMultiVal const * wcfFuncRun(wcfClient wcli,char const * member,char const * field,wcfMultiVal * args,int arg_size)

%wcfFuncRunDefinition = addFunction(libDef, ...
%    "wcfMultiVal const * wcfFuncRun(wcfClient wcli,char const * member,char const * field,wcfMultiVal * args,int arg_size)", ...
%    "MATLABName", "clib.webcface.wcfFuncRun", ...
%    "Description", "clib.webcface.wcfFuncRun Representation of C++ function wcfFuncRun."); % Modify help description values as needed.
%defineArgument(wcfFuncRunDefinition, "wcli", "clib.webcface.wcfClient", "input", 1); % <MLTYPE> can be "clib.webcface.wcfClient", primitive type, user-defined type, or a clib.array type.
%defineArgument(wcfFuncRunDefinition, "member", "string", "input", "nullTerminated");
%defineArgument(wcfFuncRunDefinition, "field", "string", "input", "nullTerminated");
%defineArgument(wcfFuncRunDefinition, "args", "clib.webcface.wcfMultiVal", "input", <SHAPE>); % <MLTYPE> can be "clib.webcface.wcfMultiVal", or "clib.array.webcface.wcfMultiVal"
%defineArgument(wcfFuncRunDefinition, "arg_size", "int32");
%defineOutput(wcfFuncRunDefinition, "RetVal", "clib.webcface.wcfMultiVal", <SHAPE>); % <MLTYPE> can be "clib.webcface.wcfMultiVal", or "clib.array.webcface.wcfMultiVal"
%validate(wcfFuncRunDefinition);

%% C++ function |wcfFuncRunS| with MATLAB name |clib.webcface.wcfFuncRunS|
% C++ Signature: char const * wcfFuncRunS(wcfClient wcli,char const * member,char const * field,char const * * args,int arg_size)

wcfFuncRunSDefinition = addFunction(libDef, ...
    "char const * wcfFuncRunS(wcfClient wcli,char const * member,char const * field,char const * * args,int arg_size)", ...
    "MATLABName", "clib.webcface.wcfFuncRunS", ...
    "Description", "clib.webcface.wcfFuncRunS Representation of C++ function wcfFuncRunS."); % Modify help description values as needed.
defineArgument(wcfFuncRunSDefinition, "wcli", "clib.webcface.wcfClient", "input", 1); % <MLTYPE> can be "clib.webcface.wcfClient", primitive type, user-defined type, or a clib.array type.
defineArgument(wcfFuncRunSDefinition, "member", "string", "input", "nullTerminated");
defineArgument(wcfFuncRunSDefinition, "field", "string", "input", "nullTerminated");
defineArgument(wcfFuncRunSDefinition, "args", "string", "input", {"arg_size", "nullTerminated"});
defineArgument(wcfFuncRunSDefinition, "arg_size", "int32");
defineOutput(wcfFuncRunSDefinition, "RetVal", "string", "nullTerminated");
validate(wcfFuncRunSDefinition);

%% Validate the library definition
validate(libDef);

end
