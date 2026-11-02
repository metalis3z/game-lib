--credit to leon games studio
return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 6 ]]
		local v1 = Random.new(p2)
		local t = {}

		for v2, v3 in p1:GetDescendants() do
			if v3:IsA("BasePart") then
				local v4 = tostring(v3.Color)

				if not t[v4] then
					local v5, v6, v7 = v3.Color:ToHSV()

					t[v4] = Color3.fromHSV((v5 + v1:NextNumber(-0.05, 0.05)) % 1, math.clamp(v6 + v1:NextNumber(-0.15, 0.15), 0, 1), (math.clamp(v7 + v1:NextNumber(-0.15, 0.15), 0, 1)))
				end

				v3.Color = t[v4]
			end
		end

		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 27 ]]
		local PrimaryPart = p1.PrimaryPart
		local t = {}

		for v1, v2 in p1:GetDescendants() do
			local v4 = tonumber(v2.Name)

			if v2:IsA("BasePart") and v4 then
				local v5 = v2:GetAttribute("OG_Transparency")

				if v5 == nil then
					v5 = v2.Transparency
				end

				if v2.Material == Enum.Material.Neon then
					v5 = 0.5
				end

				v2:SetAttribute("OG_Transparency", v5)

				local t2 = {}

				for v6, v7 in v2:GetChildren() do
					if v7:IsA("Texture") or v7:IsA("Decal") then
						table.insert(t2, {
							instance = v7,
							originalTransparency = v7.Transparency
						})
						v7.Transparency = 1
					end
				end

				table.insert(t, {
					v2,
					v2.Size,
					PrimaryPart.CFrame:ToObjectSpace(v2.CFrame),
					v4,
					v5,
					t2
				})
				v2.CanCollide = false
				v2.Transparency = 1
			end
		end

		local function updateGrowth() --[[ updateGrowth | Line: 65 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
			local v1 = p1:GetAttribute("Age") or 0

			p1:GetAttribute("MaxAge")

			for v2, v3 in t do
				local v4 = v3[1]
				local v5 = v3[2]
				local v6 = v3[3]
				local v8 = v3[5]
				local v9 = v3[6]
				local v10 = math.min(v1 - v3[4], 1)

				if v10 > 0 then
					v4.Size = Vector3.new(v5.X, v5.Y * v10, v5.Z)
					v4.CFrame = PrimaryPart.CFrame * v6 * CFrame.new(0, (v4.Size.Y - v5.Y) / 2, 0)
					v4.Transparency = v8
					v4.CanCollide = true

					for v12, v13 in v9 do
						v13.instance.Transparency = v13.originalTransparency
					end

					continue
				end

				v4.Transparency = 1
				v4.CanCollide = false

				for v14, v15 in v9 do
					v15.instance.Transparency = 1
				end
			end

			if not game.Players.LocalPlayer or (not game:GetService("RunService"):IsClient() or (p1:GetAttribute("playedSfx") or not (p1:GetAttribute("MaxAge") <= v1))) then
				return
			end

			p1:SetAttribute("playedSfx", true)
			game.SoundService:PlayLocalSound(game.SoundService.SFX.Happy)
		end

		p1:GetAttributeChangedSignal("Age"):Connect(updateGrowth)
		updateGrowth()
	end,
	Extras = {}
}