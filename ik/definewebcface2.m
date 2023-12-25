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
libDef.OutputFolder = ".";
if ispc
    libDef.Libraries = [
        "..\kobuki\src\webcface\out\build\x64-Release\webcface.dll", ...
        "..\kobuki\src\webcface\out\build\x64-Release\spdlog.dll"
    ];
elseif isunix
    libDef.Libraries = [
        "../kobuki/src/webcface/build/libwebcface.so", ...
        "../kobuki/src/webcface/build/_deps/spdlog-build/libspdlog.so"
    ];
end
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
    "Description", "int32    Data member of C++ class wcfMultiVal." + newline + ...
    "int型でのアクセス", ...
    "DetailedDescription", "This content is from the external library documentation."); % Modify help description values as needed.

%% C++ class public data member |as_double| for C++ class |wcfMultiVal| 
% C++ Signature: double wcfMultiVal::as_double

addProperty(wcfMultiValDefinition, "as_double", "double", ...
    "Description", "double    Data member of C++ class wcfMultiVal." + newline + ...
    "double型でのアクセス", ...
    "DetailedDescription", "This content is from the external library documentation."); % Modify help description values as needed.

%% C++ class public data member |as_str| for C++ class |wcfMultiVal| 
% C++ Signature: char const * wcfMultiVal::as_str

addProperty(wcfMultiValDefinition, "as_str", "string", "nullTerminated", ...
    "Description", "string    読み取り専用 Data member of C++ class wcfMultiVal." + newline + ...
    "char*型でのアクセス", ...
    "DetailedDescription", "This content is from the external library documentation." + newline + ...
    "" + newline + ...
    "as_intまたはas_doubleに値をセットして渡す場合はas_strはnullにすること。" + newline + ...
    "     " + newline + ...
    "     値が返ってくる場合はas_strがnullになっていることはない。(何も返さない場合でも空文字列が入る)"); % Modify help description values as needed.

%% C++ class |wcfFuncCallHandle| with MATLAB name |clib.webcface.wcfFuncCallHandle| 
wcfFuncCallHandleDefinition = addClass(libDef, "wcfFuncCallHandle", "MATLABName", "clib.webcface.wcfFuncCallHandle", ...
    "Description", "clib.webcface.wcfFuncCallHandle    Representation of C++ class wcfFuncCallHandle."); % Modify help description values as needed.

%% C++ class constructor for C++ class |wcfFuncCallHandle| 
% C++ Signature: wcfFuncCallHandle::wcfFuncCallHandle(wcfFuncCallHandle const & input1)

wcfFuncCallHandleConstructor1Definition = addConstructor(wcfFuncCallHandleDefinition, ...
    "wcfFuncCallHandle::wcfFuncCallHandle(wcfFuncCallHandle const & input1)", ...
    "Description", "clib.webcface.wcfFuncCallHandle Constructor of C++ class wcfFuncCallHandle."); % Modify help description values as needed.
defineArgument(wcfFuncCallHandleConstructor1Definition, "input1", "clib.webcface.wcfFuncCallHandle", "input");
validate(wcfFuncCallHandleConstructor1Definition);

%% C++ class public data member |args| for C++ class |wcfFuncCallHandle| 
% C++ Signature: wcfMultiVal const * const wcfFuncCallHandle::args

addProperty(wcfFuncCallHandleDefinition, "args", "clib.array.webcface.wcfMultiVal", "arg_size", ... % <MLTYPE> can be "clib.webcface.wcfMultiVal", or "clib.array.webcface.wcfMultiVal"
   "Description", "clib.webcface.wcfMultiVal    読み取り専用 Data member of C++ class wcfFuncCallHandle." + newline + ...
   "呼び出された引数", ...
   "DetailedDescription", "This content is from the external library documentation."); % Modify help description values as needed.

%% C++ class public data member |arg_size| for C++ class |wcfFuncCallHandle| 
% C++ Signature: int const wcfFuncCallHandle::arg_size

addProperty(wcfFuncCallHandleDefinition, "arg_size", "int32", ...
    "Description", "int32    読み取り専用 Data member of C++ class wcfFuncCallHandle." + newline + ...
    "引数の個数", ...
    "DetailedDescription", "This content is from the external library documentation." + newline + ...
    "" + newline + ...
    "listen時に指定した個数と必ず同じになる。"); % Modify help description values as needed.

%% C++ function |wcfInit| with MATLAB name |clib.webcface.wcfInit|
% C++ Signature: wcfClient * wcfInit(char const * name,char const * host,int port)

wcfInitDefinition = addFunction(libDef, ...
   "wcfClient * wcfInit(char const * name,char const * host,int port)", ...
   "MATLABName", "clib.webcface.wcfInit", ...
   "Description", "clib.webcface.wcfInit Representation of C++ function wcfInit."); % Modify help description values as needed.
defineArgument(wcfInitDefinition, "name", "string", "input", "nullTerminated");
defineArgument(wcfInitDefinition, "host", "string", "input", "nullTerminated");
defineArgument(wcfInitDefinition, "port", "int32");
defineOutput(wcfInitDefinition, "RetVal", "clib.webcface.wcfClient", 1); % <MLTYPE> can be an existing typedef name for void* or a new typedef name to void*.
validate(wcfInitDefinition);

%% C++ function |wcfInitDefault| with MATLAB name |clib.webcface.wcfInitDefault|
% C++ Signature: wcfClient * wcfInitDefault(char const * name)

wcfInitDefaultDefinition = addFunction(libDef, ...
   "wcfClient * wcfInitDefault(char const * name)", ...
   "MATLABName", "clib.webcface.wcfInitDefault", ...
   "Description", "clib.webcface.wcfInitDefault Representation of C++ function wcfInitDefault."); % Modify help description values as needed.
defineArgument(wcfInitDefaultDefinition, "name", "string", "input", "nullTerminated");
defineOutput(wcfInitDefaultDefinition, "RetVal", "clib.webcface.wcfClient", 1); % <MLTYPE> can be an existing typedef name for void* or a new typedef name to void*.
validate(wcfInitDefaultDefinition);

%% C++ function |wcfIsValid| with MATLAB name |clib.webcface.wcfIsValid|
% C++ Signature: int wcfIsValid(wcfClient * wcli)

wcfIsValidDefinition = addFunction(libDef, ...
   "int wcfIsValid(wcfClient * wcli)", ...
   "MATLABName", "clib.webcface.wcfIsValid", ...
   "Description", "clib.webcface.wcfIsValid Representation of C++ function wcfIsValid."); % Modify help description values as needed.
defineArgument(wcfIsValidDefinition, "wcli", "clib.webcface.wcfClient", "input", 1); % <MLTYPE> can be primitive type, user-defined type, clib.array type, or a list of existing typedef names for void*.
defineOutput(wcfIsValidDefinition, "RetVal", "int32");
validate(wcfIsValidDefinition);

%% C++ function |wcfIsConnected| with MATLAB name |clib.webcface.wcfIsConnected|
% C++ Signature: int wcfIsConnected(wcfClient * wcli)

wcfIsConnectedDefinition = addFunction(libDef, ...
   "int wcfIsConnected(wcfClient * wcli)", ...
   "MATLABName", "clib.webcface.wcfIsConnected", ...
   "Description", "clib.webcface.wcfIsConnected Representation of C++ function wcfIsConnected."); % Modify help description values as needed.
defineArgument(wcfIsConnectedDefinition, "wcli", "clib.webcface.wcfClient", "input", 1); % <MLTYPE> can be primitive type, user-defined type, clib.array type, or a list of existing typedef names for void*.
defineOutput(wcfIsConnectedDefinition, "RetVal", "int32");
validate(wcfIsConnectedDefinition);

%% C++ function |wcfClose| with MATLAB name |clib.webcface.wcfClose|
% C++ Signature: wcfStatus wcfClose(wcfClient * wcli)

wcfCloseDefinition = addFunction(libDef, ...
   "wcfStatus wcfClose(wcfClient * wcli)", ...
   "MATLABName", "clib.webcface.wcfClose", ...
   "Description", "clib.webcface.wcfClose Representation of C++ function wcfClose."); % Modify help description values as needed.
defineArgument(wcfCloseDefinition, "wcli", "clib.webcface.wcfClient", "input", 1); % <MLTYPE> can be primitive type, user-defined type, clib.array type, or a list of existing typedef names for void*.
defineOutput(wcfCloseDefinition, "RetVal", "int32");
validate(wcfCloseDefinition);

%% C++ function |wcfStart| with MATLAB name |clib.webcface.wcfStart|
% C++ Signature: wcfStatus wcfStart(wcfClient * wcli)

wcfStartDefinition = addFunction(libDef, ...
   "wcfStatus wcfStart(wcfClient * wcli)", ...
   "MATLABName", "clib.webcface.wcfStart", ...
   "Description", "clib.webcface.wcfStart Representation of C++ function wcfStart."); % Modify help description values as needed.
defineArgument(wcfStartDefinition, "wcli", "clib.webcface.wcfClient", "input", 1); % <MLTYPE> can be primitive type, user-defined type, clib.array type, or a list of existing typedef names for void*.
defineOutput(wcfStartDefinition, "RetVal", "int32");
validate(wcfStartDefinition);

%% C++ function |wcfSync| with MATLAB name |clib.webcface.wcfSync|
% C++ Signature: wcfStatus wcfSync(wcfClient * wcli)

wcfSyncDefinition = addFunction(libDef, ...
   "wcfStatus wcfSync(wcfClient * wcli)", ...
   "MATLABName", "clib.webcface.wcfSync", ...
   "Description", "clib.webcface.wcfSync Representation of C++ function wcfSync."); % Modify help description values as needed.
defineArgument(wcfSyncDefinition, "wcli", "clib.webcface.wcfClient", "input", 1); % <MLTYPE> can be primitive type, user-defined type, clib.array type, or a list of existing typedef names for void*.
defineOutput(wcfSyncDefinition, "RetVal", "int32");
validate(wcfSyncDefinition);

%% C++ function |wcfValueSet| with MATLAB name |clib.webcface.wcfValueSet|
% C++ Signature: wcfStatus wcfValueSet(wcfClient * wcli,char const * field,double value)

wcfValueSetDefinition = addFunction(libDef, ...
   "wcfStatus wcfValueSet(wcfClient * wcli,char const * field,double value)", ...
   "MATLABName", "clib.webcface.wcfValueSet", ...
   "Description", "clib.webcface.wcfValueSet Representation of C++ function wcfValueSet."); % Modify help description values as needed.
defineArgument(wcfValueSetDefinition, "wcli", "clib.webcface.wcfClient", "input", 1); % <MLTYPE> can be primitive type, user-defined type, clib.array type, or a list of existing typedef names for void*.
defineArgument(wcfValueSetDefinition, "field", "string", "input", "nullTerminated");
defineArgument(wcfValueSetDefinition, "value", "double");
defineOutput(wcfValueSetDefinition, "RetVal", "int32");
validate(wcfValueSetDefinition);

%% C++ function |wcfValueSetVecD| with MATLAB name |clib.webcface.wcfValueSetVecD|
% C++ Signature: wcfStatus wcfValueSetVecD(wcfClient * wcli,char const * field,double const * values,int size)

wcfValueSetVecDDefinition = addFunction(libDef, ...
   "wcfStatus wcfValueSetVecD(wcfClient * wcli,char const * field,double const * values,int size)", ...
   "MATLABName", "clib.webcface.wcfValueSetVecD", ...
   "Description", "clib.webcface.wcfValueSetVecD Representation of C++ function wcfValueSetVecD."); % Modify help description values as needed.
defineArgument(wcfValueSetVecDDefinition, "wcli", "clib.webcface.wcfClient", "input", 1); % <MLTYPE> can be primitive type, user-defined type, clib.array type, or a list of existing typedef names for void*.
defineArgument(wcfValueSetVecDDefinition, "field", "string", "input", "nullTerminated");
defineArgument(wcfValueSetVecDDefinition, "values", "clib.array.webcface.Double", "input", "size"); % <MLTYPE> can be "clib.array.webcface.Double", or "double"
defineArgument(wcfValueSetVecDDefinition, "size", "int32");
defineOutput(wcfValueSetVecDDefinition, "RetVal", "int32");
validate(wcfValueSetVecDDefinition);

%% C++ function |wcfValueGetVecD| with MATLAB name |clib.webcface.wcfValueGetVecD|
% C++ Signature: wcfStatus wcfValueGetVecD(wcfClient * wcli,char const * member,char const * field,double * values,int size,int * recv_size)

wcfValueGetVecDDefinition = addFunction(libDef, ...
   "wcfStatus wcfValueGetVecD(wcfClient * wcli,char const * member,char const * field,double * values,int size,int * recv_size)", ...
   "MATLABName", "clib.webcface.wcfValueGetVecD", ...
   "Description", "clib.webcface.wcfValueGetVecD Representation of C++ function wcfValueGetVecD."); % Modify help description values as needed.
defineArgument(wcfValueGetVecDDefinition, "wcli", "clib.webcface.wcfClient", "input", 1); % <MLTYPE> can be primitive type, user-defined type, clib.array type, or a list of existing typedef names for void*.
defineArgument(wcfValueGetVecDDefinition, "member", "string", "input", "nullTerminated");
defineArgument(wcfValueGetVecDDefinition, "field", "string", "input", "nullTerminated");
defineArgument(wcfValueGetVecDDefinition, "values", "double", "output", "size"); % <MLTYPE> can be "clib.array.webcface.Double", or "double"
defineArgument(wcfValueGetVecDDefinition, "size", "int32");
defineArgument(wcfValueGetVecDDefinition, "recv_size", "int32", "output", 1); % <MLTYPE> can be "clib.array.webcface.Int", or "int32"
defineOutput(wcfValueGetVecDDefinition, "RetVal", "int32");
validate(wcfValueGetVecDDefinition);

%% C++ function |wcfValI| with MATLAB name |clib.webcface.wcfValI|
% C++ Signature: wcfMultiVal wcfValI(int value)

wcfValIDefinition = addFunction(libDef, ...
    "wcfMultiVal wcfValI(int value)", ...
    "MATLABName", "clib.webcface.wcfValI", ...
    "Description", "clib.webcface.wcfValI Representation of C++ function wcfValI."); % Modify help description values as needed.
defineArgument(wcfValIDefinition, "value", "int32");
defineOutput(wcfValIDefinition, "RetVal", "clib.webcface.wcfMultiVal");
validate(wcfValIDefinition);

%% C++ function |wcfValD| with MATLAB name |clib.webcface.wcfValD|
% C++ Signature: wcfMultiVal wcfValD(double value)

wcfValDDefinition = addFunction(libDef, ...
    "wcfMultiVal wcfValD(double value)", ...
    "MATLABName", "clib.webcface.wcfValD", ...
    "Description", "clib.webcface.wcfValD Representation of C++ function wcfValD."); % Modify help description values as needed.
defineArgument(wcfValDDefinition, "value", "double");
defineOutput(wcfValDDefinition, "RetVal", "clib.webcface.wcfMultiVal");
validate(wcfValDDefinition);

%% C++ function |wcfValS| with MATLAB name |clib.webcface.wcfValS|
% C++ Signature: wcfMultiVal wcfValS(char const * value)

wcfValSDefinition = addFunction(libDef, ...
    "wcfMultiVal wcfValS(char const * value)", ...
    "MATLABName", "clib.webcface.wcfValS", ...
    "Description", "clib.webcface.wcfValS Representation of C++ function wcfValS."); % Modify help description values as needed.
defineArgument(wcfValSDefinition, "value", "string", "input", "nullTerminated");
defineOutput(wcfValSDefinition, "RetVal", "clib.webcface.wcfMultiVal");
validate(wcfValSDefinition);

%% C++ function |wcfFuncRun| with MATLAB name |clib.webcface.wcfFuncRun|
% C++ Signature: wcfStatus wcfFuncRun(wcfClient * wcli,char const * member,char const * field,wcfMultiVal const * args,int arg_size,wcfMultiVal * * result)

wcfFuncRunDefinition = addFunction(libDef, ...
   "wcfStatus wcfFuncRun(wcfClient * wcli,char const * member,char const * field,wcfMultiVal const * args,int arg_size,wcfMultiVal * * result)", ...
   "MATLABName", "clib.webcface.wcfFuncRun", ...
   "Description", "clib.webcface.wcfFuncRun Representation of C++ function wcfFuncRun."); % Modify help description values as needed.
defineArgument(wcfFuncRunDefinition, "wcli", "clib.webcface.wcfClient", "input", 1); % <MLTYPE> can be primitive type, user-defined type, clib.array type, or a list of existing typedef names for void*.
defineArgument(wcfFuncRunDefinition, "member", "string", "input", "nullTerminated");
defineArgument(wcfFuncRunDefinition, "field", "string", "input", "nullTerminated");
defineArgument(wcfFuncRunDefinition, "args", "clib.array.webcface.wcfMultiVal", "input", "arg_size"); % <MLTYPE> can be "clib.webcface.wcfMultiVal", or "clib.array.webcface.wcfMultiVal"
defineArgument(wcfFuncRunDefinition, "arg_size", "int32");
defineArgument(wcfFuncRunDefinition, "result", "clib.webcface.wcfMultiVal", "output", 1);
defineOutput(wcfFuncRunDefinition, "RetVal", "int32");
validate(wcfFuncRunDefinition);

%% C++ function |wcfFuncListen| with MATLAB name |clib.webcface.wcfFuncListen|
% C++ Signature: wcfStatus wcfFuncListen(wcfClient * wcli,char const * field,wcfValType const * arg_types,int arg_size,wcfValType return_type)

wcfFuncListenDefinition = addFunction(libDef, ...
   "wcfStatus wcfFuncListen(wcfClient * wcli,char const * field,wcfValType const * arg_types,int arg_size,wcfValType return_type)", ...
   "MATLABName", "clib.webcface.wcfFuncListen", ...
   "Description", "clib.webcface.wcfFuncListen Representation of C++ function wcfFuncListen."); % Modify help description values as needed.
defineArgument(wcfFuncListenDefinition, "wcli", "clib.webcface.wcfClient", "input", 1); % <MLTYPE> can be primitive type, user-defined type, clib.array type, or a list of existing typedef names for void*.
defineArgument(wcfFuncListenDefinition, "field", "string", "input", "nullTerminated");
defineArgument(wcfFuncListenDefinition, "arg_types", "clib.array.webcface.Int", "input", "arg_size"); % <MLTYPE> can be "clib.array.webcface.Int", or "int32"
defineArgument(wcfFuncListenDefinition, "arg_size", "int32");
defineArgument(wcfFuncListenDefinition, "return_type", "int32");
defineOutput(wcfFuncListenDefinition, "RetVal", "int32");
validate(wcfFuncListenDefinition);

%% C++ function |wcfFuncFetchCall| with MATLAB name |clib.webcface.wcfFuncFetchCall|
% C++ Signature: wcfStatus wcfFuncFetchCall(wcfClient * wcli,char const * field,wcfFuncCallHandle * * handle)

wcfFuncFetchCallDefinition = addFunction(libDef, ...
   "wcfStatus wcfFuncFetchCall(wcfClient * wcli,char const * field,wcfFuncCallHandle * * handle)", ...
   "MATLABName", "clib.webcface.wcfFuncFetchCall", ...
   "Description", "clib.webcface.wcfFuncFetchCall Representation of C++ function wcfFuncFetchCall."); % Modify help description values as needed.
defineArgument(wcfFuncFetchCallDefinition, "wcli", "clib.webcface.wcfClient", "input", 1); % <MLTYPE> can be primitive type, user-defined type, clib.array type, or a list of existing typedef names for void*.
defineArgument(wcfFuncFetchCallDefinition, "field", "string", "input", "nullTerminated");
defineArgument(wcfFuncFetchCallDefinition, "handle", "clib.webcface.wcfFuncCallHandle", "output", 1);
defineOutput(wcfFuncFetchCallDefinition, "RetVal", "int32");
validate(wcfFuncFetchCallDefinition);

%% C++ function |wcfFuncRespond| with MATLAB name |clib.webcface.wcfFuncRespond|
% C++ Signature: wcfStatus wcfFuncRespond(wcfFuncCallHandle const * handle,wcfMultiVal const * value)

wcfFuncRespondDefinition = addFunction(libDef, ...
   "wcfStatus wcfFuncRespond(wcfFuncCallHandle const * handle,wcfMultiVal const * value)", ...
   "MATLABName", "clib.webcface.wcfFuncRespond", ...
   "Description", "clib.webcface.wcfFuncRespond Representation of C++ function wcfFuncRespond."); % Modify help description values as needed.
defineArgument(wcfFuncRespondDefinition, "handle", "clib.webcface.wcfFuncCallHandle", "input", 1); % <MLTYPE> can be "clib.webcface.wcfFuncCallHandle", or "clib.array.webcface.wcfFuncCallHandle"
defineArgument(wcfFuncRespondDefinition, "value", "clib.webcface.wcfMultiVal", "input", 1); % <MLTYPE> can be "clib.webcface.wcfMultiVal", or "clib.array.webcface.wcfMultiVal"
defineOutput(wcfFuncRespondDefinition, "RetVal", "int32");
validate(wcfFuncRespondDefinition);

%% C++ function |wcfFuncReject| with MATLAB name |clib.webcface.wcfFuncReject|
% C++ Signature: wcfStatus wcfFuncReject(wcfFuncCallHandle const * handle,char const * message)

wcfFuncRejectDefinition = addFunction(libDef, ...
   "wcfStatus wcfFuncReject(wcfFuncCallHandle const * handle,char const * message)", ...
   "MATLABName", "clib.webcface.wcfFuncReject", ...
   "Description", "clib.webcface.wcfFuncReject Representation of C++ function wcfFuncReject."); % Modify help description values as needed.
defineArgument(wcfFuncRejectDefinition, "handle", "clib.webcface.wcfFuncCallHandle", "input", 1); % <MLTYPE> can be "clib.webcface.wcfFuncCallHandle", or "clib.array.webcface.wcfFuncCallHandle"
defineArgument(wcfFuncRejectDefinition, "message", "string", "input", "nullTerminated");
defineOutput(wcfFuncRejectDefinition, "RetVal", "int32");
validate(wcfFuncRejectDefinition);

%% Validate the library definition
validate(libDef);

end