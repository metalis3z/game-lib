local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("RunService")
game:GetService("Debris")

local TsunamiEventController = require(ReplicatedStorage.Controllers.TsunamiEventController)
local AnimalController = require(ReplicatedStorage.Controllers.AnimalController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local VFX = require(ReplicatedStorage.Shared.VFX)

local function v7()
end

local function getAnimalCFrame(input, t1: {[any]: any}?)
	local v25, v26

	if typeof(input) == "Instance" and input:IsA("Model") then
		v25 = input
		v26 = v25:GetPivot() * CFrame.new(0, v25:GetExtentsSize().Y * 0.5, 0)
	elseif typeof(input) == "string" then
		if ServerData.IsTsunamiServer() then
			local BrainrotCFrame

			BrainrotCFrame, v25 = TsunamiEventController:GetBrainrotCFrame(input)

			if not BrainrotCFrame or not v25 then
				return CFrame.identity
			end

			v26 = BrainrotCFrame * CFrame.new(0, v25:GetExtentsSize().Y * 0.5, 0)
		else
			local v27 = AnimalController:GetAnimals()[input]

			if not v27 then
				return CFrame.identity
			end

			v25 = v27.AnimalModel
			assert(v25)
			v26 = v25:GetPivot() * CFrame.new(0, v25:GetExtentsSize().Y * 0.5, 0)
		end
	else
		return CFrame.identity
	end

	if not v26 or not v25 then
		return CFrame.identity
	end

	if t1 and t1.top then
		return v26 * CFrame.new(0, v25:GetExtentsSize().Y * 0.5, 0)
	end

	if t1 and t1.bottom then
		v26 *= CFrame.new(0, -v25:GetExtentsSize().Y * 0.5, 0)
	end

	return v26
end

return {
	getAnimalModel = function(input)

		if typeof(input) == "Instance" and input:IsA("Model") then
			return input
		end

		if typeof(input) == "string" then
			if ServerData.IsTsunamiServer() then
				local _, v15 = TsunamiEventController:GetBrainrotCFrame(input)

				if not v15 then
					return nil
				end

				return v15
			end

			local v16 = AnimalController:GetAnimals()[input]

			if not v16 then
				return nil
			end

			return v16.AnimalModel
		end

		return nil
	end,
	getAnimalCFrame = getAnimalCFrame,
	getAnimalPosition = function(input, t2: {[any]: any}?)
		local v31, v32

		if typeof(input) == "Instance" and input:IsA("Model") then
			v31 = input
			v32 = v31:GetPivot().Position + Vector3.new(0, v31:GetExtentsSize().Y * 0.5, 0)
		elseif typeof(input) == "string" then
			if ServerData.IsTsunamiServer() then
				local BrainrotCFrame

				BrainrotCFrame, v31 = TsunamiEventController:GetBrainrotCFrame(input)

				if not BrainrotCFrame or not v31 then
					return (Vector3.new(0, 0, 0))
				end

				v32 = BrainrotCFrame.Position + Vector3.new(0, v31:GetExtentsSize().Y * 0.5, 0)
			else
				local v33 = AnimalController:GetAnimals()[input]

				if not v33 then
					return (Vector3.new(0, 0, 0))
				end

				v32 = v33.AnimalModel:GetPivot().Position
				v31 = v33.AnimalModel
			end
		else
			return (Vector3.new(0, 0, 0))
		end

		if not v32 or not v31 then
			return (Vector3.new(0, 0, 0))
		end

		if t2 and t2.top then
			return v32 + Vector3.new(0, v31:GetExtentsSize().Y * 0.5, 0)
		end

		if t2 and t2.bottom then
			v32 -= Vector3.new(0, v31:GetExtentsSize().Y * 0.5, 0)
		end

		return v32
	end,
	getAnimalRootPart = function(input)
		local v20

		if typeof(input) == "Instance" and input:IsA("Model") then
			v20 = input
		elseif typeof(input) == "string" then
			if ServerData.IsTsunamiServer() then
				local _, v19 = TsunamiEventController:GetBrainrotCFrame(input)

				v20 = v19 or nil
			else
				local v21 = AnimalController:GetAnimals()[input]

				v20 = if v21 then v21.AnimalModel else nil
			end
		end

		if not v20 then
			return nil
		end

		return v20.PrimaryPart
	end,
	playBurst = function(p3, p4, t3: {[any]: any}?, p5)
		local v40, v42

		if typeof(p4) == "string" then
			if ServerData.IsTsunamiServer() then
				local _, v39 = TsunamiEventController:GetBrainrotCFrame(p4)

				v40 = v39 or nil
			else
				local v41 = AnimalController:GetAnimals()[p4]

				v40 = if v41 then v41.AnimalModel else nil
			end

			v42 = getAnimalCFrame(p4, p5)

			if not v40 or not v42 then
				return v7
			end

			p4 = v40.PrimaryPart

			if not p4 then
				return v7
			end
		elseif typeof(p4) == "CFrame" then
			v42 = p4
			p4 = nil
			v40 = workspace
		elseif typeof(p4) == "Vector3" then
			v42 = CFrame.new(p4)
			p4 = nil
			v40 = workspace
		else
			v42 = p4:GetPivot()
			v40 = p4 

			if p4:IsA("Model") then
				if p4.PrimaryPart then
					p4 = p4.PrimaryPart
				else
					local baseParts = {}
					for _, descendant in p4:GetDescendants() do
						if descendant:IsA("BasePart") then
							table.insert(baseParts, descendant)
						end
					end

					if #baseParts > 0 then
						p4 = baseParts[math.random(1, #baseParts)]
					else
						p4 = nil
					end
				end
			elseif not p4:IsA("BasePart") then
				p4 = nil 
			end
		end

		local clone = p3:Clone()

		if p5 and p5.modify then
			clone = p5.modify(clone)
		end

		clone.CanCollide = false
		clone.CanTouch = false
		clone.CanQuery = false
		clone.CastShadow = false
		clone:PivotTo(v42)

		if p4 ~= nil then
			clone.Anchored = false

			local WeldConstraint = Instance.new("WeldConstraint")

			WeldConstraint.Part0 = clone
			WeldConstraint.Part1 = p4
			WeldConstraint.Parent = clone
		else
			clone.Anchored = true
		end

		clone.Parent = v40
		VFX.emit(clone)
		task.delay(5, function()
			clone:Destroy()
		end)

		if t3 ~= nil then
			for _, v46 in t3 do
				SoundController:PlaySound(v46, v42.Position, false)
			end
		end

		return function()
			clone:Destroy()
		end
	end,
	resizeEffects = function(p6, n1: number)
		local p6Parent = p6.Parent
		local Model = Instance.new("Model")

		p6.Parent = Model
		Model:ScaleTo(n1)
		p6.Parent = p6Parent
		Model:Destroy()
	end
}