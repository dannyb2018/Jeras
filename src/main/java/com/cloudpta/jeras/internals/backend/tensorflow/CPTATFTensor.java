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
import com.cloudpta.jeras.internals.backend.raw.tensorflow.SWIGTYPE_p_TF_Tensor;
import com.cloudpta.jeras.internals.backend.raw.tensorflow.SWIGTYPE_p_void;
import com.cloudpta.jeras.internals.backend.raw.tensorflow.TF_DataType;
import com.cloudpta.jeras.internals.backend.raw.tensorflow.tensorflow;
/**
 *
 * @author dannyb2018
 */
public class CPTATFTensor implements AutoCloseable
{

    public CPTATFTensor(TF_DataType dataTypeOfTensorElements, long dims[], int numberOfDimension, SWIGTYPE_p_void data, int lenOfData)
    {
        /* Return a new tensor that holds the bytes data[0,len-1].
        //
        // The data will be deallocated by a subsequent call to TF_DeleteTensor via:
        //      (*deallocator)(data, len, deallocator_arg)
        // Clients must provide a custom deallocator function so they can pass in
        // memory managed by something like numpy.
        //
        // May return NULL (and invoke the deallocator) if the provided data buffer
        // (data, len) is inconsistent with a tensor of the given TF_DataType
        // and the shape specified by (dima, num_dims). */
        

        //tensorflow.TF_NewTensor(dataTypeOfTensorElements, dims, lenOfData, data, lenOfData, deallocator, data)
    }
    
    public CPTATFTensor(TF_DataType dataTypeOfTensorElements, long dims[], int numberOfDimension)
    {
        /* Allocate and return a new Tensor.
        //
        // This function is an alternative to TF_NewTensor and should be used when
        // memory is allocated to pass the Tensor to the C API. The allocated memory
        // satisfies TensorFlow's memory alignment preferences and should be preferred
        // over calling malloc and free.
        //
        // The caller must set the Tensor values by writing them to the pointer returned
        // by TF_TensorData with length TF_TensorByteSize.*/
        
        
        //tensorflow.TF_AllocateTensor(dataTypeOfTensorElements, dims, numberOfDimension, numberOfDimension)
    }

    // Return the type of a tensor element.
    public TF_DataType getDataType()
    {
        return tensorflow.TF_TensorType(internalTensorPointer);
    }
    
    public int getDimension(int dimensionOffset)
    {
        // Return the length of the tensor in the "dim_index" dimension.
        // REQUIRES: 0 <= dim_index < TF_NumDims(tensor)
        return tensorflow.TF_Dim(internalTensorPointer, dimensionOffset);
    }
    
    public int getNumberOfDimension()
    {
        // Return the number of dimensions that the tensor has.
        return tensorflow.TF_NumDims(internalTensorPointer);
    }
    
    public long getNumberOfElements()
    {
        // Returns the number of elements in the tensor
        return tensorflow.TF_TensorElementCount(internalTensorPointer);
    }
    
    // Return the size of the underlying data in bytes.
    public long getByteSize()
    {
        return tensorflow.TF_TensorByteSize(internalTensorPointer);
    }
    
    SWIGTYPE_p_void getUnderlyingData()
    {
        // Return a pointer to the underlying data buffer.
        
        // BUGBUGDB probably find a way to make this map to a byte array
        return tensorflow.TF_TensorData(internalTensorPointer);
    }
    
    public CPTATFTensor move()
    {
        // Deletes `tensor` and returns a new TF_Tensor with the same content if
        // possible. Returns nullptr and leaves `tensor` untouched if not.

        // BUGBUGDB not sure what the point of this is, might change signature of function later
        internalTensorPointer = tensorflow.TF_TensorMaybeMove(internalTensorPointer);
        return this;
    }
    
    public void freeTensorMemory()
    {
        // Maybe inherited later
    }
    
    @Override
    public void close() throws Exception
    {
        tensorflow.TF_DeleteTensor(internalTensorPointer);
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
    protected SWIGTYPE_p_TF_Tensor internalTensorPointer = null;
}
