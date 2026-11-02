

local v1 = game:GetService("Players")
local u2 = game:GetService("RunService")
local u3 = game:GetService("CollectionService")
local u4 = game:GetService("MarketplaceService")
local u5 = game:GetService("SoundService")
local v6 = game:GetService("ReplicatedStorage")
local u7 = require(v6:WaitForChild("EventsConfig"))
local u8 = require(v6:WaitForChild("ClientState"))
local v9 = {}
local u10 = v1.LocalPlayer
local function u12(p11) 

	return u3:GetTagged(p11)
end
local function u15(p13) 

	local u14 = Instance.new("Sound")
	u14.SoundId = p13
	u14.RollOffMaxDistance = 0
	u14.Parent = u5
	u14:Play()
	u14.Ended:Connect(function()

		u14:Destroy()
	end)
end
local function u19() 

	local v16 = os.time()
	for _, v17 in ipairs(u7.Events) do
		if v17.Start <= v16 and v16 < v17.End then
			for _, v18 in ipairs(u7.CurrenciesRadar or {}) do
				if v18.Event == v17.Name then
					return v18
				end
			end
		end
	end
	return nil
end
local u20 = false
local u21 = false
local function u25() 

	u21 = false
	u20 = false
	for _, v22 in ipairs(u12("GoldenEggRadar")) do
		v22.Visible = false
	end
	for _, v23 in ipairs(u12("GoldenEggRadarArrow")) do
		v23.Image = "rbxassetid://84022142264855"
		v23.Rotation = 0
	end
	for _, v24 in ipairs(u12("GoldenEggRadarDist")) do
		v24.Text = "No egg..."
	end
end
local function u66() 

	if not u20 then
		u20 = true
		u21 = true
		local u26 = nil
		for _, v27 in ipairs(u12("GoldenEggRadar")) do
			v27.Visible = true
		end
		u8:RegisterModalListener(function(p28)

			if u21 then
				local v29 = not p28
				for _, v30 in ipairs(u12("GoldenEggRadar")) do
					v30.Visible = v29
				end
			end
		end)
		u3:GetInstanceAddedSignal("GoldenEggRadar"):Connect(function(p31)

			p31.Visible = u8.ActiveModal == nil
		end)
		u3:GetInstanceAddedSignal("Rarity1Coin"):Connect(function(p32)

			u26 = p32
			for _, v33 in ipairs(u12("GoldenEggRadarArrow")) do
				v33.Image = "rbxassetid://123139547868771"
			end
			for _, _ in ipairs(u12("GoldenEggRadarDist")) do

			end
			u15("rbxassetid://105044658147672")
		end)
		u3:GetInstanceRemovedSignal("Rarity1Coin"):Connect(function(p34)

			if u26 == p34 then
				u26 = nil
				for _, v35 in ipairs(u12("GoldenEggRadarArrow")) do
					v35.Image = "rbxassetid://84022142264855"
					v35.Rotation = 0
				end
				for _, v36 in ipairs(u12("GoldenEggRadarDist")) do
					v36.Text = "No egg..."
				end
				u15("rbxassetid://130842421411875")
			end
		end)
		local v37 = u3:GetTagged("Rarity1Coin")
		if #v37 > 0 then
			u26 = v37[1]
			for _, v38 in ipairs(u12("GoldenEggRadarArrow")) do
				v38.Image = "rbxassetid://123139547868771"
			end
			for _, _ in ipairs(u12("GoldenEggRadarDist")) do

			end
		else
			for _, v39 in ipairs(u12("GoldenEggRadarArrow")) do
				v39.Image = "rbxassetid://84022142264855"
				v39.Rotation = 0
			end
			for _, v40 in ipairs(u12("GoldenEggRadarDist")) do
				v40.Text = "No egg..."
			end
		end
		u2.Heartbeat:Connect(function()

			if u21 then
				if u26 and not u26.Parent then
					u26 = nil
					for _, v41 in ipairs(u12("GoldenEggRadarArrow")) do
						v41.Image = "rbxassetid://84022142264855"
						v41.Rotation = 0
					end
					for _, v42 in ipairs(u12("GoldenEggRadarDist")) do
						v42.Text = "No egg..."
					end
				end
				if u26 then
					local v43 = u10.Character
					if v43 then
						local v44 = v43:FindFirstChild("HumanoidRootPart")
						if v44 then
							local v45 = u26
							local v46
							if v45:IsA("Model") then
								v46 = v45:GetPivot().Position
							else
								v46 = v45.Position
							end
							local v47 = v44.Position
							local v48 = workspace.CurrentCamera.CFrame
							local v49 = v48.LookVector.X
							local v50 = v48.LookVector.Z
							local v51 = Vector3.new(v49, 0, v50).Unit
							local v52 = v48.RightVector.X
							local v53 = v48.RightVector.Z
							local v54 = Vector3.new(v52, 0, v53).Unit
							local v55 = v46.X - v47.X
							local v56 = v46.Z - v47.Z
							local v57 = Vector3.new(v55, 0, v56).Unit
							local v58 = v57:Dot(v54)
							local v59 = v57:Dot(v51)
							local v60 = math.atan2(v58, v59)
							local v61 = math.deg(v60)
							for _, v62 in ipairs(u12("GoldenEggRadarArrow")) do
								v62.Rotation = v61
							end
							local v63 = (v46 - v47).Magnitude
							local v64 = math.floor(v63)
							for _, v65 in ipairs(u12("GoldenEggRadarDist")) do
								v65.Text = v64 .. " studs"
							end
						end
					else
						return
					end
				else
					return
				end
			else
				return
			end
		end)
	end
end
function v9.Init(_) 

	local v67 = u19()
	if v67 then
		local u68 = v67.Gamepass or 0
		if u68 == 0 then
			u66()
		else
			local v69, v70 = pcall(function()

				return u4:UserOwnsGamePassAsync(u10.UserId, u68)
			end)
			if v69 and v70 then
				u66()
			end
		end
	end
	u4.PromptGamePassPurchaseFinished:Connect(function(_, p71, p72)

		if p72 then
			local v73 = u19()
			if v73 and (v73.Gamepass == 0 or v73.Gamepass == p71) then
				u66()
			end
		end
	end)
	local v74 = os.time()
	for _, v75 in ipairs(u7.Events) do
		for _, u76 in ipairs(u7.CurrenciesRadar or {}) do
			if u76.Event == v75.Name then
				if v75.Start <= v74 and v74 < v75.End then
					task.delay(v75.End - v74, u25)
				elseif v74 < v75.Start then
					task.delay(v75.Start - v74, function()

						local u77 = u76.Gamepass or 0
						if u77 == 0 then
							u66()
						else
							local v78, v79 = pcall(function()

								return u4:UserOwnsGamePassAsync(u10.UserId, u77)
							end)
							if v78 and v79 then
								u66()
							end
						end
					end)
					task.delay(v75.End - v74, u25)
				end
				break
			end
		end
	end
end
return v9