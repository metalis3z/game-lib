-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local Observers = require(ReplicatedStorage.Packages.Observers)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Animals = require(ReplicatedStorage.Shared.Animals)
local WorldBrainrotController = require(ReplicatedStorage.Controllers.WorldBrainrotController)
local _ = Players.LocalPlayer
local t1 = {
	StartDroppedBrainrotRendering = function(_)
		WorldBrainrotController:RenderPool({
			PoolId = "Steal/DroppedBrainrots",
			ReplicatorId = "Steal/DroppedBrainrots",
			ShowTimer = false,
			ShowDropButton = false,
			GrabHoldDuration = 2,
			GrabMaxDistance = 10
		})
	end,
	StartGrabbedBrainrotRendering = function(_)
		local AnimalOverhead = ReplicatedStorage.Overheads.AnimalOverhead

		Observers.observeTag("ClientRenderBrainrot", function(p3)
			local v15 = assert(p3:GetAttribute("__render_brainrot"))
			local v16 = Trove.new()
			local u17 = nil
			local v18 = v16:Extend()

			local function renderOverhead()
				v18:Clean()

				if not u17 then
					return
				end

				if not p3:GetAttribute("__render_overhead") then
					return
				end

				local OVERHEAD_ATTACHMENT = u17:FindFirstChild("OVERHEAD_ATTACHMENT", true)

				if not OVERHEAD_ATTACHMENT then
					OVERHEAD_ATTACHMENT = v18:Add(Instance.new("Attachment"))

					local ExtentsSize = u17:GetExtentsSize()

					OVERHEAD_ATTACHMENT.CFrame = CFrame.new(0, ExtentsSize.Y * 0.5, 0)
					OVERHEAD_ATTACHMENT.Parent = u17.PrimaryPart
				end

				local clone = v18:Clone(AnimalOverhead)
				local __render_stolen = p3:GetAttribute("__render_stolen")

				if __render_stolen ~= nil then
					for _, v29 in clone:GetChildren() do
						if v29:IsA("TextLabel") then
							if v29.Name == "Stolen" then
								v29.Visible = __render_stolen
							else
								v29.Visible = false
							end
						end
					end
				end

				clone.Parent = OVERHEAD_ATTACHMENT
			end

			local v20 = v16:Extend()

			local function renderBrainrot()
				v20:Clean()

				local v30 = assert(p3:GetAttribute("__render_animation"))
				local __render_mutation = p3:GetAttribute("__render_mutation")

				local rawTraits = p3:GetAttribute("__render_traits")
				local data = {}
				if rawTraits and rawTraits ~= "" then
					local success, result = pcall(HttpService.JSONDecode, HttpService, rawTraits)
					if success then
						data = result
					else
						warn("StealController: Failed to parse __render_traits:", rawTraits)
					end
				end

				local AnimatedModel = Animals:GetAnimatedModel(v15, v30)

				if not AnimatedModel then
					return
				end

				if not AnimatedModel.PrimaryPart then
					warn(`Brainrot has no primary part: { v15 }`)
					AnimatedModel:Destroy()
					return
				end

				u17 = AnimatedModel
				v20:Add(function()
					u17 = nil
				end)
				v20:Add(AnimatedModel)

				local v34 = v20:Add(Instance.new("Weld"))
				v34.Part0 = AnimatedModel.PrimaryPart
				v34.Part1 = p3
				v34.C0 = AnimatedModel.PrimaryPart.CFrame:Inverse() * AnimatedModel:GetPivot()
				v34.Parent = AnimatedModel.PrimaryPart

				if __render_mutation then
					v20:Add(Animals:ApplyMutation(AnimatedModel, v15, __render_mutation))
				end

				if data and next(data) then
					v20:Add(Animals:ApplyTraits(AnimatedModel, v15, data))
				end

				renderOverhead()
			end

			local u22 = nil

			local function queueRenderBrainrot()
				if u22 then
					return
				end

				u22 = v16:Add(task.defer(function()
					if u22 then
						v16:Pop(u22)
						u22 = nil
					end

					renderBrainrot()
				end))
			end

			v16:Add(p3:GetAttributeChangedSignal("__render_animation"):Connect(queueRenderBrainrot))
			v16:Add(p3:GetAttributeChangedSignal("__render_mutation"):Connect(queueRenderBrainrot))
			v16:Add(p3:GetAttributeChangedSignal("__render_traits"):Connect(queueRenderBrainrot))

			if not u22 then
				u22 = v16:Add(task.defer(function()
					if u22 then
						v16:Pop(u22)
						u22 = nil
					end

					renderBrainrot()
				end))
			end

			v16:Add(p3:GetAttributeChangedSignal("__render_overhead"):Connect(renderOverhead))
			v16:Add(p3:GetAttributeChangedSignal("__render_stolen"):Connect(renderOverhead))

			return v16:WrapClean()
		end)
	end
}

function t1.Start(_)
	task.spawn(t1.StartDroppedBrainrotRendering, t1)
	task.spawn(t1.StartGrabbedBrainrotRendering, t1)
end

return t1
