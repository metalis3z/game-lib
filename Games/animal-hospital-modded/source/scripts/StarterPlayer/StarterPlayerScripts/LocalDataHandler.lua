local t = {}
local LocalPlayer = game.Players.LocalPlayer
local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))

t.data = false

local function processData(p1, p2, p3, ...) --[[ processData | Line: 8 | Upvalues: t (copy), Lib (copy) ]]
	if type(p2) == "string" then
		while not t.data do
			Lib.Functional.RealWait(0.2)
		end

		t.data[p2] = p3
	else
		t.data = p2
	end

	script.UpdateData:Fire(t.data)
	script:WaitForChild(p1):Fire(p3, ...)
end

local function connectEvents() --[[ connectEvents | Line: 20 | Upvalues: t (copy), Lib (copy), processData (copy) ]]
	local UpdateData = Instance.new("BindableEvent")

	UpdateData.Name = "UpdateData"
	UpdateData.Parent = script

	for k, v in pairs(t.data) do
		if type(v) == "table" then
			Lib.Network:BindEvents({
				[k] = function(p1, p2, ...) --[[ Line: 27 | Upvalues: processData (ref), k (copy) ]]
					processData(k, p1, p2, ...)
				end
			})

			if not script:FindFirstChild(k) then
				local v1 = Instance.new("BindableEvent")

				v1.Name = k
				v1.Parent = script
			end
		end
	end
end

local v1 = nil

local function RequestData() --[[ RequestData | Line: 40 | Upvalues: v1 (ref), t (copy), Lib (copy), LocalPlayer (copy), connectEvents (copy) ]]
	-- print("Requesting data")
	v1 = true
	t.data = Lib.Network:InvokeServer("RequestData")
	-- print("Data received")

	if t.data and t.data.Help or t.data then
		v1 = false
		connectEvents()

		return t.data
	end

	LocalPlayer:Kick("ERROR RETRIEVING DATA, PLEASE REJOIN", m)
	v1 = false
	connectEvents()

	return t.data
end

function t.RequestData() --[[ RequestData | Line: 56 | Upvalues: v1 (ref), t (copy), Lib (copy), RequestData (copy) ]]
	if v1 then
		while not t.data do
			Lib.Functional.RealWait(0.1)
		end
	end

	return t.data or RequestData()
end
function t.Has(p1, p2) --[[ Has | Line: 65 | Upvalues: t (copy) ]]
	local v1 = t.data[p1]

	if not v1 then
		return
	end

	for v2, v3 in next, p2 do
		if not v1.Items[v2] then
			return
		end

		if v1.Items[v2] - v3 < 0 then
			return
		end
	end

	return v1
end
function Notify(p1, p2, p3) --[[ Notify | Line: 76 ]]
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = if p1 == "" or not p1 then "Notice" else p1,
		Text = p2,
		Icon = p3
	})
end
t.Notify = Notify
function t.GetEvent(p1) --[[ GetEvent | Line: 83 ]]
	return script:FindFirstChild(p1)
end

return t