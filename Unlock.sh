#!/bin/bash

control_c()
# run if user hits control-c
{
  exit $?
}
# trap keyboard interrupt (control-c)
trap control_c SIGINT

DEVICE=$1
ADB=$2

echo "DEVICE ID $DEVICE";
echo "ADB PATH $ADB";

$ADB -s $DEVICE shell input keyevent 26
sleep 1

echo "Unlock the device process by 82, password and enter";
$ADB -s $DEVICE shell input keyevent 82
sleep 1

$ADB -s $DEVICE shell input text "11223344"
sleep 1

$ADB -s $DEVICE shell input keyevent KEYCODE_ENTER

<<VARUN
function wakeupDeviceExecute(obj) {
    const child = spawn(__dirname + "/Unlock_android_device.sh", [obj.device, PLATFORM_TOOLS + "adb" ], { shell: true });
    child.stdout.on("data", (data) => {
            logger.log(`Wakeup Device stdout *********: ${data}`);
    });

    child.stderr.on("data", (data) => {
            logger.error(`Wakeup Device stderr ************: ${data}`);
            utils.pcloudyStatToUser(obj, "wakeupDevice", "fail");
    });

    child.on("close", (code) => {
            logger.info(`Wakeup Device child process exited with code ${code}`);
            utils.pcloudyStatToUser(obj, "wakeupDevice", "done");

    });
}

hello
VARUN
