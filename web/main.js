// from: https://github.com/abegehr/monsterjump/commit/34a098ef980804b89363fde943945595043904a3

function requestDeviceOrientationEventPermission() {
    console.log("requestDeviceOrientationEventPermission - called.");
    window.alert("requestDeviceOrientationEventPermission - called.");
  
    if (typeof DeviceOrientationEvent !== "undefined") {
      window.alert("supports DeviceOrientationEvent");
      // feature detect
      if (typeof DeviceOrientationEvent.requestPermission === "function") {
        window.alert("is Safari 13+ and has requestPermission");
        return DeviceOrientationEvent.requestPermission()
          .then((permissionState) => {
            console.log(
              "requestDeviceOrientationEventPermission – permissionState: ",
              permissionState
            );
            window.alert("requestDeviceOrientationEventPermission – permissionState: " + permissionState);
            return permissionState;
          })
          .catch((err) => {
            window.alert("requestDeviceOrientationEventPermission – err: " + err);
          });
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