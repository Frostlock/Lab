This is based on the following tutorials  
https://docs.microsoft.com/en-us/azure/iot-hub/iot-hub-python-getstarted  
https://docs.microsoft.com/en-us/azure/iot-hub/iot-hub-live-data-visualization-in-web-apps


###Installation
`pip install azure-iothub-device-client`  
`pip install azure-iothub-service-client`

**Missing libboost**  
On my Ubuntu 16.04 I had to manually add libboost for Python:  
`sudo apt-get install libboost-python1.58.0`

###1. CreateDeviceIdentity.py
Use this script to create a new device identity in your Azure IOT hub

###2. SimulatedDevice.py
This scripts simulates a device that sends data into the IOT hub.
It runs in a loop