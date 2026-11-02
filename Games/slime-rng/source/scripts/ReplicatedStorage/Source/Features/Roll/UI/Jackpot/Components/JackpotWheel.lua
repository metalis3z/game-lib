-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: JackpotWheel, time of decompilation: Sun May  3 10:11:51 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Vide = require(ReplicatedStorage.Packages.Vide)
local SoundController = require(ReplicatedStorage.Source.Core.Platform.SoundController)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local JackpotWheelOption = require(script.Parent.JackpotWheelOption)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local Sounds = require(ReplicatedStorage.Source.Game.AssetIds.Sounds)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

return function(t1: {[any]: any}) -- line: 50
	-- upvalues: Vide (copy), Sounds (copy), SoundController (copy), RunService (copy), JackpotWheelOption (copy), Frame (copy), ImageLabel (copy), ImageIds (copy)
	local v18 = t1.zIndex or 1
	local v19 = t1.scale or 1
	local v20 = Vide.source(0)
	local v21 = Vide.source(0)
	local v22 = Vide.spring(v21, 0.32, 0.72)
	local u23 = nil
	local v24 = math.random(6, 7) * 360 + (360 - ((t1.spinData.rewardIndex - 1) * 60 + 30)) % 360
	local v25 = math.floor(v24 / 60)
	local u26 = false
	local u27 = false

	local function triggerTick() -- line: 62
		-- upvalues: t1 (copy), Sounds (copy), SoundController (copy), v21 (copy), u23 (ref)
		if t1.playTickSounds ~= false then
			local v37 = table.clone(Sounds.ui.spinnerTick)

			v37.PlaybackSpeed = 0.98 + math.random() * 0.08
			SoundController:Play(v37)
		end

		v21(-26)

		if u23 then
			task.cancel(u23)
		end

		u23 = task.delay(0.05, function() -- line: 74
			-- upvalues: v21 (copy), u23 (ref)
			v21(0)
			u23 = nil
		end)
	end

	Vide.effect(function() -- line: 80
		-- upvalues: RunService (copy), v24 (copy), v20 (copy), t1 (copy), triggerTick (copy), u27 (ref), v25 (copy), u26 (ref), Vide (copy), u23 (ref)
		local n1 = 0
		local elapsed = os.clock()
		local connection = nil

		connection = RunService.Heartbeat:Connect(function() -- line: 84
			-- upvalues: elapsed (copy), v24 (copy), v20 (copy), t1 (copy), n1 (ref), triggerTick (copy), u27 (ref), v25 (copy), u26 (ref), connection (ref)
			local v41 = math.clamp((os.clock() - elapsed) / 11.4075, 0, 1)
			local v42 = 1 - (1 - v41) ^ 4.55
			local v43 = v24 * v42

			v20(v43)

			if t1.onProgress then
				t1.onProgress(v41)
			end

			local v44 = math.floor(v43 / 60)

			while v44 > n1 do
				n1 += 1
				triggerTick()

				if not u27 and n1 >= v25 then
					u27 = true

					if t1.onFinalTick then
						t1.onFinalTick()
					end
				end
			end

			if v41 >= 1 and not u26 then
				u26 = true
				connection:Disconnect()
				t1.onComplete(t1.spinData.reward)
			end
		end)
		Vide.cleanup(function() -- line: 112
			-- upvalues: connection (ref), u23 (ref)
			connection:Disconnect()

			if u23 then
				task.cancel(u23)
				u23 = nil
			end
		end)
	end)

	local t2 = {}

	for v30, v31 in t1.spinData.options do
		local v32 = JackpotWheelOption
		local t3 = {
			reward = v31
		}
		local v34 = math.rad((v30 - 1) * 60 + 30 - 90)
		local v35 = math.cos(v34) * 0.31 + 0.5
		local v36 = math.sin(v34) * 0.31 + 0.5

		t3.position = UDim2.fromScale(v35, v36)
		t3.rotation = (v30 - 1) * 60 + 30
		t3.zIndex = v18 + 4
		table.insert(t2, v32(t3))
	end

	return Frame({
		Name = "JackpotWheel",
		Size = UDim2.fromOffset(650, 650),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = t1.position or UDim2.fromScale(0.5, 0.57),
		BackgroundTransparency = 1,
		ZIndex = v18,
		Vide.create("UIScale")({
			Scale = v19
		}),
		ImageLabel({
			Name = "WheelBack",
			Size = UDim2.fromScale(1, 1),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Image = ImageIds.spinnerBack,
			ZIndex = v18 + 1
		}),
		Frame({
			Name = "SpinnerInnerWrap",
			Size = UDim2.fromScale(0.775, 0.775),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Rotation = v20,
			BackgroundTransparency = 1,
			ZIndex = v18 + 2,
			ImageLabel({
				Name = "WheelInner",
				Size = UDim2.fromScale(1, 1),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Image = ImageIds.spinnerInner,
				ZIndex = v18 + 3
			}),
			t2
		}),
		ImageLabel({
			Name = "SpinnerTicker",
			Size = UDim2.fromOffset(76, 118),
			Position = UDim2.fromScale(0.5, 0.05),
			AnchorPoint = Vector2.new(0.5, 0.2),
			Image = ImageIds.spinnerTicker,
			Rotation = v22,
			ZIndex = v18 + 8
		})
	})
end
