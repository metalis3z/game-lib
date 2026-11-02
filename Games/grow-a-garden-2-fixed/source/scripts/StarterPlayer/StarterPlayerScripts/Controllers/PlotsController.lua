--credit to quartz games studio
local t = {}
local LocalPlayer = game.Players.LocalPlayer

game:GetService("TweenService")

local Gardens = workspace:WaitForChild("Gardens")
local Networking = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("Networking"))
local ExpansionPrices = require(game.ReplicatedStorage.SharedData.ExpansionPrices)
local GardenFlags = require(game.ReplicatedStorage.SharedModules.Flags.GardenFlags)
local NumberUtils = require(game.ReplicatedStorage.SharedModules.NumberUtils)
local PlayerStateClient = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("PlayerStateClient"))
local Controllers = game.StarterPlayer.StarterPlayerScripts.Controllers
local FlashbangVFXController = require(Controllers.FlashbangVFXController)

require(Controllers.NotificationController)

local v1 = require("./SfxController")

function t.Init(p1) --[[ Init | Line: 15 ]] end

local t2 = {}
local t3 = {}
local v2 = nil

local function disconnectExpandSignConnections() --[[ disconnectExpandSignConnections | Line: 22 | Upvalues: t3 (copy) ]]
	for v1, v2 in t3 do
		v2:Disconnect()
	end

	table.clear(t3)
end

local function clearExpandSignGui() --[[ clearExpandSignGui | Line: 29 | Upvalues: t3 (copy), v2 (ref) ]]
	for v1, v22 in t3 do
		v22:Disconnect()
	end

	table.clear(t3)

	if not v2 then
		return
	end

	v2:Destroy()
	v2 = nil
end

local function getExpandSignTemplate(p1) --[[ getExpandSignTemplate | Line: 37 ]]
	local SurfaceGui = p1:FindFirstChild("SurfaceGui")

	if SurfaceGui and (SurfaceGui:IsA("BillboardGui") or SurfaceGui:IsA("SurfaceGui")) then
		return SurfaceGui
	end

	for v1, v2 in p1:GetChildren() do
		if v2:IsA("BillboardGui") or v2:IsA("SurfaceGui") then
			return v2
		end
	end

	return nil
end

local function setExpandSignModelVisible(p1, p2) --[[ setExpandSignModelVisible | Line: 52 ]]
	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("BasePart") then
			v2.Transparency = if p2 then 0 else 1
			v2.CanCollide = p2

			continue
		end

		if v2:IsA("Decal") then
			v2.Transparency = if p2 then 0 else 1

			continue
		end

		if v2:IsA("SurfaceGui") or v2:IsA("BillboardGui") then
			v2.Enabled = p2
		end
	end
end

local function getNextExpansionData(p1) --[[ getNextExpansionData | Line: 65 | Upvalues: ExpansionPrices (copy) ]]
	return ExpansionPrices[p1 + 1]
end

local function getNextExpansionPrice(p1, p2) --[[ getNextExpansionPrice | Line: 70 | Upvalues: GardenFlags (copy) ]]
	return GardenFlags.ExpansionPriceOverrides:Get()[tostring(p1 + 1)] or p2.Price
end

local Night = game.ReplicatedStorage.Night
local NotificationController = require(game.StarterPlayer.StarterPlayerScripts.Controllers.NotificationController)
local isPlaceType = require(game.ReplicatedStorage.SharedModules.Environment).placeType == "FirstSession"
local tbl = {}

local function UpdateTag(p1) --[[ UpdateTag | Line: 81 | Upvalues: Night (copy), isPlaceType (copy), LocalPlayer (copy), NotificationController (copy) ]]
	local v1 = p1.Adornee.Parent.Parent:GetAttribute("Owner")

	if v1 == nil then
		return
	end

	local v2 = game.Players:FindFirstChild(v1)

	if Night.Value == false then
		p1.PlayerFrame.Unlocked.Visible = false
		p1.PlayerFrame.fade.Visible = false
		p1.PlayerFrame.toptext.Visible = false

		return
	end

	if v2:GetAttribute("IsInOwnGarden") == true then
		if p1.PlayerFrame.Unlocked.Visible ~= true or (not isPlaceType or v2 ~= LocalPlayer) then
			p1.PlayerFrame.Unlocked.Visible = false
			p1.PlayerFrame.fade.Visible = false
			p1.PlayerFrame.toptext.Visible = false

			return
		end

		NotificationController:CreateNotification("Garden Locked!\240\159\148\146")
		p1.PlayerFrame.Unlocked.Visible = false
		p1.PlayerFrame.fade.Visible = false
		p1.PlayerFrame.toptext.Visible = false
	else
		if p1.PlayerFrame.Unlocked.Visible ~= false or (not isPlaceType or v2 ~= LocalPlayer) then
			p1.PlayerFrame.Unlocked.Visible = true
			p1.PlayerFrame.fade.Visible = true
			p1.PlayerFrame.toptext.Visible = true

			return
		end

		NotificationController:CreateNotification("Garden Unlocked!\240\159\148\147")
		p1.PlayerFrame.Unlocked.Visible = true
		p1.PlayerFrame.fade.Visible = true
		p1.PlayerFrame.toptext.Visible = true
	end
end

for k, v in pairs(tbl) do
	UpdateTag(v)
end

Night:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 117 | Upvalues: tbl (copy), UpdateTag (copy) ]]
	for k, v in pairs(tbl) do
		UpdateTag(v)
	end
end)
function t.Start(p1) --[[ Start | Line: 123 | Upvalues: LocalPlayer (copy), tbl (copy), UpdateTag (copy), t2 (copy), t3 (copy), v2 (ref), Gardens (copy), setExpandSignModelVisible (copy), getExpandSignTemplate (copy), PlayerStateClient (copy), ExpansionPrices (copy), GardenFlags (copy), NumberUtils (copy), v1 (copy), FlashbangVFXController (copy), Networking (copy), NotificationController (copy) ]]
	local function setOwnerSign(p1) --[[ setOwnerSign | Line: 124 | Upvalues: LocalPlayer (ref), tbl (ref), UpdateTag (ref), t2 (ref) ]]
		local SurfaceGui = p1.Signs.Garden:FindFirstChild("SurfaceGui", true)

		if not SurfaceGui then
			return
		end

		local v1 = p1:GetAttribute("Owner") or ""
		local v2 = p1:GetAttribute("OwnerUserId")
		local v3 = game.Players:FindFirstChild(v1)

		if not v3 and typeof(v2) == "number" then
			v3 = game.Players:GetPlayerByUserId(v2)
		end

		local v4 = SurfaceGui.Parent
		local Part = v4.Parent.Part
		local v5 = LocalPlayer.PlayerGui:FindFirstChild(p1.Name) or script.BillboardGui:Clone()

		v5.ResetOnSpawn = false
		v5.Parent = LocalPlayer.PlayerGui
		v5.Adornee = p1.Visual.PRIM
		v5.Name = p1.Name
		SurfaceGui.Enabled = true
		v4.Transparency = 0
		v4.CanCollide = true
		Part.Transparency = 0
		Part.CanCollide = true
		v5.Enabled = true
		table.insert(tbl, v5)

		if typeof(v2) == "number" then
			v3:GetAttributeChangedSignal("IsInOwnGarden"):Connect(function() --[[ Line: 152 | Upvalues: UpdateTag (ref), v5 (copy) ]]
				UpdateTag(v5)
			end)
		end

		UpdateTag(v5)

		if typeof(v2) == "number" then
			local v7 = v3 and v3.DisplayName or v1

			local function applyOwnerLabel() --[[ applyOwnerLabel | Line: 173 | Upvalues: v3 (ref), SurfaceGui (copy), v5 (copy), v7 (copy), LocalPlayer (ref) ]]
				local v1 = v3 and v3:GetAttribute("GuildTag")
				local v2 = v3 and v3:GetAttribute("GuildTagColor")
				local v32 = v3 and v3:GetAttribute("GuildColor")
				local v4 = false
				local v52

				if typeof(v2) == "string" and v2 ~= "" then
					v52 = v2
					v4 = true
				elseif typeof(v32) == "string" and v32 ~= "" then
					v52 = v32
					v4 = true
				else
					v52 = "#FFFFFF"
				end

				local v6 = if typeof(v1) == "string" and v1 ~= "" then ("<font color=\"%*\">[%*]</font> "):format(v52, v1) else ""

				if v4 then
					SurfaceGui.Player.TextLabel.RichText = true
				else
					SurfaceGui.Player.TextLabel.RichText = false
				end

				v5.PlayerFrame.Title.RichText = true
				SurfaceGui.Player.TextLabel.Text = ("%*%*\'s Garden"):format(v6, v7)

				local v8, v9

				if v3 == LocalPlayer then
					local v10 = ("%*Your Garden"):format(v6)

					if v10 then
						v8 = v10
					else
						v9 = ("%*%*\'s Garden"):format(v6, v7)
						v8 = v9
					end
				else
					v9 = ("%*%*\'s Garden"):format(v6, v7)
					v8 = v9
				end

				v5.PlayerFrame.Title.Text = v8
			end

			applyOwnerLabel()
			SurfaceGui.ImageLabel.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=150&h=150"):format(v2)
			SurfaceGui.ImageLabel.Visible = true
			v5.PlayerFrame.Headshot.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=420&h=420"):format(v2)

			if v3 then
				v3:GetAttributeChangedSignal("GuildTag"):Connect(applyOwnerLabel)
				v3:GetAttributeChangedSignal("GuildColor"):Connect(applyOwnerLabel)
				v3:GetAttributeChangedSignal("GuildTagColor"):Connect(applyOwnerLabel)
			end

			if t2[p1.Name] then
				t2[p1.Name]:Disconnect()
			end
		else
			SurfaceGui.Player.TextLabel.Text = "Empty Garden"
			SurfaceGui.ImageLabel.Image = ""
			SurfaceGui.ImageLabel.Visible = false
			v5.PlayerFrame.Title.Text = "Empty Garden"
			v5.PlayerFrame.Headshot.Image = ""
			v5.Enabled = false

			if t2[p1.Name] then
				t2[p1.Name]:Disconnect()
				t2[p1.Name] = nil
			end
		end
	end

	local v12 = false

	local function setupPlots() --[[ setupPlots | Line: 230 | Upvalues: t3 (ref), v2 (ref), LocalPlayer (ref), Gardens (ref), v12 (ref), setOwnerSign (copy), setExpandSignModelVisible (ref), getExpandSignTemplate (ref), PlayerStateClient (ref), ExpansionPrices (ref), GardenFlags (ref), NumberUtils (ref), v1 (ref), FlashbangVFXController (ref), Networking (ref), NotificationController (ref) ]]
		for v13, v22 in t3 do
			v22:Disconnect()
		end

		table.clear(t3)

		if v2 then
			v2:Destroy()
			v2 = nil
		end

		local v3 = LocalPlayer:GetAttribute("PlotId")

		for v4, v5 in Gardens:GetChildren() do
			if not v12 then
				setOwnerSign(v5)
				v5:GetAttributeChangedSignal("Owner"):Connect(function() --[[ Line: 237 | Upvalues: setOwnerSign (ref), v5 (copy) ]]
					setOwnerSign(v5)
				end)
				v5:GetAttributeChangedSignal("OwnerUserId"):Connect(function() --[[ Line: 240 | Upvalues: setOwnerSign (ref), v5 (copy) ]]
					setOwnerSign(v5)
				end)
			end

			local v6 = if v3 then if v5.Name == ("Plot%*"):format(v3) then true else false else v3
			local Signs = v5:FindFirstChild("Signs")
			local v7 = if Signs then Signs:FindFirstChild("Expand") else Signs

			if v7 then
				setExpandSignModelVisible(v7, v6 == true)
			end

			local v10 = if v7 then v7:FindFirstChild("CorePart") else v7
			local v11 = if v10 then getExpandSignTemplate(v10) else v10

			if v6 then
				if if workspace:GetAttribute("SkillPointsOn") == true then true else false then
					local SkillData = LocalPlayer:WaitForChild("SkillData", 5)
					local v13 = SkillData and SkillData:WaitForChild("SkillPoints", 5)
					local v14 = SkillData and SkillData:WaitForChild("BaseSpeed", 5)
					local v15 = SkillData and SkillData:WaitForChild("BaseJump", 5)
					local v16 = SkillData and SkillData:WaitForChild("ShovelPower", 5)
					local v17 = SkillData and SkillData:WaitForChild("MaxBackpack", 5)

					if v13 and (v14 and (v15 and (v16 and v17))) then
						local BillboardGui = v5.Signs.Garden.CorePart.Notification.BillboardGui
						local Notification = BillboardGui.Notification

						local function updateSkillPointUI() --[[ updateSkillPointUI | Line: 269 | Upvalues: v13 (copy), v14 (copy), v15 (copy), v16 (copy), v17 (copy), BillboardGui (copy), Notification (copy) ]]
							local v6 = math.min(v14.Value, v15.Value, v16.Value, v17.Value) <= v13.Value

							BillboardGui.Enabled = v6
							Notification.Visible = v6
						end

						local v23 = math.min(v14.Value, v15.Value, v16.Value, v17.Value) <= v13.Value

						BillboardGui.Enabled = v23
						Notification.Visible = v23
						v13.Changed:Connect(updateSkillPointUI)
						v14.Changed:Connect(updateSkillPointUI)
						v15.Changed:Connect(updateSkillPointUI)
						v16.Changed:Connect(updateSkillPointUI)
						v17.Changed:Connect(updateSkillPointUI)
					end
				else
					local Notification = v5.Signs.Garden.CorePart:FindFirstChild("Notification")
					local v24 = Notification and Notification:FindFirstChildWhichIsA("BillboardGui")

					if v24 then
						v24.Enabled = false

						local Notification2 = v24:FindFirstChild("Notification")

						if Notification2 and Notification2:IsA("GuiObject") then
							Notification2.Visible = false
						end
					end
				end

				if v10 and v11 then
					local ExpandSignGui = v11:Clone()

					v11:Destroy()
					ExpandSignGui.Name = "ExpandSignGui"
					ExpandSignGui.ResetOnSpawn = false
					ExpandSignGui.Parent = LocalPlayer.PlayerGui
					ExpandSignGui.Adornee = v10
					ExpandSignGui.Enabled = true
					v2 = ExpandSignGui

					local TextButton = ExpandSignGui:FindFirstChild("TextButton", true)
					local TextLabel = ExpandSignGui:FindFirstChild("TextLabel", true)

					if TextButton and (TextButton:IsA("GuiButton") and (TextLabel and TextLabel:IsA("TextLabel"))) then
						local v25 = PlayerStateClient:WaitForLocalReplica(30)
						local Sheckles = LocalPlayer:WaitForChild("leaderstats"):WaitForChild("Sheckles")
						local v26 = true

						local function updateExpandSign() --[[ updateExpandSign | Line: 320 | Upvalues: v25 (copy), ExpansionPrices (ref), GardenFlags (ref), TextButton (copy), Sheckles (copy), TextLabel (copy), NumberUtils (ref) ]]
							local v1 = if v25 then v25.Data.OwnedExpansions or 1 else 1
							local v2 = ExpansionPrices[v1 + 1]

							if not v2 then
								TextButton.Active = false
								TextButton.BackgroundColor3 = Color3.new(255/255, 0/255, 0/255)
								TextLabel.Text = "MAX"

								return
							end

							local v3 = GardenFlags.ExpansionPriceOverrides:Get()[tostring(v1 + 1)] or v2.Price

							TextButton.Active = true
							TextButton.BackgroundColor3 = if v3 <= Sheckles.Value then Color3.new(0, 0.666667, 0) else Color3.new(255/255, 0/255, 0/255)
							TextLabel.Text = NumberUtils.Abbreviate(v3) .. "\194\162"
						end

						local function f28() --[[ Line: 338 | Upvalues: LocalPlayer (ref), v26 (ref), v25 (copy), ExpansionPrices (ref), GardenFlags (ref), Sheckles (copy), v1 (ref), FlashbangVFXController (ref), Networking (ref), NotificationController (ref) ]]
							if LocalPlayer:GetAttribute("LoadingScreenActive") then
								return
							end

							if LocalPlayer:GetAttribute("IsStealingFruit") or LocalPlayer:GetAttribute("CarryingStolenFruit") then
								return
							end

							if not v26 then
								return
							end

							local v12 = if v25 then v25.Data.OwnedExpansions or 1 else 1
							local v2 = ExpansionPrices[v12 + 1]

							if not v2 then
								return
							end

							if (GardenFlags.ExpansionPriceOverrides:Get()[tostring(v12 + 1)] or v2.Price) <= Sheckles.Value then
								v26 = false
								v1:PlaySFX("Purchase")
								FlashbangVFXController:Flash(0.5)
								task.spawn(function() --[[ Line: 353 | Upvalues: Networking (ref), v26 (ref) ]]
									task.wait(0.5)
									Networking.Actions.ExpandGarden:Fire()
									v26 = true
								end)
							else
								v1:PlaySFX("Failed")
								NotificationController:CreateNotification("You can\'t afford this!")
							end
						end

						table.insert(t3, TextButton.Activated:Connect(f28))
						table.insert(t3, Sheckles:GetPropertyChangedSignal("Value"):Connect(updateExpandSign))

						local Changed = GardenFlags.ExpansionPriceOverrides.Changed

						table.insert(t3, Changed:Connect(updateExpandSign))

						local Loaded = GardenFlags.ExpansionPriceOverrides.Loaded

						table.insert(t3, Loaded:Connect(updateExpandSign))

						if v25 then
							table.insert(t3, v25:OnSet({ "OwnedExpansions" }, updateExpandSign))
						end

						updateExpandSign()
					end
				end
			end
		end

		v12 = true
	end

	setupPlots()
	LocalPlayer:GetAttributeChangedSignal("PlotId"):Connect(setupPlots)
end

return t