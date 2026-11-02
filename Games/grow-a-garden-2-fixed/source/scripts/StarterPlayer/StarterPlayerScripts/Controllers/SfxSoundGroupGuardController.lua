--credit to quartz games studio
local t = {
	StartOrder = 0
}
local SoundService = game:GetService("SoundService")

local function patch(p1) --[[ patch | Line: 32 | Upvalues: SoundService (copy) ]]
	if p1.SoundGroup == nil then
		p1.SoundGroup = SoundService:FindFirstChild("SFXGroup")
	end
end

function t.Init(p1) --[[ Init | Line: 39 | Upvalues: SoundService (copy) ]]
	game.DescendantAdded:Connect(function(p1) --[[ Line: 43 | Upvalues: SoundService (ref) ]]
		if not p1:IsA("Sound") then
			return
		end

		if p1.SoundGroup ~= nil then
			return
		end

		p1.SoundGroup = SoundService:FindFirstChild("SFXGroup")
	end)

	for v1, v2 in game:GetDescendants() do
		if v2:IsA("Sound") and v2.SoundGroup == nil then
			v2.SoundGroup = SoundService:FindFirstChild("SFXGroup")
		end
	end
end

return t