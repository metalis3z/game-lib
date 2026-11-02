
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ClientEventUtils = require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)
local CreateTween = require(ReplicatedStorage.Packages.CreateTween)
local Observers = require(ReplicatedStorage.Packages.Observers)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Net = require(ReplicatedStorage.Packages.Net)
local UFO = ReplicatedStorage.Models.Events.UFO.UFO
local v9 = Net:RemoteEvent("EventService/UFO/AbductionBurst")
local t2 = {
	Start = function(_)
		local v12 = Trove.new()

		v12:Add(Observers.observeTag("EggrotUFO", function(p2)
			if not p2:IsA("BasePart") then
				return nil
			end

			local v14 = v12:Extend()
			local clone = v14:Clone(UFO)

			for _, descendant in clone:GetDescendants() do
				if descendant:IsA("BasePart") then
					descendant.Anchored = true
					descendant.CanCollide = false
					descendant.CanQuery = false
					descendant.CanTouch = false
				end
			end

			local clone2 = ReplicatedStorage.Sounds.Events.UFO.Flying:Clone()

			clone2.Parent = p2
			clone2:Play()
			clone.Parent = workspace

			local BeamPart = clone:FindFirstChild("BeamPart", true)
			local v20 = BeamPart and BeamPart:FindFirstChild("att0")
			local v21 = BeamPart and BeamPart:FindFirstChild("att1")

			if not BeamPart or not v20 or not v21 or not v20:IsA("Attachment") or not v21:IsA("Attachment") then
				v14:Destroy()

				return nil
			end

			local t1 = {}

			for _, child in v21:GetChildren() do
				if child:IsA("Beam") then
					child.Attachment0 = v20
					child.Attachment1 = v21
					child.Enabled = false
					table.insert(t1, child)
				end
			end

			local Position = v21.Position
			local u26 = nil

			local function stopTween()
				if u26 then
					u26:Cancel()
					u26 = nil
				end
			end
			local function setBeams(b1: boolean)
				for _, v36 in t1 do
					v36.Enabled = b1
				end
			end
			local function tweenAtt1(vector3: Vector3, n1: number)
				if u26 then
					u26:Cancel()
					u26 = nil
				end

				u26 = CreateTween(v21, TweenInfo.new(n1, Enum.EasingStyle.Quad), {
					Position = vector3
				})

				return u26
			end
			local function setState(s1: string)
				if s1 == "down" then
					local clone3 = ReplicatedStorage.Sounds.Events.UFO.Abducting:Clone()

					clone3.Parent = p2
					clone3:Play()

					for _, v42 in t1 do
						v42.Enabled = true
					end

					v21.Position = v20.Position

					local v43 = Position

					if u26 then
						u26:Cancel()
						u26 = nil
					end

					u26 = CreateTween(v21, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
						Position = v43
					})

					return
				end

				if s1 == "off" then
					local Position2 = v20.Position

					if u26 then
						u26:Cancel()
						u26 = nil
					end

					u26 = CreateTween(v21, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
						Position = Position2
					})

					local v45 = u26

					if v45 then
						v45.Completed:Wait()
					end

					for _, v47 in t1 do
						v47.Enabled = false
					end

					v21.Position = Position
				end
			end

			v14:Add(p2:GetAttributeChangedSignal("BeamState"):Connect(function()
				local BeamState = p2:GetAttribute("BeamState")

				if typeof(BeamState) == "string" then
					setState(BeamState)
				end
			end))
			v14:Add(RunService.PostSimulation:Connect(function()
				if clone.PrimaryPart ~= nil and p2.Parent ~= nil then
					clone:PivotTo(p2.CFrame)

					return
				end

				v14:Destroy()
			end))
			v14:Add(stopTween)
			v14:Add(task.spawn(function()
				local BeamState = p2:GetAttribute("BeamState")

				if typeof(BeamState) == "string" then
					setState(BeamState)

					return
				end

				for _, v51 in t1 do
					v51.Enabled = false
				end

				v21.Position = Position
			end))

			return function()
				v14:Destroy()
			end
		end, { workspace }))
		v12:Add(v9.OnClientEvent:Connect(function(vector3: Vector3)
			local Effects = ReplicatedStorage.Controllers.EventController.Events.UFO:FindFirstChild("Effects")

			if Effects then
				local ufoemit = Effects:FindFirstChild("ufoemit")

				if ufoemit then
					ClientEventUtils.playBurst(ufoemit, vector3, { ReplicatedStorage.Sounds.Events.UFO.Burst })
				end
			end
		end))

		return function()
			v12:Destroy()
		end
	end
}

return table.freeze(t2)
