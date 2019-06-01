REM set environment variables
SET SWIG_HOME=z:\swigwin-3.0.12
SET JERAS_HOME=Z:\jeras
SET PROTOBUF_HOME=Z:\protobuf-master
SET TENSOR_FLOW_HOME=Z:\tensorflow-master

REM make the directory for java raw api wrapper files if not already there
if not exist %JERAS_HOME%\src\main\java\com\cloudpta\jeras\internals\backend\raw\tensorflow mkdir %JERAS_HOME%\src\main\java\com\cloudpta\jeras\internals\backend\raw\tensorflow
if not exist %JERAS_BUF_HOME%\src\main\java\com\google\protobuf mkdir %JERAS_BUF_HOME%\src\main\java\com\google\protobuf

REM copy across the helper code for protocol buffers from the installation
xcopy /s/e/y %PROTOBUF_HOME%\java\core\src\main\java\com\google\protobuf\*.java %JERAS_HOME%\src\main\java\com\google\protobuf\

REM generate protocol buffer serialiser/deserialisers
%JERAS_HOME%\bin\protoc -I=%PROTOBUF_HOME%\src\google\protobuf --java_out=%JERAS_HOME%\src\main\java any.proto
%JERAS_HOME%\bin\protoc -I=%PROTOBUF_HOME%\src\google\protobuf\ --java_out=%JERAS_HOME%\src\main\java google/protobuf/api.proto
%JERAS_HOME%\bin\protoc -I=%PROTOBUF_HOME%\src\google\protobuf\ --java_out=%JERAS_HOME%\src\main\java descriptor.proto
%JERAS_HOME%\bin\protoc -I=%PROTOBUF_HOME%\src\google\protobuf\ --java_out=%JERAS_HOME%\src\main\java duration.proto
%JERAS_HOME%\bin\protoc -I=%PROTOBUF_HOME%\src\google\protobuf\ --java_out=%JERAS_HOME%\src\main\java empty.proto
%JERAS_HOME%\bin\protoc -I=%PROTOBUF_HOME%\src\google\protobuf\ --java_out=%JERAS_HOME%\src\main\java field_mask.proto
%JERAS_HOME%\bin\protoc -I=%PROTOBUF_HOME%\src\google\protobuf\ --java_out=%JERAS_HOME%\src\main\java source_context.proto
%JERAS_HOME%\bin\protoc -I=%PROTOBUF_HOME%\src\google\protobuf\ --java_out=%JERAS_HOME%\src\main\java struct.proto
%JERAS_HOME%\bin\protoc -I=%PROTOBUF_HOME%\src\google\protobuf\ --java_out=%JERAS_HOME%\src\main\java timestamp.proto
%JERAS_HOME%\bin\protoc -I=%PROTOBUF_HOME%\src\google\protobuf\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java type.proto
%JERAS_HOME%\bin\protoc -I=%PROTOBUF_HOME%\src\google\protobuf\ --java_out=.\tensorflow\src\main\java wrappers.proto
%JERAS_HOME%\bin\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java allocation_description.proto
%JERAS_HOME%\bin\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java api_def.proto
%JERAS_HOME%\bin\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java attr_value.proto
%JERAS_HOME%\bin\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java cost_graph.proto
%JERAS_HOME%\bin\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java device_attributes.proto
%JERAS_HOME%\bin\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java function.proto
%JERAS_HOME%\bin\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java graph.proto
%JERAS_HOME%\bin\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java graph_transfer_info.proto
%JERAS_HOME%\bin\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java kernel_def.proto
%JERAS_HOME%\bin\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java log_memory.proto
%JERAS_HOME%\bin\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java node_def.proto
%JERAS_HOME%\bin\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java op_def.proto
%JERAS_HOME%\bin\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java reader_base.proto
%JERAS_HOME%\bin\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java remote_fused_graph_execute_info.proto
%JERAS_HOME%\bin\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java resource_handle.proto
%JERAS_HOME%\bin\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java step_stats.proto
%JERAS_HOME%\bin\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java summary.proto
%JERAS_HOME%\bin\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java tensor.proto
%JERAS_HOME%\bin\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java tensor_description.proto
%JERAS_HOME%\bin\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java tensor_shape.proto
%JERAS_HOME%\bin\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java tensor_slice.proto
%JERAS_HOME%\bin\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java types.proto
%JERAS_HOME%\bin\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java variable.proto
%JERAS_HOME%\bin\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java versions.proto

REM create the wrapper files
%SWIG_HOME%\swig -I%SWIG_HOME%\lib;%TENSOR_FLOW_HOME% -java -c++ -package com.cloudpta.jeras.internals.backend.raw.tensorflow -outdir %JERAS_HOME%/src/main/java/com/cloudpta/jeras/internals/backend/raw/tensorflow tensorflow.swig