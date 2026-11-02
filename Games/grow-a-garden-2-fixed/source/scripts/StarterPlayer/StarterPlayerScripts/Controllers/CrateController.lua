--credit to quartz games studio
local t = {
	StartOrder = 5
}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.RollController)

local Networking = require(ReplicatedStorage.SharedModules.Networking)
local CrateOpenEffect = require(script:WaitForChild("CrateOpenEffect"))
local LocalPlayer = Players.LocalPlayer
local v1 = 0

local function ResolveCrateModel(p1) --[[ ResolveCrateModel | Line: 22 | Upvalues: ReplicatedStorage (copy) ]]
	local Assets = ReplicatedStorage.Assets
	local GuildCrates = Assets:FindFirstChild("GuildCrates")

	if GuildCrates then
		local v1 = GuildCrates:FindFirstChild(p1)

		if v1 and v1:IsA("Model") then
			return v1
		end
	end

	local Crates = Assets.Crates
	local v2 = Crates:FindFirstChild(p1)

	if v2 and v2:IsA("Model") then
		return v2
	end

	local v3 = Crates:FindFirstChild("Arch Crate")

	if v3 and v3:IsA("Model") then
		return v3
	end

	return nil
end

function t.Init(p1) --[[ Init | Line: 44 ]] end

local CrateSFX = game.SoundService.SFX.CrateSFX
local t2 = {
	Spawn = CrateSFX.CrateSpawn,
	Land = CrateSFX.CrateLand,
	Shake = CrateSFX.CrateShake,
	Explode = CrateSFX.CrateExplode,
	Reveal = CrateSFX.CrateReward,
	Collect = CrateSFX.CrateCollect
}

function t.Start(p1) --[[ Start | Line: 58 | Upvalues: LocalPlayer (copy), Networking (copy), ResolveCrateModel (copy), CrateOpenEffect (copy), ReplicatedStorage (copy), t2 (copy) ]]
	local function onCharacter(p12) --[[ onCharacter | Line: 59 | Upvalues: p1 (copy) ]]
		p12.ChildAdded:Connect(function(p12) --[[ Line: 60 | Upvalues: p1 (ref) ]]
			if not (p12:IsA("Tool") and p12:GetAttribute("Crate")) then
				return
			end

			p1:BindCrateTool(p12)
		end)

		for v1, v2 in p12:GetChildren() do
			if v2:IsA("Tool") and v2:GetAttribute("Crate") then
				p1:BindCrateTool(v2)
			end
		end
	end

	if LocalPlayer.Character then
		onCharacter(LocalPlayer.Character)
	end

	LocalPlayer.CharacterAdded:Connect(onCharacter)
	Networking.Crate.ReplicateOpenCrate.OnClientEvent:Connect(function(p1, p2) --[[ Line: 80 | Upvalues: LocalPlayer (ref), ResolveCrateModel (ref), CrateOpenEffect (ref), ReplicatedStorage (ref), t2 (ref) ]]
		if p1 == LocalPlayer then
			return
		end

		local v1 = ResolveCrateModel(p2.WonItem.CrateName)

		if v1 then
			CrateOpenEffect.Play({
				RarityName = "Legendary",
				Rarity = 0.01,
				Player = p1,
				CrateModel = v1,
				ItemImage = p2.WonItem.Image,
				ItemName = p2.WonItem.Name,
				RarityColor = Color3.fromRGB(255, 215, 0),
				IsBestItem = p2.WonItem.IsBestItem,
				BillboardTemplate = ReplicatedStorage.Assets.BillboardUIs.CrateItemBillboard,
				Particles = {
					Impact = ReplicatedStorage.Assets.VFX.CrateVFX.Impact:GetChildren(),
					Explosion = ReplicatedStorage.Assets.VFX.CrateVFX.Explosion:GetChildren(),
					Trail = ReplicatedStorage.Assets.VFX.CrateVFX.Trail.Trail
				},
				Sounds = t2,
				OnCollected = function() --[[ OnCollected | Line: 103 ]] end
			})
		end
	end)
end
function t.BindCrateTool(p1, p2) --[[ BindCrateTool | Line: 110 ]]
	p2.Activated:Connect(function() --[[ Line: 111 | Upvalues: p2 (copy), p1 (copy) ]]
		local v1 = p2:GetAttribute("Crate")

		if v1 then
			p1:OpenCrate(v1)
		end
	end)
end
function t.OpenCrate(p1, p2) --[[ OpenCrate | Line: 119 | Upvalues: v1 (ref), Networking (copy), ResolveCrateModel (copy), CrateOpenEffect (copy), LocalPlayer (copy), ReplicatedStorage (copy), t2 (copy) ]]
	if v1 >= 10 then
		return
	end

	v1 = v1 + 1

	local ok, result = pcall(function() --[[ Line: 127 | Upvalues: Networking (ref), p2 (copy) ]]
		return Networking.Crate.OpenCrate:Fire(p2)
	end)

	if ok and (result and result.Success) then
		local v12 = ResolveCrateModel(result.WonItem.CrateName)

		if v12 then
			task.spawn(function() --[[ Line: 138 | Upvalues: CrateOpenEffect (ref), LocalPlayer (ref), v12 (copy), result (copy), ReplicatedStorage (ref), t2 (ref), v1 (ref) ]]
				local ok, result2 = pcall(function() --[[ Line: 139 | Upvalues: CrateOpenEffect (ref), LocalPlayer (ref), v12 (ref), result (ref), ReplicatedStorage (ref), t2 (ref) ]]
					CrateOpenEffect.Play({
						RarityName = "Legendary",
						Player = LocalPlayer,
						CrateModel = v12,
						ItemImage = result.WonItem.Image,
						ItemName = result.WonItem.Name,
						RarityColor = Color3.fromRGB(255, 215, 0),
						Rarity = result.WonItem.Chance / 100,
						IsBestItem = result.WonItem.IsBestItem,
						BillboardTemplate = ReplicatedStorage.Assets.BillboardUIs.CrateItemBillboard,
						Particles = {
							Impact = ReplicatedStorage.Assets.VFX.CrateVFX.Impact:GetChildren(),
							Explosion = ReplicatedStorage.Assets.VFX.CrateVFX.Explosion:GetChildren(),
							Trail = ReplicatedStorage.Assets.VFX.CrateVFX.Trail.Trail
						},
						Sounds = t2
					})
				end)

				if not ok then
					warn((("CrateOpenEffect.Play error: %*"):format(result2)))
				end

				v1 = v1 - 1
			end)
		else
			v1 = v1 - 1
		end
	else
		if ok then
			v1 = v1 - 1

			return
		end

		warn((("[CrateController] OpenCrate invoke errored (%*): %*"):format(p2, result)))
		v1 = v1 - 1
	end
end

return t