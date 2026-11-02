local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))
local Frame = Lib.UI.Get("EmergencyCounter"):WaitForChild("Frame")
local t = {}

local function updateCounter(p1) --[[ updateCounter | Line: 7 | Upvalues: t (copy), Lib (copy), Frame (copy) ]]
	local v1 = t[p1]

	if not v1 then
		Lib.MusicService.Get("NotificationDing", "sfx").sound:Play()
	end

	local v2 = if v1 then v1 else Frame:WaitForChild("Templates"):WaitForChild("Frame"):Clone()

	t[p1] = v2

	local v3 = p1:GetAttribute("TimeLeft") or ""

	v2.text.Text = Lib.Talk.Translate(v2.text, p1:GetAttribute("Description") or "")
	v2.timer.Text = v3 .. "s"
	v2.Parent = Frame:WaitForChild("Feed")
	v2.Visible = true
	v2:AddTag("EmergencyCounterFeed")
	Frame.Visible = #Lib.CS:GetTagged("EmergencyCounterFeed") > 0
end

local function deleteCounter(p1) --[[ deleteCounter | Line: 28 | Upvalues: t (copy), Frame (copy), Lib (copy) ]]
	local v1 = t[p1]

	if v1 then
		v1:Destroy()
	end

	t[p1] = nil
	Frame.Visible = #Lib.CS:GetTagged("EmergencyCounterFeed") > 0
end

Lib.CS:GetInstanceRemovedSignal("EmergencyEventCounter"):Connect(deleteCounter)
Lib.CS:GetInstanceAddedSignal("EmergencyEventCounter"):Connect(function(p1) --[[ Line: 39 | Upvalues: updateCounter (copy) ]]
	if p1:IsDescendantOf(workspace) then
		local v1 = nil

		updateCounter(p1)

		local v2 = p1:GetAttributeChangedSignal("TimeLeft"):Connect(function() --[[ Line: 46 | Upvalues: updateCounter (ref), p1 (copy) ]]
			updateCounter(p1)
		end)

		v1 = p1.Destroying:Connect(function() --[[ Line: 50 | Upvalues: v2 (ref), v1 (ref) ]]
			if v2 then
				v2:Disconnect()
				v2 = nil
			end

			if not v1 then
				return
			end

			v1:Disconnect()
			v1 = nil
		end)
	end
end)

return {}