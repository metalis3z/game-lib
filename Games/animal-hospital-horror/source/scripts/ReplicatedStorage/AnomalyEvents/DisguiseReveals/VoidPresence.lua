local t = {}
local t2 = { "Body", "Head" }

function t.Apply(p1) --[[ Apply | Line: 4 | Upvalues: t2 (copy) ]]
	if p1:FindFirstChild("VoidHighlight") then
		return
	end

	local VoidHighlight = Instance.new("Highlight")

	VoidHighlight.Name = "VoidHighlight"
	VoidHighlight.FillColor = Color3.fromRGB(0, 0, 0)
	VoidHighlight.FillTransparency = 0
	VoidHighlight.OutlineTransparency = 1
	VoidHighlight.Parent = p1
	VoidHighlight.DepthMode = Enum.HighlightDepthMode.Occluded

	for i, v in ipairs(t2) do
		local v1 = p1:FindFirstChild(v)

		if v1 and (v1:IsA("BasePart") and not v1:FindFirstChild("Lost")) then
			local v2 = game.ReplicatedStorage.Misc.Particles.Lost:Clone()

			v2.Parent = v1
			v2.Enabled = true
		end
	end
end
function t.UnDo(p1) --[[ UnDo | Line: 26 | Upvalues: t2 (copy) ]]
	local VoidHighlight = p1:FindFirstChild("VoidHighlight")

	if VoidHighlight then
		VoidHighlight:Destroy()
	end

	for i, v in ipairs(t2) do
		local v1 = p1:FindFirstChild(v)

		if v1 and (v1:IsA("BasePart") and v1:FindFirstChild("Lost")) then
			v1:FindFirstChild("Lost"):Destroy()
		end
	end
end

return t