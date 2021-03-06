local sg90_crv = {}

sg90_crv.Angle_AX =     { 0, 30, 60, 90, 120, 150, 180}
-- 0 -> 0.544 ms -> 2.72% -> 27.8256/1023
-- 90 -> 1.5 ms -> 7.5% -> 76.725/1023
-- 180 -> 2.4 ms -> 12% -> 122.76/1023
sg90_crv.Duty1023_Crv = {27, 43, 59, 76,  91, 107, 123}
sg90_crv.size = 0
sg90_crv.persisteFile = "sg90_crv.ref"

function sg90_crv.init()
    	sg90_crv.size = table.getn(sg90_crv.Angle_AX)
	sg90_crv.persisteFile = "sg90_crv.ref"
end

function sg90_crv.getAngle_AX()
	return sg90_crv.Angle_AX
end

function sg90_crv.calibDuty1023_Crv(index, val)
	sg90_crv.Duty1023_Crv[index] = val
end

function sg90_crv.readDuty1023_Crv()
	local f = io.open(sg90_crv.persisteFile, "r")
	local i = 1
	if nil ~= f then
		for li = f:lines() do
			sg90_crv.Duty1023_Crv[i] = tonumber(li)
			i = i + 1
		end
		f:close()
	end
end

function sg90_crv.persisteDuty1023_Crv()
	local f = io.open(sg90_crv.persisteFile, "w+")
	for i = 1, sg90_crv.size do
		f:write(sg90_crv.Duty1023_Crv[i] .. "\n")
	end
	f:close()
end

function sg90_crv.linearInterpol(angle)
	local ret = 0
	local i = 1
	if angle <= sg90_crv.Angle_AX[1] then
		ret = sg90_crv.Angle_AX[1]
	elseif angle >= sg90_crv.Angle_AX[sg90_crv.size] then
		ret = sg90_crv.Angle_AX[sg90_crv.size]
	else
		while angle < sg90_crv.Angle_AX[i]
			i = i + 1
		end
		ret = (sg90_crv.Duty1023_Crv[i-1]*(angle-sg90_crv.Angle_AX[i-1]) + sg90_crv.Duty1023_Crv[i]*(sg90_crv.Angle_AX[i]-angle))/(sg90_crv.Angle_AX[i]-sg90_crv.Angle_AX[i-1]);
	end
	return ret
end

return sg90_crv

