#! /usr/bin/lua
-- demo to control servo SG90 using pwm and tmr
local servo_sg90 = require "servo_sg90"
local tmr0 = 0
local tmr1 = 1
local ledPin = 4
local ledState = 1 
local angle_delta = 10
local angle_max = 180
local angle_min = 0
 
gpio.mode(ledPin,gpio.OUTPUT)
servo_sg90.servo_sg90_init_proc()
 
function updateAngle()
    
    gpio.write(ledPin, ledState)
    duty = 100*pulse/period;
    print("current angle: " .. servo_sg90.angle_C)
    pwm.setduty(servo_p, math.floor(1024*duty/100))
    if ledState > 0 then
        servo_sg90.angle_C = servo_sg90.angle_C + angle_delta
        if servo_sg90.angle_C >= angle_max then
            servo_sg90.angle_C = angle_max
            ledState = 0
        end
    else
        servo_sg90.angle_C = servo_sg90.angle_C - angle_delta
        if servo_sg90.angle_C <= angle_min then
            servo_sg90.angle_C = angle_min
            ledState = 1
        end
    end
    
end

tmr.alarm(tmr0, 1000, tmr.ALARM_AUTO, servo_sg90.servo_sg90_1000ms_proc)
tmr.alarm(tmr1, 5000, tmr.ALARM_AUTO, updateAngle)


