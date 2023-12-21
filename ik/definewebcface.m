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

%% C++ enumeration |wcfStatus| with MATLAB name |clib.webcface.wcfStatus| 
addEnumeration(libDef, "wcfStatus", "int32",...
    [...
      "WCF_OK",...  % 0
      "WCF_BAD_WCLI",...  % 1
      "WCF_NOT_FOUND",...  % 2
    ],...
    "MATLABName", "clib.webcface.wcfStatus", ...
    "Description", "clib.webcface.wcfStatus    Representation of C++ enumeration wcfStatus."); % Modify help description values as needed.

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
    "Description", "clib.webcface.wcfInit Representation of C++ function wcfInit." + newline + ...
    "クライアントを初期化する", ...
    "DetailedDescription", "This content is from the external library documentation."); % Modify help description values as needed.
defineArgument(wcfInitDefinition, "name", "string", "input", "nullTerminated");
defineArgument(wcfInitDefinition, "host", "string", "input", "nullTerminated");
defineArgument(wcfInitDefinition, "port", "int32");
defineOutput(wcfInitDefinition, "RetVal", "clib.webcface.wcfClient", 1, "Description", "Clientのポインタ");
validate(wcfInitDefinition);

%% C++ function |wcfIsInstance| with MATLAB name |clib.webcface.wcfIsInstance|
% C++ Signature: int wcfIsInstance(wcfClient wcli)

wcfIsInstanceDefinition = addFunction(libDef, ...
    "int wcfIsInstance(wcfClient wcli)", ...
    "MATLABName", "clib.webcface.wcfIsInstance", ...
    "Description", "clib.webcface.wcfIsInstance Representation of C++ function wcfIsInstance." + newline + ...
    "有効なClientのポインタであるかを返す", ...
    "DetailedDescription", "This content is from the external library documentation."); % Modify help description values as needed.
defineArgument(wcfIsInstanceDefinition, "wcli", "clib.webcface.wcfClient", "input", 1); % <MLTYPE> can be "clib.webcface.wcfClient", primitive type, user-defined type, or a clib.array type.
defineOutput(wcfIsInstanceDefinition, "RetVal", "int32", "Description", "wcliが正常にwcfInitされwcfCloseする前のポインタであれば1、そうでなければ0");
validate(wcfIsInstanceDefinition);

%% C++ function |wcfClose| with MATLAB name |clib.webcface.wcfClose|
% C++ Signature: wcfStatus wcfClose(wcfClient wcli)

wcfCloseDefinition = addFunction(libDef, ...
    "wcfStatus wcfClose(wcfClient wcli)", ...
    "MATLABName", "clib.webcface.wcfClose", ...
    "Description", "clib.webcface.wcfClose Representation of C++ function wcfClose." + newline + ...
    "クライアントを閉じる", ...
    "DetailedDescription", "This content is from the external library documentation."); % Modify help description values as needed.
defineArgument(wcfCloseDefinition, "wcli", "clib.webcface.wcfClient", "input", 1); % <MLTYPE> can be "clib.webcface.wcfClient", primitive type, user-defined type, or a clib.array type.
defineOutput(wcfCloseDefinition, "RetVal", "clib.webcface.wcfStatus", "Description", "wcliが無効ならWCF_BAD_WCLI");
validate(wcfCloseDefinition);

%% C++ function |wcfStart| with MATLAB name |clib.webcface.wcfStart|
% C++ Signature: wcfStatus wcfStart(wcfClient wcli)

wcfStartDefinition = addFunction(libDef, ...
    "wcfStatus wcfStart(wcfClient wcli)", ...
    "MATLABName", "clib.webcface.wcfStart", ...
    "Description", "clib.webcface.wcfStart Representation of C++ function wcfStart." + newline + ...
    "接続を開始する", ...
    "DetailedDescription", "This content is from the external library documentation."); % Modify help description values as needed.
defineArgument(wcfStartDefinition, "wcli", "clib.webcface.wcfClient", "input", 1); % <MLTYPE> can be "clib.webcface.wcfClient", primitive type, user-defined type, or a clib.array type.
defineOutput(wcfStartDefinition, "RetVal", "clib.webcface.wcfStatus", "Description", "wcliが無効ならWCF_BAD_WCLI");
validate(wcfStartDefinition);

%% C++ function |wcfSync| with MATLAB name |clib.webcface.wcfSync|
% C++ Signature: wcfStatus wcfSync(wcfClient wcli)

wcfSyncDefinition = addFunction(libDef, ...
    "wcfStatus wcfSync(wcfClient wcli)", ...
    "MATLABName", "clib.webcface.wcfSync", ...
    "Description", "clib.webcface.wcfSync Representation of C++ function wcfSync." + newline + ...
    "送信用にセットしたデータをすべて送信キューに入れる。", ...
    "DetailedDescription", "This content is from the external library documentation." + newline + ...
    "" + newline + ...
    "実際に送信をするのは別スレッドであり、この関数はブロックしない。" + newline + ...
    " " + newline + ...
    " サーバーに接続していない場合、wcfStart()を呼び出す。"); % Modify help description values as needed.
defineArgument(wcfSyncDefinition, "wcli", "clib.webcface.wcfClient", "input", 1); % <MLTYPE> can be "clib.webcface.wcfClient", primitive type, user-defined type, or a clib.array type.
defineOutput(wcfSyncDefinition, "RetVal", "clib.webcface.wcfStatus", "Description", "wcliが無効ならWCF_BAD_WCLI");
validate(wcfSyncDefinition);

%% C++ function |wcfValueSet| with MATLAB name |clib.webcface.wcfValueSet|
% C++ Signature: wcfStatus wcfValueSet(wcfClient wcli,char const * field,double value)

wcfValueSetDefinition = addFunction(libDef, ...
    "wcfStatus wcfValueSet(wcfClient wcli,char const * field,double value)", ...
    "MATLABName", "clib.webcface.wcfValueSet", ...
    "Description", "clib.webcface.wcfValueSet Representation of C++ function wcfValueSet." + newline + ...
    "単一の値を送信する", ...
    "DetailedDescription", "This content is from the external library documentation."); % Modify help description values as needed.
defineArgument(wcfValueSetDefinition, "wcli", "clib.webcface.wcfClient", "input", 1, "Description", "wcli Clientポインタ"); % <MLTYPE> can be "clib.webcface.wcfClient", primitive type, user-defined type, or a clib.array type.
defineArgument(wcfValueSetDefinition, "field", "string", "input", "nullTerminated", "Description", "field valueの名前");
defineArgument(wcfValueSetDefinition, "value", "double", "Description", "value 送信する値");
defineOutput(wcfValueSetDefinition, "RetVal", "clib.webcface.wcfStatus", "Description", "wcliが無効ならWCF_BAD_WCLI");
validate(wcfValueSetDefinition);

%% C++ function |wcfValueSetVecD| with MATLAB name |clib.webcface.wcfValueSetVecD|
% C++ Signature: wcfStatus wcfValueSetVecD(wcfClient wcli,char const * field,double const * values,int size)

wcfValueSetVecDDefinition = addFunction(libDef, ...
   "wcfStatus wcfValueSetVecD(wcfClient wcli,char const * field,double const * values,int size)", ...
   "MATLABName", "clib.webcface.wcfValueSetVecD", ...
   "Description", "clib.webcface.wcfValueSetVecD Representation of C++ function wcfValueSetVecD." + newline + ...
   "複数の値を送信する(doubleの配列)", ...
   "DetailedDescription", "This content is from the external library documentation."); % Modify help description values as needed.
defineArgument(wcfValueSetVecDDefinition, "wcli", "clib.webcface.wcfClient", "input", 1, "Description", "wcli Clientポインタ"); % <MLTYPE> can be "clib.webcface.wcfClient", primitive type, user-defined type, or a clib.array type.
defineArgument(wcfValueSetVecDDefinition, "field", "string", "input", "nullTerminated", "Description", "field valueの名前");
defineArgument(wcfValueSetVecDDefinition, "values", "clib.array.webcface.Double", "input", "size", "Description", "values 送信する値の配列の先頭のポインタ"); % <MLTYPE> can be "clib.array.webcface.Double", or "double"
defineArgument(wcfValueSetVecDDefinition, "size", "int32", "Description", "size 送信する値の数");
defineOutput(wcfValueSetVecDDefinition, "RetVal", "clib.webcface.wcfStatus", "Description", "wcliが無効ならWCF_BAD_WCLI");
validate(wcfValueSetVecDDefinition);

%% C++ function |wcfValueGetVecD| with MATLAB name |clib.webcface.wcfValueGetVecD|
% C++ Signature: wcfStatus wcfValueGetVecD(wcfClient wcli,char const * member,char const * field,double * values,int size,int * recv_size)

wcfValueGetVecDDefinition = addFunction(libDef, ...
   "wcfStatus wcfValueGetVecD(wcfClient wcli,char const * member,char const * field,double * values,int size,int * recv_size)", ...
   "MATLABName", "clib.webcface.wcfValueGetVecD", ...
   "Description", "clib.webcface.wcfValueGetVecD Representation of C++ function wcfValueGetVecD." + newline + ...
   "値を受信する" + newline + ...
   " " + newline + ...
   " sizeに指定したサイズより実際に受信した値の個数のほうが大きい場合、" + newline + ...
   " valuesにはsize分の値のみを格納しrecv_sizeには本来のサイズを返す", ...
   "DetailedDescription", "This content is from the external library documentation."); % Modify help description values as needed.
defineArgument(wcfValueGetVecDDefinition, "wcli", "clib.webcface.wcfClient", "input", 1, "Description", "wcli Clientポインタ"); % <MLTYPE> can be "clib.webcface.wcfClient", primitive type, user-defined type, or a clib.array type.
defineArgument(wcfValueGetVecDDefinition, "member", "string", "input", "nullTerminated", "Description", "member memberの名前");
defineArgument(wcfValueGetVecDDefinition, "field", "string", "input", "nullTerminated", "Description", "field valueの名前");
defineArgument(wcfValueGetVecDDefinition, "values", "double", "output", "size", "Description", "values 受信した値を格納する配列へのポインタ"); % <MLTYPE> can be "clib.array.webcface.Double", or "double"
defineArgument(wcfValueGetVecDDefinition, "size", "int32", "Description", "size 配列のサイズ");
defineArgument(wcfValueGetVecDDefinition, "recv_size", "int32", "output", 1, "Description", "recv_size 実際に受信した値の個数が返る"); % <MLTYPE> can be "clib.array.webcface.Int", or "int32"
defineOutput(wcfValueGetVecDDefinition, "RetVal", "clib.webcface.wcfStatus", "Description", "wcliが無効ならWCF_BAD_WCLI," + newline + ...
   "対象のmemberやfieldが存在しない場合 WCF_NOT_FOUND");
validate(wcfValueGetVecDDefinition);

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
