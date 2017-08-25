local calsrv = {}
local cal_measures = {}
local cal_calibs = {}
local apcfg = {}
local ipcfg = {}
-- element size
calsrv.Bool = 1
calsrv.Byte = 1
calsrv.Word = 2
calsrv.DWord = 4
calsrv.QWord = 8
calsrv.Float = 4
calsrv.Double = 8

function calsrv.calsrv_init_proc()
	apcfg.ssid = "NodeMCU_Calib"
	apcfg.pwd = "12345678"
	apcfg.max = 1

    	ipcfg.ip="192.168.250.1",
    	ipcfg.netmask="255.255.255.0",
    	ipcfg.gateway="192.168.250.1"
end

local function fun_ApStaConnected_cb(T)

end

function calsrv.calsrv_initend_proc()
	wifi.ap.config(apcfg)
	wifi.ap.setip(ipcfg)
	wifi.ap.dhcp.start()
	wifi.eventmon.register(wifi.eventmon.AP_STACONNECTED, fun_ApStaConnected_cb)
end

function calsrv.calsrv_100ms_proc()

end

function calsrv.register_meas(var)

end

function calsrv.register_calib(var)

end

return calsrv

