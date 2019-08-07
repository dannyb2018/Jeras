/*
       Copyright dannyb@cloudpta 2019, https://github.com/dannyb2018

       Licensed under the Apache License, Version 2.0 (the "License");
       you may not use this file except in compliance with the License.
       You may obtain a copy of the License at

         http://www.apache.org/licenses/LICENSE-2.0

       Unless required by applicable law or agreed to in writing, software
       distributed under the License is distributed on an "AS IS" BASIS,
       WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
       See the License for the specific language governing permissions and
       limitations under the License.

       Based on code from 
       https://github.com/tensorflow
       Copyright 2016 The TensorFlow Authors. All Rights Reserved
 */
package com.cloudpta.jeras.internals.backend.tensorflow;
import com.cloudpta.jeras.internals.backend.CPTAResultCode;
import com.cloudpta.jeras.internals.backend.raw.tensorflow.SWIGTYPE_p_TF_Status;
import com.cloudpta.jeras.internals.backend.raw.tensorflow.TF_Code;
import com.cloudpta.jeras.internals.backend.raw.tensorflow.tensorflow;
/**
 *
 * @author PC
 */
public class CPTATFStatus implements AutoCloseable
{
    public CPTATFStatus()
    {
        status = tensorflow.TF_NewStatus();
    }
    
    public CPTATFStatus(CPTAResultCode statusCode, String statusMessage)
    {
        status = tensorflow.TF_NewStatus();
        TF_Code tfCode = convertToTensorflowCode(statusCode);
        tensorflow.TF_SetStatus(status, tfCode, statusMessage);
    }
    
    public CPTAResultCode getCode()
    {
        TF_Code result = tensorflow.TF_GetCode(status);
        return this.convertToInternalCode(result);
    }
    
    public String getMessage()
    {
        return tensorflow.TF_Message(status);
    }
    
    @Override
    public void close() throws Exception
    {
        tensorflow.TF_DeleteStatus(status);
    }
    
    private TF_Code convertToTensorflowCode(CPTAResultCode code)
    {
        return TF_Code.TF_OK;
    }
    
    private CPTAResultCode convertToInternalCode(TF_Code tensorflowResultCode)
    {
        return CPTAResultCode.OK;
    }
    
    SWIGTYPE_p_TF_Status status;
}
