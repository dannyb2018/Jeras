REM set environment variables
SET SWIG_HOME=..\..\swigwin-3.0.12
SET JERAS_HOME=..\jeras
SET PROTOBUF_HOME=..\protobuf-master
SET TENSOR_FLOW_HOME=..\tensorflow-master
SET PROTOC_HOME=..\jeras\bin

REM make the directory for java raw api wrapper files if not already there
if not exist %JERAS_HOME%\src\main\java\com\cloudpta\jeras\internals\backend\raw\tensorflow mkdir %JERAS_HOME%\src\main\java\com\cloudpta\jeras\internals\backend\raw\tensorflow
if not exist %JERAS_BUF_HOME%\src\main\java\com\google\protobuf mkdir %JERAS_BUF_HOME%\src\main\java\com\google\protobuf

REM copy across the helper code for protocol buffers from the installation
xcopy /s/e/y %PROTOBUF_HOME%\java\core\src\main\java\com\google\protobuf\*.java %JERAS_HOME%\src\main\java\com\google\protobuf\

REM generate protocol buffer serialiser/deserialisers
%PROTOC_HOME%\protoc -I=%PROTOBUF_HOME%\src\google\protobuf --java_out=%JERAS_HOME%\src\main\java any.proto
%PROTOC_HOME%\protoc -I=%PROTOBUF_HOME%\src\google\protobuf\ --java_out=%JERAS_HOME%\src\main\java google/protobuf/api.proto
%PROTOC_HOME%\protoc -I=%PROTOBUF_HOME%\src\google\protobuf\ --java_out=%JERAS_HOME%\src\main\java descriptor.proto
%PROTOC_HOME%\protoc -I=%PROTOBUF_HOME%\src\google\protobuf\ --java_out=%JERAS_HOME%\src\main\java duration.proto
%PROTOC_HOME%\protoc -I=%PROTOBUF_HOME%\src\google\protobuf\ --java_out=%JERAS_HOME%\src\main\java empty.proto
%PROTOC_HOME%\protoc -I=%PROTOBUF_HOME%\src\google\protobuf\ --java_out=%JERAS_HOME%\src\main\java field_mask.proto
%PROTOC_HOME%\protoc -I=%PROTOBUF_HOME%\src\google\protobuf\ --java_out=%JERAS_HOME%\src\main\java source_context.proto
%PROTOC_HOME%\protoc -I=%PROTOBUF_HOME%\src\google\protobuf\ --java_out=%JERAS_HOME%\src\main\java struct.proto
%PROTOC_HOME%\protoc -I=%PROTOBUF_HOME%\src\google\protobuf\ --java_out=%JERAS_HOME%\src\main\java timestamp.proto
%PROTOC_HOME%\protoc -I=%PROTOBUF_HOME%\src\google\protobuf\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java type.proto
%PROTOC_HOME%\protoc -I=%PROTOBUF_HOME%\src\google\protobuf\ --java_out=.\tensorflow\src\main\java wrappers.proto
%PROTOC_HOME%\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java allocation_description.proto
%PROTOC_HOME%\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java api_def.proto
%PROTOC_HOME%\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java attr_value.proto
%PROTOC_HOME%\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java cost_graph.proto
%PROTOC_HOME%\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java device_attributes.proto
%PROTOC_HOME%\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java function.proto
%PROTOC_HOME%\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java graph.proto
%PROTOC_HOME%\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java graph_transfer_info.proto
%PROTOC_HOME%\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java kernel_def.proto
%PROTOC_HOME%\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java log_memory.proto
%PROTOC_HOME%\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java node_def.proto
%PROTOC_HOME%\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java op_def.proto
%PROTOC_HOME%\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java reader_base.proto
%PROTOC_HOME%\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java remote_fused_graph_execute_info.proto
%PROTOC_HOME%\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java resource_handle.proto
%PROTOC_HOME%\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java step_stats.proto
%PROTOC_HOME%\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java summary.proto
%PROTOC_HOME%\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java tensor.proto
%PROTOC_HOME%\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java tensor_description.proto
%PROTOC_HOME%\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java tensor_shape.proto
%PROTOC_HOME%\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java tensor_slice.proto
%PROTOC_HOME%\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java types.proto
%PROTOC_HOME%\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java variable.proto
%PROTOC_HOME%\protoc -I=%TENSOR_FLOW_HOME%\;%TENSOR_FLOW_HOME%\tensorflow\core\framework\;%PROTOBUF_HOME%\src\ --java_out=%JERAS_HOME%\src\main\java versions.proto

REM create the wrapper files
%SWIG_HOME%\swig -I%SWIG_HOME%\lib;%TENSOR_FLOW_HOME% -java -c++ -package com.cloudpta.jeras.internals.backend.raw.tensorflow -outdir %JERAS_HOME%/src/main/java/com/cloudpta/jeras/internals/backend/raw/tensorflow tensorflow.swig