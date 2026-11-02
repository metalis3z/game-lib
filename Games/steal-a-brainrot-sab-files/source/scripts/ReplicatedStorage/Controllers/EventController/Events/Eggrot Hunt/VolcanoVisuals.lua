
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = require(ReplicatedStorage.Packages.Net)
local Observers = require(ReplicatedStorage.Packages.Observers)
local Trove = require(ReplicatedStorage.Packages.Trove)
local VFX = require(ReplicatedStorage.Shared.VFX)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)

require(ReplicatedStorage.Controllers.WorldBrainrotController)

local v8 = Net:RemoteEvent("EggrotHunt/VolcanoLaunch")
local t4 = {
	Start = function(_: {[any]: any}, t2: {[any]: any})
		local v12 = Trove.new()
		local Animator = nil
		local u14 = nil
		local EruptionVFX = nil
		local RippleVFX = nil
		local u17 = nil
		local Position = nil

		v12:Add(Observers.observeTag("EggrotVolcanoMachine", function(p1)
			local AnimatedEggSequences = (p1.Parent or p1):FindFirstChild("AnimatedEggSequences", true)

			if not AnimatedEggSequences then
				return
			end

			local MutateSequence = AnimatedEggSequences:FindFirstChild("MutateSequence")

			if not MutateSequence then
				return
			end

			local AnimationController = MutateSequence:FindFirstChild("AnimationController")

			if AnimationController then
				Animator = AnimationController:FindFirstChild("Animator")
			end

			local Anchor = MutateSequence:FindFirstChild("Anchor")

			u17 = Anchor and Anchor:FindFirstChild("VFX")

			local Egg = MutateSequence:FindFirstChild("Egg")

			if Egg and Egg:IsA("BasePart") then
				u14 = Egg
			end

			EruptionVFX = MutateSequence:FindFirstChild("EruptionVFX")
			RippleVFX = AnimatedEggSequences:FindFirstChild("RippleVFX")
			Position = p1:GetPivot().Position

			return function()
				Animator = nil
				u14 = nil
				EruptionVFX = nil
				RippleVFX = nil
				u17 = nil
				Position = nil
			end
		end, { workspace }))
		v12:Add(v8.OnClientEvent:Connect(function(s1: string, _: CFrame, _: CFrame, _: number)
			local v29 = Animator
			local v30 = u14
			local u31 = true
			local u32 = nil
			local u33 = nil
			local t3 = {}
			local u35 = nil

			local function cleanup()
				if u35 then
					v12:Pop(u35)
				end

				if u33 then
					u33:Disconnect()
					u33 = nil
				end

				for _, v40 in t3 do
					v40.Anchored = false
				end

				table.clear(t3)

				if u32 then
					u32:Stop(0)
					u32:Destroy()
					u32 = nil
				end

				if u17 then
					VFX.disable(u17)
				end
			end

			if v29 then
				local track = v29:LoadAnimation(script.Sequence)

				u32 = track
				track.Looped = false
				track:GetMarkerReachedSignal("VFX_Start"):Once(function()
					if u17 then
						VFX.enable(u17)
					end
				end)
				track:GetMarkerReachedSignal("Erupt"):Once(function()
					if EruptionVFX then
						VFX.emit(EruptionVFX)
					end

					if Position then
						SoundController:PlaySound("Sounds.Events.Easter.VolcanoEruption", Position, false)
					end
				end)
				track:GetMarkerReachedSignal("Ripple"):Once(function()
					if RippleVFX then
						VFX.emit(RippleVFX)
					end

					if Position then
						SoundController:PlaySound("Sounds.Events.Easter.VolcanoRipple", Position, false)
					end
				end)
				track:GetMarkerReachedSignal("VFX_Stop"):Once(function()
					if u17 then
						VFX.disable(u17)
					end

					u31 = false
					track:Stop(0)
				end)
				track:Play(0)
			end

			if not v30 then
				return
			end

			local function anchorModel(p2)
				for _, v43 in p2:QueryDescendants("BasePart [Anchored = false]") do
					v43.Anchored = true
					table.insert(t3, v43)
				end
			end

			RunService.PostSimulation:Connect(function()
				if not u31 then
					cleanup()

					return
				end

				local v44 = t2[s1]

				if not v44 or not v44.model then
					return
				end

				if #t3 == 0 then
					for _, v46 in v44.model:QueryDescendants("BasePart [Anchored = false]") do
						v46.Anchored = true
						table.insert(t3, v46)
					end
				end

				v44.model:PivotTo(v30:GetPivot())
			end)
			u35 = v12:Add(cleanup)
		end))

		return function()
			v12:Destroy()
		end
	end
}

return table.freeze(t4)
