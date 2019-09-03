# ReadMe

Based on
<https://docs.microsoft.com/en-us/azure/iot-hub/quickstart-send-telemetry-dotnet>

## Port requirements

Not sure what this needs, suspect some other ports are required because it is not working from laptop on work network.

## Simulated Temperature Sensor

The simulated sensor generates 500 messages of the following format:
''' json
{
    "machine":{"temperature":104.77499091195637,"pressure":10.543986306425408},
    "ambient":{"temperature":20.799186179553711,"humidity":25},
    "timeCreated":"2019-09-03T12:10:47.0579766Z"
}
'''

Total size of the 500 messages is about 87KB
The temperature is supposed to rise over the course of the 500 messages (I didn't check)
