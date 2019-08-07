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
import com.cloudpta.jeras.internals.backend.raw.tensorflow.TF_Buffer;
import com.cloudpta.jeras.internals.backend.raw.tensorflow.tensorflow;
/**
 *
 * @author dannyb2018
 */
public class CPTATFBuffer implements AutoCloseable
{
    public CPTATFBuffer(byte[] data)
    {
        // So buffers in tensorflow involve making a new buffer
        // Then setting the data to point to some data then 
        // with its length 
        // Need to set the release function too....
        // In C looks like
        // TF_Buffer* buffer = TF_NewBuffer();
        // buffer->data= some_data;
        // buffer->length= length_of_some_data;
        // buffer->data_deallocator = free_buffer_function ;
        // signature of data_deallocator is
        // void free_buffer(void* data, size_t length)
        // Probably best to set this inside 
        buffer = tensorflow.TF_NewBuffer();
    }
     
    public static CPTATFBuffer fromString(String bufferAsString)
    {
        return null;
    }
    
    public void freeBuffer()
    {
        // Maybe inherited later
    }
    
    @Override
    public void close() throws Exception
    {
        tensorflow.TF_DeleteBuffer(buffer);
    }
    
    protected TF_Buffer buffer;

}
