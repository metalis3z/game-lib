-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local SoundService = game:GetService("SoundService")
local t = {
	PlaySound = function(p1, p2, p3) --[[ PlaySound | Line: 12 | Upvalues: SoundService (copy) ]]
		local v1 = nil

		if typeof(p2) == "Instance" and p2:IsA("Sound") then
			v1 = p2
		end

		if not v1 then
			return warn((("Sound not found for %*"):format(p2)))
		end

		if not p3 then
			SoundService:PlayLocalSound(v1)

			return v1
		end

		local Part = Instance.new("Part")

		Part.CanCollide = false
		Part.CanQuery = false
		Part.CanTouch = false
		Part.Massless = true
		Part.Anchored = true
		Part.Parent = workspace
		Part.Transparency = 1
		Part.Position = p3

		local v2 = v1:Clone()

		v2.Parent = Part

		local v3 = os.clock()

		while not v2.IsLoaded and os.clock() - v3 < 2 do
			task.wait()
		end

		if v2.IsLoaded then
			v2:Play()
		else
			Part:Destroy()
		end

		v2.Ended:Once(function() --[[ Line: 51 | Upvalues: Part (copy) ]]
			Part:Destroy()
		end)

		return v1
	end,
	UpdateOST = function(p1) --[[ UpdateOST | Line: 58 ]] end,
	Start = function() --[[ Start | Line: 59 ]] end
}

t.Start()

return t