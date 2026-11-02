-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Library = game:GetService("ReplicatedStorage"):WaitForChild("Library")
local Functions = require(Library.Functions)
local Audio = require(Library.Audio)

return {
	Play = function(p1) --[[ Play | Line: 45 | Upvalues: Functions (copy), Audio (copy) ]]
		local v1 = p1.Duration or 3
		local v2 = p1.VolumeScale or 1
		local v3 = p1.RateScale or 1
		local v4 = p1.SpeedScale or 1
		local v5 = p1.SizeScale or 1
		local isPopUp = p1.PopUp == true
		local v6 = if p1.ManualEmitMode == true then true else false
		local v7 = p1.ManualEmitAmount or 1
		local v8 = p1.Drag or 2.65
		local Part = Instance.new("Part")

		Part.Anchored = true
		Part.CanCollide = false
		Part.CanQuery = false
		Part.CanTouch = false
		Part.Transparency = 1

		local v9, v10 = Functions.ComputeScreenSpacePart(10, 2)

		Part.CFrame = v9
		Part.Size = v10

		local v11 = Functions.Scaler()
		local list = {}
		local v12 = 0

		for i, v in ipairs(p1.Particles) do
			local v13 = script:WaitForChild("ParticleEmitter"):Clone()

			v13.Texture = v.Texture

			if v.LightEmission then
				v13.LightEmission = v.LightEmission
			end

			if v.LightInfluence then
				v13.LightInfluence = v.LightInfluence
			end

			if v.SizeScalar then
				v13.Size = Functions.ScaleNumberSequence(v13.Size, v.SizeScalar)
			end

			table.insert(list, v13)

			local v15 = math.max(v12, v13.Lifetime.Max / v13.TimeScale)

			v13.ZOffset = v13.ZOffset + (math.random() * 2 - 1) * 0.1
			v13.Rate = Functions.FixParticleRate(v13.Rate * v3 / #p1.Particles, Part.Position)

			local Speed = v13.Speed

			v13.Speed = p1.SpeedOverride or NumberRange.new(Speed.Min * v4, Speed.Max * v4)

			if v5 ~= 1 then
				v11(v13, v5)
			end

			if p1.DragOverride then
				v13.Drag = p1.DragOverride
			end

			v13.Enabled = false
			v13.Parent = Part
			v12 = v15
		end

		Part.Parent = workspace.CurrentCamera

		local v17 = 0
		local v18 = false

		if v6 then
			for i, v in ipairs(list) do
				local v19 = v:Clone()

				v19.EmissionDirection = Enum.NormalId.Bottom
				v19.Speed = NumberRange.new(-30, -20)
				v19.Drag = v8
				v19.Parent = Part
				task.delay(math.random() * 0.35, function() --[[ Line: 146 | Upvalues: v19 (copy), v7 (copy) ]]
					v19:Emit(v7)
				end)
			end

			if v2 > 0 then
				local SprinkleSounds = p1.SprinkleSounds

				if SprinkleSounds then
					Audio.Play(SprinkleSounds.Assets, workspace.CurrentCamera, SprinkleSounds.Pitch, SprinkleSounds.Volume)
				end
			end
		elseif isPopUp then
			v17 = 0.75

			for i, v in ipairs(list) do
				local v21 = math.round((v:GetAttribute("EmitCount") or 0) * v3)

				if v21 > 0 then
					local v22 = v:Clone()

					v22.EmissionDirection = Enum.NormalId.Bottom
					v22.Speed = NumberRange.new(-30, -20)
					v22.Drag = v8
					v22.Parent = Part
					v22:Emit(v21)
				end
			end

			if v2 > 0 then
				local PopSounds = p1.PopSounds

				if PopSounds then
					Audio.Play(PopSounds.Assets, workspace.CurrentCamera, PopSounds.Pitch, PopSounds.Volume)
				end
			end
		else
			v18 = true

			for i, v in ipairs(list) do
				v.Enabled = true
			end

			if v2 > 0 then
				local SprinkleSounds = p1.SprinkleSounds

				if SprinkleSounds then
					Audio.Play(SprinkleSounds.Assets, workspace.CurrentCamera, SprinkleSounds.Pitch, SprinkleSounds.Volume)
				end
			end
		end

		Functions.RenderStepped(function(p12, p2) --[[ Line: 162 | Upvalues: Functions (ref), Part (copy), v6 (copy), v17 (ref), v1 (copy), v18 (ref), v2 (copy), p1 (copy), Audio (ref), list (copy) ]]
			local v12, v22 = Functions.ComputeScreenSpacePart(10, 2)

			Part.CFrame = v12
			Part.Size = v22

			if v6 then
				return
			end

			local v3 = v17 <= p2 and p2 < v17 + v1

			if v18 == v3 then
				return
			end

			v18 = v3

			if v2 > 0 and v3 then
				local SprinkleSounds = p1.SprinkleSounds

				if SprinkleSounds then
					Audio.Play(SprinkleSounds.Assets, workspace.CurrentCamera, SprinkleSounds.Pitch, SprinkleSounds.Volume)
				end
			end

			for i, v in ipairs(list) do
				v.Enabled = v3
			end
		end, v17 + v1 + v12):Then(function() --[[ Line: 189 | Upvalues: Part (copy) ]]
			Part:Destroy()
		end)
	end
}