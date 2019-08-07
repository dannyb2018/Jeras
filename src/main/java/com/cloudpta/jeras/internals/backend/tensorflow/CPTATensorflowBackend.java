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
import com.cloudpta.jeras.internals.backend.CPTABackend;
import java.util.HashMap;
/**
 *
 * @author dannyb2018
 */
public class CPTATensorflowBackend extends CPTABackend
{
    //# This is the default internal TF session used by Keras.
    //# It can be set manually via `set_session(sess)`.
    protected CPTATFSession defaultSession = null;

    //# This dictionary holds a mapping {graph: learning_phase}.
    //# A learning phase is a bool tensor used to run Keras models in
    //# either train mode (learning_phase == 1) or test mode (learning_phase == 0).
    //_GRAPH_LEARNING_PHASES = {}
    protected HashMap<String, Integer> graphLearningPhases = new HashMap<>();

    //# This dictionary holds a mapping {graph: UID_DICT}.
    //# each UID_DICT is a dictionary mapping name prefixes to a current index,
    //# used for generating graph-specific string UIDs
    //# for various names (e.g. layer names).
    //_GRAPH_UID_DICTS = {}
    protected HashMap<String, String> graphUIDDicts = new HashMap<>();

    //# This boolean flag can be set to True to leave variable initialization
    //# up to the user.
    //# Change its value via `manual_variable_initialization(value)`.
    //_MANUAL_VAR_INIT = False
    protected boolean manualVarInit = false;

    //# This list holds the available devices.
    //# It is populated when `_get_available_gpus()` is called for the first time.
    //# We assume our devices don't change during our lifetime.
    //_LOCAL_DEVICES = None 
    protected Object localDevices = null;
}
