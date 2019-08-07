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
import com.cloudpta.jeras.internals.backend.raw.tensorflow.SWIGTYPE_p_TF_SessionOptions;
import com.cloudpta.jeras.internals.backend.raw.tensorflow.tensorflow;
/**
 *
 * @author dannyb2018
 */
public class CPTATFSessionOptions implements AutoCloseable
{
    public CPTATFSessionOptions()
    {
        options = tensorflow.TF_NewSessionOptions();
    }
    
    public void setParameter(String parameter)
    {
        // Set the target in TF_SessionOptions.options.
        // target can be empty, a single entry, or a comma separated list of entries.
        // Each entry is in one of the following formats :
        // "local"
        // ip:port
        // host:port
        tensorflow.TF_SetTarget(options, parameter);
    }
    
    @Override
    public void close() throws Exception
    {
        tensorflow.TF_DeleteSessionOptions(options);
    }
 
    SWIGTYPE_p_TF_SessionOptions options;
}
