local t = {}
local v1 = Random.new()

function t.Apply(p1) --[[ Apply | Line: 4 | Upvalues: v1 (copy) ]]
	if p1:GetAttribute("HasBrokenBones") then
		return
	end

	p1:SetAttribute("HasBrokenBones", true)

	for i, v in ipairs(p1:GetDescendants()) do
		if v.Name ~= "spine" and (not v:FindFirstAncestor("spine.005") and (v:IsA("Bone") and v1:NextInteger(1, 3) < 3)) then
			v:SetAttribute("OriginalCFrame", v:GetAttribute("OriginalCFrame") or v.CFrame)

			local v8 = CFrame.Angles(math.rad((v1:NextNumber(-30, 30))), math.rad((v1:NextNumber(-30, 30))), (math.rad((v1:NextNumber(-30, 30)))))

			v.CFrame = v.CFrame * v8 + Vector3.new(v1:NextNumber(-2.5, 2.5), v1:NextNumber(-2.5, 2.5), 0)
		end
	end
end
function t.UnDo(p1) --[[ UnDo | Line: 20 ]]
	if not p1:GetAttribute("HasBrokenBones") then
		return
	end

	p1:SetAttribute("HasBrokenBones", false)

	for i, v in ipairs(p1:GetDescendants()) do
		if v.Name ~= "spine" and v:IsA("Bone") then
			v.CFrame = v:GetAttribute("OriginalCFrame") or v.CFrame
		end
	end
end

return t