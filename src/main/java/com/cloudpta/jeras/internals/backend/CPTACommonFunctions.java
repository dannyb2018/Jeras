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
 */
package com.cloudpta.jeras.internals.backend;

import java.util.ArrayList;

/**
 *
 * @author dannyb2018
 */
public class CPTACommonFunctions 
{
    public enum FLOAT_TYPE
    {
        FLOAT_16, FLOAT_32, FLOAT_64;
    }
    
    public enum IMAGE_DATA_FORMAT_TYPE
    {
        CHANNELS_LAST,CHANNELS_FIRST;
    }
    
    // the type of float to use throughout the session.
    static protected FLOAT_TYPE _FLOATX = FLOAT_TYPE.FLOAT_32;
    protected String _EPSILON = "1e-7";
    protected IMAGE_DATA_FORMAT_TYPE _IMAGE_DATA_FORMAT = IMAGE_DATA_FORMAT_TYPE.CHANNELS_LAST;

    /*
        Returns .
    """

    # Returns
        A float.

    # Example
    ```python
        >>> keras.backend.epsilon()
        1e-07
    ```
    """
    */
    /*
    @returns the value of the fuzz factor used in numeric expressions
    */
    public String getEpsilon()
    {
        return _EPSILON;
    }

    /*
    """Sets the value of the fuzz factor used in numeric expressions.

    # Arguments
        e: float. New value of epsilon.

    # Example
    ```python
        >>> from keras import backend as K
        >>> K.epsilon()
        1e-07
        >>> K.set_epsilon(1e-05)
        >>> K.epsilon()
        1e-05
    ```
    """
    
    */
    public void setEpsilon(String newEpsilon)
    {
        _EPSILON = newEpsilon;
    }

    /*
        @return the default float type, FLOAT16, FLOAT32, FLOAT64.
        @see #FLOAT_TYPE
    */
    public FLOAT_TYPE getFloatX()
    {
        return _FLOATX;
    }


    /*
    """Sets the default float type.

    # Arguments
        floatx: String, 'float16', 'float32', or 'float64'.

    # Example
    ```python
        >>> from keras import backend as K
        >>> K.floatx()
        'float32'
        >>> K.set_floatx('float16')
        >>> K.floatx()
        'float16'
    ```
    """
    
    */
    public void setFloatx( FLOAT_TYPE newFloatx)
    {
        _FLOATX = newFloatx;
        
    }

    /*
    """Cast a Numpy array to the default Keras float type.

    # Arguments
        x: Numpy array.

    # Returns
        The same Numpy array, cast to its new type.

    # Example
    ```python
        >>> from keras import backend as K
        >>> K.floatx()
        'float32'
        >>> arr = numpy.array([1.0, 2.0], dtype='float64')
        >>> arr.dtype
        dtype('float64')
        >>> new_arr = K.cast_to_floatx(arr)
        >>> new_arr
        array([ 1.,  2.], dtype=float32)
        >>> new_arr.dtype
        dtype('float32')
    ```
    """
    
    */
    public ArrayList<Float> castToFloatX(ArrayList<Object> arrayToConvertToDefault)
    {
        //    return np.asarray(x, dtype=_FLOATX)
        return null;
    }

    /*
    """Returns the default image data format convention.

    # Returns
        A string, either `'channels_first'` or `'channels_last'`

    # Example
    ```python
        >>> keras.backend.image_data_format()
        'channels_first'
    ```
    """    
    */
    public IMAGE_DATA_FORMAT_TYPE getImageDataFormat()
    {
        return _IMAGE_DATA_FORMAT;
    }

    /*
    """Sets the value of the data format convention.

    # Arguments
        data_format: string. `'channels_first'` or `'channels_last'`.

    # Example
    ```python
        >>> from keras import backend as K
        >>> K.image_data_format()
        'channels_first'
        >>> K.set_image_data_format('channels_last')
        >>> K.image_data_format()
        'channels_last'
    ```
    """    
    */
    public void setImageDataFormat(IMAGE_DATA_FORMAT_TYPE newImageDataFormat)
    {
//    if data_format not in {'channels_last', 'channels_first'}:
  //      raise ValueError('Unknown data_format:', data_format)
        _IMAGE_DATA_FORMAT = newImageDataFormat;        
    }

/*def normalize_data_format(value):
    """Checks that the value correspond to a valid data format.

    # Arguments
        value: String or None. `'channels_first'` or `'channels_last'`.

    # Returns
        A string, either `'channels_first'` or `'channels_last'`

    # Example
    ```python
        >>> from keras import backend as K
        >>> K.normalize_data_format(None)
        'channels_first'
        >>> K.normalize_data_format('channels_last')
        'channels_last'
    ```

    # Raises
        ValueError: if `value` or the global `data_format` invalid.
    """
    if value is None:
        value = image_data_format()
    data_format = value.lower()
    if data_format not in {'channels_first', 'channels_last'}:
        raise ValueError('The `data_format` argument must be one of '
                         '"channels_first", "channels_last". Received: ' +
                         str(value))
    return data_format
/*

# Legacy methods

*/
    /*
    """Legacy setter for `image_data_format`.

    # Arguments
        dim_ordering: string. `tf` or `th`.

    # Example
    ```python
        >>> from keras import backend as K
        >>> K.image_data_format()
        'channels_first'
        >>> K.set_image_data_format('channels_last')
        >>> K.image_data_format()
        'channels_last'
    ```

    # Raises
        ValueError: if `dim_ordering` is invalid.
    """    
    */
    public void setImageDimOrdering(String newImageDimOrdering)
    {
         // defaulting to tensorflow
        IMAGE_DATA_FORMAT_TYPE dataFormat = IMAGE_DATA_FORMAT_TYPE.CHANNELS_LAST;
        // But if we are theano
        if ( true == newImageDimOrdering.equalsIgnoreCase("th"))
        {
            dataFormat = IMAGE_DATA_FORMAT_TYPE.CHANNELS_FIRST;
        }
        
        _IMAGE_DATA_FORMAT = dataFormat;
    }
    /*
                """Legacy getter for `image_data_format`.

    # Returns
        string, one of `'th'`, `'tf'`
    """

            */
    public String getImageDimOrdering()
    {
        if(IMAGE_DATA_FORMAT_TYPE.CHANNELS_LAST == _IMAGE_DATA_FORMAT)
        {
            return "tf";
        }
        else
        {
            return "th";
        } 
    }
}
