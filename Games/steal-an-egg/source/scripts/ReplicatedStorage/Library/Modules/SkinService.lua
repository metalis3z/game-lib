-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Skins = ReplicatedStorage:WaitForChild("Skins")
local t = {
	Rainbow = {}
}

local function SkinAdded(p1, p2, p3) --[[ SkinAdded | Line: 12 ]]
	p2:AddTag("RainbowPart")
end

t.Rainbow.SkinAdded = SkinAdded

local function SkinRemoved(p1, p2, p3) --[[ SkinRemoved | Line: 16 ]]
	p2:RemoveTag("RainbowPart")
end

t.Rainbow.SkinRemoved = SkinRemoved

local t2 = {
	Debug = {
		ColorsList = {
			SkinIndex1 = Color3.fromRGB(0, 85, 0),
			SkinIndex2 = Color3.fromRGB(97, 78, 51),
			SkinIndex3 = Color3.fromRGB(0, 0, 0)
		},
		MaterialList = {
			SkinIndex1 = Enum.Material.Grass,
			SkinIndex2 = Enum.Material.Mud,
			SkinIndex3 = Enum.Material.Marble
		},
		MaterialVariantList = {},
		SkinFunctionList = {
			SkinIndex3 = "Rainbow"
		}
	}
}
local t3 = { "Color", "Material", "Transparency", "Reflectance", "MaterialVariant" }
local t4 = {}

for v1, v2 in Skins:GetChildren() do
	local v3 = v2.Name

	if not t2[v3] then
		local t5 = {
			SkinFunctionList = {}
		}

		for v4, v5 in t3 do
			t5[("%sList"):format(v5)] = {}
		end

		t2[v3] = t5
	end

	local v6 = t2[v3]

	if v6 then
		for v7, v8 in v2:GetChildren() do
			if v8:IsA("BasePart") then
				local v9 = v8.Name

				for v10, v11 in t3 do
					v6[("%sList"):format(v11)][v9] = v8[v11]
				end

				local v12 = v8:GetAttribute("SkinFunction")

				if v12 then
					v6.SkinFunctionList[v9] = v12
				end
			end
		end

		continue
	end

	warn("Somehow no skin data??")

	if Constants.IS_STUDIO then
		error((("SkinService: No skin data for %*"):format(v3)))
	end
end

function t4.SetSkin(p1, p2, p3) --[[ SetSkin | Line: 81 | Upvalues: t2 (copy), t3 (copy), t (copy), Skins (copy) ]]
	if not p2 then
		return warn("SkinService:SetSkin | No ParentModel provided!")
	end

	p1:RemoveSkin(p2)

	local v1 = t2[p3]

	if not v1 then
		return warn(("SkinService:SetSkin | %* does not exist as a skin!"):format(p3))
	end

	p2:SetAttribute("CurrentSkin", p3)

	for v2, v3 in p2:GetDescendants() do
		if v3:IsA("BasePart") then
			local v4 = v3:GetAttribute("SkinIndex")

			if v4 then
				for v5, v6 in t3 do
					local v7 = v1[("%sList"):format(v6)]

					if v7 then
						local v8 = v7[v4]

						if v8 ~= nil then
							v3:SetAttribute(("SkinPrevious%*"):format(v6), v3[v6])
							v3[v6] = v8
						end
					end
				end

				local v9 = v1.SkinFunctionList[v4]
				local v10 = if v9 then t[v9] else v9

				if v10 then
					v10:SkinAdded(v3, p3)
				end
			end
		end
	end

	local v11 = Skins:FindFirstChild(p3)

	if not v11 then
		return
	end

	for v12, v13 in v11:GetDescendants() do
		if v13:IsA("ParticleEmitter") then
			local v14 = v13.Name

			for v15, v16 in p2:GetDescendants() do
				if v16:GetAttribute("VfxIndex") == v14 then
					local v17 = v16.Parent

					if v17 then
						v16:Destroy()
						v13:Clone().Parent = v17
					end
				end
			end
		end
	end
end
function t4.RemoveSkin(p1, p2) --[[ RemoveSkin | Line: 135 | Upvalues: t2 (copy), t3 (copy), t (copy) ]]
	local v1 = p2:GetAttribute("CurrentSkin")

	if not v1 then
		return
	end

	local v2 = t2[v1]

	if not v2 then
		return warn(("SkinService:RemoveSkin | %* does not exist as a skin!"):format(v1))
	end

	for v3, v4 in p2:GetDescendants() do
		if v4:IsA("BasePart") then
			local v5 = v4:GetAttribute("SkinIndex")

			if v5 then
				for v6, v7 in t3 do
					if v2[("%*List"):format(v7)] then
						local v8 = ("SkinPrevious%*"):format(v7)
						local v9 = v4:GetAttribute(v8)

						if v9 then
							v4[v7] = v9
							v4:SetAttribute(v8, nil)
						end
					end
				end

				local v10 = v2.SkinFunctionList[v5]
				local v11 = if v10 then t[v10] else v10

				if v11 then
					v11:SkinRemoved(v4, v1)
				end
			end
		end
	end

	p2:SetAttribute("CurrentSkin", nil)
end

return t4