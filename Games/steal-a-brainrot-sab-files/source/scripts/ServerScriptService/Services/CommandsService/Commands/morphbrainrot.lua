---this file by kydexbeyyyyyyyy
---- im new leakerrrr
local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local MutationsData = require(ReplicatedStorage.Datas.Mutations)
	local TraitsData = require(ReplicatedStorage.Datas.Traits)

	local AnimalModels = ReplicatedStorage.Models.Animals

	local RaritiesData = require(ReplicatedStorage.Datas.Rarities)

	local GradientPresets = {
		["Rainbow"]  = {"#ff0000", "#ff7700", "#ffff00", "#00ff00", "#0000ff", "#8b00ff"},
		["Zebra"]    = {"#ffffff", "#444444"},
		["OG"]       = {"#ffffff", "#aaaaaa", "#ffffff"},
		["YellowRed"]= {"#ffff00", "#ff0000"},
		["GreenRed"] = {"#00ff00", "#ff0000"},
	}

	local function GetRarityColoredName(RarityName: string, DisplayName: string): string
		local rarityData = RaritiesData[RarityName]
		if not rarityData then return DisplayName end

		local preset = rarityData.GradientPreset
		if preset and GradientPresets[preset] then
			local colors = GradientPresets[preset]
			local chars = string.split(DisplayName, "")
			local result = ""
			for i, char in ipairs(chars) do
				if char == " " then
					result = result .. " "
				else
					local colorIndex = ((i - 1) % #colors) + 1
					result = result .. string.format('<font color="%s">%s</font>', colors[colorIndex], char)
				end
			end
			return result
		else
			local color = rarityData.Color
			if not color then return DisplayName end
			local hex = string.format("#%02X%02X%02X",
				math.floor(color.R * 255),
				math.floor(color.G * 255),
				math.floor(color.B * 255)
			)
			return string.format('<font color="%s">%s</font>', hex, DisplayName)
		end
	end

	Conch.register("morphbrainrot", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return
				{
					kind = "argument",
					type = "player",
					name = "Target",
				},
			{
				kind = "argument",
				type = "Brainrot",
				name = "Brainrot",
			},
			{
				kind = "argument",
				type = "Mutation",
				name = "Mutation",
				optional = true
			},
			{
				kind = "argument",
				type = "Traits",
				name = "Traits",
				typeHint = "{ Trait? }",
				optional = true
			}
		end,
		callback = function(targetPlayer, brainrotName, mutation, traits)
			local player = targetPlayer :: Player

			local animalData = require(ReplicatedStorage.Datas.Animals)[brainrotName]
			if not animalData then
				return false, "invalid brainrot"
			end

			local brainrotAsset = AnimalModels:FindFirstChild(animalData.DisplayName)
			if not brainrotAsset then
				return false, "not found"
			end

			local oldChar = player.Character
			if not oldChar then
				return false, "unloaded"
			end

			local oldHum = oldChar:FindFirstChildOfClass("Humanoid")
			if not oldHum or oldHum.RigType ~= Enum.HumanoidRigType.R15 then
				return false, "r15"
			end

			local cleanMutation = nil
			if mutation and mutation ~= "" and mutation ~= "Default" and mutation ~= "Normal" then
				if not MutationsData[mutation] then
					return false, "invalid mutation"
				end
				cleanMutation = mutation
			end

			local traitTable = nil
			if traits ~= nil then
				if type(traits) ~= "table" then
					return false, "invalid format"
				end
				traitTable = {}
				local seen = {}
				for _, trait in ipairs(traits) do
					if seen[trait] then
						return false, "duplicate trait"
					end
					seen[trait] = true
					if not TraitsData[trait] then
						return false, "invalid trait"
					end
					table.insert(traitTable, trait)
				end
				if #traitTable == 0 then
					traitTable = nil
				end
			end

			local root = oldChar:FindFirstChild("HumanoidRootPart")
			local savedCFrame = root and (root :: BasePart).CFrame

			player:LoadCharacter()
			repeat
				task.wait()
			until player.Character and player.Character ~= oldChar

			local newChar = player.Character
			local hum = newChar:WaitForChild("Humanoid") :: Humanoid

			for _, desc in ipairs(newChar:GetDescendants()) do
				if desc:IsA("BasePart") and desc.Name ~= "HumanoidRootPart" then
					desc.Transparency = 1
				elseif desc:IsA("Decal") or desc:IsA("SpecialMesh") or desc:IsA("SurfaceAppearance") then
					desc:Destroy()
				end
			end

			local clonedModel = brainrotAsset:Clone()

			for _, desc in ipairs(clonedModel:GetDescendants()) do
				if desc:IsA("BasePart") then
					desc.Anchored = false
					desc.CanCollide = false
				end
			end

			if cleanMutation then
				clonedModel:SetAttribute("Mutation", cleanMutation)
				local SharedAnimals = require(ReplicatedStorage.Shared.Animals)
				SharedAnimals:ApplyMutation(clonedModel, animalData.DisplayName, cleanMutation)
			end

			clonedModel.Parent = newChar

			local hrp = newChar:FindFirstChild("HumanoidRootPart") :: BasePart
			local modelRoot = clonedModel:FindFirstChild("RootPart")
				or clonedModel:FindFirstChild("FakeRootPart")
				or clonedModel.PrimaryPart
				or clonedModel:FindFirstChildOfClass("BasePart")

			if savedCFrame then
				local newRoot = newChar:WaitForChild("HumanoidRootPart") :: BasePart
				newRoot.CFrame = savedCFrame
			end

			task.wait()

			if modelRoot and hrp then
				local rayOrigin = hrp.Position + Vector3.new(0, 10, 0)
				local rayDir = Vector3.new(0, -60, 0)
				local rayParams = RaycastParams.new()
				rayParams.FilterType = Enum.RaycastFilterType.Exclude
				rayParams.FilterDescendantsInstances = { newChar, clonedModel }
				local rayResult = workspace:Raycast(rayOrigin, rayDir, rayParams)

				if not rayResult then
					local fallbackParams = RaycastParams.new()
					fallbackParams.FilterType = Enum.RaycastFilterType.Include
					fallbackParams.FilterDescendantsInstances = { workspace.Map, workspace.Terrain }
					rayResult = workspace:Raycast(rayOrigin, rayDir, fallbackParams)
				end

				local floorY = rayResult and rayResult.Position.Y or hrp.Position.Y
				local modelSize = clonedModel:GetExtentsSize()
				local targetY = floorY + (modelSize.Y * 0.45)

				modelRoot.CFrame = CFrame.new(
					hrp.Position.X,
					targetY,
					hrp.Position.Z
				) * (hrp.CFrame - hrp.CFrame.Position)
				local weld = Instance.new("WeldConstraint")
				weld.Part0 = hrp
				weld.Part1 = modelRoot
				weld.Parent = modelRoot
			end

			local animFolder = ReplicatedStorage:FindFirstChild("Animations")
				and ReplicatedStorage.Animations:FindFirstChild("Animals")
				and ReplicatedStorage.Animations.Animals:FindFirstChild(animalData.DisplayName)

			if animFolder then
				local animController = clonedModel:FindFirstChildOfClass("AnimationController")
				if animController then
					local animator = animController:FindFirstChildOfClass("Animator")
						or Instance.new("Animator", animController)
					local idleAnim = animFolder:FindFirstChild("Idle")
					local walkAnim = animFolder:FindFirstChild("Walk")
					local loadedIdle = idleAnim and animator:LoadAnimation(idleAnim)
					local loadedWalk = walkAnim and animator:LoadAnimation(walkAnim)
					if loadedIdle then
						loadedIdle.Looped = true
						loadedIdle:Play()
					end
					if loadedIdle and loadedWalk then
						task.spawn(function()
							local wasWalking = false
							while newChar and newChar.Parent and hum and hum.Parent do
								local isWalking = hum.MoveDirection.Magnitude > 0.1
								if isWalking and not wasWalking then
									loadedIdle:Stop()
									loadedWalk:Play()
									wasWalking = true
								elseif not isWalking and wasWalking then
									loadedWalk:Stop()
									loadedIdle:Play()
									wasWalking = false
								end
								task.wait(0.1)
							end
						end)
					end
				end
			end

			hum.DisplayName = animalData.DisplayName
			hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer

			return "morphed"
		end,
	})
end

return module