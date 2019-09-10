
clear %clears all data for future use

%register the brick, motor, and sensor
mylego = legoev3('usb');
dispMotor = motor(mylego,'A');
codeMotor = motor(mylego,'B');
touchBoi = touchSensor(mylego,1);

while readTouch(touchBoi) ~= 1
    dispMotor.Speed = -45;
    start(dispMotor)
end
dispMotor.Speed = 0;
stop(dispMotor)
pause(1)

while readTouch(touchBoi) ~= 1
    codeMotor.Speed = 5;
    start(codeMotor)
end
codeMotor.Speed = 0;
stop(codeMotor)
