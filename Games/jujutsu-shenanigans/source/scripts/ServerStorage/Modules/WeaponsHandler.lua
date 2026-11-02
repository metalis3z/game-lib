-- SERVICES --

local ServerStorage = game:GetService('ServerStorage')
local ReplicatedStorage = game:GetService('ReplicatedStorage')


-- SERVER MODULES --

local ServerModules = ServerStorage.Modules

local AnimationService = require(ServerModules.AnimationService)


-- VARIABLES --

local SeathTasks = {}


-- SERVER ASSETS --

local ServerAssets = ServerStorage.Assets

local WeaponModels = ServerAssets.Models.Weapons
local SeathAnim = ServerAssets.Animations.Other.Seath
local UnseathAnim = ServerAssets.Animations.Other.Unseath


-- FUNCTIONS --

local function TriggerTransparency(Sword: Model?, State: boolean)
	if Sword:IsA('Model') then
		for _,Part: Part in Sword:GetDescendants() do
			if Part:IsA('Part') or Part:IsA('MeshPart') or Part:IsA('UnionOperation') then 
				if Part:HasTag('Invisible') then continue end

				if State == false then
					Part.Transparency = 0
				else
					Part.Transparency = 1
				end
			end
		end
	else
		if State == false then
			Sword.Transparency = 0
		else
			Sword.Transparency = 1
		end
	end
end


-- MODULE --

local module = {}
function module:AddSword(Character: Model, MovesetName: string)
	local Sword: Model = WeaponModels[MovesetName].Sword:Clone()
	Sword.Parent = Character
	Sword.Seath.TorsoWeld.Part0 = Character.Torso
	Sword.WeaponHold.WeaponHold.Part0 = Character['Right Arm']
	
	Character:AddTag('HasSword')
end

function module:AddDaggers(Character: Model, MovesetName: string)
	local Daggers: Model = WeaponModels[MovesetName].Daggers:Clone()
	Daggers.Parent = Character
	Daggers.LGrip.LGrip.Part0 = Character['Left Arm']
	Daggers.RGrip.RGrip.Part0 = Character['Right Arm']
	
	Character:AddTag('HasDaggers')
end

function module:AddArms(Character: Model, MovesetName: string)
	local Humanoid = Character.Humanoid
	
	local Arms: Model = WeaponModels[MovesetName].HeianArmsModel:Clone()
	Arms.Parent = Character

	Arms.Torso.Anchored = false
	
	local weld = Instance.new("Motor6D", Character.Torso)
	weld.Part0 = Arms.Torso
	weld.Part1 = Character:WaitForChild("Torso")
	
	if Character:FindFirstChild("Shirt") then
		local shirt2 = Character:WaitForChild("Shirt"):Clone()
		shirt2.Parent = Arms
	end
	
	Arms["Left Arm"].Color = Character:WaitForChild("Left Arm").Color
	Arms["Right Arm"].Color = Character:WaitForChild("Right Arm").Color
	
	local Percentage = 1.3 -- 1 = normal, 0.5 = half your normal size, 2 = double your normal size
	
	if Character and Character:FindFirstChild("AppliedGrowth") == nil then
		local Motors = {}
		local NewMotors = {}
		local NewVal = Instance.new("BoolValue")
		NewVal.Name = "AppliedGrowth"
		NewVal.Parent = Character


		for i,v in pairs(Character.Torso:GetChildren()) do
			if v:IsA("Motor6D") then
				table.insert(Motors, v)
			end
		end
		table.insert(Motors, Character.HumanoidRootPart.RootJoint)

		for i,v in pairs(Motors) do

			local X, Y, Z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = v.C0:components()
			X = X * Percentage
			Y = Y * Percentage
			Z = Z * Percentage
			R00 = R00 * Percentage
			R01 = R01 * Percentage
			R02 = R02 * Percentage
			R10 = R10 * Percentage
			R11 = R11 * Percentage
			R12 = R12 * Percentage
			R20 = R20 * Percentage
			R21 = R21 * Percentage
			R22 = R22 * Percentage
			v.C0 = CFrame.new(X, Y, Z, R00, R01, R02, R10, R11, R12, R20, R21, R22)

			local X, Y, Z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = v.C1:components()
			X = X * Percentage
			Y = Y * Percentage
			Z = Z * Percentage
			R00 = R00 * Percentage
			R01 = R01 * Percentage
			R02 = R02 * Percentage
			R10 = R10 * Percentage
			R11 = R11 * Percentage
			R12 = R12 * Percentage
			R20 = R20 * Percentage
			R21 = R21 * Percentage
			R22 = R22 * Percentage
			v.C1 = CFrame.new(X, Y, Z, R00, R01, R02, R10, R11, R12, R20, R21, R22)

			table.insert(NewMotors, {v:Clone(), v.Parent})
			v:Destroy()
		end
		

		for _,v in pairs(Character:GetDescendants()) do
			if v:IsA("BasePart") then --(not v.Parent.Name) == "HeianArmsModel"
				if v:FindFirstChild("Heian") then
					v.Size = v.Size * 1.25
				else
                    v.Size = v.Size * Percentage
				end
				
			elseif v:IsA("SpecialMesh") and v.MeshType == Enum.MeshType.FileMesh then
				v.Scale = v.Scale * Percentage
			elseif v:IsA("Weld") and v.Name == "AccessoryWeld" then
				local X, Y, Z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = v.C0:components()
				X = X * Percentage
				Y = Y * Percentage
				Z = Z * Percentage
				R00 = R00 * Percentage
				R01 = R01 * Percentage
				R02 = R02 * Percentage
				R10 = R10 * Percentage
				R11 = R11 * Percentage
				R12 = R12 * Percentage
				R20 = R20 * Percentage
				R21 = R21 * Percentage
				R22 = R22 * Percentage
				v.C0 = CFrame.new(X, Y, Z, R00, R01, R02, R10, R11, R12, R20, R21, R22)
				local X, Y, Z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = v.C1:components()
				X = X * Percentage
				Y = Y * Percentage
				Z = Z * Percentage
				R00 = R00 * Percentage
				R01 = R01 * Percentage
				R02 = R02 * Percentage
				R10 = R10 * Percentage
				R11 = R11 * Percentage
				R12 = R12 * Percentage
				R20 = R20 * Percentage
				R21 = R21 * Percentage
				R22 = R22 * Percentage
				v.C1 = CFrame.new(X, Y, Z, R00, R01, R02, R10, R11, R12, R20, R21, R22)
			end
		end

		for i,v in pairs(NewMotors) do
			v[1].Parent = v[2]
		end
	end

	Character:AddTag('HasArms')
end

function module:RemoveWeapons(Character: Model)
	for _, Weapon: Model in Character:GetChildren() do
		if Weapon:HasTag('Weapon') then
			Weapon:Destroy()
		end
	end
	
	Character:RemoveTag('HasSword')
	Character:RemoveTag('HasDaggers')
	Character:RemoveTag('HasArms')
end

function module:TriggerSeath(Character: Model, State: boolean)
	local Sword: Model = Character.Sword
	if State ~= nil then
		Sword:SetAttribute('Seathed', State)
	else
		Sword:SetAttribute('Seathed', not Sword:GetAttribute('Seathed'))
	end

	if Sword:GetAttribute('Seathed') == true then
		if Sword:HasTag('CantSeath') then return end
		AnimationService:playAnimation(Character, SeathAnim)
		task.delay(.667, function()
			if not Character:FindFirstChild('Sword') then return end
			
			Sword.WeaponHold.MainSword.Enabled = false
			Sword.Seath.SwordsSeathWelds.Main.Enabled = true
		end)
	else
		Sword.Seath.SwordsSeathWelds.Main.Enabled = false
		Sword.WeaponHold.MainSword.Enabled = true
		
		
		if SeathTasks[Character] then
			task.cancel(SeathTasks[Character])
			SeathTasks[Character] = nil
		end
		
		SeathTasks[Character] = task.delay(15, function()
			if not Character:FindFirstChild('Sword') then return end
			
			module:TriggerSeath(Character, true)
		end)
	end
end

function module:TriggerTrail(Character: Model, State: boolean)
	local Sword: Model = Character.Sword
	if State ~= nil then
		for _, Trail: Trail in Sword:GetDescendants() do
			if Trail:IsA('Trail') then
				Trail.Enabled = State
			end
		end
	else
		for _, Trail: Trail in Sword:GetDescendants() do
			if Trail:IsA('Trail') then
				Trail.Enabled = not Trail.Enabled
			end
		end
	end
end

function module:AddAwakeningSword(Character: Model)
	local Sword = Character:FindFirstChild('Sword')
	if not Sword then return end
	
	
	TriggerTransparency(Sword.Main, true)
	TriggerTransparency(Sword.AwakeningMain, false)
end

function module:RemoveAwakeningSword(Character: Model)
	local Sword = Character:FindFirstChild('Sword')
	if not Sword then return end


	TriggerTransparency(Sword.Main, false)
	TriggerTransparency(Sword.AwakeningMain, true)
end


return module