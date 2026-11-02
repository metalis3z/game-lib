return {
	Apply = function(p1) --[[ Apply | Line: 3 ]]
		local NeckBone = p1:FindFirstChild("NeckBone")

		if not (NeckBone and NeckBone.Value) then
			return
		end

		local v1 = NeckBone.Value

		v1:SetAttribute("OriginalCFrame", v1:GetAttribute("OriginalCFrame") or v1.CFrame)
		v1:SetAttribute("HeadRotationMax", true)
		p1:AddTag("HeadRotationEnabled")
	end,
	UnDo = function(p1) --[[ UnDo | Line: 13 ]]
		p1:RemoveTag("HeadRotationEnabled")

		local v1 = p1:FindFirstChild("NeckBone") and p1.NeckBone.Value

		if not v1 then
			return
		end

		v1:SetAttribute("HeadRotationMax", false)
	end
}