-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ActiveAssetModels = ReplicatedStorage:WaitForChild("ActiveAssetModels")
local AssetModels = ReplicatedStorage:WaitForChild("AssetModels")

local function findPart(p1, p2) --[[ findPart | Line: 7 ]]
	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("BasePart") and v.Name == p2 then
			return v
		end
	end

	return nil
end

local count = 0
local count2 = 0

for i, v in ipairs(ActiveAssetModels:GetChildren()) do
	if v:IsA("Model") then
		local v1 = AssetModels:FindFirstChild(v.Name)

		if v1 and v1:IsA("Model") then
			local v2 = findPart(v, "CENTER")
			local v3 = findPart(v, "AnimRoot")
			local v4 = findPart(v1, "AnimRoot")

			if v2 and (v3 and v4) then
				local v5 = v3.CFrame:ToObjectSpace(v2.CFrame)
				local v6 = findPart(v1, "CENTER")

				if not v6 then
					local v7 = v2:Clone()

					v7.Parent = v1
					v6 = v7
				end

				v6.CFrame = v4.CFrame * v5

				if v6:IsA("BasePart") then
					v6.Anchored = v2.Anchored
					v6.Size = v2.Size
					v6.Transparency = v2.Transparency
					v6.CanCollide = v2.CanCollide
				end

				print("Updated CENTER for:", v1.Name)
				count = count + 1

				continue
			end

			warn(("Missing parts for %s (CENTER/AnimRoot)"):format(v.Name))
			count2 = count2 + 1

			continue
		end

		warn("No matching target model for:", v.Name)
		count2 = count2 + 1
	end
end

print(("Done. Updated: %d, Skipped: %d"):format(count, count2))