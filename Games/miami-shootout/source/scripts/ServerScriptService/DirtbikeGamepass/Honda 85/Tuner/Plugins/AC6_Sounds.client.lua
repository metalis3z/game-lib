--[[
	Novena Constraint Type: Motorcycle
			The Bike Chassis
	
	
					RikOne2 | Enjin
--]]
local bike = script.Parent.Bike.Value
local _Tune = require(bike["Tuner"])
local handler = bike:WaitForChild("AC6_Sound")

local on = 0
local mult=0
local det=0
local trm=.4
local trmmult=0
local trmon=0
local throt=0
local redline=0
local shift=0

local SetPitch = .1
local SetRev = 1.8

local vol = .7 --Set the volume for everything below

handler:FireServer("stopSound",bike.DriveSeat:WaitForChild("Rev"))
--handler:FireServer("stopSound",Your sound here)
wait()
handler:FireServer("playSound",bike.DriveSeat.Rev)
--handler:FireServer("playSound",Your sound here)


script.Parent.Values.Gear.Changed:connect(function()
	mult=1
	if script.Parent.Values.RPM.Value>5000 then shift=.2 end
end)

function makeTable(snd,pit,vol)
	local tbl = {}
	table.insert(tbl,snd)
	table.insert(tbl,pit)
	table.insert(tbl,vol)
	return tbl
end

function update(tbl)
	for _,i in pairs(tbl) do
		if i[2]~=i[1].Pitch then i[1].Pitch = i[2] end
		if i[3]~=i[1].Volume then i[1].Volume = i[3] end
	end
end

local lt = 0
local start = false
local play
game["Run Service"].Stepped:connect(function()
	local _RPM = script.Parent.Values.RPM.Value
	local updtbl = {}
	mult=math.max(0,mult-.1)
	
	if script.Parent.Values.Throttle.Value <= 0/100 then
		throt = math.max(.3,throt-.2)	
	else
		throt = math.min(1,throt+.1)	
	end	
	
	shift = math.min(1,shift+.2)
	
	if script.Parent.Values.RPM.Value > _Tune.Redline-_Tune.RevBounce/4 and script.Parent.Values.Throttle.Value > 0/100 then
		redline=.5
	else
		redline=1
	end
	
	if not script.Parent.IsOn.Value then on=math.max(on-.015,0) else on=1 end
	
	local function pitch(pit,rev) return math.max((((pit + rev*_RPM/_Tune.Redline))*on^2)+(det*mult*math.sin(80*tick())),pit) end
	local volBase = ((throt*shift*redline)+(trm*trmon*trmmult*(throt)*math.sin(tick()*50)))
	
	local RevP = pitch(SetPitch,SetRev) * on
	
	local RevV = math.max(volBase * on,0)
	
	
	table.insert(updtbl,makeTable(bike.DriveSeat.Rev,RevP,RevV*vol))
	--table.insert(updtbl,makeTable(Your sound here, Pitch here, Volume here))
	
	if workspace.FilteringEnabled then handler:FireServer("updateSounds",updtbl) else update(updtbl) end
end)
