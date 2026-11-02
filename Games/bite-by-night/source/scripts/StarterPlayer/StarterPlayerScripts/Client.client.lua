-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
game:GetService("GroupService")
require(v1:WaitForChild("Modules"):WaitForChild("SmartBone")).Start()
game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, false)
game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Captures, false)
game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.SelfView, false)
game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
local v_u_2 = require(v1.Modules.Icon)
local v_u_3 = require(v1:WaitForChild("CmdrClient", 10000))
v_u_3:SetActivationKeys({ Enum.KeyCode.F2 })
task.spawn(function()
	-- upvalues: (copy) v_u_3
	game:GetService("TextChatService"):WaitForChild("CMDRCommand").Triggered:Connect(function()
		-- upvalues: (ref) v_u_3
		v_u_3:Toggle()
	end)
end)
for _, v4 in game:GetService("Lighting"):GetChildren() do
	v4:Destroy()
end
local v5 = game:GetService("ReplicatedStorage").Lightings:FindFirstChild("Lobby"):Clone()
for _, v6 in v5:FindFirstChild("Lighting"):GetChildren() do
	game:GetService("Lighting")[v6.Name] = v6.Value
end
for _, v7 in v5:GetChildren() do
	v7.Parent = game:GetService("Lighting")
end

local v_u_8, v_u_9 = pcall(function()
	return game:GetService("Players").LocalPlayer:GetAttribute("Rank")
end)

local v10 = game:GetService("TextChatService")
local v_u_11 = {
	["Tester"] = Color3.fromRGB(141, 255, 115):ToHex(),
	["Contributor"] = Color3.fromRGB(255, 115, 0):ToHex(),
	["Developer"] = Color3.fromRGB(44, 255, 202):ToHex(),
	["Lead Developer"] = Color3.fromRGB(255, 255, 255):ToHex(),
	["Manager"] = Color3.fromRGB(91, 0, 0):ToHex(),
	["Co-Director"] = Color3.fromRGB(76, 198, 255):ToHex(),
	["Director"] = Color3.fromRGB(202, 10, 255):ToHex()
}
function v10.OnIncomingMessage(p12)
	-- upvalues: (copy) v_u_11
	local v13 = Instance.new("TextChatMessageProperties")
	if p12.TextSource then
		local v_u_14 = game:GetService("Players"):GetPlayerByUserId(p12.TextSource.UserId)
		if v_u_14:GetAttribute("VIPTag") == true and v_u_14:HasTag("VIP_OWN") then
			v13.PrefixText = "<font color=\'#" .. Color3.fromRGB(255, 213, 0):ToHex() .. "\'>[VIP]</font> " .. p12.PrefixText
		end
		local Translate = require('@game/ReplicatedStorage/Modules/Misc/RankTranslations')
		local _, v15 = pcall(function()
			return Translate.RankTranslate[game:GetService("Players").LocalPlayer:GetAttribute("Rank")]
		end)
		if v_u_11[v15] and v_u_14:GetAttribute("DevTags") == true then
			v13.PrefixText = "<font color=\'#" .. v_u_11[v15] .. "\'>[" .. v15 .. "]</font> " .. p12.PrefixText
		end
	end
	return v13
end
local function v_u_16()
	-- upvalues: (ref) v_u_9, (copy) v_u_2, (copy) v_u_3
	if v_u_9 > 5 then
		v_u_2.new():setImage(16149179345):setLabel("Commands", "Viewing"):bindEvent("selected", function()
			-- upvalues: (ref) v_u_3
			v_u_3:Toggle()
		end)
	end
end
if v_u_8 then
	v_u_16()
else
	task.delay(2, function()
		-- upvalues: (ref) v_u_8, (ref) v_u_9, (copy) v_u_16
		local v17, v18 = pcall(function()
			return game:GetService("Players").LocalPlayer:GetAttribute("Rank")
		end)
		v_u_8 = v17
		v_u_9 = v18
		if v_u_8 then
			v_u_16()
		end
	end)
end

workspace.Terrain.ChildAdded:Connect(function(p19)
	if p19:IsA("BoxHandleAdornment") or p19:IsA("SphereHandleAdornment") then
		p19.Visible = game:GetService("Players").LocalPlayer:GetAttribute("ShowHitboxes")
	end
end)

if game:GetService("Players").LocalPlayer.Character then
	game:GetService("Players").LocalPlayer.Character.Parent = workspace.IGNORE
end
local v_u_20 = game:GetService("Players").LocalPlayer:GetMouse()
v_u_20.TargetFilter = workspace.IGNORE
workspace.MAPS.DescendantAdded:Connect(function(p21)
	if (p21:IsA("MeshPart") or p21:IsA("BasePart")) and (p21.Transparency == 1 or p21.CanCollide == false) then
		if workspace:FindFirstChild("MAPS") and (workspace.MAPS:FindFirstChild("InventoryModel") and p21:IsDescendantOf(workspace.MAPS.InventoryModel)) then
			return
		end
		if workspace:FindFirstChild("MAPS") and (workspace.MAPS:FindFirstChild("ShopModel") and p21:IsDescendantOf(workspace.MAPS.ShopModel)) then
			return
		end
		task.wait(0.1)
		local v22 = p21:FindFirstAncestorOfClass("Model")
		if v22 and (v22:FindFirstChildOfClass("Humanoid") or v22:FindFirstChildOfClass("AnimationController")) then
			return
		end
		if game:GetService("Players").LocalPlayer:GetAttribute("ShowBarriers") and (p21.Transparency == 1 and p21.CanCollide) then
			p21:AddTag("Barrier")
			p21.Transparency = 0.95
			p21.Material = Enum.Material.Neon
		end
		p21.Locked = false
		if p21.Locked == false or p21.Parent == nil then
			p21.Parent = workspace.IGNORE
		end
	end
end)
local v23 = require(v1:WaitForChild("Modules"):WaitForChild("Warp"))
local v24 = v23.Client("Side")
local v_u_25 = v23.Client("Change")
local v26 = v23.Client("ChatMessage")
local v27 = v23.Client("MapAnnouncer")
local v_u_28 = game:GetService("UserInputService")
local v_u_29 = nil
v_u_28.InputChanged:Connect(function()
	-- upvalues: (copy) v_u_28, (ref) v_u_29, (copy) v_u_25
	if v_u_28:GetLastInputType() == Enum.UserInputType.Gamepad1 then
		if v_u_29 ~= "Console" then
			v_u_29 = "Console"
			v_u_25:Fire(true, v_u_29)
		end
	elseif v_u_29 ~= "PC" then
		v_u_29 = "PC"
		v_u_25:Fire(true, v_u_29)
	end
end)
v26:Connect(function(p30)
	game.TextChatService.TextChannels.RBXGeneral:DisplaySystemMessage(p30)
end)
local v_u_31 = 0
v27:Connect(function(_, p32)
	-- upvalues: (ref) v_u_31
	if tick() - v_u_31 >= 0.5 then
		v_u_31 = tick()
		p32:Play()
	end
end)

v_u_25:Connect(function(p33)
	if p33[1] then
		warn(p33);
		
		if p33[1] == "Module" then			
			require(p33[2])[p33[3]](p33[4])
			return
		end
		if p33[1] == "LightingChange" then
			if p33[5] then
				game:GetService("TweenService"):Create(game:GetService("Lighting"):FindFirstChildOfClass(p33[2]), TweenInfo.new(p33[5]), {
					[p33[3]] = p33[4]
				}):Play()
			else
				game:GetService("Lighting"):FindFirstChildOfClass(p33[2])[p33[3]] = p33[4]
			end
		end
		if p33[1] == "CameraSubject" then
			workspace.CurrentCamera.CameraSubject = p33[2]
			return
		end
		if p33[1] == "Lighting" then
			for _, v34 in game:GetService("Lighting"):GetChildren() do
				v34:Destroy()
			end
			local v35 = game:GetService("ReplicatedStorage").Lightings:FindFirstChild(p33[2]):Clone()
			for _, v36 in v35:FindFirstChild("Lighting"):GetChildren() do
				game:GetService("Lighting")[v36.Name] = v36.Value
			end
			for _, v37 in v35:GetChildren() do
				if v37:IsA("Clouds") then
					v37.Parent = game:GetService("Workspace").Terrain
				else
					v37.Parent = game:GetService("Lighting")
				end
			end
			return
		end
		
		if p33[1] == "Camera" then
			if p33[2] == "FieldOfView" then
				local v38 = p33[4] or 0
				game:GetService("TweenService"):Create(game:GetService("Workspace").CurrentCamera, TweenInfo.new(v38), {
					["FieldOfView"] = p33[3]
				}):Play()
			else
				workspace.CurrentCamera[p33[2]] = p33[3]
			end
		end
		
		if p33[2] == "Volume" then
			p33[1].Volume = p33[3]
			return
		end
		if p33[2] == "Invisibility" then
			for _, v39 in p33[1] do
				if v39:IsA("BasePart") and v39:GetAttribute("OGTransparency") < 1 then
					v39.Transparency = 0.75
				end
			end
			return
		end
		
		p33[1][p33[2]] = p33[3]
	end
end)
v24:Connect(function(p40, p41)
	-- upvalues: (copy) v_u_20, (copy) v_u_28
	if p40 == "Mouse" then
		return v_u_20.Hit.Position
	elseif p40 == "Camera" then
		return workspace.CurrentCamera[p41]
	elseif p40 == "CameraAuto" then
		local v42 = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -100)
		if game:GetService("Players").LocalPlayer.Character.Parent.Name == "KILLER" then
			local v43 = 100
			for _, v44 in workspace:WaitForChild("PLAYERS"):WaitForChild("ALIVE"):GetChildren() do
				if v44 ~= game:GetService("Players").LocalPlayer.Character and workspace.CurrentCamera:GetPartsObscuringTarget({ workspace.CurrentCamera.CFrame.Position, v44.HumanoidRootPart.Position }, { workspace.IGNORE, workspace.PLAYERS }) then
					local v45, v46 = workspace.CurrentCamera:WorldToViewportPoint(v44.HumanoidRootPart.Position)
					local v47 = (v45.X - v_u_20.ViewSizeX / 2) ^ 2 + (v45.Y - v_u_20.ViewSizeY / 2) ^ 2
					local v48 = math.sqrt(v47)
					if v46 and v48 < v43 then
						v42 = v44.HumanoidRootPart.CFrame
						v43 = v48
					end
				end
			end
			return v42
		else
			local v49 = 100
			for _, v50 in workspace:WaitForChild("PLAYERS"):WaitForChild("KILLER"):GetChildren() do
				if v50 ~= game:GetService("Players").LocalPlayer.Character and workspace.CurrentCamera:GetPartsObscuringTarget({ workspace.CurrentCamera.CFrame.Position, v50.HumanoidRootPart.Position }, { workspace.IGNORE, workspace.PLAYERS }) then
					local v51, v52 = workspace.CurrentCamera:WorldToViewportPoint(v50.HumanoidRootPart.Position)
					local v53 = (v51.X - v_u_20.ViewSizeX / 2) ^ 2 + (v51.Y - v_u_20.ViewSizeY / 2) ^ 2
					local v54 = math.sqrt(v53)
					if v52 and v54 < v49 then
						v42 = v50.HumanoidRootPart.CFrame
						v49 = v54
					end
				end
			end
			return v42
		end
	else
		if p40 == "Find" then
			return p41[1]:FindFirstChild(p41[2]) and true or false
		end
		if p40 == "Mobile?" then
			return v_u_28.TouchEnabled and true or false
		end
		if p40 == "Console?" then
			return v_u_28.GamepadEnabled and true or false
		end
		if p40 then
			return p40[p41]
		end
		return
	end
end)
local function v_u_57(p_u_55)
	repeat
		task.wait()
	until game:GetService("Players").LocalPlayer:GetAttribute("MusicVolume") and game:GetService("Players").LocalPlayer:GetAttribute("Volume")
	local v_u_56 = nil
	v_u_56 = p_u_55:GetPropertyChangedSignal("Parent"):Connect(function()
		-- upvalues: (copy) p_u_55, (ref) v_u_56
		if p_u_55.Parent == nil then
			v_u_56:Disconnect()
		end
	end)
	if p_u_55:HasTag("Music") then
		p_u_55.SoundGroup = game:GetService("SoundService").MusicVolume
		game:GetService("Workspace").GAME.STOP_MUSIC_ALL:GetPropertyChangedSignal("Value"):Connect(function()
			-- upvalues: (copy) p_u_55
			if game:GetService("Workspace").GAME.STOP_MUSIC_ALL.Value == true then
				p_u_55.Volume = 0
			end
		end)
	elseif p_u_55:IsDescendantOf(game:GetService("Players").LocalPlayer.PlayerGui) then
		p_u_55.SoundGroup = game:GetService("SoundService").UIVolume
	else
		if p_u_55.IsPlaying then
			p_u_55.TimePosition = 0
			p_u_55:Play()
		end
		if p_u_55:HasTag("EMOTE") then
			p_u_55.SoundGroup = game:GetService("SoundService").EmoteVolume
		else
			p_u_55.SoundGroup = game:GetService("SoundService").Volume
		end
	end
end
for _, v58 in workspace:QueryDescendants("Sound") do
	if v58:IsA("Sound") then
		v_u_57(v58)
	end
end
for _, v59 in game:GetService("Players").LocalPlayer.PlayerGui:QueryDescendants("Sound") do
	if v59:IsA("Sound") then
		v_u_57(v59)
	end
end
game:GetService("SoundService").UIVolume.Volume = game:GetService("Players").LocalPlayer:GetAttribute("UIVolume")
game:GetService("SoundService").EmoteVolume.Volume = game:GetService("Players").LocalPlayer:GetAttribute("EmoteVolume")
game:GetService("SoundService").Volume.Volume = game:GetService("Players").LocalPlayer:GetAttribute("Volume")
game:GetService("SoundService").MusicVolume.Volume = game:GetService("Players").LocalPlayer:GetAttribute("MusicVolume")
game:GetService("Players").LocalPlayer:GetAttributeChangedSignal("EmoteVolume"):Connect(function()
	game:GetService("SoundService").EmoteVolume.Volume = game:GetService("Players").LocalPlayer:GetAttribute("EmoteVolume")
end)
game:GetService("Players").LocalPlayer:GetAttributeChangedSignal("UIVolume"):Connect(function()
	game:GetService("SoundService").UIVolume.Volume = game:GetService("Players").LocalPlayer:GetAttribute("UIVolume")
end)
game:GetService("Players").LocalPlayer:GetAttributeChangedSignal("Volume"):Connect(function()
	game:GetService("SoundService").Volume.Volume = game:GetService("Players").LocalPlayer:GetAttribute("Volume")
end)
game:GetService("Players").LocalPlayer:GetAttributeChangedSignal("MusicVolume"):Connect(function()
	game:GetService("SoundService").MusicVolume.Volume = game:GetService("Players").LocalPlayer:GetAttribute("MusicVolume")
end)
workspace.DescendantAdded:Connect(function(p60)
	-- upvalues: (copy) v_u_57
	if p60:IsA("Sound") then
		v_u_57(p60)
	end
end)