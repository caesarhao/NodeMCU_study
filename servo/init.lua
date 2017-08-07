#! /usr/bin/lua
-- demo to control servo SG90 using pwm and tmr
local servo_p = 1 -- control with D1/GPIO5
local duty = 0 
--local duties = {27, 71, 123}
local pulse_min = 1.0 -- 1.0 ms for 0
local pulse_max = 2.0 -- 2.0 ms for 180
local freq = 50 -- Hz 
local period = 1000/freq -- ms
local num = 10
local pulse_delta = (pulse_max-pulse_min)/num
local pulse = pulse_min
local index = 1 
local tmr0 = 0
local ledPin = 4
local ledState = 1 
 
gpio.mode(ledPin,gpio.OUTPUT)
-- Use 400 Hz to control servo, period is 2.5 ms
duty = pulse/period;
pwm.setup(servo_p, freq, duty*1023/1000)
pwm.start(servo_p)
 
function updateDuty()
    
    gpio.write(ledPin, ledState)
    duty = 100*pulse/period;
    print("current duty: " .. duty .. "%")
    pwm.setduty(servo_p, math.floor(1024*duty/100))
    if ledState > 0 then
        pulse = pulse + pulse_delta
        if pulse > pulse_max then
            pulse = pulse_max
            ledState = 0
        end
    else
        pulse = pulse - pulse_delta
        if pulse < pulse_min then
            pulse = pulse_min
            ledState = 1
        end
    end
    
end

tmr.alarm(tmr0, 500, tmr.ALARM_AUTO, updateDuty)
