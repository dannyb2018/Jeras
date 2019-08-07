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

/*Status*/
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

%feature("director") TF_Status;
TF_Status* TF_NewStatus(void);
void TF_DeleteStatus(TF_Status*);

// Record <code, msg> in *s.  Any previous information is lost.
// A common use is to clear a status: TF_SetStatus(s, TF_OK, "");
void TF_SetStatus(TF_Status* s, TF_Code code, const char* msg);
// Return the code record in *s.
TF_Code TF_GetCode(const TF_Status* s);

// Return a pointer to the (null-terminated) error message in *s.  The
// return value points to memory that is only usable until the next
// mutation to *s.  Always returns an empty string if TF_GetCode(s) is
// TF_OK.
const char* TF_Message(const TF_Status* s);

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


TF_Tensor* TF_NewTensor(TF_DataType, const int64_t* dims, int num_dims, void* data, size_t len, void (*deallocator)(void* data, size_t len, void* arg), void* deallocator_arg);
TF_Tensor* TF_AllocateTensor(TF_DataType,const int64_t* dims,
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

/* sesson */
%feature("director") TF_SessionOptions;
TF_SessionOptions* TF_NewSessionOptions(void);
void TF_DeleteSessionOptions(TF_SessionOptions*);
void TF_SetTarget(TF_SessionOptions* options, const char* target);
// BUGBUGDB this is left here but no idea how it will work
// Set the config in TF_SessionOptions.options.
// config should be a serialized tensorflow.ConfigProto proto.
// If config was not parsed successfully as a ConfigProto, record the
// error information in *status.
void TF_SetConfig(TF_SessionOptions* options, const void* proto, size_t proto_len, TF_Status* status);

%feature("director") TF_Session;
// Return a new execution session with the associated graph, or NULL on
// error. Does not take ownership of any input parameters.
//
// *`graph` must be a valid graph (not deleted or nullptr). `graph` will be be
// kept alive for the lifetime of the returned TF_Session. New nodes can still
// be added to `graph` after this call.
TF_Session* TF_NewSession(TF_Graph* graph, const TF_SessionOptions* opts, TF_Status* status);
// Close a session.
//
// Contacts any other processes associated with the session, if applicable.
// May not be called after TF_DeleteSession().
void TF_CloseSession(TF_Session*, TF_Status* status);
// Destroy a session object.
//
// Even if error information is recorded in *status, this call discards all
// local resources associated with the session.  The session may not be used
// during or after this call (and the session drops its reference to the
// corresponding graph).
void TF_DeleteSession(TF_Session*, TF_Status* status);
