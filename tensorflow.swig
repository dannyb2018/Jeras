%module tensorflow
%{
#include "include/tensorflow/c/c_api.h"
%}
%include "cdata.i"

%apply int { size_t };
%apply long{ int64_t  };

const char* TF_Version();
enum TF_DataType {
  TF_FLOAT = 1,
  TF_DOUBLE = 2,
  TF_INT32 = 3,  // Int32 tensors are always in 'host' memory.
  TF_UINT8 = 4,
  TF_INT16 = 5,
  TF_INT8 = 6,
  TF_STRING = 7,
  TF_COMPLEX64 = 8,  // Single-precision complex
  TF_COMPLEX = 8,    // Old identifier kept for API backwards compatibility
  TF_INT64 = 9,
  TF_BOOL = 10,
  TF_QINT8 = 11,     // Quantized int8
  TF_QUINT8 = 12,    // Quantized uint8
  TF_QINT32 = 13,    // Quantized int32
  TF_BFLOAT16 = 14,  // Float32 truncated to 16 bits.  Only for cast ops.
  TF_QINT16 = 15,    // Quantized int16
  TF_QUINT16 = 16,   // Quantized uint16
  TF_UINT16 = 17,
  TF_COMPLEX128 = 18,  // Double-precision complex
  TF_HALF = 19,
  TF_RESOURCE = 20,
  TF_VARIANT = 21,
  TF_UINT32 = 22,
  TF_UINT64 = 23,
} ;
enum TF_Code {
  TF_OK = 0,
  TF_CANCELLED = 1,
  TF_UNKNOWN = 2,
  TF_INVALID_ARGUMENT = 3,
  TF_DEADLINE_EXCEEDED = 4,
  TF_NOT_FOUND = 5,
  TF_ALREADY_EXISTS = 6,
  TF_PERMISSION_DENIED = 7,
  TF_UNAUTHENTICATED = 16,
  TF_RESOURCE_EXHAUSTED = 8,
  TF_FAILED_PRECONDITION = 9,
  TF_ABORTED = 10,
  TF_OUT_OF_RANGE = 11,
  TF_UNIMPLEMENTED = 12,
  TF_INTERNAL = 13,
  TF_UNAVAILABLE = 14,
  TF_DATA_LOSS = 15,
};

/* Buffer Management */
struct TF_Buffer {
  void* data;
  size_t length;
  void (*data_deallocator)(void* data, size_t length);
} ;


TF_Buffer* TF_NewBufferFromString(const char* proto, size_t proto_len);

// Useful for passing *out* a protobuf.
TF_Buffer* TF_NewBuffer();
void TF_DeleteBuffer(TF_Buffer*);
TF_Buffer TF_GetBuffer(TF_Buffer* buffer);

size_t TF_DataTypeSize(TF_DataType dt);

size_t TF_StringEncode(const char* src, size_t src_len, char* dst, size_t dst_len, TF_Status* status);
size_t TF_StringDecode(const char* src, size_t src_len, const char** dst, size_t* dst_len, TF_Status* status);
size_t TF_StringEncodedSize(size_t len);

/* Tensors */

%feature("director") TF_Tensor;


TF_Tensor* TF_NewTensor(
    TF_DataType, const int64_t* dims, int num_dims, void* data, size_t len,
    void (*deallocator)(void* data, size_t len, void* arg),
    void* deallocator_arg);
TF_Tensor* TF_AllocateTensor(TF_DataType,
                                                   const int64_t* dims,
                                                   int num_dims, size_t len);
void TF_DeleteTensor(TF_Tensor* tensor);
TF_Tensor* TF_TensorMaybeMove(TF_Tensor* tensor);

size_t TF_TensorByteSize(const TF_Tensor*);
void* TF_TensorData(const TF_Tensor* tensor);

TF_DataType TF_TensorType(const TF_Tensor* tensor);
int TF_NumDims(const TF_Tensor* tensor);
int64_t TF_Dim(const TF_Tensor* tensor, int dim_index);
int64_t TF_TensorElementCount(const TF_Tensor* tensor);

/* Graph */
%feature("director") TF_Graph;

TF_Graph* TF_NewGraph(void);
void TF_DeleteGraph(TF_Graph*);


/* ops */
TF_Buffer* TF_GetAllOpList();
