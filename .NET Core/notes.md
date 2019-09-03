# Notes

## Running the code

in the folder

``` powershell
dotnet restore
dotnet run
```

## Publish EXE

dotnet publish -c Release -r win10-x64
dotnet publish -c Release -r ubuntu.16.10-x64
(See also <https://docs.microsoft.com/en-us/dotnet/core/rid-catalog>)

## CV with .NET Core

Some links on doing computer vision with C#

In combination with OpenCV
<https://www.c-sharpcorner.com/article/a-quick-introduction-to-computer-vision-using-c-sharp/>

Emgu CV is a .NET wrapper for OpenCV

Emgu TF is a .NET wrapper for Tensorflow
