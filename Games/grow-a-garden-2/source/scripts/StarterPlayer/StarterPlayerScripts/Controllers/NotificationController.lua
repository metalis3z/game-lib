--credit to leon games studio
local t = {}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Debris = game:GetService("Debris")
local SoundService = game:GetService("SoundService")
local SocialService = game:GetService("SocialService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.ClientModules.Chalk)

local NotificationCondenser = require(script.NotificationCondenser)
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local NumberUtils = require(ReplicatedStorage.SharedModules.NumberUtils)
local Purchase = game.SoundService.SFX.Purchase
local Accept = game.SoundService.SFX.BargainSFX.Accept
local Tick = game.SoundService.SFX.Tick
local Sound = Instance.new("Sound")

Sound.SoundId = "rbxassetid://114731118678981"
Sound.Parent = SoundService

local function FormatCoins(p1) --[[ FormatCoins | Line: 25 | Upvalues: NumberUtils (copy) ]]
	return "<font color=\"#00FF00\">" .. NumberUtils.Abbreviate(p1) .. "\194\162</font>"
end

local LocalPlayer = Players.LocalPlayer
local DevProductController = require(LocalPlayer.PlayerScripts.Controllers.DevProductController)

local function PromptFriendInvite() --[[ PromptFriendInvite | Line: 33 | Upvalues: SocialService (copy), LocalPlayer (copy) ]]
	local ExperienceInviteOptions = Instance.new("ExperienceInviteOptions")

	ExperienceInviteOptions.PromptMessage = "Invite a friend to use the Wheelbarrow!"
	pcall(function() --[[ Line: 36 | Upvalues: SocialService (ref), LocalPlayer (ref), ExperienceInviteOptions (copy) ]]
		SocialService:PromptGameInvite(LocalPlayer, ExperienceInviteOptions)
	end)
end

local function PromptFriendRequest(p1) --[[ PromptFriendRequest | Line: 44 ]]
	pcall(function() --[[ Line: 45 | Upvalues: p1 (copy) ]]
		game.StarterGui:SetCore("PromptSendFriendRequest", p1)
	end)
end

local function GetBackpackSpaceUpgradesPurchased() --[[ GetBackpackSpaceUpgradesPurchased | Line: 55 | Upvalues: LocalPlayer (copy) ]]
	return tonumber(LocalPlayer:GetAttribute("BackpackSpaceUpgradesPurchased")) or 0
end

local function IsAtMaxBackpackSpace() --[[ IsAtMaxBackpackSpace | Line: 59 | Upvalues: LocalPlayer (copy) ]]
	return (tonumber(LocalPlayer:GetAttribute("BackpackSpaceUpgradesPurchased")) or 0) >= 37
end

local function GetInventoryUpgradeProductKey() --[[ GetInventoryUpgradeProductKey | Line: 63 | Upvalues: LocalPlayer (copy) ]]
	return ("SkillUpgrade:Backpack Space:%*"):format((math.min((tonumber(LocalPlayer:GetAttribute("BackpackSpaceUpgradesPurchased")) or 0) + 1, 37)))
end

local Frame = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("TopNotification"):WaitForChild("Frame")
local Notification = SoundService.SFX.Notification
local Notification_UI_Mobile = ReplicatedStorage.Assets.NotificationUI.Notification_UI_Mobile
local Notification_UI = ReplicatedStorage.Assets.NotificationUI.Notification_UI

local function IsMobileScreen() --[[ IsMobileScreen | Line: 84 | Upvalues: UserInputService (copy) ]]
	local CurrentCamera = workspace.CurrentCamera

	if not CurrentCamera then
		return UserInputService.TouchEnabled
	end

	local ViewportSize = CurrentCamera.ViewportSize

	return math.min(ViewportSize.X, ViewportSize.Y) <= 600
end

local function GetOdometerDuration(p1) --[[ GetOdometerDuration | Line: 102 ]]
	if p1 <= 1 then
		return 0
	end

	return math.min(p1 * 0.05, 5)
end

local t2 = {
	["Common Seed Pack"] = {
		Color = Color3.fromRGB(180, 180, 180)
	},
	["Uncommon Seed Pack"] = {
		Color = Color3.fromRGB(85, 220, 85)
	},
	["Rare Seed Pack"] = {
		Color = Color3.fromRGB(85, 140, 255)
	},
	["Epic Seed Pack"] = {
		Color = Color3.fromRGB(180, 90, 255)
	},
	["Legendary Seed Pack"] = {
		Color = Color3.fromRGB(255, 220, 70)
	},
	["Mythic Seed Pack"] = {
		Color = Color3.fromRGB(255, 70, 70)
	},
	["Super Seed Pack"] = {
		Gradient = "rainbow"
	},
	["Secret Seed Pack"] = {
		Gradient = "bw"
	},
	["Gold Seed"] = {
		Gradient = "gold"
	},
	["Rainbow Seed"] = {
		Gradient = "rainbow"
	}
}
local t3 = {
	Common = {
		Color = Color3.fromRGB(180, 180, 180)
	},
	Uncommon = {
		Color = Color3.fromRGB(85, 220, 85)
	},
	Rare = {
		Color = Color3.fromRGB(85, 140, 255)
	},
	Epic = {
		Color = Color3.fromRGB(180, 90, 255)
	},
	Legendary = {
		Color = Color3.fromRGB(255, 220, 70)
	},
	Mythic = {
		Color = Color3.fromRGB(255, 70, 70)
	},
	Super = {
		Gradient = "rainbow"
	},
	Secret = {
		Gradient = "bw"
	}
}
local t4 = {
	{
		threshold = 5,
		color = "#aaaaaa"
	},
	{
		threshold = 10,
		color = "#55ff7f"
	},
	{
		threshold = 15,
		color = "#ffe066"
	},
	{
		threshold = 20,
		color = "#55aaff"
	},
	{
		threshold = 40,
		color = "#ff5555"
	}
}

local function GetRecordColor(p1) --[[ GetRecordColor | Line: 148 | Upvalues: t4 (copy) ]]
	for v1, v2 in t4 do
		if p1 < v2.threshold then
			return v2.color
		end
	end

	return nil
end

local t5 = {}
local t6 = {}

local function FadeSingleButton(p1, p2, p3) --[[ FadeSingleButton | Line: 160 | Upvalues: TweenService (copy) ]]
	if not (p1 and p1.Visible) then
		return
	end

	TweenService:Create(p1, p3, {
		BackgroundTransparency = p2
	}):Play()

	local v1 = p1:FindFirstChildWhichIsA("UIStroke")

	if v1 then
		TweenService:Create(v1, p3, {
			Transparency = p2
		}):Play()
	end

	for v2, v3 in p1:GetDescendants() do
		if v3:IsA("TextLabel") or v3:IsA("TextButton") then
			TweenService:Create(v3, p3, {
				TextTransparency = p2,
				TextStrokeTransparency = p2
			}):Play()

			continue
		end

		if v3:IsA("ImageLabel") or v3:IsA("ImageButton") then
			TweenService:Create(v3, p3, {
				ImageTransparency = p2
			}):Play()

			continue
		end

		if v3:IsA("UIStroke") then
			TweenService:Create(v3, p3, {
				Transparency = p2
			}):Play()
		end
	end
end

local function FadeDevProductButton(p1, p2, p3) --[[ FadeDevProductButton | Line: 184 | Upvalues: FadeSingleButton (copy) ]]
	FadeSingleButton(p1.Content:FindFirstChild("DevProductInventory"), p2, p3)
end

local function ActivateNotificationFrame(p1) --[[ ActivateNotificationFrame | Line: 188 | Upvalues: TweenService (copy), FadeSingleButton (copy), Notification (copy) ]]
	local v1 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local v2 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	TweenService:Create(p1.Content.TextLabel, v2, {
		Position = p1.Content.TextLabel.Position
	}):Play()
	TweenService:Create(p1.ImageLabel, v1, {
		ImageTransparency = 0.5
	}):Play()
	TweenService:Create(p1.Content.TextLabel, v1, {
		TextTransparency = 0
	}):Play()
	TweenService:Create(p1.Content.TextLabel, v1, {
		TextStrokeTransparency = 0
	}):Play()
	FadeSingleButton(p1.Content:FindFirstChild("DevProductInventory"), 0, v1)
	Notification.PlaybackSpeed = 1 + math.random(-15, 15) / 100
	Notification.Playing = true
	Notification.TimePosition = 0
end

local function DeactivateNotificationFrame(p1) --[[ DeactivateNotificationFrame | Line: 205 | Upvalues: TweenService (copy), FadeSingleButton (copy), Debris (copy) ]]
	local v1 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local v2 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	TweenService:Create(p1.Content.TextLabel, v2, {
		Position = p1.Content.TextLabel.Position + UDim2.new(0, 0, 0.2, 0)
	}):Play()
	TweenService:Create(p1.ImageLabel, v1, {
		ImageTransparency = 1
	}):Play()
	TweenService:Create(p1.Content.TextLabel, v1, {
		TextTransparency = 1
	}):Play()
	TweenService:Create(p1.Content.TextLabel, v1, {
		TextStrokeTransparency = 1
	}):Play()
	FadeSingleButton(p1.Content:FindFirstChild("DevProductInventory"), 1, v1)
	Debris:AddItem(p1, v1.Time)
end

local function CreateNotificationFrame(p1, p2, p3, p4) --[[ CreateNotificationFrame | Line: 220 | Upvalues: LocalPlayer (copy), DevProductController (copy), SocialService (copy), Players (copy), Frame (copy) ]]
	local v1 = p1:Clone()

	v1.Content.TextLabel.RichText = if string.find(p2, "<%a") == nil then false else true
	v1.Content.TextLabel.Text = p2
	v1:SetAttribute("OG", p2)
	v1:SetAttribute("NotificationTimer", p3)

	if p4 then
		v1:SetAttribute("HelperUserId", p4)
	end

	local VAL_OBJ = Instance.new("IntValue")

	VAL_OBJ.Name = "VAL_OBJ"
	VAL_OBJ.Value = 1
	VAL_OBJ.Parent = v1
	v1.ImageLabel.ImageTransparency = 1
	v1.Content.TextLabel.TextTransparency = 1
	v1.Content.TextLabel.TextStrokeTransparency = 1

	local function InitButtonHidden(p1) --[[ InitButtonHidden | Line: 239 ]]
		p1.Visible = true
		p1.BackgroundTransparency = 1

		local v1 = p1:FindFirstChildWhichIsA("UIStroke")

		if v1 then
			v1.Transparency = 1
		end

		for v2, v3 in p1:GetDescendants() do
			if v3:IsA("TextLabel") or v3:IsA("TextButton") then
				v3.TextTransparency = 1
				v3.TextStrokeTransparency = 1

				continue
			end

			if v3:IsA("ImageLabel") or v3:IsA("ImageButton") then
				v3.ImageTransparency = 1
			end
		end
	end

	if p2 == "Your inventory is full" then
		local v3 = LocalPlayer
		local v4 = (tonumber(v3:GetAttribute("BackpackSpaceUpgradesPurchased")) or 0) >= 37
		local DevProductInventory = v1.Content:FindFirstChild("DevProductInventory")

		if DevProductInventory and v4 then
			DevProductInventory.Visible = false
		elseif DevProductInventory then
			InitButtonHidden(DevProductInventory)
			DevProductInventory.Activated:Connect(function() --[[ Line: 271 | Upvalues: DevProductController (ref), LocalPlayer (ref) ]]
				DevProductController:PromptPurchase((("SkillUpgrade:Backpack Space:%*"):format((math.min((tonumber(LocalPlayer:GetAttribute("BackpackSpaceUpgradesPurchased")) or 0) + 1, 37)))))
			end)
		end
	elseif p2 == "Friend in Server Required!" then
		local DevProductInventory = v1.Content:FindFirstChild("DevProductInventory")

		if DevProductInventory then
			InitButtonHidden(DevProductInventory)
			DevProductInventory.Activated:Connect(function() --[[ Line: 280 | Upvalues: SocialService (ref), LocalPlayer (ref) ]]
				local ExperienceInviteOptions = Instance.new("ExperienceInviteOptions")

				ExperienceInviteOptions.PromptMessage = "Invite a friend to use the Wheelbarrow!"
				pcall(function() --[[ Line: 36 | Upvalues: SocialService (ref), LocalPlayer (ref), ExperienceInviteOptions (copy) ]]
					SocialService:PromptGameInvite(LocalPlayer, ExperienceInviteOptions)
				end)
			end)
		end
	elseif v1:GetAttribute("HelperUserId") then
		local DevProductInventory = v1.Content:FindFirstChild("DevProductInventory")

		if DevProductInventory then
			InitButtonHidden(DevProductInventory)
			DevProductInventory.Activated:Connect(function() --[[ Line: 292 | Upvalues: v1 (copy), Players (ref) ]]
				local v12 = v1:GetAttribute("HelperUserId")

				if type(v12) ~= "number" then
					return
				end

				local v2 = Players:GetPlayerByUserId(v12)

				if not v2 then
					return
				end

				pcall(function() --[[ Line: 45 | Upvalues: v2 (copy) ]]
					game.StarterGui:SetCore("PromptSendFriendRequest", v2)
				end)
			end)
		end
	end

	v1.Parent = Frame

	return v1
end

local function CreateOdometerNotification(p1, p2, p3, p4, p5, p6, p7, p8) --[[ CreateOdometerNotification | Line: 312 | Upvalues: Notification_UI_Mobile (copy), Notification_UI (copy), CreateNotificationFrame (copy), ActivateNotificationFrame (copy), RunService (copy), Tick (copy), Accept (copy) ]]
	local v1 = p6 or tostring
	local v3 = p7 or (if p3 <= 1 then 0 else math.min(p3 * 0.05, 5))
	local v4 = (p5 or 3.5) + math.ceil(v3)
	local v5 = if v3 > 0 then 1 else p3
	local v6 = CreateNotificationFrame(p1 and Notification_UI_Mobile or Notification_UI, p2 .. v1(v5) .. p4, v4)

	v6:SetAttribute("OG", (("__odometer_%*%*_%*"):format(p2, p3, (os.clock()))))
	ActivateNotificationFrame(v6)

	if not (v3 <= 0) then
		local TextLabel = v6.Content.TextLabel
		local v7 = os.clock()
		local v8 = v5
		local v9 = 0
		local v10 = nil

		v10 = RunService.Heartbeat:Connect(function() --[[ Line: 335 | Upvalues: v6 (copy), TextLabel (copy), v10 (ref), v7 (copy), v3 (copy), p3 (copy), v8 (ref), p2 (copy), v1 (copy), p4 (copy), v9 (ref), Tick (ref), Accept (ref), p8 (copy) ]]
			if v6.Parent and TextLabel.Parent then
				local v2 = math.min((os.clock() - v7) / v3, 1)
				local v32 = 1 - (1 - v2) ^ 2
				local v4 = if v2 >= 1 then p3 else math.clamp(math.floor((p3 - 1) * v32 + 1 + 0.5), 1, p3)

				if v4 ~= v8 then
					v8 = v4
					TextLabel.Text = p2 .. v1(v4) .. p4

					local v82 = os.clock()

					if v9 <= v82 then
						local v92 = v32 + 1

						Tick.PlaybackSpeed = v92
						Tick.TimePosition = 0
						Tick.Playing = true
						v9 = v82 + 0.079 / v92
					end
				end

				if not (v2 >= 1 and v10) then
					return
				end

				v10:Disconnect()
				v10 = nil
				Accept.PlaybackSpeed = 1 + math.random(-15, 15) / 100
				Accept.TimePosition = 0
				Accept.Playing = true

				if not p8 then
					return
				end

				p8(v6)
			else
				if not v10 then
					return
				end

				v10:Disconnect()
				v10 = nil
			end
		end)
		v6.AncestryChanged:Connect(function(p1, p2) --[[ Line: 376 | Upvalues: v10 (ref) ]]
			if p2 or not v10 then
				return
			end

			v10:Disconnect()
			v10 = nil
		end)

		return v6
	end

	if p8 then
		p8(v6)
	end

	return v6
end

local function CreateNotification(p1, p2, p3, p4) --[[ CreateNotification | Line: 386 | Upvalues: Purchase (copy), LocalPlayer (copy), CreateOdometerNotification (copy), FormatCoins (copy), t3 (copy), t (copy), Sound (copy), Notification_UI_Mobile (copy), Notification_UI (copy), NotificationCondenser (copy), Frame (copy), t6 (copy), t5 (copy), CreateNotificationFrame (copy), ActivateNotificationFrame (copy) ]]
	local v1 = p4 or 3.5
	local v2 = string.match(p2, "^You stole (%d+) fruits!$")

	if v2 then
		Purchase.PlaybackSpeed = 1 + math.random(-15, 15) / 100
		Purchase.Playing = true
		Purchase.TimePosition = 0

		local v5 = math.floor(tonumber(LocalPlayer:GetAttribute("StolenCarryValue")) or 0)

		if v5 > 0 then
			CreateOdometerNotification(p1, "You <font color=\"#FF4444\">stole</font> ", v5, " worth of fruit!", v1, FormatCoins, 2)
		else
			CreateOdometerNotification(p1, "You stole ", tonumber(v2), " fruits!", v1)
		end
	else
		local v6, v7 = string.match(p2, "^(An?) (%a+) pet has spawned!$")

		if v6 and (v7 and t3[v7]) then
			t:CreateRarityWordNotification(v6 .. " ", v7, " pet has spawned!", v7)

			return
		end

		local v8 = string.match(p2, "^Guild Competition Record: ([%d%.]+)kg!$")

		if v8 and tonumber(v8) then
			t:CreateGuildRecordNotification(p1, tonumber(v8), v1)

			return
		end

		if string.match(p2, "^New sell price record!") then
			Sound.PlaybackSpeed = 1 + math.random(-15, 15) / 100
			Sound.TimePosition = 0
			Sound.Playing = true
		end

		local v10 = NotificationCondenser:GetCondenseKey(p2)
		local v11 = nil

		if v10 then
			for i, v in ipairs(Frame:GetChildren()) do
				if v:IsA("Frame") and v:GetAttribute("CondenseKey") == v10.Rule.Key then
					v11 = v

					break
				end
			end

			if v11 then
				if p1 then
					local v12 = t5[v10.Rule.Key] or {}

					table.insert(v12, {
						Text = p2,
						Duration = v1,
						IsMobile = p1
					})
					t5[v10.Rule.Key] = v12
				else
					local v13 = t6[v11] or {}
					local t2 = {}

					for i, v in ipairs(v13) do
						t2[v.Plain] = true
					end

					if not t2[v10.Variant.Plain] then
						table.insert(v13, v10.Variant)
					end

					t6[v11] = v13

					if #v13 >= 2 then
						v11.Content.TextLabel.RichText = true
						v11.Content.TextLabel.Text = NotificationCondenser:BuildCondensedText(v13, v10.Rule.Suffix, v10.Rule.PluralSuffix)
					end

					v11:SetAttribute("NotificationTimer", v1)
				end

				return
			end
		elseif not p3 then
			for i, v in ipairs(Frame:GetChildren()) do
				if v:IsA("Frame") and v:GetAttribute("OG") == p2 then
					v11 = v

					break
				end
			end

			if v11 then
				local VAL_OBJ = v11:FindFirstChild("VAL_OBJ")

				if VAL_OBJ then
					VAL_OBJ.Value = VAL_OBJ.Value + 1
					v11.Content.TextLabel.Text = p2 .. " [X" .. VAL_OBJ.Value .. "]"
				end

				v11:SetAttribute("NotificationTimer", v1)

				return
			end
		end

		local v14 = CreateNotificationFrame(p1 and Notification_UI_Mobile or Notification_UI, p2, v1)

		if v10 then
			v14:SetAttribute("CondenseKey", v10.Rule.Key)
			t6[v14] = { v10.Variant }
		end

		ActivateNotificationFrame(v14)
	end
end

local function CreateHelperRequestNotification(p1) --[[ CreateHelperRequestNotification | Line: 527 | Upvalues: UserInputService (copy), Notification_UI_Mobile (copy), Notification_UI (copy), Frame (copy), CreateNotificationFrame (copy), ActivateNotificationFrame (copy) ]]
	local CurrentCamera = workspace.CurrentCamera
	local v1

	if CurrentCamera then
		local ViewportSize = CurrentCamera.ViewportSize

		v1 = if math.min(ViewportSize.X, ViewportSize.Y) <= 600 then true else false
	else
		v1 = UserInputService.TouchEnabled
	end

	local v4 = ("%* is helping your garden! Friend?"):format(p1.Name)

	for v5, v6 in Frame:GetChildren() do
		if v6:IsA("Frame") and v6:GetAttribute("HelperUserId") == p1.UserId then
			v6:SetAttribute("NotificationTimer", 7)

			return
		end
	end

	ActivateNotificationFrame((CreateNotificationFrame(v1 and Notification_UI_Mobile or Notification_UI, v4, 7, p1.UserId)))
end

local function FormatStaticSeedPackText(p1, p2) --[[ FormatStaticSeedPackText | Line: 547 ]]
	return ("A <font color=\"rgb(%*,%*,%*)\">%*</font> Spawned!"):format(math.floor(p2.R * 255), math.floor(p2.G * 255), math.floor(p2.B * 255), p1)
end

local function FormatStaticSeedPackClaimedText(p1, p2, p3) --[[ FormatStaticSeedPackClaimedText | Line: 554 ]]
	return ("%* found a <font color=\"rgb(%*,%*,%*)\">%*</font>!"):format(p1, math.floor(p3.R * 255), math.floor(p3.G * 255), math.floor(p3.B * 255), p2)
end

local function BuildAnimatedPackName(p1, p2, p3) --[[ BuildAnimatedPackName | Line: 569 ]]
	local v1 = table.create(#p1)

	for i = 1, #p1 do
		local v2, v3, v4
		local v5 = string.sub(p1, i, i)

		if p3 == "rainbow" then
			local v6 = Color3.fromHSV((p2 * 0.6 + (i - 1) * 0.02) % 1, 1, 1)

			v2, v3, v4 = math.floor(v6.R * 255), math.floor(v6.G * 255), math.floor(v6.B * 255)
		elseif p3 == "gold" then
			local v13 = math.sin(p2 * 5 + i * 0.55) * 0.5 + 0.5
			local v14 = math.floor(v13 * 60 + 180)

			v2, v3, v4 = 255, v14, math.floor(v13 * 40 + 20)
		else
			local v17 = math.floor((math.sin(p2 * 4 + i * 0.45) * 0.5 + 0.5) * 255)

			v2 = v17
			v3 = v17
			v4 = v17
		end

		if v5 == " " then
			v1[i] = " "

			continue
		end

		v1[i] = ("<font color=\"rgb(%*,%*,%*)\">%*</font>"):format(v2, v3, v4, v5)
	end

	return table.concat(v1)
end

local function FormatAnimatedSeedPackText(p1, p2, p3) --[[ FormatAnimatedSeedPackText | Line: 603 | Upvalues: BuildAnimatedPackName (copy) ]]
	return ("A %* Spawned!"):format((BuildAnimatedPackName(p1, p2, p3)))
end

local function FormatAnimatedSeedPackClaimedText(p1, p2, p3, p4) --[[ FormatAnimatedSeedPackClaimedText | Line: 607 | Upvalues: BuildAnimatedPackName (copy) ]]
	return ("%* found a %*!"):format(p1, (BuildAnimatedPackName(p2, p3, p4)))
end

function t.CreateSeedPackSpawnNotification(p1, p2) --[[ CreateSeedPackSpawnNotification | Line: 611 | Upvalues: t2 (copy), UserInputService (copy), Notification_UI_Mobile (copy), Notification_UI (copy), BuildAnimatedPackName (copy), Frame (copy), ActivateNotificationFrame (copy), RunService (copy) ]]
	local v1 = t2[p2]

	if not v1 then
		return
	end

	local CurrentCamera = workspace.CurrentCamera
	local v2

	if CurrentCamera then
		local ViewportSize = CurrentCamera.ViewportSize

		v2 = math.min(ViewportSize.X, ViewportSize.Y) <= 600
	else
		v2 = UserInputService.TouchEnabled
	end

	local v4

	if v1.Gradient then
		v4 = ("A %* Spawned!"):format((BuildAnimatedPackName(p2, 0, v1.Gradient)))
	else
		local v6 = v1.Color or Color3.new(255/255, 255/255, 255/255)

		v4 = ("A <font color=\"rgb(%*,%*,%*)\">%*</font> Spawned!"):format(math.floor(v6.R * 255), math.floor(v6.G * 255), math.floor(v6.B * 255), p2)
	end

	local v13 = (v2 and Notification_UI_Mobile or Notification_UI):Clone()

	v13:SetAttribute("OG", (("__seedpack_%*_%*"):format(p2, (os.clock()))))
	v13:SetAttribute("NotificationTimer", 6)
	v13.Content.TextLabel.RichText = true
	v13.Content.TextLabel.Text = v4

	local VAL_OBJ = Instance.new("IntValue")

	VAL_OBJ.Name = "VAL_OBJ"
	VAL_OBJ.Value = 1
	VAL_OBJ.Parent = v13
	v13.ImageLabel.ImageTransparency = 1
	v13.Content.TextLabel.TextTransparency = 1
	v13.Content.TextLabel.TextStrokeTransparency = 1
	v13.Parent = Frame
	ActivateNotificationFrame(v13)

	if not v1.Gradient then
		return
	end

	local TextLabel = v13.Content.TextLabel
	local Gradient = v1.Gradient
	local v14 = os.clock()
	local v15 = nil

	v15 = RunService.Heartbeat:Connect(function() --[[ Line: 650 | Upvalues: v13 (copy), TextLabel (copy), v15 (ref), p2 (copy), v14 (copy), Gradient (copy), BuildAnimatedPackName (ref) ]]
		if v13.Parent and TextLabel.Parent then
			TextLabel.Text = ("A %* Spawned!"):format((BuildAnimatedPackName(p2, os.clock() - v14, Gradient)))
		else
			v15:Disconnect()
		end
	end)
	v13.AncestryChanged:Connect(function(p1, p2) --[[ Line: 657 | Upvalues: v15 (ref) ]]
		if p2 or not v15 then
			return
		end

		v15:Disconnect()
		v15 = nil
	end)
end

local function FormatStaticBirdSeedText(p1, p2, p3) --[[ FormatStaticBirdSeedText | Line: 666 ]]
	return ("Your %* dropped a <font color=\"rgb(%*,%*,%*)\">%* Seed</font>!"):format(p3, math.floor(p2.R * 255), math.floor(p2.G * 255), math.floor(p2.B * 255), p1)
end

local function FormatAnimatedBirdSeedText(p1, p2, p3, p4) --[[ FormatAnimatedBirdSeedText | Line: 673 | Upvalues: BuildAnimatedPackName (copy) ]]
	return ("Your %* dropped a %*!"):format(p4, (BuildAnimatedPackName(p1 .. " Seed", p2, p3)))
end

local function FormatStaticRarityWordText(p1, p2, p3, p4) --[[ FormatStaticRarityWordText | Line: 677 ]]
	return ("%*<font color=\"rgb(%*,%*,%*)\">%*</font>%*"):format(p1, math.floor(p4.R * 255), math.floor(p4.G * 255), math.floor(p4.B * 255), p2, p3)
end

local function FormatAnimatedRarityWordText(p1, p2, p3, p4, p5) --[[ FormatAnimatedRarityWordText | Line: 684 | Upvalues: BuildAnimatedPackName (copy) ]]
	return ("%*%*%*"):format(p1, BuildAnimatedPackName(p2, p4, p5), p3)
end

function t.CreateRarityWordNotification(p1, p2, p3, p4, p5) --[[ CreateRarityWordNotification | Line: 688 | Upvalues: t3 (copy), UserInputService (copy), Notification_UI_Mobile (copy), Notification_UI (copy), BuildAnimatedPackName (copy), Frame (copy), ActivateNotificationFrame (copy), RunService (copy) ]]
	local v1 = t3[p5] or t3.Common
	local CurrentCamera = workspace.CurrentCamera
	local v2

	if CurrentCamera then
		local ViewportSize = CurrentCamera.ViewportSize

		v2 = if math.min(ViewportSize.X, ViewportSize.Y) <= 600 then true else false
	else
		v2 = UserInputService.TouchEnabled
	end

	local v4

	if v1.Gradient then
		v4 = ("%*%*%*"):format(p2, BuildAnimatedPackName(p3, 0, v1.Gradient), p4)
	else
		local v6 = v1.Color or Color3.new(255/255, 255/255, 255/255)

		v4 = ("%*<font color=\"rgb(%*,%*,%*)\">%*</font>%*"):format(p2, math.floor(v6.R * 255), math.floor(v6.G * 255), math.floor(v6.B * 255), p3, p4)
	end

	local v13 = (v2 and Notification_UI_Mobile or Notification_UI):Clone()

	v13:SetAttribute("OG", (("__rarity_word_%*_%*_%*"):format(p3, p5, (os.clock()))))
	v13:SetAttribute("NotificationTimer", 6)
	v13.Content.TextLabel.RichText = true
	v13.Content.TextLabel.Text = v4

	local VAL_OBJ = Instance.new("IntValue")

	VAL_OBJ.Name = "VAL_OBJ"
	VAL_OBJ.Value = 1
	VAL_OBJ.Parent = v13
	v13.ImageLabel.ImageTransparency = 1
	v13.Content.TextLabel.TextTransparency = 1
	v13.Content.TextLabel.TextStrokeTransparency = 1
	v13.Parent = Frame
	ActivateNotificationFrame(v13)

	if not v1.Gradient then
		return
	end

	local TextLabel = v13.Content.TextLabel
	local Gradient = v1.Gradient
	local v14 = os.clock()
	local v15 = nil

	v15 = RunService.Heartbeat:Connect(function() --[[ Line: 724 | Upvalues: v13 (copy), TextLabel (copy), v15 (ref), p2 (copy), p3 (copy), p4 (copy), v14 (copy), Gradient (copy), BuildAnimatedPackName (ref) ]]
		if v13.Parent and TextLabel.Parent then
			TextLabel.Text = ("%*%*%*"):format(p2, BuildAnimatedPackName(p3, os.clock() - v14, Gradient), p4)
		else
			v15:Disconnect()
		end
	end)
	v13.AncestryChanged:Connect(function(p1, p2) --[[ Line: 731 | Upvalues: v15 (ref) ]]
		if p2 or not v15 then
			return
		end

		v15:Disconnect()
		v15 = nil
	end)
end
function t.CreateGuildRecordNotification(p1, p2, p3, p4) --[[ CreateGuildRecordNotification | Line: 745 | Upvalues: t4 (copy), CreateOdometerNotification (copy), RunService (copy), BuildAnimatedPackName (copy) ]]
	local v1

	do
		local __inline_returned = false

		for v2, v3 in t4 do
			if p3 < v3.threshold then
				v1 = v3.color
				__inline_returned = true

				break
			end
		end

		if not __inline_returned then
			v1 = nil
		end
	end

	CreateOdometerNotification(p2, if v1 then ("Guild Competition Record: <font color=\"%*\">"):format(v1) else "Guild Competition Record: ", p3, if v1 then "kg</font>!" else "kg!", p4, nil, nil, function(p1) --[[ Line: 752 | Upvalues: v1 (copy), p3 (copy), RunService (ref), BuildAnimatedPackName (ref) ]]
		if v1 then
			return
		end

		local v12 = p1.Content and p1.Content:FindFirstChild("TextLabel")

		if v12 then
			v12.RichText = true

			local v2 = ("%*kg"):format(p3)
			local v3 = os.clock()
			local v4 = nil

			v4 = RunService.Heartbeat:Connect(function() --[[ Line: 762 | Upvalues: p1 (copy), v12 (copy), v4 (ref), v2 (copy), v3 (copy), BuildAnimatedPackName (ref) ]]
				if p1.Parent and v12.Parent then
					v12.Text = ("Guild Competition Record: %*!"):format((BuildAnimatedPackName(v2, os.clock() - v3, "rainbow")))

					return
				end

				if not v4 then
					return
				end

				v4:Disconnect()
				v4 = nil
			end)
			p1.AncestryChanged:Connect(function(p1, p2) --[[ Line: 769 | Upvalues: v4 (ref) ]]
				if p2 or not v4 then
					return
				end

				v4:Disconnect()
				v4 = nil
			end)
		end
	end)
end
function t.CreateBirdSeedDropNotification(p1, p2, p3, p4) --[[ CreateBirdSeedDropNotification | Line: 778 | Upvalues: t3 (copy), UserInputService (copy), Notification_UI_Mobile (copy), Notification_UI (copy), BuildAnimatedPackName (copy), Frame (copy), ActivateNotificationFrame (copy), RunService (copy) ]]
	local v1 = t3[p3] or t3.Common
	local CurrentCamera = workspace.CurrentCamera
	local v2

	if CurrentCamera then
		local ViewportSize = CurrentCamera.ViewportSize

		v2 = if math.min(ViewportSize.X, ViewportSize.Y) <= 600 then true else false
	else
		v2 = UserInputService.TouchEnabled
	end

	local v4

	if v1.Gradient then
		v4 = ("Your %* dropped a %*!"):format(p4, (BuildAnimatedPackName(p2 .. " Seed", 0, v1.Gradient)))
	else
		local v6 = v1.Color or Color3.new(255/255, 255/255, 255/255)

		v4 = ("Your %* dropped a <font color=\"rgb(%*,%*,%*)\">%* Seed</font>!"):format(p4, math.floor(v6.R * 255), math.floor(v6.G * 255), math.floor(v6.B * 255), p2)
	end

	local v13 = (v2 and Notification_UI_Mobile or Notification_UI):Clone()

	v13:SetAttribute("OG", (("__bird_seed_%*_%*"):format(p2, (os.clock()))))
	v13:SetAttribute("NotificationTimer", 6)
	v13.Content.TextLabel.RichText = true
	v13.Content.TextLabel.Text = v4

	local VAL_OBJ = Instance.new("IntValue")

	VAL_OBJ.Name = "VAL_OBJ"
	VAL_OBJ.Value = 1
	VAL_OBJ.Parent = v13
	v13.ImageLabel.ImageTransparency = 1
	v13.Content.TextLabel.TextTransparency = 1
	v13.Content.TextLabel.TextStrokeTransparency = 1
	v13.Parent = Frame
	ActivateNotificationFrame(v13)

	if not v1.Gradient then
		return
	end

	local TextLabel = v13.Content.TextLabel
	local Gradient = v1.Gradient
	local v14 = os.clock()
	local v15 = nil

	v15 = RunService.Heartbeat:Connect(function() --[[ Line: 814 | Upvalues: v13 (copy), TextLabel (copy), v15 (ref), p2 (copy), v14 (copy), Gradient (copy), p4 (copy), BuildAnimatedPackName (ref) ]]
		if v13.Parent and TextLabel.Parent then
			TextLabel.Text = ("Your %* dropped a %*!"):format(p4, (BuildAnimatedPackName(p2 .. " Seed", os.clock() - v14, Gradient)))
		else
			v15:Disconnect()
		end
	end)
	v13.AncestryChanged:Connect(function(p1, p2) --[[ Line: 821 | Upvalues: v15 (ref) ]]
		if p2 or not v15 then
			return
		end

		v15:Disconnect()
		v15 = nil
	end)
end
function t.CreateSeedPackClaimedNotification(p1, p2, p3) --[[ CreateSeedPackClaimedNotification | Line: 830 | Upvalues: t2 (copy), UserInputService (copy), Notification_UI_Mobile (copy), Notification_UI (copy), BuildAnimatedPackName (copy), Frame (copy), ActivateNotificationFrame (copy), RunService (copy) ]]
	local v1 = t2[p3]

	if not v1 then
		return
	end

	local CurrentCamera = workspace.CurrentCamera
	local v2

	if CurrentCamera then
		local ViewportSize = CurrentCamera.ViewportSize

		v2 = if math.min(ViewportSize.X, ViewportSize.Y) <= 600 then true else false
	else
		v2 = UserInputService.TouchEnabled
	end

	local v4

	if v1.Gradient then
		v4 = ("%* found a %*!"):format(p2, (BuildAnimatedPackName(p3, 0, v1.Gradient)))
	else
		local v6 = v1.Color or Color3.new(255/255, 255/255, 255/255)

		v4 = ("%* found a <font color=\"rgb(%*,%*,%*)\">%*</font>!"):format(p2, math.floor(v6.R * 255), math.floor(v6.G * 255), math.floor(v6.B * 255), p3)
	end

	local v13 = (v2 and Notification_UI_Mobile or Notification_UI):Clone()

	v13:SetAttribute("OG", (("__seedpack_claimed_%*_%*_%*"):format(p2, p3, (os.clock()))))
	v13:SetAttribute("NotificationTimer", 6)
	v13.Content.TextLabel.RichText = true
	v13.Content.TextLabel.Text = v4

	local VAL_OBJ = Instance.new("IntValue")

	VAL_OBJ.Name = "VAL_OBJ"
	VAL_OBJ.Value = 1
	VAL_OBJ.Parent = v13
	v13.ImageLabel.ImageTransparency = 1
	v13.Content.TextLabel.TextTransparency = 1
	v13.Content.TextLabel.TextStrokeTransparency = 1
	v13.Parent = Frame
	ActivateNotificationFrame(v13)

	if not v1.Gradient then
		return
	end

	local TextLabel = v13.Content.TextLabel
	local Gradient = v1.Gradient
	local v14 = os.clock()
	local v15 = nil

	v15 = RunService.Heartbeat:Connect(function() --[[ Line: 869 | Upvalues: v13 (copy), TextLabel (copy), v15 (ref), p2 (copy), p3 (copy), v14 (copy), Gradient (copy), BuildAnimatedPackName (ref) ]]
		if v13.Parent and TextLabel.Parent then
			TextLabel.Text = ("%* found a %*!"):format(p2, (BuildAnimatedPackName(p3, os.clock() - v14, Gradient)))
		else
			v15:Disconnect()
		end
	end)
	v13.AncestryChanged:Connect(function(p1, p2) --[[ Line: 876 | Upvalues: v15 (ref) ]]
		if p2 or not v15 then
			return
		end

		v15:Disconnect()
		v15 = nil
	end)
end
function t.Init(p1) --[[ Init | Line: 885 ]] end
function t.Start(p1) --[[ Start | Line: 888 | Upvalues: Frame (copy), DeactivateNotificationFrame (copy), t5 (copy), Notification_UI_Mobile (copy), Notification_UI (copy), CreateNotificationFrame (copy), ActivateNotificationFrame (copy), Networking (copy), CreateNotification (copy), UserInputService (copy), Players (copy), CreateHelperRequestNotification (copy) ]]
	task.spawn(function() --[[ Line: 889 | Upvalues: Frame (ref), DeactivateNotificationFrame (ref), t5 (ref), Notification_UI_Mobile (ref), Notification_UI (ref), CreateNotificationFrame (ref), ActivateNotificationFrame (ref) ]]
		while true do
			for v1, v2 in Frame:GetChildren() do
				if v2:IsA("Frame") and (v2.Name == "Notification_UI" or v2.Name == "Notification_UI_Mobile") then
					local v3 = v2:GetAttribute("NotificationTimer")

					if v3 and type(v3) == "number" then
						local v4 = v3 - 1

						if v4 <= 0 then
							v2:SetAttribute("NotificationTimer", nil)

							local v5 = v2:GetAttribute("CondenseKey")

							DeactivateNotificationFrame(v2)

							if v5 then
								local v6 = t5[v5] or {}

								if #v6 >= 1 then
									local v7 = v6[1]

									table.remove(v6, 1)

									local v9 = CreateNotificationFrame(v7.IsMobile and Notification_UI_Mobile or Notification_UI, v7.Text, v7.Duration)

									v9:SetAttribute("CondenseKey", v5)
									task.spawn(function() --[[ Line: 914 | Upvalues: ActivateNotificationFrame (ref), v9 (copy) ]]
										task.wait(0.4)
										ActivateNotificationFrame(v9)
									end)
								end
							end

							continue
						end

						v2:SetAttribute("NotificationTimer", v4)
					end
				end
			end

			task.wait(1)
		end
	end)
	Networking.Notification.OnClientEvent:Connect(function(...) --[[ Line: 931 | Upvalues: CreateNotification (ref), UserInputService (ref) ]]
		local CurrentCamera = workspace.CurrentCamera
		local v2

		if CurrentCamera then
			local ViewportSize = CurrentCamera.ViewportSize

			v2 = math.min(ViewportSize.X, ViewportSize.Y) <= 600
		else
			v2 = UserInputService.TouchEnabled
		end

		CreateNotification(v2, ...)
	end)
	game.ReplicatedStorage.Notify.Event:Connect(function(...) --[[ Line: 934 | Upvalues: CreateNotification (ref), UserInputService (ref) ]]
		local CurrentCamera = workspace.CurrentCamera
		local v2

		if CurrentCamera then
			local ViewportSize = CurrentCamera.ViewportSize

			v2 = math.min(ViewportSize.X, ViewportSize.Y) <= 600
		else
			v2 = UserInputService.TouchEnabled
		end

		CreateNotification(v2, ...)
	end)
	Networking.HelperRequest.OnClientEvent:Connect(function(p1) --[[ Line: 938 | Upvalues: Players (ref), CreateHelperRequestNotification (ref) ]]
		if type(p1) ~= "number" then
			return
		end

		local v1 = Players:GetPlayerByUserId(p1)

		if v1 then
			CreateHelperRequestNotification(v1)
		end
	end)
	Networking.SeedPackSpawn.Claimed.OnClientEvent:Connect(function(p12, p2) --[[ Line: 950 | Upvalues: p1 (copy) ]]
		if type(p12) == "string" and type(p2) == "string" then
			p1:CreateSeedPackClaimedNotification(p12, p2)
		end
	end)
	Networking.Bird.SeedDropped.OnClientEvent:Connect(function(p12, p2, p3) --[[ Line: 955 | Upvalues: p1 (copy) ]]
		if type(p12) ~= "string" or type(p2) ~= "string" then
			return
		end

		local v2, v3, v4

		if type(p3) == "string" and p3 ~= "" then
			v2 = p12
			v3 = p2
			v4 = p3
		else
			v2 = p12
			v3 = p2
			v4 = "bird"
		end

		p1:CreateBirdSeedDropNotification(v2, v3, v4)
	end)
end
function t.CreateNotification(p1, p2, p3, p4) --[[ CreateNotification | Line: 961 | Upvalues: UserInputService (copy), CreateNotification (copy) ]]
	local CurrentCamera = workspace.CurrentCamera
	local v1

	if CurrentCamera then
		local ViewportSize = CurrentCamera.ViewportSize

		v1 = if math.min(ViewportSize.X, ViewportSize.Y) <= 600 then true else false
	else
		v1 = UserInputService.TouchEnabled
	end

	CreateNotification(v1, p2, p3, p4)
end
function t.CreateStickyNotification(p1, p2) --[[ CreateStickyNotification | Line: 976 | Upvalues: UserInputService (copy), Notification_UI_Mobile (copy), Notification_UI (copy), Frame (copy), ActivateNotificationFrame (copy), DeactivateNotificationFrame (copy) ]]
	local CurrentCamera = workspace.CurrentCamera
	local v1

	if CurrentCamera then
		local ViewportSize = CurrentCamera.ViewportSize

		v1 = if math.min(ViewportSize.X, ViewportSize.Y) <= 600 then true else false
	else
		v1 = UserInputService.TouchEnabled
	end

	local v3 = (v1 and Notification_UI_Mobile or Notification_UI):Clone()

	v3:SetAttribute("NotificationTimer", nil)
	v3.Content.TextLabel.RichText = true
	v3.Content.TextLabel.Text = p2
	v3:SetAttribute("OG", "__sticky__")
	v3.ImageLabel.ImageTransparency = 1
	v3.Content.TextLabel.TextTransparency = 1
	v3.Content.TextLabel.TextStrokeTransparency = 1
	v3.Parent = Frame
	ActivateNotificationFrame(v3)

	local t = {}
	local v4 = false

	function t.SetText(p1, p2) --[[ SetText | Line: 1001 | Upvalues: v4 (ref), v3 (copy) ]]
		if not v4 and v3.Parent then
			v3.Content.TextLabel.RichText = true
			v3.Content.TextLabel.Text = p2
		end
	end
	function t.Dismiss(p1) --[[ Dismiss | Line: 1007 | Upvalues: v4 (ref), v3 (copy), DeactivateNotificationFrame (ref) ]]
		if v4 then
			return
		end

		v4 = true

		if not v3.Parent then
			return
		end

		DeactivateNotificationFrame(v3)
	end

	return t
end

return t