#! /usr/bin/lua
-- demo to control servo SG90 using pwm and tmr
local servo_p = 1 -- control with D1/GPIO5
local duty = 0
local duties = {27, 71, 123}
local index = 1
local tmr0 = 0
local ledPin = 4
local ledState = 0

gpio.mode(ledPin,gpio.OUTPUT)
pwm.setup(servo_p, 50, duty*1023/1000)
pwm.start(servo_p)

function updateDuty()
    ledState = 1 - ledState;
    gpio.write(ledPin, ledState)
    duty = duty + 10
    if duty > 100 then
        duty = 0
    end
    print("current duty: " .. duties[index]*100/1023)
    pwm.setduty(servo_p, duties[index])
    index = index + 1
    if index > 3 then
        index = 1
    end
end

tmr.alarm(tmr0, 5000, tmr.ALARM_AUTO, updateDuty)
