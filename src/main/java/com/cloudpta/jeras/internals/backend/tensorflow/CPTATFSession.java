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
package com.cloudpta.jeras.internals.backend.tensorflow;
import com.cloudpta.jeras.internals.backend.raw.tensorflow.SWIGTYPE_p_TF_Session;
import com.cloudpta.jeras.internals.backend.raw.tensorflow.tensorflow;
/**
 *
 * @author dannyb2018
 */
public class CPTATFSession implements AutoCloseable
{
    public CPTATFSession(CPTATFGraph sessionGraph, CPTATFSessionOptions sessionOptions)
    {
        graph = sessionGraph;
        options = sessionOptions;
        CPTATFStatus newSessionCreateStatus = new CPTATFStatus();
        
        session = tensorflow.TF_NewSession(graph.graph, options.options, newSessionCreateStatus.status);
    }
    
    @Override
    public void close() throws Exception
    {
        // Close the session
        CPTATFStatus sessionStatus = new CPTATFStatus();
        tensorflow.TF_CloseSession(session, sessionStatus.status);
        // Delete the session
        tensorflow.TF_DeleteSession(session, sessionStatus.status);
    }
    
    SWIGTYPE_p_TF_Session session;
    CPTATFGraph graph;
    CPTATFSessionOptions options;
}
