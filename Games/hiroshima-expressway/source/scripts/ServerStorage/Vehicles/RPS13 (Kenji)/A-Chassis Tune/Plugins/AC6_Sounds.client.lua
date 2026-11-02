local car = script.Parent.Car.Value
local _Tune = require(car["A-Chassis Tune"])
local handler = car:WaitForChild("AC6_Sound")

local on = 0
local mult=0
local det=0
local trm=.4
local trmmult=0
local trmon=0
local throt=0
local redline=0
local shift=0

local RevAPitch = .09
local RevARev = 1

local RevBPitch = .17
local RevBRev = 1

local RelAPitch = .1
local RelARev = 0.6

local RelBPitch = .1
local RelBRev = 1

local RedPitch = .05
local RedRev = 1

local IdlePitch = 0.8
local IdleRev = 1

local RmbAPitch = .1
local RmbARev = 2.5

local RmbBPitch = .1
local RmbBRev = 2.5

local vol = 5 --Set the volume for everything below

car.Body:WaitForChild("Exh")

handler:FireServer("stopSound",car.Body.Exh.RevA)
handler:FireServer("stopSound",car.Body.Exh.RevB)
handler:FireServer("stopSound",car.Body.Exh.RelA)
handler:FireServer("stopSound",car.Body.Exh.RelB)
handler:FireServer("stopSound",car.Body.Exh.RmbA)
handler:FireServer("stopSound",car.Body.Exh.RmbB)
handler:FireServer("stopSound",car.Body.Exh.Idle)
handler:FireServer("stopSound",car.Body.Exh.Red)
wait()
handler:FireServer("playSound",car.Body.Exh.RevA)
handler:FireServer("playSound",car.Body.Exh.RevB)
handler:FireServer("playSound",car.Body.Exh.RelA)
handler:FireServer("playSound",car.Body.Exh.RelB)
handler:FireServer("playSound",car.Body.Exh.Idle)
handler:FireServer("playSound",car.Body.Exh.Red)


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
	throt = script.Parent.Values.Throttle.Value
	shift = math.min(1,shift+.2)
	
	if script.Parent.Values.RPM.Value > _Tune.Redline-_Tune.RevBounce/4 and script.Parent.Values.Throttle.Value > _Tune.IdleThrottle/100 then
		redline=.5
	else
		redline=1
	end
	
	if not script.Parent.IsOn.Value then on=math.max(on-.015,0) else on=1 end
	
	local function pitch(pit,rev) return math.max((((pit + rev*_RPM/_Tune.Redline))*on^2)+(det*mult*math.sin(80*tick())),pit) end
	local volBase = ((throt*shift*redline)+(trm*trmon*trmmult*(throt)*math.sin(tick()*50)))
	local relBase = (((1-throt)*shift*redline)+(trm*trmon*trmmult*(1-throt)*math.sin(tick()*50)))
	
	local RevAP = pitch(RevAPitch,RevARev) * on
	local RevBP = pitch(RevBPitch,RevBRev) * on
	local RelAP = pitch(RevAPitch,RevARev) * on
	local RelBP = pitch(RevBPitch,RevBRev) * on
	local RmbAP = pitch(RmbAPitch,RmbARev) * on
	local RmbBP = pitch(RmbBPitch,RmbBRev) * on
	local IdleP = pitch(IdlePitch,IdleRev) * on
	local RedP = pitch(RedPitch,RedRev) * on
	
	local RedV = math.max(volBase * (math.max(math.min(((_RPM/_Tune.Redline)*14)-13,1),0)) * on,0)
	local IdleV = (1 - math.min(((script.Parent.Values.RPM.Value*8)/_Tune.Redline)-1,1))
	local RevAV = math.max(volBase * math.max(math.min(((_RPM/_Tune.Redline)*11.25)-5,1),0) - RedV - IdleV * on,0)
	local RevBV = math.max(volBase * (1-math.max(math.min(((_RPM/_Tune.Redline)*11.25)-5,1),0)) - RedV * on,0)
	local RelAV = math.max(relBase * math.max(math.min(((_RPM/_Tune.Redline)*11.25)-5,1),0) - RedV - IdleV * on,0)
	local RelBV = math.max(relBase * (1-math.max(math.min(((_RPM/_Tune.Redline)*11.25)-5,1),0)) - RedV * on,0)
	local RmbAV = math.max(math.min(((_RPM/_Tune.Redline)*28)-4,1),0) - math.max(math.min(((_RPM/_Tune.Redline)*(2.8*4))-3,1),0) * on
	local RmbBV = math.max(math.min(((_RPM/_Tune.Redline)*(2.8*4))-3,1),0) - math.max(math.min(((_RPM/_Tune.Redline)*(2.1*6))-5,1),0) * on
	if throt<lt and throt>.95 then
		if play then play = false handler:FireServer("stopSound",car.Body.Exh.RmbA) handler:FireServer("stopSound",car.Body.Exh.RmbB) end
	else
		if not play then play = true handler:FireServer("playSound",car.Body.Exh.RmbA) handler:FireServer("playSound",car.Body.Exh.RmbB) end
	end
	lt = throt
	
	table.insert(updtbl,makeTable(car.Body.Exh.RevA,RevAP,RevAV*vol))
	table.insert(updtbl,makeTable(car.Body.Exh.RevB,RevBP,RevBV*vol))
	table.insert(updtbl,makeTable(car.Body.Exh.RelA,RelAP,RelAV*vol))
	table.insert(updtbl,makeTable(car.Body.Exh.RelB,RelBP,RelBV*vol))
	table.insert(updtbl,makeTable(car.Body.Exh.RmbA,RmbAP,RmbAV*vol))
	table.insert(updtbl,makeTable(car.Body.Exh.RmbB,RmbBP,RmbBV*vol))
	table.insert(updtbl,makeTable(car.Body.Exh.Idle,IdleP,IdleV*0.05*vol))
	table.insert(updtbl,makeTable(car.Body.Exh.Red,RedP,RedV*2*vol))
	
	if workspace.FilteringEnabled then handler:FireServer("updateSounds",updtbl) else update(updtbl) end
end)
