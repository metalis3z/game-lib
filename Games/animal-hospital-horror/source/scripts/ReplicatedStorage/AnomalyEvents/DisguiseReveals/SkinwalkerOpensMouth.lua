local t = {}
local t2 = {}
local t3 = { "Gulp", "Tooth", "TongueMesh", "Spit", "Teeth" }

function t.Apply(p1) --[[ Apply | Line: 6 | Upvalues: t2 (copy), t3 (copy) ]]
	local v1 = t2[p1]
	local v2 = p1:FindFirstChildOfClass("Humanoid") and p1.Humanoid:FindFirstChildOfClass("Animator")

	if not (v1 or v2) then
		return
	end

	if not v1 and v2 then
		v1 = v2:LoadAnimation(game.ReplicatedStorage.Animations:WaitForChild("IdleSkinwalker"))
	end

	for i, v in ipairs(t3) do
		local v4 = p1:FindFirstChild(v)

		if v4 and v4:IsA("BasePart") then
			v4.Transparency = 0
		end
	end

	t2[p1] = v1
	v1:Play()
end
function t.UnDo(p1) --[[ UnDo | Line: 26 | Upvalues: t2 (copy), t3 (copy) ]]
	local v1 = t2[p1]

	if v1 then
		v1:Stop()
	end

	for i, v in ipairs(t3) do
		local v2 = p1:FindFirstChild(v)

		if v2 and v2:IsA("BasePart") then
			v2.Transparency = 1
		end
	end
end
game:GetService("CollectionService"):GetInstanceRemovedSignal("NPC"):Connect(function(p1) --[[ Line: 41 | Upvalues: t2 (copy) ]]
	t2[p1] = nil
end)

return t