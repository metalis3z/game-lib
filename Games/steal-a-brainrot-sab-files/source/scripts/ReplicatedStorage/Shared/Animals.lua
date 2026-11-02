local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("RunService")

local Packages = ReplicatedStorage:WaitForChild("Packages")

require(Packages.Trove)

local Observers = require(Packages.Observers)
local FFlags = require(Packages.FFlags)
local Trove = require(Packages.Trove)
local Datas = ReplicatedStorage:WaitForChild("Datas")
local Animals = require(Datas.Animals)
local Game = require(Datas.Game)

require(Datas.Rebirth)

local Rarities = require(Datas.Rarities)
local Mutations = require(Datas.Mutations)
local Traits = require(Datas.Traits)
local GetAnimalBoundingBox = require(ReplicatedStorage.Shared.GetAnimalBoundingBox)
local BrainrotAssets = require(ReplicatedStorage.Shared.BrainrotAssets)
local Animals2 = ReplicatedStorage:WaitForChild("Animations").Animals
local MutationSurfaces = ReplicatedStorage:WaitForChild("MutationSurfaces")
local Models = ReplicatedStorage:WaitForChild("Models")
local Traits2 = Models.Traits
local Traits3 = ReplicatedStorage:WaitForChild("Vfx").Traits
local Vfx = ReplicatedStorage:WaitForChild("Vfx")
local Exclusive = require(ReplicatedStorage:WaitForChild("Exclusive"))
local GameData = require(ReplicatedStorage:WaitForChild("GameData"))

local function isBlacklistedNonExclusive(animalName: string?): boolean
	if type(animalName) ~= "string" or animalName == "" then
		return false
	end
	local blacklist = GameData and GameData.UnSpawnableBrainrots
	if not blacklist then
		return false
	end
	return blacklist[animalName] == true and Exclusive[animalName] ~= true
end

local t1 = {}
local colorSequence = ColorSequence.new(Color3.fromRGB(0, 0, 0))
local Unit = Vector3.new(-1, 0.25, -1).Unit

local function disablePartCollision(part: BasePart)
	part.CanCollide = false
	part.CanQuery = false
	part.CanTouch = false
	part.LocalTransparencyModifier = 0
end

local function FitCam(p1, s1: string, p2, n1: number, n2: number?, n3: number?)
	local v37 = n3 or 0.5
	local _, v39 = GetAnimalBoundingBox(s1, p2)
	local Zoom = t1:GetZoom(s1, n2)
	local v41

	if s1 == "Tacorita Bicicleta" or s1 == "W or L" or s1 == "25" or s1 == "Cocoa Assassino" or s1 == "Los Jolly Combinasionas" or s1 == "Bunny Bunny Bunny Sahur" then
		v41 = p2:GetPivot() + Vector3.new(0, v39.Y * 0.5, 0)
	elseif s1 == "Boppin Bunny" then
		v41 = p2:GetPivot() + Vector3.new(0, v39.Y * 0.65, 0)
	elseif s1 == "Smurf Cat" then
		v41 = p2:GetPivot() + Vector3.new(0, -v39.Y * -0.5, 0)
	else
		v41 = p2.PrimaryPart and p2.PrimaryPart.CFrame or p2:GetPivot()
	end

	local v42 = math.max(v39.X, v39.Y, v39.Z)
	local v43 = v42 * 0.5 / math.tan((math.rad(n1 * 0.5))) * Zoom

	p1.CFrame = CFrame.new((v41 * CFrame.new(Unit * (v43 + v42 * v37))).Position, v41.Position)
end
local function IsSurfaceEye(p3)
	local v45 = p3.Size.X * p3.Size.Y * p3.Size.Z

	if p3.Color ~= Color3.fromRGB(255, 255, 255) and p3.Color ~= Color3.fromRGB(163, 162, 165) then
		return true
	end

	if v45 > 3 then
		return false
	end

	return true
end

function t1.GetZoom(_: {[any]: any}, s2: string, n4: number?)
	local v49 = n4 or 0.8

	assert(v49)

	if s2 == "Tacorita Bicicleta" then
		return v49 + 0.2
	end

	if s2 == "25" then
		return v49 - 0.6
	end

	if s2 == "Los Jolly Combinasionas" then
		return v49 - 0.4
	end

	if s2 == "Money Money Reindeer" then
		return v49 + 0.2
	end

	if s2 == "Boppin Bunny" then
		v49 += 0.7
	end

	return v49
end
function t1.GetBoundingBox(_: {[any]: any}, s3: string, p4)
	return GetAnimalBoundingBox(s3, p4)
end
function t1.GetSellValue(_: {[any]: any}, s4: string)
	return (math.ceil(t1:GetPrice(s4) * Game.Animal.SellModifier))
end

local t5 = {
	["Spyder Elephant"] = true
}

function t1.IsLocked(_: {[any]: any}, t7: {[any]: any}?)
	if type(t7) ~= "table" then
		return false
	end

	return t7.Index ~= nil and t5[t7.Index] == true
end

local function GetBiggestInstance(p5)
	local n5 = 0
	local v59 = nil

	for _, v61 in (p5:QueryDescendants("BasePart:not([Transparency=1])")) do
		local v62 = v61.Size.X * v61.Size.Y * v61.Size.Z

		if n5 < v62 then
			n5 = v62
			v59 = v61
		end
	end

	return v59
end
local function ShouldIgnoreColor(p6, s5: string)
	local v65 = p6:GetAttribute(`{ s5 }IgnoreColor`)

	if v65 == false then
		return false
	end

	return p6:GetAttribute("IgnoreColor") or v65
end
local function resolveColor(p7)
	if typeof(p7) == "table" then
		return p7.Color
	end

	return p7
end
local function applyPhantomToPart(p8, s6: string, p9, n6: number, p10, b1: boolean?, b2: boolean?)
	local v74 = p8:GetAttribute(`{ s6 }IgnoreColor`)

	if v74 ~= false and (p8:GetAttribute("IgnoreColor") or v74) then
		return
	end

	if p8.Transparency == 1 then
		return
	end

	local SurfaceAppearance = p8:FindFirstChildOfClass("SurfaceAppearance")

	if p8:GetAttribute("Eyes") or SurfaceAppearance and not b2 then
		if b2 then
			return
		end

		local p8Material = p8.Material
		local p8Color = p8.Color
		local p8Transparency = p8.Transparency

		p8.Material = Enum.Material.Neon
		p8.Color = Color3.fromRGB(0, 0, 0)
		p8.Transparency = 0

		if SurfaceAppearance then
			local AlphaMode = SurfaceAppearance.AlphaMode
			local SurfaceAppearanceColor = SurfaceAppearance.Color
			local EmissiveTint = SurfaceAppearance.EmissiveTint
			local EmissiveStrength = SurfaceAppearance.EmissiveStrength

			SurfaceAppearance.AlphaMode = Enum.AlphaMode.Overlay
			SurfaceAppearance.Color = Color3.fromRGB(0, 0, 0)
			SurfaceAppearance.EmissiveTint = Color3.fromRGB(0, 0, 0)
			SurfaceAppearance.EmissiveStrength = 0
			p10:Add(function()
				SurfaceAppearance.AlphaMode = AlphaMode
				SurfaceAppearance.Color = SurfaceAppearanceColor
				SurfaceAppearance.EmissiveTint = EmissiveTint
				SurfaceAppearance.EmissiveStrength = EmissiveStrength
			end)
		end

		p8:AddTag("PhantomEyesPart")
		p10:Add(function()
			p8.Material = p8Material
			p8.Color = p8Color
			p8.Transparency = p8Transparency
			p8:RemoveTag("PhantomEyesPart")
		end)

		return
	end

	local v83 = p8:GetAttribute(`{ s6 }Color`) or (p8:GetAttribute("Color") or 1)
	local v84 = p9.Palettes[n6][v83] or p9.Palettes[n6][1]

	if v83 == 4 and n6 == 1 or v83 == 5 and n6 == 1 or v83 == 7 and n6 == 2 or v83 == 9 and n6 == 2 then
		local p8Material = p8.Material

		p8.Material = Enum.Material.Neon
		p10:Add(function()
			p8.Material = p8Material
		end)
	elseif v83 == 1 or v83 == 6 or v83 == 7 then
		local p8Material = p8.Material

		p8.Material = Enum.Material.Glass
		p10:Add(function()
			p8.Material = p8Material
		end)
	elseif v83 == 2 or v83 == 3 then
		local p8Material = p8.Material
		local MaterialVariant = p8.MaterialVariant

		p8.Material = Enum.Material.SmoothPlastic
		p8.MaterialVariant = "Custom Stud"
		p10:Add(function()
			p8.Material = p8Material
			p8.MaterialVariant = MaterialVariant
		end)
	end

	if SurfaceAppearance then
		local AlphaMode = SurfaceAppearance.AlphaMode
		local SurfaceAppearanceColor = SurfaceAppearance.Color
		local EmissiveTint = SurfaceAppearance.EmissiveTint
		local EmissiveStrength = SurfaceAppearance.EmissiveStrength

		SurfaceAppearance.AlphaMode = Enum.AlphaMode.Overlay
		p8.Material = Enum.Material.Neon
		SurfaceAppearance.Color = Color3.fromRGB(0, 0, 0)
		SurfaceAppearance.EmissiveTint = Color3.fromRGB(0, 0, 0)
		SurfaceAppearance.EmissiveStrength = 0
		p10:Add(function()
			SurfaceAppearance.AlphaMode = AlphaMode
			SurfaceAppearance.Color = SurfaceAppearanceColor
			SurfaceAppearance.EmissiveTint = EmissiveTint
			SurfaceAppearance.EmissiveStrength = EmissiveStrength
		end)
	end

	local p8Color = p8.Color
	local p8Transparency = p8.Transparency

	p8.Color = v84.Color

	if not b1 then
		p8.Transparency = v84.Transparency
	end

	p10:Add(function()
		p8.Transparency = p8Transparency
		p8.Color = p8Color
	end)

	if not b1 then
		p8:AddTag("PhantomPart")
		p10:Add(function()
			p8:RemoveTag("PhantomPart")
		end)
	end
end

local function observeBodyVfxRecolor(p11, p12, t8: {[any]: any}, p13: ((...any) -> ...any))
	local function isUnderTrait(inst)
		local parent = inst.Parent

		while parent and parent ~= p11 do
			if string.sub(parent.Name, 1, 7) == "_Trait." then
				return true
			end

			parent = parent.Parent
		end

		return false
	end
	local function consider(inst)
		for _, className in t8 do
			if inst:IsA(className) then
				if not isUnderTrait(inst) then
					p13(inst)
				end

				return
			end
		end
	end

	for _, descendant in p11:GetDescendants() do
		consider(descendant)
	end

	p12:Add(p11.DescendantAdded:Connect(consider))
end

function t1.ApplyMutation(_: {[any]: any}, p16, s7: string, s8: string, b3: boolean?)
	local v108 = Trove.new()

	if b3 then
		v108:Add(p16.Destroying:Connect(function()
			v108:Destroy()
		end))
	else
		v108:Add(p16.AncestryChanged:Connect(function(_, parent)
			if parent then
				return
			end

			v108:Destroy()
		end))
	end

	local v109 = Mutations[s8]
	local s7_2 = MutationSurfaces:FindFirstChild(s7)
	local v111 = tonumber(p16:GetAttribute(`{ s8 }Palette`) or (p16:GetAttribute("Palette") or 1)) or 1

	if not v109 or not v109.Palettes[v111] then
		v111 = 1
	end

	local v112 = p16:FindFirstAncestorWhichIsA("ViewportFrame") ~= nil or p16:FindFirstAncestorWhichIsA("WorldModel") ~= nil
	local t10 = {}

	if s8 == "Rainbow" then
		v108:Add(function()
			p16:RemoveTag("RainbowModel")
		end)

		for _, descendant in p16:GetDescendants() do
			if descendant:IsA("BasePart") and not descendant:GetAttribute("IgnoreRainbowColor") then
				local SurfaceAppearance = descendant:FindFirstChildOfClass("SurfaceAppearance")

				if SurfaceAppearance then
					v108:Add(function()
						local SurfaceAppearance2 = descendant:FindFirstChildOfClass("SurfaceAppearance")

						if SurfaceAppearance2 then
							SurfaceAppearance2:Destroy()
						end

						SurfaceAppearance:Clone().Parent = descendant
					end)
				else
					local descendantColor = descendant.Color

					v108:Add(function()
						descendant.Color = descendantColor
					end)

					local MaterialVariant = descendant.MaterialVariant

					if MaterialVariant == "Strawberry Stud Light" or MaterialVariant == "Strawberry Stud Dark" then
						descendant.MaterialVariant = ""
						v108:Add(function()
							descendant.MaterialVariant = MaterialVariant
						end)
					end
				end
			end
		end

		p16:AddTag("RainbowModel")
	else
		for _, descendant in p16:GetDescendants() do
			if not descendant:IsA("BasePart") then
				continue
			end

			local v121 = descendant:GetAttribute(`{ s8 }IgnoreColor`)

			if v121 ~= false and (descendant:GetAttribute("IgnoreColor") or v121) then
				continue
			end

			local v122 = v109.Palettes[v111]
			local v123 = v109.Palettes[v111]
			local v124 = tonumber(descendant:GetAttribute(`{ s8 }Color`) or (descendant:GetAttribute("Color") or 1)) or 1
			local v125 = v123[v124] or (v122[v124] or v123[math.clamp(v124, 1, #v123)])
			local v126 = if typeof(v125) ~= "table" then v125 else v125.Color

			if descendant:GetAttribute("Neon") then
				local descendantMaterial = descendant.Material

				descendant.Material = Enum.Material.Neon
				v108:Add(function()
					descendant.Material = descendantMaterial
				end)
			end

			local SurfaceAppearance = descendant:FindFirstChildOfClass("SurfaceAppearance")

			if SurfaceAppearance then
				SurfaceAppearance:Destroy()

				if s7_2 then
					local clone = v108:Clone(s7_2)

					if s8 == "Divine" then
						clone.Color = v123[1] or v122[1]
					else
						clone.Color = v126
					end

					clone.Parent = descendant
				end

				v108:Add(function()
					local SurfaceAppearance3 = descendant:FindFirstChildOfClass("SurfaceAppearance")

					if SurfaceAppearance3 then
						SurfaceAppearance3:Destroy()
					end

					SurfaceAppearance:Clone().Parent = descendant
				end)

				continue
			end

			if s8 ~= "Phantom" then
				local MaterialVariant = descendant.MaterialVariant

				if MaterialVariant == "Strawberry Stud Light" or MaterialVariant == "Strawberry Stud Dark" then
					t10[descendant] = true
					descendant.MaterialVariant = `{ s8 } Strawberry Stud Light`
					v108:Add(function()
						descendant.MaterialVariant = MaterialVariant
					end)

					if MaterialVariant == "Strawberry Stud Light" then
						continue
					end
				end
			end

			local descendantColor = descendant.Color

			descendant.Color = v126
			v108:Add(function()
				descendant.Color = descendantColor
			end)
		end
	end

	if s8 == "Lava" then
		for _, descendant in p16:GetDescendants() do
			if descendant:IsA("BasePart") and not t10[descendant] then
				local v134 = descendant:GetAttribute(`{ s8 }IgnoreColor`)

				if (v134 == false or not descendant:GetAttribute("IgnoreColor") and not v134) and (descendant:GetAttribute(`{ s8 }Color`) or descendant:GetAttribute("Color")) == 1 then
					local descendantMaterial = descendant.Material

					descendant.Material = Enum.Material.Neon
					v108:Add(function()
						descendant.Material = descendantMaterial
					end)
				end
			end
		end
	elseif s8 == "Galaxy" then
		for _, descendant in p16:GetDescendants() do
			if descendant:IsA("BasePart") and not t10[descendant] then
				local v138 = descendant:GetAttribute(`{ s8 }IgnoreColor`)

				if v138 == false or not descendant:GetAttribute("IgnoreColor") and not v138 then
					if (descendant:GetAttribute(`{ s8 }Color`) or descendant:GetAttribute("Color")) == 1 then
						local descendantMaterial = descendant.Material

						descendant.Material = Enum.Material.Neon
						v108:Add(function()
							descendant.Material = descendantMaterial
						end)
					end

					local MaterialVariant = descendant.MaterialVariant

					descendant.MaterialVariant = "Galaxy Stud"
					v108:Add(function()
						descendant.MaterialVariant = MaterialVariant
					end)
				end
			end
		end
	elseif s8 == "YinYang" then
		for _, descendant in p16:GetDescendants() do
			if descendant:IsA("BasePart") and not t10[descendant] then
				local v143 = descendant:GetAttribute(`{ s8 }IgnoreColor`)

				if v143 == false or not descendant:GetAttribute("IgnoreColor") and not v143 then
					local v144 = descendant:GetAttribute(`{ s8 }Color`) or (descendant:GetAttribute("Color") or 1)

					if v144 == 3 or v144 == 4 then
						local descendantMaterial = descendant.Material

						descendant.Material = Enum.Material.Neon
						v108:Add(function()
							descendant.Material = descendantMaterial
						end)
					end
				end
			end
		end
	elseif s8 == "Radioactive" then
		for _, descendant in p16:GetDescendants() do
			if descendant:IsA("BasePart") and not t10[descendant] then
				local v148 = descendant:GetAttribute(`{ s8 }IgnoreColor`)

				if v148 == false or not descendant:GetAttribute("IgnoreColor") and not v148 then
					local MaterialVariant = descendant.MaterialVariant
					local descendantMaterial = descendant.Material
					local v151 = descendant:GetAttribute(`{ s8 }Color`) or (descendant:GetAttribute("Color") or 1)

					if v151 == 2 and v111 == 1 or (v151 == 2 and v111 == 4 or (v151 == 2 or v151 == 6) and v111 == 5) then
						descendant.Material = Enum.Material.Neon
						v108:Add(function()
							descendant.Material = descendantMaterial
						end)
					end

					local v152 = descendant:GetAttribute(`{ s8 }Stud`)

					if v152 ~= false and ((descendant.MaterialVariant == "Custom Stud" or v152 == true) and not descendant:GetAttribute(`{ s8 }Ignore`)) then
						if descendant:GetAttribute(`{ s8 }MaterialMode`) == 2 or p16:GetAttribute(`{ s8 }MaterialMode`) == 2 then
							if descendant:GetAttribute(`{ s8 }Material`) == 2 or p16:GetAttribute(`{ s8 }Material`) == 2 then
								descendant.Material = Enum.Material.SmoothPlastic
								descendant.MaterialVariant = "Radioactive Stud"
								v108:Add(function()
									descendant.MaterialVariant = MaterialVariant
									descendant.Material = descendantMaterial
								end)
							else
								descendant.Material = Enum.Material.SmoothPlastic
								descendant.MaterialVariant = "Radioactive Stud2"
								v108:Add(function()
									descendant.MaterialVariant = MaterialVariant
									descendant.Material = descendantMaterial
								end)
							end
						elseif v151 ~= 2 and v151 ~= 6 then
							if descendant:GetAttribute(`{ s8 }Material`) == 2 or p16:GetAttribute(`{ s8 }Material`) == 2 then
								descendant.Material = Enum.Material.SmoothPlastic
								descendant.MaterialVariant = "Radioactive Stud"
								v108:Add(function()
									descendant.MaterialVariant = MaterialVariant
									descendant.Material = descendantMaterial
								end)
							else
								descendant.Material = Enum.Material.SmoothPlastic
								descendant.MaterialVariant = "Radioactive Stud2"
								v108:Add(function()
									descendant.MaterialVariant = MaterialVariant
									descendant.Material = descendantMaterial
								end)
							end
						end
					elseif v152 == false then
						descendant.MaterialVariant = ""
						v108:Add(function()
							descendant.MaterialVariant = MaterialVariant
						end)
					end
				end
			end
		end
	elseif s8 == "Cursed" then
		local v153 = p16:FindFirstChild("_Trait.Zombie")

		if v153 then
			v153:Destroy()
		end

		for _, descendant in p16:GetDescendants() do
			if descendant:IsA("BasePart") and not t10[descendant] then
				local v156 = descendant:GetAttribute(`{ s8 }IgnoreColor`)

				if v156 == false or not descendant:GetAttribute("IgnoreColor") and not v156 then
					local MaterialVariant = descendant.MaterialVariant
					local descendantMaterial = descendant.Material
					local descendantColor = descendant.Color
					local v160 = descendant:GetAttribute(`{ s8 }Color`) or (descendant:GetAttribute("Color") or 1)

					if v160 == 2 and v111 == 1 or (v160 == 2 and v111 == 4 or (v160 == 2 or v160 == 6) and v111 == 5) then
						descendant.Material = Enum.Material.Neon
						v108:Add(function()
							descendant.Material = descendantMaterial
						end)
					end

					local v161 = descendant:GetAttribute(`{ s8 }Stud`)

					if v161 ~= false and ((descendant.MaterialVariant == "Custom Stud" or v161 == true) and not descendant:GetAttribute(`{ s8 }Ignore`)) then
						if v160 ~= 2 and v160 ~= 6 or v161 == true then
							descendant.Material = Enum.Material.SmoothPlastic
							descendant.MaterialVariant = "Cursed Stud"
							descendant.Color = Color3.fromRGB(255, 23, 23)
							v108:Add(function()
								descendant.MaterialVariant = MaterialVariant
								descendant.Material = descendantMaterial
								descendant.Color = descendantColor
							end)
						end
					elseif v161 == false then
						descendant.MaterialVariant = ""
						v108:Add(function()
							descendant.MaterialVariant = MaterialVariant
						end)
					end

					local SurfaceAppearance = descendant:FindFirstChildOfClass("SurfaceAppearance")

					if SurfaceAppearance then
						if not descendant:GetAttribute(`{ s8 }IgnoreSurfaceColor`) then
							SurfaceAppearance.Color = Color3.fromRGB(255, 23, 23)
						end

						if descendant:GetAttribute("IgnoreSurface") then
							SurfaceAppearance:Destroy()
						end
					end
				end
			end
		end

		local v163 = BrainrotAssets.getTrait("Zombie", s7)

		if v163 and not isBlacklistedNonExclusive(s7) then
			local v164 = v108:Add(Instance.new("Model"))

			v164.Name = "_Trait.Zombie"
			v164.Parent = p16

			local t11 = {}

			local function placeEye(p18, p19, s9: string)
				p18.Color = Color3.fromRGB(255, 23, 23)

				local v380 = t11[s9] or p16:FindFirstChild(s9, true)

				if not p19 or not v380 then
					p18:Destroy()

					return
				end

				p18.Parent = v164
				p18:PivotTo(v380.WorldCFrame)
				t11[s9] = v380

				local RigidConstraint = Instance.new("RigidConstraint")

				RigidConstraint.Attachment0 = p19
				RigidConstraint.Attachment1 = v380
				RigidConstraint.Parent = p19
			end

			local Zombie = Models.TraitsPerAnimal:FindFirstChild("Zombie")
			local v168 = Zombie and Zombie:FindFirstChild("_Template")

			if v168 and not v163:FindFirstChildWhichIsA("BasePart", true) then
				local t12 = {}

				for _, child in v168:GetChildren() do
					local Attachment = child:FindFirstChildOfClass("Attachment")

					if Attachment then
						t12[Attachment.Name] = child
					end
				end

				local Scale = v163:GetAttribute("Scale")

				for _, child in v163:GetChildren() do
					if child:IsA("Attachment") then
						local v176 = t12[child:GetAttribute("Tmpl") or child.Name]

						if v176 then
							local clone = v176:Clone()
							local v178 = child:GetAttribute("Scale") or Scale

							if typeof(v178) == "number" and v178 ~= 1 then
								local Model = Instance.new("Model")

								clone.Parent = Model
								Model:ScaleTo(v178)
								clone.Parent = nil
								Model:Destroy()
							end

							local Attachment = clone:FindFirstChildOfClass("Attachment")

							if Attachment then
								Attachment.CFrame = child.CFrame
							end

							placeEye(clone, Attachment, child:GetAttribute("Bind") or child.Name)
						end
					end
				end
			else
				local clone = v163:Clone()

				for _, child in clone:GetChildren() do
					if child:IsA("BasePart") then
						local Attachment = child:FindFirstChildOfClass("Attachment")

						placeEye(child, Attachment, Attachment and Attachment.Name or "")
					end
				end

				clone:Destroy()
			end
		end
	elseif s8 == "Divine" then
		local EmissiveStrength = p16:GetAttribute("EmissiveStrength")

		for _, descendant in p16:GetDescendants() do
			if descendant:IsA("SurfaceAppearance") then
				local EmissiveStrength2 = descendant.EmissiveStrength

				descendant.EmissiveStrength = EmissiveStrength or 2
				v108:Add(function()
					descendant.EmissiveStrength = EmissiveStrength2
				end)
			end

			if descendant:IsA("BasePart") and not t10[descendant] then
				local v189 = descendant:GetAttribute(`{ s8 }IgnoreColor`)

				if v189 == false or not descendant:GetAttribute("IgnoreColor") and not v189 then
					local v190 = descendant:GetAttribute(`{ s8 }Color`) or (descendant:GetAttribute("Color") or 1)

					if v190 == 2 and v111 == 1 or (v190 == 2 and v111 == 4 or (v190 == 2 or v190 == 6) and v111 == 5) then
						local descendantMaterial = descendant.Material

						descendant.Material = Enum.Material.Neon
						v108:Add(function()
							descendant.Material = descendantMaterial
						end)
					end

					local v192 = descendant:GetAttribute(`{ s8 }Stud`)

					if v192 ~= false and ((descendant.MaterialVariant == "Custom Stud" or v192 == true) and not descendant:GetAttribute(`{ s8 }Ignore`)) then
						if descendant:GetAttribute(`{ s8 }MaterialMode`) == 2 or p16:GetAttribute(`{ s8 }MaterialMode`) == 2 then
							local descendantMaterial = descendant.Material
							local MaterialVariant = descendant.MaterialVariant

							descendant.Material = Enum.Material.SmoothPlastic
							descendant.MaterialVariant = "Divine Stud"
							v108:Add(function()
								descendant.MaterialVariant = MaterialVariant
								descendant.Material = descendantMaterial
							end)
						elseif v190 ~= 2 and v190 ~= 6 then
							local descendantMaterial = descendant.Material
							local MaterialVariant = descendant.MaterialVariant

							descendant.Material = Enum.Material.SmoothPlastic
							descendant.MaterialVariant = "Divine Stud"
							v108:Add(function()
								descendant.MaterialVariant = MaterialVariant
								descendant.Material = descendantMaterial
							end)
						end
					elseif v192 == false then
						local MaterialVariant = descendant.MaterialVariant

						descendant.MaterialVariant = ""
						v108:Add(function()
							descendant.MaterialVariant = MaterialVariant
						end)
					end
				end
			end
		end
	elseif s8 == "Cyber" then
		local v198 = p16:FindFirstChild("VfxInstance") or GetBiggestInstance(p16)
		local PrimaryPart = p16.PrimaryPart

		if PrimaryPart then
			for _, child in script.MutationVFX.Cyber.RootPart:GetChildren() do
				v108:Clone(child).Parent = PrimaryPart
			end
		end

		for _, v203 in p16:QueryDescendants("BasePart") do
			if not t10[v203] then
				local v204 = v203:GetAttribute(`{ s8 }IgnoreColor`)

				if v204 == false or not v203:GetAttribute("IgnoreColor") and not v204 then
					if v198 == v203 then
						for _, child in script.MutationVFX.Cyber.BiggestInstance:GetChildren() do
							v108:Clone(child).Parent = v203
						end
					end

					if v203.Transparency ~= 1 then
						local Material = v203.Material
						local Transparency = v203.Transparency
						local MaterialVariant = v203.MaterialVariant
						local Color = v203.Color
						local v211 = v203:GetAttribute(`{ s8 }Color`) or (v203:GetAttribute("Color") or 1)
						local SurfaceAppearance = v203:FindFirstChildOfClass("SurfaceAppearance")

						if v211 == 7 then
							v203.Material = Enum.Material.Neon
							v108:Add(function()
								v203.Material = Material
							end)
						elseif v211 == 1 then
							v203.Material = Enum.Material.Glass
							v203.Transparency = 0.25
							v108:Add(function()
								v203.Material = Material
								v203.Transparency = Transparency
							end)

							if not SurfaceAppearance and not v203:GetAttribute("Eyes") and v203.ClassName == "MeshPart" then
								v108:Add(Instance.new("SurfaceAppearance")).Parent = v203
							end
						elseif v211 == 3 or v211 == 4 or v111 == 2 and v211 == 2 then
							if v211 == 4 then
								v203.Transparency = 0.5
								v203.Material = Enum.Material.SmoothPlastic
								v203.MaterialVariant = "Tech Stud"
								v203.Color = Color3.fromRGB(62, 155, 255)
								v108:Add(function()
									v203.Color = Color
									v203.Material = Material
									v203.Transparency = Transparency
									v203.MaterialVariant = MaterialVariant
								end)
							else
								v203.Material = Enum.Material.Glass
								v203.Transparency = 0.5
								v108:Add(function()
									v203.Material = Material
									v203.Transparency = Transparency
								end)

								if not SurfaceAppearance and not v203:GetAttribute("Eyes") and v203.ClassName == "MeshPart" then
									v108:Add(Instance.new("SurfaceAppearance")).Parent = v203
								end
							end
						end

						if v203:GetAttribute("Eyes") then
							v203.Color = v109.Palettes[v111][7]
							v203.Transparency = 0.25
							v203.Material = Enum.Material.Neon
							v108:Add(function()
								v203.Material = Material
								v203.Transparency = Transparency
								v203.Color = Color
							end)
						end

						if SurfaceAppearance then
							if IsSurfaceEye(v203) then
								v203.Transparency = 0
								v203.Material = Enum.Material.Neon
								v108:Add(function()
									v203.Material = Material
									v203.Transparency = Transparency
								end)
								SurfaceAppearance.AlphaMode = Enum.AlphaMode.Overlay
								SurfaceAppearance.Color = Color3.fromRGB(35, 75, 115)
								SurfaceAppearance.EmissiveTint = Color3.fromRGB(255, 255, 255)
								SurfaceAppearance.EmissiveStrength = 50
							else
								v203.Transparency = 0
								v203.Material = Enum.Material.Neon
								v108:Add(function()
									v203.Material = Material
									v203.Transparency = Transparency
								end)
								SurfaceAppearance.AlphaMode = Enum.AlphaMode.Overlay
								SurfaceAppearance.Color = Color3.fromRGB(0, 25, 30)
								SurfaceAppearance.EmissiveTint = Color3.fromRGB(255, 255, 255)
								SurfaceAppearance.EmissiveStrength = 25
							end
						end
					end
				end
			end
		end

		if s7 == "Meowl" then
			local color3 = Color3.fromRGB(62, 155, 255)
			local colorSequence2 = ColorSequence.new(color3)

			observeBodyVfxRecolor(p16, v108, { "ParticleEmitter" }, function(p20)
				local p20Color = p20.Color

				p20.Color = colorSequence2
				v108:Add(function()
					p20.Color = p20Color
				end)
			end)
		end
	elseif s8 == "Phantom" then
		local v215 = p16:GetAttribute("PhantomUseZombieEyes") == true
			and not isBlacklistedNonExclusive(s7)

		observeBodyVfxRecolor(p16, v108, {
			"ParticleEmitter",
			"Beam",
			"Trail"
		}, function(p21)
			local p21Color = p21.Color

			p21.Color = colorSequence
			p21.LocalTransparencyModifier = p21.LocalTransparencyModifier + 0.5
			v108:Add(function()
				local v522 = p21

				v522.LocalTransparencyModifier = v522.LocalTransparencyModifier - 0.5
				p21.Color = p21Color
			end)
		end)

		for _, v217 in (p16:QueryDescendants("BasePart")) do
			if not t10[v217] then
				applyPhantomToPart(v217, s8, v109, v111, v108, v112, v215)
			end
		end

		if v215 then
			local v218 = p16:FindFirstChild("_Trait.Zombie")

			if v218 then
				v218:Destroy()
			end

			local v219 = BrainrotAssets.getTrait("Zombie", s7)

			if v219 then
				local clone = v108:Clone(v219)

				clone.Name = "_Trait.Zombie"
				clone.Parent = p16

				local t13 = {}

				for _, child in clone:GetChildren() do
					local Attachment = child:FindFirstChildOfClass("Attachment")

					if Attachment then
						local v225 = t13[Attachment.Name] or p16:FindFirstChild(Attachment.Name, true)

						if not v225 then
							child:Destroy()
						else
							child.Color = Color3.fromRGB(255, 255, 255)
							child:PivotTo(v225.WorldCFrame)
							child:AddTag("PhantomEyesPart")
							t13[Attachment.Name] = v225

							local RigidConstraint = Instance.new("RigidConstraint")

							RigidConstraint.Attachment0 = Attachment
							RigidConstraint.Attachment1 = v225
							RigidConstraint.Parent = Attachment
						end
					end
				end
			end
		end
	end

	local s8_2 = Vfx:FindFirstChild(s8)
	local VfxInstance = p16:FindFirstChild("VfxInstance")

	if s8_2 and VfxInstance then
		for _, child in s8_2:GetChildren() do
			v108:Clone(child).Parent = VfxInstance
		end
	end

	p16:SetAttribute("__mutation", s8)
	v108:Add(function()
		p16:SetAttribute("__mutation", nil)
	end)

	return v108:WrapClean()
end
function t1.ApplyTraits(_: {[any]: any}, p22, s10: string, t15: {[any]: any})
	local v235 = Trove.new()

	if isBlacklistedNonExclusive(s10) then
		return v235:WrapClean()
	end

	local t16 = {}
    
	for _, v238 in t15 do
		t16[v238] = true
	end

	local v239 = t16.Skibidi and Models.TraitsPerAnimal.Skibidi:FindFirstChild(s10)

	for _, v241 in t15 do
		local function loadSpecificAnimalModel()
			if not Traits[v241] then
				return
			end

			local v386 = Models.TraitsPerAnimal:FindFirstChild(v241)

			if not v386 then
				return
			end

			if p22:FindFirstChild(`_Trait.{ v241 }`) then
				return
			end

			local s10_2 = v386:FindFirstChild(s10)

			if not s10_2 then
				s10_2 = BrainrotAssets.getTrait(v241, s10)

				if not s10_2 or not p22.Parent or p22:FindFirstChild(`_Trait.{ v241 }`) then
					return
				end
			end

			local _Template = v386:FindFirstChild("_Template")
			local v389 = nil

			if _Template and not s10_2:FindFirstChildWhichIsA("BasePart", true) then
				v389 = s10_2
			else
				_Template = s10_2
			end

			local v390 = v389 and v389:FindFirstChild("__Geo")
			local v391 = false

			if v389 and not v390 then
				for _, child in v389:GetChildren() do
					if child:IsA("Attachment") and child:GetAttribute("Tmpl") ~= nil then
						v391 = true

						break
					end
				end
			end

			local clone

			if v390 and _Template then
				clone = v235:Clone(_Template)

				local Scale = v390:GetAttribute("Scale")
				local Pivot = v390:GetAttribute("Pivot")
				local childName = nil
				local childCFrame = nil

				for _, child in v389:GetChildren() do
					if child:IsA("Attachment") then
						childName = child.Name
						childCFrame = child.CFrame

						break
					end
				end

				local v401 = nil
				local v402 = nil

				if childName then
					for _, descendant in clone:GetDescendants() do
						if not descendant:IsA("BasePart") then
							continue
						end

						local childName2 = descendant:FindFirstChild(childName)

						if childName2 and childName2:IsA("Attachment") then
							v401 = descendant
							v402 = childName2

							break
						end
					end
				end

				local v406 = nil

				if v401 then
					for _, child in v401:GetChildren() do
						if child:IsA("Model") then
							v406 = child

							break
						end
					end
				end

				local v409 = nil

				if v406 then
					for _, descendant in v406:GetDescendants() do
						if descendant.Name == "RootPart" and descendant:IsA("BasePart") then
							v409 = descendant
						end
					end
				end

				if v406 and typeof(Scale) == "number" and Scale ~= 1 then
					v406:ScaleTo(Scale)
				end

				if v402 and childCFrame then
					v402.CFrame = childCFrame
				end

				if v409 and v401 and v402 and childCFrame and typeof(Pivot) == "CFrame" then
					local v412 = nil

					for _, descendant in clone:GetDescendants() do
						if descendant:IsA("Weld") and (v409 == descendant.Part0 and v401 == descendant.Part1 or v401 == descendant.Part0 and v409 == descendant.Part1) then
							v412 = descendant

							break
						end
					end

					if v412 then
						if v409 ~= v412.Part0 then
							v412.Part0 = v409
							v412.Part1 = v401
						end

						v412.C0 = CFrame.identity
						v412.C1 = childCFrame * Pivot
					end
				end

				if v402 and childCFrame then
					local childName3 = p22:FindFirstChild(childName, true)

					if childName3 then
						local RigidConstraint = Instance.new("RigidConstraint")

						RigidConstraint.Attachment0 = v402
						RigidConstraint.Attachment1 = childName3
						RigidConstraint.Parent = v401
					end
				end
			elseif v391 and _Template then
				local t17 = {}

				for _, child in _Template:GetChildren() do
					local Attachment = child:FindFirstChildOfClass("Attachment")

					if Attachment then
						t17[Attachment.Name] = child
					end
				end

				clone = Instance.new("Model")

				local Scale = v389:GetAttribute("Scale")

				for _, child in v389:GetChildren() do
					if child:IsA("Attachment") then
						local v424 = t17[child:GetAttribute("Tmpl") or child.Name]

						if v424 then
							local clone2 = v424:Clone()
							local v426 = child:GetAttribute("Scale") or Scale

							if typeof(v426) == "number" and v426 ~= 1 then
								local Model = Instance.new("Model")

								clone2.Parent = Model
								Model:ScaleTo(v426)
								clone2.Parent = nil
								Model:Destroy()
							end

							local Attachment = clone2:FindFirstChildOfClass("Attachment")

							if Attachment then
								Attachment.CFrame = child.CFrame
							end

							local v429 = child:GetAttribute("Bind") or child.Name
							local v430 = p22:FindFirstChild(v429, true)

							if Attachment and v430 then
								local RigidConstraint = Instance.new("RigidConstraint")

								RigidConstraint.Attachment0 = Attachment
								RigidConstraint.Attachment1 = v430
								RigidConstraint.Parent = clone2
							end

							clone2.Parent = clone
						end
					end
				end

				for _, child in _Template:GetChildren() do
					if not child:FindFirstChildOfClass("Attachment") then
						child:Clone().Parent = clone
					end
				end

				v235:Add(clone)
			else
				clone = v235:Clone(_Template)

				local v434 = v389 and v389:GetAttribute("Scale")

				if typeof(v434) == "number" and clone:IsA("Model") then
					clone:ScaleTo(v434)
				end

				for _, child in clone:GetChildren() do
					local Attachment = child:FindFirstChildOfClass("Attachment")

					if Attachment then
						local AttachmentName = Attachment.Name
						local Bind = Attachment:GetAttribute("Bind")

						if type(Bind) == "string" then
							AttachmentName = Bind
						end

						if v389 then
							local AttachmentName2 = v389:FindFirstChild(Attachment.Name, true)

							if AttachmentName2 and AttachmentName2:IsA("Attachment") then
								Attachment.CFrame = AttachmentName2.CFrame

								local Bind2 = AttachmentName2:GetAttribute("Bind")

								if type(Bind2) == "string" then
									AttachmentName = Bind2
								end
							end
						end

						local AttachmentName3 = p22:FindFirstChild(AttachmentName, true)

						if AttachmentName3 then
							local RigidConstraint = Instance.new("RigidConstraint")

							RigidConstraint.Attachment0 = Attachment
							RigidConstraint.Attachment1 = AttachmentName3
							RigidConstraint.Parent = child
						end
					end
				end
			end

			clone.Name = `_Trait.{ v241 }`
			clone.Parent = p22

			if v241 == "Jackolantern Pet" or v241 == "Reindeer Pet" or v241 == "Pink Egg" or v241 == "Blue Egg" or v241 == "Green Egg" or v241 == "Orange Egg" or v241 == "Burger" then
				local Animator = clone:FindFirstChildWhichIsA("Animator", true)

				if Animator then
					Animator:SetAttribute("Animation", `Animations.Traits.{ v241 }`)
					Animator:AddTag("ClientLoadAnimation")

					local track = Animator:LoadAnimation(ReplicatedStorage.Animations.Traits[v241].Walk)

					v235:Add(function()
						track:Stop(0)
						track:Destroy()
					end)

					local v446 = v241 ~= "Pink Egg" and (v241 ~= "Blue Egg" and (v241 ~= "Green Egg" and v241 ~= "Orange Egg")) and 1 or 2

					v235:Add(Observers.observeAttribute(p22, "Walking", function(p23)
						if p23 then
							if not track.IsPlaying then
								track:Play(0.2, 1, v446)
							end
						elseif track.IsPlaying then
							track:Stop()
						end

						return nil
					end))
				end
			end
		end
		local function loadModels()
			local v447 = Traits[v241]

			if not v447 then
				return
			end

			local v448 = Traits2:FindFirstChild(v241)

			if not v448 then
				return
			end

			local clone = v235:Clone(v448)

			clone.Name = `_Trait.{ v241 }`

			for _, child in clone:GetChildren() do
				local v452 = false

				for _, child2 in child:GetChildren() do
					if child2:IsA("Attachment") then
						local child2Name = p22:FindFirstChild(child2.Name, true)

						if child2Name then
							v452 = true

							local vector3 = Vector3.new(0, 0, 0)

							if t16.Halo and v241 ~= "Halo" then
								vector3 += Vector3.new(0, -2, 0)
							end

							if (v241 == "10B" or v241 == "26") and t16["10B"] then
								vector3 += Vector3.new(0, -1.4589999914169312, 0)
							end

							if (v241 == "1 Year" or v241 == "26") and t16["1 Year"] then
								vector3 += Vector3.new(0, -1.4589999914169312, 0)
							end

							if v241 == "1 Year" and t16["10B"] then
								vector3 += Vector3.new(0, -1.4589999914169312, 0)
							end

							if (v241 == "Taco" or v241 == "10B" or v241 == "26" or v241 == "1 Year") and t16["RIP Gravestone"] then
								vector3 += Vector3.new(0, -3.5820000171661377, 0)
							end

							if (v241 == "Taco" or v241 == "10B" or v241 == "26" or v241 == "1 Year" or v241 == "RIP Gravestone") and t16["Matteo Hat"] then
								vector3 += Vector3.new(0, -1.3300000429153442, 0)
							end

							if (v241 == "Taco" or v241 == "10B" or v241 == "26" or v241 == "1 Year" or v241 == "Matteo Hat" or v241 == "RIP Gravestone") and t16["Santa Hat"] then
								vector3 += Vector3.new(0, -1.534000039100647, 0)
							end

							if (v241 == "Taco" or v241 == "10B" or v241 == "26" or v241 == "1 Year" or v241 == "Matteo Hat" or v241 == "RIP Gravestone" or v241 == "Santa Hat") and t16["Witch Hat"] then
								vector3 += Vector3.new(0, -2.450000047683716, 0)
							end

							if (v241 == "Taco" or v241 == "10B" or v241 == "26" or v241 == "1 Year" or v241 == "Matteo Hat" or v241 == "RIP Gravestone" or v241 == "Santa Hat" or v241 == "Witch Hat") and t16.Sombrero then
								vector3 += Vector3.new(0, -2.7279999256134033, 0)
							end

							if (v241 == "Taco" or v241 == "10B" or v241 == "26" or v241 == "1 Year" or v241 == "Matteo Hat" or v241 == "RIP Gravestone" or v241 == "Santa Hat" or v241 == "Witch Hat" or v241 == "Sombrero") and t16.Skibidi then
								local child2Name2 = child2.Name

								if not string.find(child2Name2, "Forward") then
									local v458 = string.find(child2Name2, "Second")

									child2Name2 = if not string.find(child2Name2, "Third") then not v458 and "ForwardHatAttachment" or "SecondForwardHatAttachment" else "ThirdForwardHatAttachment"
								end

								local child2Name2_2 = v239 and v239:FindFirstChild(child2Name2, true)

								if child2Name2_2 then
									local child2Name2_2Parent = child2Name2_2.Parent
									local SizeY = nil

									if child2Name2_2Parent:IsA("BasePart") then
										SizeY = child2Name2_2Parent.Size.Y
									else
										local _Template = Models.TraitsPerAnimal.Skibidi:FindFirstChild("_Template")
										local v463 = _Template and (_Template:FindFirstChild(child2Name2, true) or _Template:FindFirstChild("ForwardHatAttachment", true))
										local v464 = v463 and v463.Parent

										if v464 and v464:IsA("BasePart") then
											local Scale = v239:GetAttribute("Scale")

											SizeY = v464.Size.Y * (typeof(Scale) ~= "number" and 1 or Scale)
										end
									end

									if SizeY then
										vector3 += Vector3.new(0, -(SizeY * 0.5) + child2Name2_2.Position.Y, 0)
									end
								end
							end

							if vector3 ~= Vector3.new(0, 0, 0) then
								if v241 == "26" then
									vector3 = Vector3.new(0, 0, vector3.Y)
								end

								child2.Position = child2.Position + vector3
							end

							local RigidConstraint = Instance.new("RigidConstraint")

							RigidConstraint.Attachment0 = child2
							RigidConstraint.Attachment1 = child2Name
							RigidConstraint.Parent = child

							if v447.Modify then
								v447.Modify(child, child2, child2Name)
							end
						end
					end
				end

				if not v452 then
					child:Destroy()
				end
			end

			clone.Parent = p22

			if t16.Lightning then
				local Animator = clone:FindFirstChildWhichIsA("Animator", true)

				if Animator then
					Animator:SetAttribute("Animation", "Animations.Traits.Lightning")
					Animator:AddTag("ClientLoadAnimation")

					return
				end
			elseif t16.Granny then
				local Animator = clone:FindFirstChildWhichIsA("Animator", true)

				if Animator then
					Animator:SetAttribute("Animation", "Animations.Traits.Granny")
					Animator:AddTag("ClientLoadAnimation")

					return
				end
			elseif t16.Sun then
				local Animator = clone:FindFirstChildWhichIsA("Animator", true)

				if Animator then
					Animator:SetAttribute("Animation", "Animations.Traits.Sun")
					Animator:AddTag("ClientLoadAnimation")
				end

				local RootPart = clone:FindFirstChild("RootPart", true)

				if RootPart and RootPart:IsA("BasePart") then
					RootPart:AddTag("ClientFloat")
				end
			end
		end
		local function loadVfx()
			local v471 = Traits[v241]

			if not v471 then
				return
			end

			local v472 = Traits3:FindFirstChild(v241)

			if v472 then
				for _, child in v472:GetChildren() do
					local childName = p22:FindFirstChild(child.Name)

					if childName then
						local clone = v235:Clone(child)

						clone.Massless = true
						clone.CanCollide = false
						clone.CanQuery = false
						clone.CanTouch = false
						clone.Transparency = 1
						clone.CFrame = childName.CFrame

						local WeldConstraint = Instance.new("WeldConstraint", clone)

						WeldConstraint.Part0 = childName
						WeldConstraint.Part1 = clone
						clone.Parent = p22
						clone.Name = `_{ child.Name }`

						if v471.ModifyVFX then
							v471.ModifyVFX(clone, childName, s10)
						end
					end
				end
			end
		end

		if v241 ~= "Strawberry" or s10 ~= "Strawberry Elephant" then
			loadSpecificAnimalModel()
			loadModels()
			loadVfx()

			if v241 == "Strawberry" then
				for _, v246 in p22:QueryDescendants("BasePart") do
					local MaterialVariant = v246.MaterialVariant
					local Color = v246.Color

					if v246:HasTag("Strawberry") then
						v246.Color = Color3.fromRGB(255, 255, 255)
						v246.Material = Enum.Material.SmoothPlastic
						v246.MaterialVariant = "Strawberry Stud Light"
						v235:Add(function()
							v246.MaterialVariant = MaterialVariant
							v246.Color = Color
						end)
					end

					if v246:HasTag("Strawberry2") then
						v246.Color = Color3.fromRGB(193, 193, 193)
						v246.Material = Enum.Material.SmoothPlastic
						v246.MaterialVariant = "Strawberry Stud Light"
						v235:Add(function()
							v246.MaterialVariant = MaterialVariant
							v246.Color = Color
						end)
					end

					if v246:HasTag("Strawberry3") then
						v246.Color = Color3.fromRGB(147, 147, 147)
						v246.Material = Enum.Material.SmoothPlastic
						v246.MaterialVariant = "Strawberry Stud Light"
						v235:Add(function()
							v246.MaterialVariant = MaterialVariant
							v246.Color = Color
						end)
					end
				end
			elseif v241 == "Chocolate" then
				local v249 = s10 ~= "Strawberry Elephant" and "Chocolate Stud" or "Chocolate Strawberry Stud"

				for _, v251 in p22:QueryDescendants("BasePart") do
					local MaterialVariant = v251.MaterialVariant
					local Color = v251.Color

					if v251:HasTag("Strawberry") then
						v251.Color = Color3.fromRGB(136, 73, 28)
						v251.Material = Enum.Material.SmoothPlastic
						v251.MaterialVariant = v249
						v235:Add(function()
							v251.MaterialVariant = MaterialVariant
							v251.Color = Color
						end)
					end

					if v251:HasTag("Strawberry2") then
						v251.Color = Color3.fromRGB(113, 59, 22)
						v251.Material = Enum.Material.SmoothPlastic
						v251.MaterialVariant = v249
						v235:Add(function()
							v251.MaterialVariant = MaterialVariant
							v251.Color = Color
						end)
					end

					if v251:HasTag("Strawberry3") then
						v251.Color = Color3.fromRGB(91, 46, 16)
						v251.Material = Enum.Material.SmoothPlastic
						v251.MaterialVariant = v249
						v235:Add(function()
							v251.MaterialVariant = MaterialVariant
							v251.Color = Color
						end)
					end
				end
			elseif v241 == "Lucky" then
				for _, v255 in p22:QueryDescendants("BasePart") do
					local MaterialVariant = v255.MaterialVariant
					local Color = v255.Color

					if v255:HasTag("Strawberry") then
						v255.Color = Color3.fromRGB(255, 255, 255)
						v255.Material = Enum.Material.SmoothPlastic
						v255.MaterialVariant = "Clover Stud"
						v235:Add(function()
							v255.MaterialVariant = MaterialVariant
							v255.Color = Color
						end)
					end

					if v255:HasTag("Strawberry2") then
						v255.Color = Color3.fromRGB(255, 255, 255)
						v255.Material = Enum.Material.SmoothPlastic
						v255.MaterialVariant = "Clover Stud"
						v235:Add(function()
							v255.MaterialVariant = MaterialVariant
							v255.Color = Color
						end)
					end

					if v255:HasTag("Strawberry3") then
						v255.Color = Color3.fromRGB(255, 255, 255)
						v255.Material = Enum.Material.SmoothPlastic
						v255.MaterialVariant = "Clover Stud2"
						v235:Add(function()
							v255.MaterialVariant = MaterialVariant
							v255.Color = Color
						end)
					end
				end
			end
		end
	end

	if s10 == "Rosey and Teddy" and t16["Matteo Hat"] then
		local __mutation = p22:GetAttribute("__mutation")

		for _, child in p22:GetChildren() do
			if child:IsA("BasePart") and child.Transparency < 1 then
				local childTransparency = child.Transparency

				child.Transparency = 1
				v235:Add(function()
					child.Transparency = childTransparency
				end)
			end
		end

		local clone = v235:Clone(script["MatteoHat_Rosey and Teddy"])

		if __mutation then
			v235:Add(t1:ApplyMutation(clone, s10, __mutation))
		end

		clone.AnimationController:Destroy()

		local Weld = Instance.new("Weld")

		Weld.Part0 = clone.PrimaryPart
		Weld.Part1 = p22.PrimaryPart
		Weld.Parent = clone
		clone.Parent = p22
	end

	if p22:GetAttribute("__mutation") == "Phantom" then
		if p22:GetAttribute("PhantomUseZombieEyes") ~= true then
		end

		local function tagTraitPhantom(p24)
			if p24.Transparency == 1 then
				return
			end

			p24:SetAttribute("PhantomNoColor", true)
			p24:AddTag("PhantomPart")
			v235:Add(function()
				p24:RemoveTag("PhantomPart")
				p24:SetAttribute("PhantomNoColor", nil)
			end)
		end

		for _, child in p22:GetChildren() do
			if string.sub(child.Name, 1, 7) == "_Trait." then
				if child:IsA("BasePart") then
					tagTraitPhantom(child)
				end

				for _, descendant in child:GetDescendants() do
					if descendant:IsA("BasePart") then
						tagTraitPhantom(descendant)
					end
				end
			end
		end
	end

	return v235:WrapClean()
end
function t1.GetAnimatedModel(_: {[any]: any}, s10: string, s11: string)
	local s10_2 = BrainrotAssets.getModel(s10)

	if not s10_2 then
		warn(`Animal not found { s10 } in model folder`)

		return nil
	end

	local clone = s10_2:Clone()

	if clone.PrimaryPart then
		clone.PrimaryPart.Anchored = true
	end

	clone.Parent = workspace

	local s10_3 = Animals2:FindFirstChild(s10)
	local v271 = s10_3 and s10_3:FindFirstChild(s11)

	local animator

	if FFlags:GetInstant("Optimisation.HumanoidBrainrotModels", true) then
		local humanoid = clone:FindFirstChildOfClass("Humanoid")

		if humanoid then
			local strayController = clone:FindFirstChildOfClass("AnimationController")

			if strayController then
				strayController:Destroy()
			end

			humanoid.EvaluateStateMachine = false
			humanoid.PlatformStand = true
			humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
			humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff

			-- Fix: Force LTM=0 on all parts after Humanoid is configured to prevent invisibility
			for _, desc in clone:GetDescendants() do
				if desc:IsA("BasePart") then
					desc.LocalTransparencyModifier = 0
				end
			end

			animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)
		else
			local existingController = clone:FindFirstChild("AnimationController")

			if existingController then
				existingController:Destroy()
			end

			local newHumanoid = Instance.new("Humanoid")

			newHumanoid.Name = "AnimationController"
			newHumanoid.EvaluateStateMachine = false
			newHumanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
			newHumanoid.PlatformStand = true
			newHumanoid.Parent = clone

			-- Fix: Force LTM=0 on all parts after Humanoid is added to prevent invisibility
			for _, desc in clone:GetDescendants() do
				if desc:IsA("BasePart") then
					desc.LocalTransparencyModifier = 0
				end
			end

			animator = Instance.new("Animator", newHumanoid)
		end
	else
		local animationController = clone:FindFirstChildOfClass("AnimationController")
			or Instance.new("AnimationController", clone)

		animator = animationController:FindFirstChildOfClass("Animator")
			or Instance.new("Animator", animationController)
	end

	if v271 and animator then
		local track = animator:LoadAnimation(v271)

		track.Looped = true
		track:Play()
	end


	for _, descendant in clone:GetDescendants() do
		if descendant:IsA("BasePart") then
			disablePartCollision(descendant)
			descendant.Massless = true
			descendant.Anchored = false
		end
	end

	for _, child in clone:GetChildren() do
		if child:IsA("Humanoid") then
			child.EvaluateStateMachine = false
			child.PlatformStand = true
			child.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
			child.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
			child.StateChanged:Connect(function()
				for _, part in clone:GetDescendants() do
					if part:IsA("BasePart") then
						disablePartCollision(part)
					end
				end
			end)
		end
	end

	clone.DescendantAdded:Connect(function(desc)
		if desc:IsA("BasePart") then
			task.defer(function()
				if desc and desc.Parent then
					disablePartCollision(desc)
				end
			end)
		end
	end)

	return clone
end
function t1.AttachOnViewportWithOptimizations(_: {[any]: any}, s13: string, p25, _, s14: string?, _: boolean?)
	local v288 = Trove.new()
	local u289 = true

	v288:Add(function()
		u289 = false
	end)
	v288:Add(p25.Destroying:Connect(function()
		v288:Destroy()
	end))

	local isExclusive = Exclusive and Exclusive[s13] ~= nil

	local u290 = nil
	local u291 = nil
	local t20 = {}
	local u293 = false
	local u294 = false
	local u295 = false

	local idleTracks = {}

	local function getModel()
		return u290
	end
	local function onModel(p27: ((...any) -> ...any))
		if u290 then
			task.spawn(p27, u290)

			return
		end

		if u289 then
			table.insert(t20, p27)
		end
	end

	local v298 = v288:Add(Instance.new("Camera"))

	v298.FieldOfView = 50
	v298.Parent = p25
	p25.CurrentCamera = v298

	local function unloadIdleAnimation()
		if #idleTracks == 0 then
			return
		end

		for _, pair in idleTracks do
			pair.track:Stop(0)
			pair.track:Destroy()
			pair.animator:Destroy()
		end

		table.clear(idleTracks)
	end
	local function loadIdleAnimation()
		if #idleTracks > 0 or (not u289 or not u295) then
			return
		end

		local clone = u290

		if not clone then
			return
		end

		local function playOn(targetModel, targetName: string)
			local animFolder = Animals2:FindFirstChild(targetName)
			local idleAnim = animFolder and animFolder:FindFirstChild("Idle")

			if not idleAnim then
				return
			end

			local controller = targetModel:FindFirstChild("AnimationController")
				or Instance.new("AnimationController", targetModel)
			local animator = controller:FindFirstChild("Animator")
				or Instance.new("Animator", controller)

			local track = animator:LoadAnimation(idleAnim)

			track.Looped = true
			track:Play(0)

			table.insert(idleTracks, { track = track, animator = animator })
		end

		if isExclusive then
			for _, child in clone:GetChildren() do
				if child:IsA("Model") then
					playOn(child, child.Name)
				end
			end
		else
			playOn(clone, s13)
		end
	end
	local function ensureBuilt()
		if u294 or (u293 or not u289) then
			return
		end

		u293 = true

		local v486 = BrainrotAssets.getModel(s13)

		u293 = false

		if not u289 or u294 then
			return
		end

		if not v486 then
			warn(`Animal not found { s13 } in model folder`)

			return
		end

		u294 = true

		local clone = v288:Clone(v486)

		u290 = clone
		u291 = v288:Add(Instance.new("WorldModel"))
		clone.Parent = u291

		-- Fix: Force LTM=0 on all parts to prevent invisibility in viewport/WorldModel rendering
		for _, desc in clone:GetDescendants() do
			if desc:IsA("BasePart") then
				desc.LocalTransparencyModifier = 0
			end
			end
		clone.DescendantAdded:Connect(function(desc)
			if desc:IsA("BasePart") then
				task.defer(function()
					if desc and desc.Parent then
						desc.LocalTransparencyModifier = 0
					end
				end)
			end
		end)

		if s14 and s14 ~= "Default" then
			if isExclusive then
				for _, child in clone:GetChildren() do
					if child:IsA("Model") then
						v288:Add(t1:ApplyMutation(child, child.Name, s14))
					end
				end
			else
				v288:Add(t1:ApplyMutation(clone, s13, s14))
			end
		end

		FitCam(v298, s13, clone, v298.FieldOfView, 0.75, 0.7)

		local pending = t20

		t20 = {}

		for _, cb in pending do
			task.spawn(cb, clone)
		end
	end
	local function applyVisibility()
		if not u289 then
			return
		end

		if u295 then
			if not u294 then
				ensureBuilt()

				if not u289 or not u295 then
					return
				end
			end

			if u291 then
				u291.Parent = p25
			end

			loadIdleAnimation()

			return
		end

		unloadIdleAnimation()

		if u291 then
			u291.Parent = nil
		end
	end
	local function setVisible(b5: boolean)
		u295 = b5

		if b5 then
			task.spawn(applyVisibility)

			return
		end

		if not u289 then
			return
		end

		unloadIdleAnimation()

		if u291 then
			u291.Parent = nil
		end
	end
	local function updateAncestry(p28)
		if not p28 then
			setVisible(false)

			return
		end

		local LayerCollector = p28:FindFirstAncestorWhichIsA("LayerCollector")

		if not LayerCollector then
			setVisible(false)

			return
		end

		local GuiObject = LayerCollector:FindFirstChildWhichIsA("GuiObject")

		if not GuiObject then
			setVisible(false)

			return
		end

		return Observers.observeProperty(LayerCollector, "Enabled", function(p29)
			if not p29 then
				setVisible(false)

				return
			end

			return Observers.observeProperty(GuiObject, "Visible", function(p30)
				setVisible(p30 == true)

				return function()
					setVisible(false)
				end
			end)
		end)
	end

	local u307 = nil

	local function requestUpdateAncestry(p31)
		if type(u307) == "function" then
			u307()
		end

		u307 = updateAncestry(p31)
	end

	v288:Add(p25.AncestryChanged:Connect(function(_, parent)
		if type(u307) == "function" then
			u307()
		end

		u307 = updateAncestry(parent)
	end))

	if p25.Parent then
		local p25Parent = p25.Parent

		if type(u307) == "function" then
			u307()
		end

		u307 = updateAncestry(p25Parent)
	end

	return v288, getModel, onModel
end
function t1.AttachOnViewport(_: {[any]: any}, s15: string, p33, _: boolean?, s16: string?, _: boolean?)
	return t1:AttachOnViewportWithOptimizations(s15, p33, nil, s16)
end
function t1.GetListOfRarity(_, p35)
	local t22 = {}

	for v319, v320 in Animals do
		if p35 == v320.Rarity then
			table.insert(t22, v319)
		end
	end

	return t22
end
function t1.GetList(_: {[any]: any}, s17: string, b8: boolean?)
	local t24 = {}

	for v325, v326 in Animals do
		if not v326.IsEnabled or v326.IsEnabled() then
			table.insert(t24, v325)
		end
	end

	if s17 == "Rarity" then
		table.sort(t24, function(p36, p37)
			local v504 = Animals[p36]
			local v505 = Animals[p37]
			local v506 = v504 and v504.Rarity
			local v507 = v505 and v505.Rarity
			local v508 = v506 and (not not Rarities[v506] and Rarities[v506].Weight) or 0
			local v509 = v507 and (not not Rarities[v507] and Rarities[v507].Weight) or 0

			if b8 then
				return v508 < v509
			end

			return v509 < v508
		end)

		return t24
	end

	if s17 == "Price" then
		table.sort(t24, function(p38, p39)
			local v512 = Animals[p38]
			local v513 = Animals[p39]
			local v514 = v512 and v512.Price or 0
			local v515 = v513 and v513.Price or 0

			if b8 then
				return v514 < v515
			end

			return v515 < v514
		end)

		return t24
	end

	if s17 == "Generation" then
		table.sort(t24, function(p40, p41)
			local v518 = Animals[p40]
			local v519 = Animals[p41]
			local v520 = v518 and v518.Generation or 0
			local v521 = v519 and v519.Generation or 0

			if b8 then
				return v520 < v521
			end

			return v521 < v520
		end)
	end

	return t24
end
function t1.GetGeneration(_: {[any]: any}, s18: string, s19: string?, t26: {[any]: any}?, p42)
	local n7 = 0
	local v333 = Animals[s18]

	if not v333 then
		return n7
	end

	local v334 = if not v333.Generation then n7 + v333.Price * Game.Game.AnimalGanerationModifier else n7 + v333.Generation
	local n8 = 1

	if s19 then
		n8 += Mutations[s19].Modifier
	end

	local v336 = false

	if t26 then
		for _, v338 in t26 do
			local v339 = Traits[v338]

			if v339 then
				if v338 == "Sleepy" then
					v336 = true
				else
					n8 += v339.MultiplierModifier
				end
			end
		end
	end

	local v340 = v334 * n8

	if v336 then
		v340 *= 0.5
	end

	if p42 then
		v340 *= require(ReplicatedStorage.Shared.Game):GetPlayerCashMultiplayer(p42)
	end

	return (math.round(v340))
end
function t1.GetGenerationNoTraits(t27: {[any]: any}, s20: string, s21: string?, p43)
	return t27:GetGeneration(s20, s21, nil, p43)
end
function t1.GetPrice(_: {[any]: any}, s22: string, _)
	return Animals[s22].Price
end
function t1.GetRarityStringFormat(_: {[any]: any}, s23: string)
	local v350 = Rarities[s23]

	if s23 == "OG" then
		return "<og>%s</og>"
	end

	if s23 == "Festive" then
		return "<greenred>%s</greenred>"
	end

	if s23 == "Admin" or s23 == "Taco" or s23 == "Spooky" then
		return "<yellowred>%s</yellowred>"
	end

	if s23 == "Secret" then
		return "<zebra>%s</zebra>"
	end

	if s23 == "Brainrot God" then
		return "<rainbow>%s</rainbow>"
	end

	if v350 then
		return `<font color="#{ v350.Color:ToHex() }">%s</font>`
	end

	return "%s"
end
function t1.GetAnimalTag(_: {[any]: any}, s24: string)
	local v353 = Animals[s24]

	if v353 then
		return t1:GetRarityStringFormat(v353.Rarity)
	end

	return "%s"
end
function t1.GetRarityWeight(_: {[any]: any}, s25: string)
	local v356 = Rarities[s25]

	if v356 then
		return v356.Weight
	end

	return 1
end
function t1.ColorBrainrotName(t32: {[any]: any}, s26: string)
	local AnimalTag = t32:GetAnimalTag(s26)

	return string.format(AnimalTag, s26)
end
function t1.ColorRecipeName(t33: {[any]: any}, s27: string)
	local t34 = {}

	for _, v364 in (string.split(s27, " & ")) do
		table.insert(t34, t33:ColorBrainrotName(v364))
	end

	return table.concat(t34, " & ")
end

return t1