// from: https://github.com/abegehr/monsterjump/commit/34a098ef980804b89363fde943945595043904a3

function requestDeviceOrientationEventPermission() {
    console.log("requestDeviceOrientationEventPermission - called.");
  
    if (typeof DeviceOrientationEvent !== "undefined") {
      // feature detect
      if (typeof DeviceOrientationEvent.requestPermission === "function") {
        return DeviceOrientationEvent.requestPermission()
          .then((permissionState) => {
            console.log(
              "requestDeviceOrientationEventPermission – permissionState: ",
              permissionState
            );
            return permissionState;
          })
          .catch((err) =>
            console.warn("requestDeviceOrientationEventPermission – Error: ", err)
          );
      } else {
        // handle regular non iOS 13+ devices
        console.warn(
          "requestDeviceOrientationEventPermission – DeviceOrientationEvent.requestPermission is not defined."
        );
      }
    } else {
      alert("You're device does not support Orientation :(");
    }
  }