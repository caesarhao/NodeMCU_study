local servo_sg90 = {}

local servo_sg90.Angle_AX =     { 0, 30, 60, 90, 120, 150, 180}
local servo_sg90.Duty1023_Crv = {27, 43, 58, 71,  88, 105, 123}
local servo_sg90.size = 0

function servo_sg90.init()
    servo_sg90.size = table.getn(servo_sg90.Angle_AX)
end

function servo_sg90.linearInterpol(angle)
	local ret = 0
	local i = 1
	if angle <= servo_sg90.Angle_AX[1] then
		ret = servo_sg90.Angle_AX[1]
	elseif angle >= servo_sg90.Angle_AX[servo_sg90.size] then
		ret = servo_sg90.Angle_AX[servo_sg90.size]
	else
		while angle < servo_sg90.Angle_AX[i]
			i = i + 1
		end
		ret = (servo_sg90.Duty1023_Crv[i-1]*(angle-servo_sg90.Angle_AX[i-1]) + servo_sg90.Duty1023_Crv[i]*(servo_sg90.Angle_AX[i]-angle))/(servo_sg90.Angle_AX[i]-servo_sg90.Angle_AX[i-1]);
	end
	return ret
end

return servo_sg90
