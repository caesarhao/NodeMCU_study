local sg90_crv = require 'sg90_crv'
local servo_sg90 = {}
servo_sg90.servo_p = 1
servo_sg90.angle_C = 90

function servo_sg90.servo_sg90_init_proc()
  pwm.setup(servo_sg90.servo_p, 50, sg90_crv.linearInterpol(90))
  pwm.start(servo_sg90.servo_p)
end

function servo_sg90.servo_sg90_1000ms_proc()
  pwm.setduty(servo_sg90.servo_p, sg90_crv.linearInterpol(servo_sg90.angle_C))
end

return servo_sg90
