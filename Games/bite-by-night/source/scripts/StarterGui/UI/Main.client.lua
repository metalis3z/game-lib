
workspace:WaitForChild("Lobby"):WaitForChild("TV"):WaitForChild("Screen"):WaitForChild("Board").Parent = game:GetService("Players").LocalPlayer.PlayerGui.UI
local TweenService = game:GetService("TweenService")
local Warp = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Warp"))
local Keybinds = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Keybinds"))
local Maid = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Maid"))
local v4 = Warp.Client("Side")
local v5 = Warp.Client("Escaped")
local Player = game:GetService("Players").LocalPlayer
if not Player.Character then
	Player.CharacterAdded:Wait()
end
local Character = Player.Character
local PlayerHealth = Character:WaitForChild("Humanoid").Health
local v9 = Character:GetAttribute("Dodges") or 0
local v11 = require(game:GetService("ReplicatedStorage").Modules.InfoCards)
local PlayerUI = script.Parent
local LobbyUIContainer = PlayerUI:FindFirstChild("UI"):WaitForChild("LobbyUIContainer", 10) -- // :nerd:
local GameUIContainer = PlayerUI:FindFirstChild("UI"):WaitForChild("GameUIContainer", 10)
local ShopUI = LobbyUIContainer.Shop
local InventoryUI = LobbyUIContainer.Inventory
game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Health, false)

local RankTranslation = require('@game/ReplicatedStorage/Modules/Misc/RankTranslations');

PlayerUI.UI.RoundKiller.Visible = false
local v17 = false
repeat
	task.wait()
until Player:HasTag("LOADED")
local function evalColorSequence(v18, v19)
	if v19 == 0 then
		return v18.Keypoints[1].Value
	elseif v19 == 1 then
		return v18.Keypoints[#v18.Keypoints].Value
	else
		for v20 = 1, #v18.Keypoints - 1 do
			local v21 = v18.Keypoints[v20]
			local v22 = v18.Keypoints[v20 + 1]
			if v21.Time <= v19 and v19 < v22.Time then
				local v23 = (v19 - v21.Time) / (v22.Time - v21.Time)
				return Color3.new((v22.Value.R - v21.Value.R) * v23 + v21.Value.R, (v22.Value.G - v21.Value.G) * v23 + v21.Value.G, (v22.Value.B - v21.Value.B) * v23 + v21.Value.B)
			end
		end
		return
	end
end
lerp = function(v25, v26, v27) --[[ Line: 62 ]] --[[ Name: lerp ]]
	return v25 + (v26 - v25) * v27
end
quadBezier = function(v28, v29, v30, v31) --[[ Line: 66 ]] --[[ Name: quadBezier ]]
	local v32 = lerp(v29, v30, v28)
	local v33 = lerp(v30, v31, v28)
	return (lerp(v32, v33, v28))
end
convertToHMS = function(v34) --[[ Line: 73 ]] --[[ Name: convertToHMS ]]
	local v35 = math.ceil(v34)
	local v36 = (v35 - v35 % 60) / 60
	v35 = v35 - v36 * 60
	v36 = v36 - (v36 - v36 % 60) / 60 * 60
	if v36 == 0 then
		v36 = 12
	end
	return {
		string.format("%01i", v36), 
		string.format("%02i", v35)
	}
end
local function setLMSInvisible()
	for _, v38 in next, GameUIContainer.LMS:GetDescendants() do
		if v38:IsA("GuiObject") then
			if v38:IsA("ImageButton") or v38:IsA("ImageLabel") then
				if not v38:GetAttribute("ImageTransparency") then
					v38:SetAttribute("ImageTransparency", v38.ImageTransparency)
				end
				v38.ImageTransparency = 1
			end
			if not v38:GetAttribute("BackgroundTransparency") then
				v38:SetAttribute("BackgroundTransparency", v38.BackgroundTransparency)
			end
			v38.BackgroundTransparency = 1
		end
	end
end
local function tweenLMSInvisible()
	for _, v41 in next, GameUIContainer.LMS:GetDescendants() do
		if v41:IsA("GuiObject") then
			local v42 = {BackgroundTransparency = 1}
			if v41:IsA("ImageButton") or v41:IsA("ImageLabel") then
				v42.ImageTransparency = 1
			end
			game:GetService("TweenService"):Create(v41, TweenInfo.new(1), v42):Play()
		end
	end
end
local function tweenLMSVisible()
	for _, v45 in next, GameUIContainer.LMS:GetDescendants() do
		if v45:IsA("GuiObject") then
			local v46 = {BackgroundTransparency = v45:GetAttribute("BackgroundTransparency")}
			if v45:IsA("ImageButton") or v45:IsA("ImageLabel") then
				v46.ImageTransparency = v45:GetAttribute("ImageTransparency")
			end
			game:GetService("TweenService"):Create(v45, TweenInfo.new(0.1), v46):Play()
		end
	end
end
local function LMS_PopUp()
	setLMSInvisible()
	tweenLMSVisible()
	GameUIContainer.LMS.Visible = true
	task.delay(4, function()
		tweenLMSInvisible()
		task.delay(1, function()
			GameUIContainer.LMS.Visible = false
		end)
	end)
end
local function StaticBuzz()
	LobbyUIContainer.Spectate:WaitForChild("Static"):WaitForChild("Static"):WaitForChild("UIGradient").Enabled = false
	LobbyUIContainer.Spectate:WaitForChild("Static").GroupTransparency = 0
	LobbyUIContainer.Spectate:WaitForChild("Static"):WaitForChild("Static").ImageTransparency = 0
	local v49 = game:GetService("TweenService"):Create(LobbyUIContainer.Spectate:WaitForChild("Static"), TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {GroupTransparency = 0.19})
	local v50 = game:GetService("TweenService"):Create(LobbyUIContainer.Spectate:WaitForChild("Static"):WaitForChild("Static"), TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {ImageTransparency = 1})
	local v51 = game:GetService("TweenService"):Create(LobbyUIContainer.Spectate:WaitForChild("Static"):WaitForChild("Static"), TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageTransparency = 0.63})
	v49:Play()
	v50:Play()
	v50.Completed:Connect(function()
		v51:Play()
		LobbyUIContainer.Spectate:WaitForChild("Static"):WaitForChild("Static"):WaitForChild("UIGradient").Enabled = true
	end)
end
local function Spectate(enabled: boolean)
	if LobbyUIContainer.Spectate.Visible == true or workspace.GAME.CURRENTMAP.Value == nil or not game:GetService("ReplicatedStorage").Lightings:FindFirstChild(workspace.GAME.CURRENTMAP.Value) then
		return
	else
		v17 = true
		LobbyUIContainer.Visible = true
		GameUIContainer.Visible = false
		if enabled then
			script.Parent.sfx.Spectate:Play()
			StaticBuzz()
			LobbyUIContainer.Spectate.Visible = true
			LobbyUIContainer:WaitForChild("Settings").Visible = false
			LobbyUIContainer:WaitForChild("Currency").Visible = false
			LobbyUIContainer:WaitForChild("Buttons").Visible = false
			LobbyUIContainer.Spectate.Back.Visible = true
		else
			LobbyUIContainer.Spectate.Back.Visible = true
		end
		for _, thing in game:GetService("Lighting"):GetChildren() do
			thing:Destroy()
		end
		local currentMapLighting = game:GetService("ReplicatedStorage").Lightings:FindFirstChild(workspace.GAME.CURRENTMAP.Value):Clone()
		for _, v58 in currentMapLighting:FindFirstChild("Lighting"):GetChildren() do
			game:GetService("Lighting")[v58.Name] = v58.Value
		end
		for _, v60 in currentMapLighting:GetChildren() do
			v60.Parent = game:GetService("Lighting")
		end
		if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("TouchGui") then
			game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("TouchGui").Enabled = false
		end
		LobbyUIContainer.Spectate.User.Username.Text = ""
		LobbyUIContainer.Spectate.User.Display.Text = ""
		local v61 = 1
		local v62 = {}
		local v63 = {}
		for _, v65 in workspace.PLAYERS.ALIVE:GetChildren() do
			table.insert(v62, v65)
			v63[#v63 + 1] = v65:FindFirstChildOfClass("Humanoid"):GetPropertyChangedSignal("Health"):Connect(function() --[[ Line: 203 ]]
				-- upvalues: v65 (copy), v62 (copy), v61 (ref), v13 (ref)
				if v65:FindFirstChildOfClass("Humanoid").Health <= 0 and table.find(v62, v65) then
					if v62[v61] == v65 then
						LobbyUIContainer:FindFirstChild("Spectate"):FindFirstChild("Static"):FindFirstChild("Static2").ImageTransparency = 0
						game:GetService("TweenService"):Create(LobbyUIContainer:FindFirstChild("Spectate"):FindFirstChild("Static"):FindFirstChild("Static2"), TweenInfo.new(0.5), {
							ImageTransparency = 0.98
						}):Play()
						if v62[v61 + 1] then
							v61 = v61 + 1
							workspace.CurrentCamera.CameraSubject = v62[v61]:FindFirstChildOfClass("Humanoid")
						elseif v62[v61 - 1] then
							v61 = v61 - 1
							workspace.CurrentCamera.CameraSubject = v62[v61]:FindFirstChildOfClass("Humanoid")
						elseif v62[#v62] then
							v61 = #v62
							workspace.CurrentCamera.CameraSubject = v62[v61]:FindFirstChildOfClass("Humanoid")
						elseif v62[v61] == v65 then
							LobbyUIContainer.Spectate.Nosignal.Visible = true
						end
					end
					LobbyUIContainer.Spectate.User.Username.Text = "@" .. v62[v61].Name
					LobbyUIContainer.Spectate.User.Display.Text = v62[v61]:FindFirstChildOfClass("Humanoid").DisplayName
					table.remove(v62, table.find(v62, v65))
				end
			end)
			v63[#v63 + 1] = v65:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 228 ]]
				-- upvalues: v65 (copy), v62 (copy), v61 (ref), v13 (ref)
				if v65.Parent == nil and table.find(v62, v65) then
					if v62[v61] == v65 then
						LobbyUIContainer:FindFirstChild("Spectate"):FindFirstChild("Static"):FindFirstChild("Static2").ImageTransparency = 0
						game:GetService("TweenService"):Create(LobbyUIContainer:FindFirstChild("Spectate"):FindFirstChild("Static"):FindFirstChild("Static2"), TweenInfo.new(0.5), {
							ImageTransparency = 0.98
						}):Play()
					end
					if v62[v61 + 1] then
						v61 = v61 + 1
						workspace.CurrentCamera.CameraSubject = v62[v61]:FindFirstChildOfClass("Humanoid")
					elseif v62[v61 - 1] then
						v61 = v61 - 1
						workspace.CurrentCamera.CameraSubject = v62[v61]:FindFirstChildOfClass("Humanoid")
					elseif v62[#v62] then
						v61 = #v62
						workspace.CurrentCamera.CameraSubject = v62[v61]:FindFirstChildOfClass("Humanoid")
					elseif v62[v61] == v65 then
						LobbyUIContainer.Spectate.Nosignal.Visible = true
					end
					LobbyUIContainer.Spectate.User.Username.Text = "@" .. v62[v61].Name
					LobbyUIContainer.Spectate.User.Display.Text = v62[v61]:FindFirstChildOfClass("Humanoid").DisplayName
					table.remove(v62, table.find(v62, v65))
				end
			end)
		end
		for _, v67 in workspace.PLAYERS.KILLER:GetChildren() do
			table.insert(v62, v67)
			v63[#v63 + 1] = v67.ChildRemoved:Connect(function() --[[ Line: 258 ]]
				-- upvalues: v67 (copy)
				local l_Humanoid_0 = v67:FindFirstChildOfClass("Humanoid")
				if l_Humanoid_0 then
					task.wait(0.5)
					l_Humanoid_0.CameraOffset = Vector3.new(0, 0, 0, 0)
				end
			end)
			v63[#v63 + 1] = v67.ChildAdded:Connect(function() --[[ Line: 266 ]]
				-- upvalues: v67 (copy)
				local l_Humanoid_1 = v67:FindFirstChildOfClass("Humanoid")
				if l_Humanoid_1 then
					task.wait(0.5)
					l_Humanoid_1.CameraOffset = Vector3.new(0, 0, 0, 0)
				end
			end)
			v63[#v63 + 1] = v67:FindFirstChildOfClass("Humanoid"):GetPropertyChangedSignal("Health"):Connect(function() --[[ Line: 274 ]]
				-- upvalues: v67 (copy), v62 (copy), v61 (ref), v13 (ref)
				if v67:FindFirstChildOfClass("Humanoid").Health <= 0 and table.find(v62, v67) then
					if v62[v61 + 1] then
						v61 = v61 + 1
						workspace.CurrentCamera.CameraSubject = v62[v61]:FindFirstChildOfClass("Humanoid")
					elseif v62[v61 - 1] then
						v61 = v61 - 1
						workspace.CurrentCamera.CameraSubject = v62[v61]:FindFirstChildOfClass("Humanoid")
					elseif v62[#v62] then
						v61 = #v62
						workspace.CurrentCamera.CameraSubject = v62[v61]:FindFirstChildOfClass("Humanoid")
					elseif v62[v61] == v67 then
						LobbyUIContainer.Spectate.Nosignal.Visible = true
					end
					LobbyUIContainer.Spectate.User.Username.Text = "@" .. v62[v61].Name
					LobbyUIContainer.Spectate.User.Display.Text = v62[v61]:FindFirstChildOfClass("Humanoid").DisplayName
					table.remove(v62, table.find(v62, v67))
				end
			end)
			v63[#v63 + 1] = v67:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 294 ]]
				-- upvalues: v67 (copy), v62 (copy), v61 (ref), v13 (ref)
				if v67.Parent == nil and table.find(v62, v67) then
					if v62[v61 + 1] then
						v61 = v61 + 1
						workspace.CurrentCamera.CameraSubject = v62[v61]:FindFirstChildOfClass("Humanoid")
					elseif v62[v61 - 1] then
						v61 = v61 - 1
						workspace.CurrentCamera.CameraSubject = v62[v61]:FindFirstChildOfClass("Humanoid")
					elseif v62[#v62] then
						v61 = #v62
						workspace.CurrentCamera.CameraSubject = v62[v61]:FindFirstChildOfClass("Humanoid")
					elseif v62[v61] == v67 then
						LobbyUIContainer.Spectate.Nosignal.Visible = true
					end
					LobbyUIContainer.Spectate.User.Username.Text = "@" .. v62[v61].Name
					LobbyUIContainer.Spectate.User.Display.Text = v62[v61]:FindFirstChildOfClass("Humanoid").DisplayName
					table.remove(v62, table.find(v62, v67))
				end
			end)
		end
		if v62[1] then
			LobbyUIContainer.Spectate.User.Display.Text = v62[1]:FindFirstChildOfClass("Humanoid").DisplayName
			LobbyUIContainer.Spectate.User.Username.Text = v62[1].Name
			workspace.CurrentCamera.CameraSubject = v62[1]:FindFirstChildOfClass("Humanoid")
		else
			LobbyUIContainer.Spectate.Nosignal.Visible = true
		end
		local v70 = nil
		local v71 = nil
		local v72 = nil
		local v73 = nil
		local v74 = nil
		local function Stop()
			v17 = false
			for _, v76 in v63 do
				v76:Disconnect()
			end
			for _, v78 in LobbyUIContainer.Buttons:GetChildren() do
				v78.Visible = true
			end
			LobbyUIContainer.Spectate.Visible = false
			LobbyUIContainer.Currency.Visible = true
			if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("TouchGui") then
				game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("TouchGui").Enabled = true
			end
			for _, v80 in game:GetService("Lighting"):GetChildren() do
				v80:Destroy()
			end
			local v81 = game:GetService("ReplicatedStorage").Lightings:FindFirstChild("Lobby"):Clone()
			for _, v83 in v81:FindFirstChild("Lighting"):GetChildren() do
				game:GetService("Lighting")[v83.Name] = v83.Value
			end
			for _, v85 in v81:GetChildren() do
				v85.Parent = game:GetService("Lighting")
			end
			workspace.CurrentCamera.CameraSubject = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			v70:Disconnect()
			v71:Disconnect()
			v72:Disconnect()
			v73:Disconnect()
			v74:Disconnect()
		end
		v70 = LobbyUIContainer.Spectate.User.Next.Button.MouseButton1Click:Connect(function()
			if not v62[1] then
				return
			else
				LobbyUIContainer.Spectate.Nosignal.Visible = false
				LobbyUIContainer:FindFirstChild("Spectate"):FindFirstChild("Static"):FindFirstChild("Static2").ImageTransparency = 0
				game:GetService("TweenService"):Create(LobbyUIContainer:FindFirstChild("Spectate"):FindFirstChild("Static"):FindFirstChild("Static2"), TweenInfo.new(0.5), {
					ImageTransparency = 0.98
				}):Play()
				v61 = v61 + 1
				if v61 > #v62 then
					v61 = 1
				end
				if v62[v61] then
					workspace.CurrentCamera.CameraSubject = v62[v61]:FindFirstChildOfClass("Humanoid")
					local l_Humanoid_2 = v62[v61]:FindFirstChildOfClass("Humanoid")
					if l_Humanoid_2 then
						l_Humanoid_2.CameraOffset = Vector3.new(0, 0, 0, 0)
					end
					LobbyUIContainer.Spectate.User.Username.Text = "@" .. v62[v61].Name
					LobbyUIContainer.Spectate.User.Display.Text = v62[v61]:FindFirstChildOfClass("Humanoid").DisplayName
					script.Parent.sfx.Spectate:Play()
				end
				return
			end
		end)
		v71 = LobbyUIContainer.Spectate.User.Previous.Button.MouseButton1Click:Connect(function()
			if not v62[1] then
				return
			else
				LobbyUIContainer.Spectate.Nosignal.Visible = false
				LobbyUIContainer:FindFirstChild("Spectate"):FindFirstChild("Static"):FindFirstChild("Static2").ImageTransparency = 0
				game:GetService("TweenService"):Create(LobbyUIContainer:FindFirstChild("Spectate"):FindFirstChild("Static"):FindFirstChild("Static2"), TweenInfo.new(0.5), {
					ImageTransparency = 0.98
				}):Play()
				v61 = v61 - 1
				if v61 < 1 then
					v61 = #v62
				end
				if v62[v61] then
					workspace.CurrentCamera.CameraSubject = v62[v61]:FindFirstChildOfClass("Humanoid")
					local l_Humanoid_3 = v62[v61]:FindFirstChildOfClass("Humanoid")
					if l_Humanoid_3 then
						l_Humanoid_3.CameraOffset = Vector3.new(0, 0, 0, 0)
					end
					LobbyUIContainer.Spectate.User.Username.Text = "@" .. v62[v61].Name
					LobbyUIContainer.Spectate.User.Display.Text = v62[v61]:FindFirstChildOfClass("Humanoid").DisplayName
					script.Parent.sfx.Spectate:Play()
				end
				return
			end
		end)
		v72 = LobbyUIContainer.Spectate.Back.Button.MouseButton1Click:Once(function() --[[ Line: 413 ]]
			-- upvalues: v17 (ref)
			v17 = false
		end)
		v73 = game:GetService("UserInputService").InputBegan:Connect(function(v89, v90) --[[ Line: 416 ]]
			-- upvalues: v62 (copy), v13 (ref), v61 (ref)
			if v90 then
				return
			elseif not v62[1] then
				return
			else
				if v89.KeyCode == Enum.KeyCode.E then
					LobbyUIContainer.Spectate.Nosignal.Visible = false
					LobbyUIContainer:FindFirstChild("Spectate"):FindFirstChild("Static"):FindFirstChild("Static2").ImageTransparency = 0
					game:GetService("TweenService"):Create(LobbyUIContainer:FindFirstChild("Spectate"):FindFirstChild("Static"):FindFirstChild("Static2"), TweenInfo.new(0.5), {
						ImageTransparency = 0.98
					}):Play()
					v61 = v61 - 1
					if v61 < 1 then
						v61 = #v62
					end
					if v62[v61] then
						workspace.CurrentCamera.CameraSubject = v62[v61]:FindFirstChildOfClass("Humanoid")
						local l_Humanoid_4 = v62[v61]:FindFirstChildOfClass("Humanoid")
						if l_Humanoid_4 then
							l_Humanoid_4.CameraOffset = Vector3.new(0, 0, 0, 0)
						end
						LobbyUIContainer.Spectate.User.Username.Text = "@" .. v62[v61].Name
						LobbyUIContainer.Spectate.User.Display.Text = v62[v61]:FindFirstChildOfClass("Humanoid").DisplayName
						script.Parent.sfx.Spectate:Play()
						return
					end
				elseif v89.KeyCode == Enum.KeyCode.Q then
					LobbyUIContainer.Spectate.Nosignal.Visible = false
					LobbyUIContainer:FindFirstChild("Spectate"):FindFirstChild("Static"):FindFirstChild("Static2").ImageTransparency = 0
					game:GetService("TweenService"):Create(LobbyUIContainer:FindFirstChild("Spectate"):FindFirstChild("Static"):FindFirstChild("Static2"), TweenInfo.new(0.5), {
						ImageTransparency = 0.98
					}):Play()
					v61 = v61 + 1
					if v61 > #v62 then
						v61 = 1
					end
					if v62[v61] then
						workspace.CurrentCamera.CameraSubject = v62[v61]:FindFirstChildOfClass("Humanoid")
						local l_Humanoid_5 = v62[v61]:FindFirstChildOfClass("Humanoid")
						if l_Humanoid_5 then
							l_Humanoid_5.CameraOffset = Vector3.new(0, 0, 0, 0)
						end
						LobbyUIContainer.Spectate.User.Username.Text = "@" .. v62[v61].Name
						LobbyUIContainer.Spectate.User.Display.Text = v62[v61]:FindFirstChildOfClass("Humanoid").DisplayName
						script.Parent.sfx.Spectate:Play()
					end
				end
				return
			end
		end)
		v74 = game:GetService("Workspace").GAME.MODE:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 463 ]]
			-- upvalues: v13 (ref)
			if workspace.GAME.MODE.Value ~= "GAME" then
				LobbyUIContainer.Spectate.Nosignal.Visible = true
			end
		end)
		repeat
			task.wait(0.01)
		until v17 == false
		Stop()
	end
end

v5:Connect(function(v94)
	if v94 then
		for _, v96 in next, GameUIContainer.Players.List:GetChildren() do
			if v96.Name == v94 then
				v96.Viewport.Escape.Visible = true
			end
		end
	end
end)

local function createNewPlayerIcon(Character: Model)
	if GameUIContainer.Players.List:FindFirstChild(Character.Name) then
		warn('Clear')

		GameUIContainer.Players.List:FindFirstChild(Character.Name):Destroy();
	end
	
	local Humanoid = Character:FindFirstChildOfClass('Humanoid');
	if not Humanoid then
		return
	end
	
	local CharacterAttribute = Character:GetAttribute('Character');
	local CharacterName = string.split(CharacterAttribute, '-');
	local PlayerIconHolder = script.Player:Clone();
	local IconViewport = PlayerIconHolder:FindFirstChild('Viewport');
	local DisplayFrame = PlayerIconHolder:FindFirstChild('Display');
	local Class = PlayerIconHolder:FindFirstChild('Class');
	local ClassHolder = Class:FindFirstChild('Holder');
	local DisplayHolder = DisplayFrame:FindFirstChild('Holder');
	
	PlayerIconHolder.Name = Character.Name -- // Aka player name ^^
	
	if CharacterName then
		ClassHolder.Text.Text = CharacterName[2] or ''
	else 
		ClassHolder.Text.Text = CharacterAttribute
	end
	
	-- // This call is uncertain as the character could be a placeholder / template.
	pcall(function(): ()
		local PlayerInstance = game:GetService('Players'):GetPlayerFromCharacter(Character);
		if PlayerInstance then
			if (PlayerInstance:HasTag('VIP_OWN') and PlayerInstance:GetAttribute('VIPTag') == true) then
				DisplayHolder.Username.VIP_Gradient.Enabled = true
				DisplayHolder.VIP.Visible = true
			end
			
			if PlayerInstance then
				local Success, RoleInGroup = pcall(function()
					return PlayerInstance:GetRoleInGroupAsync(635601940); -- // Replace this group one day
				end)
				
				if not Success then
					warn(`Couldn't get the role for {PlayerInstance.Name} !`);
					
					return
				end
				
				if (table.find(RankTranslation.DevRoles, RoleInGroup) or table.find(RankTranslation.MaxPermsIds, PlayerInstance.UserId)) then
					DisplayHolder.Developer.Visible = true
					DisplayHolder.Username.VIP_Gradient.Enabled = false
					DisplayHolder.VIP.Visible = false
				end
				
				if (PlayerInstance.HasVerifiedBadge or table.find(RankTranslation.MaxPermsIds, PlayerInstance.UserId)) then
					DisplayHolder.Verified.Visible = true
				end
			end
			
			local PlayerState = 'Alive'
			local WasIngame = PlayerInstance and true or false
			local Connections: RBXScriptConnection = {}
			
			Connections[#Connections + 1] = Humanoid.HealthChanged:Connect(function(): ()
				if PlayerState == 'Alive' then
					if Humanoid.Health <= 0 and workspace.GAME.DISPLAY_DEATHS.Value then
						PlayerState = 'Dead'
						
						DisplayHolder.Username.TextColor3 = Color3.fromRGB(56, 56, 56);
						ClassHolder.Text.TextColor3 = Color3.fromRGB(75, 75, 75);
						IconViewport.ViewportFrame.ImageColor3 = Color3.fromRGB(255, 0, 0);
						IconViewport.Death.Visible = true
					else
						PlayerState = 'Alive'

						DisplayHolder.Username.TextColor3 = Color3.fromRGB(127, 127, 127);
						ClassHolder.Text.TextColor3 = Color3.fromRGB(255, 255, 255);
						IconViewport.ViewportFrame.ImageColor3 = Color3.fromRGB(255, 255, 255);
						IconViewport.Death.Visible = false
					end
				end
			end)
			
			Connections[#Connections + 1] = Character:GetPropertyChangedSignal('Parent'):Connect(function(): ()
				if PlayerState == 'Alive' then
					if Character.Parent == nil and workspace.GAME.DISPLAY_DEATHS.Value then
						PlayerState = 'Leave'
						
						if not IconViewport.Escape.Visible then
							if WasIngame and PlayerInstance == nil then
								IconViewport.Leave.Visible = true
								IconViewport.ViewportFrame.ImageColor3 = Color3.fromRGB(56, 56, 56);
							else 
								IconViewport.Death.Visible = true
								IconViewport.ViewportFrame.ImageColor3 = Color3.fromRGB(255, 0, 0);
							end
						else 
							IconViewport.ViewportFrame.ImageColor3 = Color3.fromRGB(56, 56, 56);
						end
						
						DisplayHolder.Username.TextColor3 =  Color3.fromRGB(56, 56, 56);
						ClassHolder.Text.TextColor3 =  Color3.fromRGB(75, 75, 75);
					end
				end
			end)
			
			Connections[#Connections + 1] = PlayerIconHolder:GetPropertyChangedSignal('Parent'):Connect(function(): ()
				if PlayerIconHolder.Parent ~= nil then
					return
				end
				
				for _, Connection in Connections do 
					if typeof(Connection) == 'RBXScriptConnection' then
						Connection:Disconnect();
					end
				end
				
				table.clear(Connections);
			end)
			
			Connections[#Connections + 1] = workspace.GAME.GAMEMODE:GetPropertyChangedSignal('Value'):Connect(function(): ()
				if workspace.GAME.GAMEMODE.Value ~= 'GAME' then
					for _, Connection in Connections do 
						if typeof(Connection) == 'RBXScriptConnection' then
							Connection:Disconnect();
						end
					end

					table.clear(Connections);
				end
			end)
		else
			warn(`No player instance for {Character.Name}`);
		end
	end)
	
	DisplayHolder.Username.Text = `@{Humanoid.DisplayName}`
	PlayerIconHolder.Parent = GameUIContainer.Players.List
	
	task.delay(1.5, function(): ()
		if IconViewport then
			pcall(function(): ()
				IconViewport.ViewportFrame.WorldModel.Rig.Humanoid:ApplyDescriptionAsync(Humanoid:GetAppliedDescription());
			end)
		end
	end)
end

Player.CharacterAdded:Connect(function()
	setLMSInvisible()
	LobbyUIContainer.Inventory.EmoteEquip.Visible = false
	LobbyUIContainer.Shop.Visible = false
	LobbyUIContainer.Inventory.Visible = false
	game:GetService("UserInputService").MouseBehavior = Enum.MouseBehavior.Default
	game:GetService("UserInputService").MouseIconEnabled = true
	game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
	task.wait(0.05)
	InventoryUI.Visible = false
	ShopUI.Visible = false
	for _, frame in GameUIContainer.Effects:GetChildren() do
		if frame:IsA("Frame") then
			frame:Destroy()
		end
	end
	for _, button in LobbyUIContainer.Buttons:GetChildren() do
		button.Visible = true
	end
	for _, frame in GameUIContainer.Players.List:GetChildren() do
		if frame:IsA("Frame") then
			frame:Destroy()
		end
	end
	for _, child in workspace.PLAYERS.ALIVE:GetChildren() do
		if child:FindFirstChildOfClass("Humanoid") then
			createNewPlayerIcon(child)
		end
	end
	PlayerUI.UI.RoundKiller.Visible = false
	script.Parent.Static.Visible = false
	Character = Player.Character
	workspace.CurrentCamera.CameraSubject = Character:FindFirstChildOfClass("Humanoid")
	workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
	PlayerHealth = Character:WaitForChild("Humanoid").Health
	v9 = Character:GetAttribute("Dodges")
	GameUIContainer.Timer.Holder.Rotation = 0
	LobbyUIContainer.Spectate.Visible = false
	LobbyUIContainer.Settings.Visible = false
	LobbyUIContainer.Currency.Visible = true

	for _, escape in next, workspace.IGNORE:GetChildren() do
		if escape.Name == "EscapePoint" and escape:FindFirstChild("Highlight") then
			escape.Highlight.Enabled = false
		end
	end
end)


local v117 = Warp.Client("Dialogue")
warn(v117)

local v118 = Warp.Client("Side")
local v119 = Warp.Client("ScreenEffect")
local v120 = v118:Invoke(999, "Data")
local l_Dialogues_0 = require('@game/ReplicatedStorage/Modules/Dialogues');

for _, child in workspace.PLAYERS.ALIVE:GetChildren() do
	if child:FindFirstChildOfClass("Humanoid") then
		createNewPlayerIcon(child)
	end
end

workspace.PLAYERS.ALIVE.ChildAdded:Connect(function(child)
	if child:FindFirstChildOfClass("Humanoid") then
		createNewPlayerIcon(child)
	end
end)

v119:Connect(function(v125)
	warn(v125[1]);
	warn(v125);

	if v125[1] == "TimerBreak" then
		for _ = 1, v125[5] do
			local v127 = script:WaitForChild("Effects"):WaitForChild("Triangle"):Clone()
			v127.Position = UDim2.new(0.5, 0, 0.075, 0)
			v127.ImageColor3 = v125[4]
			v127.Size = UDim2.new(0.1, 0, Random.new():NextNumber(v125[2], v125[3]), 0)
			v127.Parent = GameUIContainer.Effects
			task.spawn(function()
				local v128 = math.random(50, 125)
				local v129 = Random.new():NextNumber(0, 1)
				local l_Scale_0 = v127.Position.X.Scale
				local l_Scale_1 = v127.Position.Y.Scale
				local v132 = false
				if v129 > 0.5 then
					v132 = true
				end
				game:GetService("TweenService"):Create(v127, TweenInfo.new(v128 / 125, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
					Size = UDim2.new(0, 0, 0, 0)
				}):Play()
				for v133 = 1, v128 do
					local v134 = nil
					local v135 = quadBezier(v133 / v128, l_Scale_1, 0.1, 1)
					if v132 then
						local l_v127_0 = v127
						l_v127_0.Rotation = l_v127_0.Rotation + 5
						v134 = quadBezier(v133 / v128, l_Scale_0, 0.6, v129)
					else
						local l_v127_1 = v127
						l_v127_1.Rotation = l_v127_1.Rotation - 5
						v134 = quadBezier(v133 / v128, l_Scale_0, 0.4, v129)
					end
					v127.Position = UDim2.new(v134, 0, v135, 0)
					task.wait(0.01)
				end
			end)
		end
	end
	if v125[1] == "Spectate" then Spectate(true) return end
	if v125[1] == "SpectateDisable" then v17 = false return end
	if v125[1] == "LMS" then
		warn('LMS thing omg !');

		setLMSInvisible()
		tweenLMSVisible()
		GameUIContainer.LMS.Visible = true
		task.delay(4, function()
			tweenLMSInvisible()
			task.delay(1, function()
				GameUIContainer.LMS.Visible = false
			end)
		end)
	end
end)

Dialogue = function(v138, v139)
	if not l_Dialogues_0[v138] or not l_Dialogues_0[v138].Texts[v139] then
		return
	else
		for _, v141 in l_Dialogues_0[v138].Texts[v139] do
			if v141[3].SoundId ~= "rbxassetid://0" then
				local l_Sound_0 = Instance.new("Sound")
				l_Sound_0.Volume = v141[4] or 1
				l_Sound_0.SoundId = v141[3]
				l_Sound_0.Name = "TextSound"
				l_Sound_0.Parent = workspace
				if l_Sound_0.IsLoaded == false and l_Sound_0.SoundId ~= "rbxassetid://0" then
					repeat
						task.wait()
					until l_Sound_0.IsLoaded == true
				end
				l_Sound_0:Play()
				local l_l_Sound_0_0 = l_Sound_0 --[[ copy: 8 -> 26 ]]
				task.delay(l_Sound_0.TimeLength, function() --[[ Line: 716 ]]
					-- upvalues: l_l_Sound_0_0 (copy)
					l_l_Sound_0_0:Destroy()
				end)
			end
			local v144 = script.Dialogue:Clone()
			v144.ICON.Image = l_Dialogues_0[v138].Icon
			v144.Parent = PlayerUI["DIALOGUE-POPUP"]
			local v145 = {}
			local v146 = {}
			local v147 = {}
			for v148 = 1, #v141[1] do
				if string.sub(v141[1], v148, v148) == "," then
					table.insert(v145, v148)
				elseif string.sub(v141[1], v148, v148) == "." then
					table.insert(v146, v148)
				elseif string.sub(v141[1], v148, v148) == "-" then
					table.insert(v147, v148)
				end
			end
			local v149 = v141[8] or 5
			local v150 = string.split(v141[7], "-")
			local v151 = 0
			if v150[1] == "Shake" and v150[3] then
				v151 = tonumber(v150[3])
			end
			do
				local l_v151_0 = v151
				for v153 = 1, #v141[1] do
					local v154 = script.textFrame:Clone()
					v154.text.FontFace = l_Dialogues_0[v138].Font
					v154.text.Text = string.sub(v141[1], v153, v153)
					if typeof(v141[2]) == "Color3" then
						v154.text.TextColor3 = v141[2]
					elseif typeof(v141[2]) == "ColorSequence" then
						v154.text.TextColor3 = evalColorSequence(v141[2], v153 / #v141[1])
					else
						if v141[2].Text then
							v154.text.TextColor3 = v141[2].Text
						end
						if v141[2].Stroke then
							v154.text.UIStroke.Enabled = true
							if typeof(v141[2].Stroke) == "ColorSequence" then
								v154.text.UIStroke.Color = evalColorSequence(v141[2].Stroke, v153 / #v141[1])
							else
								v154.text.UIStroke.Color = v141[2].Stroke
							end
						end
						if v141[2].Font then
							v154.text.FontFace = v141[2].Font
						end
					end
					v154.Shadow.Position = UDim2.new(0.62, 0, 0.047, 0)
					v154.text.Position = UDim2.new(0.5, 0, 0, 0)
					v154.text.Visible = false
					v154.Parent = v144
					local function Show(v155)
						v154.text.Visible = true
						if v141[7] == "Fancy" then
							game:GetService("TweenService"):Create(v154.text, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
								Position = UDim2.new(0.5, 0, 0.6, 0)
							}):Play()
							task.delay(0.5, function()
								game:GetService("TweenService"):Create(v154.text, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
									Position = UDim2.new(0.5, 0, 0.5, 0)
								}):Play()
							end)
						elseif v141[7] == "Shake" or v150[1] == "Shake" then
							task.spawn(function()
								local v156 = v150[2] or 0.1
								v154.text.Position = UDim2.new(Random.new():NextNumber(0.4, 0.6), 0, Random.new():NextNumber(0.4, 0.6), 0)
								while task.wait(v156) and v154 ~= nil and v154:FindFirstChild("text") and v154.Parent ~= nil and l_v151_0 ~= 0 do
									v154.text.Position = UDim2.new(Random.new():NextNumber(0.4, 0.6), 0, Random.new():NextNumber(0.4, 0.6), 0)
									l_v151_0 = l_v151_0 - 1
								end
								if v154:FindFirstChild("text") then
									v154.text.Position = UDim2.new(0.5, 0, 0.5, 0)
								end
							end)
						elseif v141[7] == "Fade" then
							v154.text.TextTransparency = 1
							v154.Shadow.ImageTransparency = 1
							game:GetService("TweenService"):Create(v154.text, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
								Position = UDim2.new(0.5, 0, 0.5, 0), 
								TextTransparency = 0
							}):Play()
							game:GetService("TweenService"):Create(v154.Shadow, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
								Position = UDim2.new(0.62, 0, 0.547, 0), 
								ImageTransparency = 0
							}):Play()
						elseif v141[7] == "Scale" then
							v154.Shadow.Size = UDim2.new(0, 0, 0, 0)
							v154.text.Size = UDim2.new(0, 0, 0, 0)
							v154.text.Position = UDim2.new(0.5, 0, 0.5, 0)
							game:GetService("TweenService"):Create(v154.text, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
								Position = UDim2.new(0.5, 0, 0.5, 0), 
								Size = UDim2.new(1, 0, 1, 0)
							}):Play()
							game:GetService("TweenService"):Create(v154.Shadow, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
								Size = UDim2.new(3.219, 0, 1.252, 0)
							}):Play()
						elseif v141[7] == "Impact" then
							v154.text.Position = UDim2.new(0.5, 0, 0.5, 0)
							v154.Shadow.Position = UDim2.new(0.62, 0, 0.547, 0)
						else
							game:GetService("TweenService"):Create(v154.text, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
								Position = UDim2.new(0.5, 0, 0.5, 0)
							}):Play()
							game:GetService("TweenService"):Create(v154.Shadow, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
								Position = UDim2.new(0.62, 0, 0.547, 0)
							}):Play()
						end
						task.delay(v149 - 0.5 - v155 + v153 / #v141[1], function()
							game:GetService("TweenService"):Create(v154.text, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
								TextTransparency = 1
							}):Play()
							game:GetService("TweenService"):Create(v154.Shadow, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
								ImageTransparency = 1
							}):Play()
							game:GetService("TweenService"):Create(v154.text.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
								Transparency = 1
							}):Play()
						end)
					end
					if v141[7] == "Impact" then
						Show(0)
					else
						local v158 = v153 * v141[5]
						for _, v160 in v145 do
							if v160 < v153 then
								v158 = v158 + 0.5
							end
						end
						for _, v162 in v146 do
							if v162 < v153 then
								v158 = v158 + 0.75
							end
						end
						for _, v164 in v147 do
							if v164 < v153 then
								v158 = v158 + 1
							end
						end
						do
							local l_v158_0 = v158
							task.delay(l_v158_0, function()
								Show(l_v158_0)
							end)
						end
					end
				end
				task.delay(v149 - 0.6 + 1 / #v141[1], function()
					game:GetService("TweenService"):Create(v144.ICON, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
						ImageTransparency = 1, 
						BackgroundTransparency = 1
					}):Play()
				end)
				task.wait(#v141[1] * v141[5] + #v145 * 0.5 + #v146 * 0.75 + #v147 * 1)
				task.delay(v149 + 1, function()
					v144:Destroy()
				end)
				task.wait(v141[6])
			end
		end
	end
end

local CreateButton = function(v166)
	if not v166:FindFirstChild("Shine") then
		return
	else
		local l_Shine_0 = v166:FindFirstChild("Shine")
		v166.MouseEnter:Connect(function()
			PlayerUI.sfx.Hover:Play()
			l_Shine_0:FindFirstChildOfClass("UIGradient").Offset = Vector2.new(-2, 0)
			TweenService:Create(l_Shine_0:FindFirstChildOfClass("UIGradient"), TweenInfo.new(0.5), {
				Offset = Vector2.new(2, 0)
			}):Play()
			if v166:FindFirstChild("ICON") and v166:FindFirstChild("ICON"):GetAttribute("OPEN") then
				v166:FindFirstChild("ICON").Image = v166:FindFirstChild("ICON"):GetAttribute("OPEN")
			end
			if v166:FindFirstChild("BORDER") then
				TweenService:Create(v166:FindFirstChild("BORDER"), TweenInfo.new(0.25), {
					Size = UDim2.new(1.25, 0, 1.25, 0)
				}):Play()
			end
		end)
		v166.MouseLeave:Connect(function()
			if v166:FindFirstChild("ICON") and v166:FindFirstChild("ICON"):GetAttribute("CLOSED") then
				v166:FindFirstChild("ICON").Image = v166:FindFirstChild("ICON"):GetAttribute("CLOSED")
			end
			if v166:FindFirstChild("BORDER") then
				TweenService:Create(v166:FindFirstChild("BORDER"), TweenInfo.new(0.25), {
					Size = UDim2.new(1.1, 0, 1.1, 0)
				}):Play()
			end
		end)
		v166.MouseButton1Click:Connect(function()
			PlayerUI.sfx.Click:Play()
		end)
	end
end

v117:Connect(function(v170, v171, v172)	
	if l_Dialogues_0[v170] then
		Dialogue(v170, v171)
	else
		Dialogue(v172, v171)
	end
end)

local v173 = 1
local v174 = 0
local function LoadEmoteWheel()
	v174 = v174 + 1
	local l_v174_0 = v174
	local CharAttribute = game:GetService("Players").LocalPlayer.Character:GetAttribute("Character")
	local SkinAttribute = game:GetService("Players").LocalPlayer.Character:GetAttribute("Skin")
	local v178 = nil
	local v179 = nil
	if CharAttribute:match("Survivor") then
		local v180 = string.split(CharAttribute, "-")
		v178 = game:GetService("ReplicatedStorage").Characters.Survivor:FindFirstChild("Customer"):FindFirstChild(game:GetService("ReplicatedStorage").Characters.Survivor:GetAttribute("Default"))
		v179 = game:GetService("ReplicatedStorage").Characters.Survivor:FindFirstChild(v180[2]):FindFirstChild(game:GetService("ReplicatedStorage").Characters.Survivor:GetAttribute("Default"))
		if game:GetService("ReplicatedStorage").Characters.Survivor:FindFirstChild(v180[2]):FindFirstChild(SkinAttribute) then
			v179 = game:GetService("ReplicatedStorage").Characters.Survivor:FindFirstChild(v180[2]):FindFirstChild(SkinAttribute)
		end
	else
		v178 = game:GetService("ReplicatedStorage").Characters:FindFirstChild(CharAttribute):FindFirstChild(game:GetService("ReplicatedStorage").Characters:FindFirstChild(CharAttribute):GetAttribute("Default"))
		v179 = game:GetService("ReplicatedStorage").Characters:FindFirstChild(CharAttribute):FindFirstChild(SkinAttribute)
	end
	for v181 = 1, 4 do
		for _, v183 in PlayerUI.EmoteWheel:FindFirstChild("Button" .. v181, true):FindFirstChildOfClass("ViewportFrame"):FindFirstChildOfClass("WorldModel"):GetChildren() do
			v183:Destroy()
		end
	end
	local v184 = 0
	if v173 == 2 then
		v184 = 4
	end
	local l_HumanoidDescriptionFromUserIdAsync_0 = game:GetService("Players"):GetHumanoidDescriptionFromUserIdAsync(game:GetService("Players").LocalPlayer.UserId)
	for v186 = 1, 4 do
		task.spawn(function()
			local v187 = nil
			v187 = if CharAttribute:match("Survivor") then game:GetService("ReplicatedStorage").Modules.Emotes:FindFirstChild(v120.Emotes.Survivor[v186 + v184]) else game:GetService("ReplicatedStorage").Modules.Emotes:FindFirstChild(v120.Emotes[CharAttribute][v186 + v184])
			local v188 = string.split(v187.Name, "-")
			PlayerUI.EmoteWheel:FindFirstChild("Button" .. v186, true):FindFirstChild("EMOTE-NAME").Text = v188[1] or ""
			if v187.Name ~= "" and l_v174_0 == v174 then
				local v189 = nil
				v189 = if v179:FindFirstChild("StarterCharacter") then v179:FindFirstChild("StarterCharacter"):Clone() else if v178:FindFirstChild("StarterCharacter") then v178:FindFirstChild("StarterCharacter"):Clone() else game:GetService("ReplicatedStorage").Dummy:Clone()
				if v189 and v189:GetAttribute("Pivot") then
					v189:PivotTo(v189:GetAttribute("Pivot") + Vector3.new(805, 56.902000427246094, -79.74400329589844, 0))
					v189.Parent = PlayerUI.EmoteWheel:FindFirstChild("Button" .. v186, true):FindFirstChildOfClass("ViewportFrame"):FindFirstChildOfClass("WorldModel")
					require(v187).new({
						v189
					}).EmoteFunc()
				elseif v189 and not v189:GetAttribute("Pivot") then
					v189:PivotTo(CFrame.new(805, 56.402, -79.744))
					v189.Parent = PlayerUI.EmoteWheel:FindFirstChild("Button" .. v186, true):FindFirstChildOfClass("ViewportFrame"):FindFirstChildOfClass("WorldModel")
					require(v187).new({
						v189
					}).EmoteFunc()
				end
				do
					task.spawn(function()
						if CharAttribute:match("Survivor") then
							task.delay(0.25, function()
								v189:FindFirstChildOfClass("Humanoid"):ApplyDescriptionAsync(l_HumanoidDescriptionFromUserIdAsync_0)
							end)
						end
					end)
				end
			end
		end)
	end
end
PlayerUI.EmoteWheel.PageChange.MouseButton1Click:Connect(function() --[[ Line: 994 ]]
	-- upvalues: v120 (ref), v173 (ref), LoadEmoteWheel (copy), PlayerUI (copy)
	if v120.Stats.Passes.EXTRA_PAGE == false then
		return
	else
		if v173 == 1 then
			v173 = 2
		else
			v173 = 1
		end
		LoadEmoteWheel()
		PlayerUI.EmoteWheel.PageChange.Rotation = 0
		game:GetService("TweenService"):Create(PlayerUI.EmoteWheel.PageChange, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			Rotation = 360
		}):Play()
		return
	end
end)
local v192 = false
local function emoteWheel()
	if v192 == true or game:GetService("Players").LocalPlayer:GetAttribute("LOADED") == false then return end
	if PlayerUI.EmoteWheel.Visible == false then		
		v192 = true
		v173 = 1
		script.RemoteEvent:FireServer("EmoteWheel", true)
		PlayerUI.EmoteWheel.Visible = true
		PlayerUI.EmoteWheel.Wheel1.Image.UIGradient.Rotation = 180
		PlayerUI.EmoteWheel.Wheel2.Image.UIGradient.Rotation = 180
		PlayerUI.EmoteWheel.Wheel1:FindFirstChild("4Emotes").UIGradient.Rotation = 180
		PlayerUI.EmoteWheel.Wheel2:FindFirstChild("4Emotes").UIGradient.Rotation = 180
		PlayerUI.EmoteWheel.Shadow.ImageTransparency = 1
		PlayerUI.EmoteWheel.PageChange.Size = UDim2.new(0, 0, 0, 0)
		PlayerUI.EmoteWheel.PageChange.Rotation = -180
		game:GetService("TweenService"):Create(PlayerUI.EmoteWheel.Shadow, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {ImageTransparency = 0.5}):Play()
		game:GetService("TweenService"):Create(PlayerUI.EmoteWheel.PageChange, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Rotation = 0, Size = UDim2.new(0.15, 0, 0.15, 0)}):Play()
		game:GetService("TweenService"):Create(PlayerUI.EmoteWheel.Wheel1.Image.UIGradient, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Rotation = 0}):Play()
		game:GetService("TweenService"):Create(PlayerUI.EmoteWheel.Wheel1:FindFirstChild("4Emotes").UIGradient, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Rotation = 0}):Play()
		task.delay(0.25, function()
			game:GetService("TweenService"):Create(PlayerUI.EmoteWheel.Wheel2.Image.UIGradient, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Rotation = 0}):Play()
			game:GetService("TweenService"):Create(PlayerUI.EmoteWheel.Wheel2:FindFirstChild("4Emotes").UIGradient, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Rotation = 0}):Play()
		end)
		LoadEmoteWheel()
		task.wait(0.5)
		v192 = false
	else
		PlayerUI.EmoteWheel.PageChange.Rotation = 0
		v192 = true
		PlayerUI.EmoteWheel.Wheel1.Image.UIGradient.Rotation = 0
		PlayerUI.EmoteWheel.Wheel2.Image.UIGradient.Rotation = 0
		PlayerUI.EmoteWheel.Wheel1:FindFirstChild("4Emotes").UIGradient.Rotation = 0
		PlayerUI.EmoteWheel.Wheel2:FindFirstChild("4Emotes").UIGradient.Rotation = 0
		PlayerUI.EmoteWheel.Shadow.ImageTransparency = 0.5
		game:GetService("TweenService"):Create(PlayerUI.EmoteWheel.Shadow, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {ImageTransparency = 1}):Play()
		game:GetService("TweenService"):Create(PlayerUI.EmoteWheel.PageChange, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Rotation = 180, Size = UDim2.new(0, 0, 0, 0)}):Play()
		game:GetService("TweenService"):Create(PlayerUI.EmoteWheel.Wheel2.Image.UIGradient, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Rotation = -180}):Play()
		game:GetService("TweenService"):Create(PlayerUI.EmoteWheel.Wheel2:FindFirstChild("4Emotes").UIGradient, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Rotation = -180}):Play()
		task.delay(0.25, function()
			game:GetService("TweenService"):Create(PlayerUI.EmoteWheel.Wheel1.Image.UIGradient, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Rotation = -180}):Play()
			game:GetService("TweenService"):Create(PlayerUI.EmoteWheel.Wheel1:FindFirstChild("4Emotes").UIGradient, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Rotation = -180}):Play()
		end)
		task.wait(0.5)
		PlayerUI.EmoteWheel.Visible = false
		script.RemoteEvent:FireServer("EmoteWheel", false)
		v192 = false
	end
end
local v194 = false
local v195 = false
local chosenEmote = nil
local l_zero_0 = Vector2.zero
local function lockCamera(_, v199, v200)
	if v199 == Enum.UserInputState.Change then
		l_zero_0 = Vector2.new(v200.Position.X, -v200.Position.Y)
	end
	return Enum.ContextActionResult.Sink
end

game:GetService("UserInputService").LastInputTypeChanged:Connect(function(lastInputType)
	v194 = lastInputType.Name:find("Gamepad")
end)

game:GetService("UserInputService").InputEnded:Connect(function(input, processed)
	if processed then return end
	if not v194 or Player.Character:HasTag("Cutscene") then return end

	if table.find(Keybinds.Emote, input.KeyCode) and ShopUI.Visible == false and InventoryUI.Visible == false then			
		game:GetService("ContextActionService"):UnbindAction("LockRightStick")
		v195 = false
		PlayerUI.sfx.Click:Play()
		PlayerUI.EmoteWheel.Visible = false
		script.RemoteEvent:FireServer("EmoteWheel", false)
		PlayerUI.EmoteWheel.EmoteExecute:FireServer(chosenEmote)
		chosenEmote = nil
		l_zero_0 = Vector2.zero
	end
end)

game:GetService("RunService").Heartbeat:Connect(function()
	if PlayerUI.EmoteWheel.Visible and Player.Character:HasTag("Cutscene") then PlayerUI.EmoteWheel.Visible = false end
	if not v195 or not PlayerUI.EmoteWheel.Visible or not v194 then return end
	if l_zero_0.Magnitude < 0.5 then chosenEmote = nil return end

	local v205 = math.deg((math.atan2(l_zero_0.Y, l_zero_0.X)))
	if v205 >= -45 and v205 < 45 then
		chosenEmote = 2
	elseif v205 >= 45 and v205 < 135 then
		chosenEmote = 4
	elseif v205 >= 135 or v205 < -135 then
		chosenEmote = 3
	elseif v205 >= -135 and v205 < -45 then
		chosenEmote = 1
	end
end)

game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
	if processed or Player.Character:HasTag("Cutscene") then return end
	if table.find(Keybinds.Emote, input.KeyCode) then
		if v194 then
			v195 = true
			game:GetService("ContextActionService"):BindActionAtPriority("LockRightStick", lockCamera, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Thumbstick2)
		end
		emoteWheel()
	end
end)

script.Parent.UI.MobileOverlay.Emote.Emote.Button.MouseButton1Click:Connect(function()
	emoteWheel()
end)

-- i did NOT like how the same script was copy-pasted qwq
local function emoteClick()
	PlayerUI.sfx.Click:Play()
	PlayerUI.EmoteWheel.Visible = false
	script.RemoteEvent:FireServer("EmoteWheel", false)
	game:GetService("ContextActionService"):UnbindAction("LockRightStick")
end

-- first emote wheel buttons
PlayerUI.EmoteWheel.Wheel1:FindFirstChild("4Emotes").Button1.MouseButton1Click:Connect(function()
	emoteClick()
end)
PlayerUI.EmoteWheel.Wheel1:FindFirstChild("4Emotes").Button3.MouseButton1Click:Connect(function()
	emoteClick()
end)

-- second emote wheel gamepass buttons
PlayerUI.EmoteWheel.Wheel2:FindFirstChild("4Emotes").Button2.MouseButton1Click:Connect(function()
	emoteClick()
end)
PlayerUI.EmoteWheel.Wheel2:FindFirstChild("4Emotes").Button4.MouseButton1Click:Connect(function()
	emoteClick()
end)

for _, descendant in PlayerUI:GetDescendants() do
	if descendant:IsA("TextButton") then
		descendant.MouseEnter:Connect(function()
			script.Parent.sfx.Hover:Play()
		end)
	end
end

PlayerUI.DescendantAdded:Connect(function(descendant: Instance)
	if descendant:IsA("TextButton") then
		descendant.MouseEnter:Connect(function()
			script.Parent.sfx.Hover:Play()
		end)
	end
end)

for _, plrFrame in LobbyUIContainer.Settings.Holder.List.ScrollingFrame:GetChildren() do
	if plrFrame:HasTag("Toggle") then
		if Player:GetAttribute(plrFrame.Name) == true then
			plrFrame:FindFirstChild("DisabledVignette").Visible = false
			plrFrame:FindFirstChild("Container"):FindFirstChild("Selected").Visible = true
			plrFrame:FindFirstChild("Status").Text = "Enabled"
		else
			plrFrame:FindFirstChild("DisabledVignette").Visible = true
			plrFrame:FindFirstChild("Container"):FindFirstChild("Selected").Visible = false
			plrFrame:FindFirstChild("Status").Text = "Disabled"
		end
		plrFrame.MouseButton1Click:Connect(function()
			Player:SetAttribute(plrFrame.Name, not Player:GetAttribute(plrFrame.Name))
			PlayerUI.sfx.Click:Play()
			if Player:GetAttribute(plrFrame.Name) == true then
				plrFrame:FindFirstChild("DisabledVignette").Visible = false
				plrFrame:FindFirstChild("Container"):FindFirstChild("Selected").Visible = true
				plrFrame:FindFirstChild("Status").Text = "Enabled"
			else
				plrFrame:FindFirstChild("DisabledVignette").Visible = true
				plrFrame:FindFirstChild("Container"):FindFirstChild("Selected").Visible = false
				plrFrame:FindFirstChild("Status").Text = "Disabled"
			end
			script.RemoteEvent:FireServer("SettingChange", plrFrame.Name, Player:GetAttribute(plrFrame.Name))
		end)
	elseif plrFrame:HasTag("Bar") then
		local l_Bar_0 = plrFrame:WaitForChild("Slider"):FindFirstChild("Bar")
		local v214 = false
		local v215 = tonumber(game:GetService("Players").LocalPlayer:GetAttribute(plrFrame.Name)) * 100
		plrFrame:SetAttribute("Value", math.clamp(v215, 0, 100) / 100)
		plrFrame.Percentage.Text = math.ceil(plrFrame:GetAttribute("Value") * 100) .. "%"
		l_Bar_0.Size = UDim2.new(plrFrame:GetAttribute("Value"), 0, 1, 0)
		do
			local l_v214_0, l_v215_0 = v214, v215
			l_Bar_0:FindFirstChild("End"):FindFirstChild("Interact").MouseButton1Down:Connect(function() --[[ Line: 1224 ]]
				-- upvalues: l_v214_0 (ref)
				l_v214_0 = true
			end)
			plrFrame.Percentage.FocusLost:Connect(function() --[[ Line: 1227 ]]
				-- upvalues: plrFrame (copy), l_Bar_0 (copy), l_v215_0 (ref)
				if tonumber(plrFrame.Percentage.Text) then
					script.Parent.sfx.Click:Play()
					local v218 = tonumber(plrFrame.Percentage.Text)
					script.RemoteEvent:FireServer("SettingChange", plrFrame.Name, math.clamp(v218, 0, 100) / 100)
					plrFrame:SetAttribute("Value", math.clamp(v218, 0, 100) / 100)
					plrFrame.Percentage.Text = math.ceil(plrFrame:GetAttribute("Value") * 100) .. "%"
					l_Bar_0.Size = UDim2.new(plrFrame:GetAttribute("Value"), 0, 1, 0)
					script.Parent.sfx.Hover:Play()
					l_v215_0 = math.clamp(v218, 0, 100) / 100
					return
				else
					plrFrame.Percentage.Text = math.ceil(l_v215_0) .. "%"
					return
				end
			end)
			game:GetService("UserInputService").InputEnded:Connect(function(v219) --[[ Line: 1246 ]]
				-- upvalues: l_v214_0 (ref), plrFrame (copy), l_v215_0 (ref), l_Bar_0 (copy)
				if (v219.UserInputType == Enum.UserInputType.MouseButton1 or v219.UserInputType == Enum.UserInputType.Touch) and l_v214_0 == true then
					script.RemoteEvent:FireServer("SettingChange", plrFrame.Name, l_v215_0)
					plrFrame:SetAttribute("Value", l_v215_0)
					l_Bar_0.Size = UDim2.new(plrFrame:GetAttribute("Value"), 0, 1, 0)
					script.Parent.sfx.Click:Play()
					l_v214_0 = false
				end
			end)
			game:GetService("UserInputService").InputChanged:Connect(function() --[[ Line: 1256 ]]
				-- upvalues: l_v214_0 (ref), v13 (copy), l_Bar_0 (copy), plrFrame (copy), l_v215_0 (ref)
				if l_v214_0 == true and (LobbyUIContainer.Visible == false or LobbyUIContainer.Settings.Visible == false) then
					script.Parent.sfx.Click:Play()
					l_v214_0 = false
					return
				else
					if l_v214_0 == true then
						local v220 = math.clamp((game:GetService("UserInputService"):GetMouseLocation() - l_Bar_0.Parent.AbsolutePosition).X / l_Bar_0.Parent.AbsoluteSize.X, 0, 1)
						plrFrame:SetAttribute("Value", v220)
						l_Bar_0.Size = UDim2.new(plrFrame:GetAttribute("Value"), 0, 1, 0)
						plrFrame.Percentage.Text = math.floor(v220 * 100 + 0.5) .. "%"
						if plrFrame.Percentage.Text ~= tostring((math.floor(l_v215_0 * 100 + 0.5))) .. "%" then
							script.Parent.sfx.Hover:Play()
							l_v215_0 = v220
						end
					end
					return
				end
			end)
		end
	end
end
local ShopAtmosphere = script:WaitForChild("ShopAtmosphere"):Clone()
local v222 = nil
local v223 = nil
local v224 = ""
local v225 = ""
local v226 = nil
local v227 = nil
local v228 = nil
local v229 = nil
ShopUI:GetPropertyChangedSignal("Visible"):Connect(function()
	if ShopUI.Visible == false then
		game:GetService("GamepadService"):DisableGamepadCursor()
		ShopAtmosphere.Parent = nil
		if v222 then
			v222.Parent = game:GetService("Lighting")
			v222 = nil
		end
		if v223 then
			v223:Destroy()
			v223 = nil
		end
		v224 = ""
		v225 = ""
		v226 = nil
		if v227 then
			task.spawn(function()
				repeat
					local v230 = v227.Stop()
					task.wait()
				until v230 ~= false
				v227 = nil
			end)
		end
		if v229 then
			v229:Destroy()
		end
		v228 = nil
	else
		game:GetService("GamepadService"):EnableGamepadCursor(ShopUI)
	end
end)

--print(game:GetService("GroupService"):GetGroupInfoAsync(635601940))
local _, groupRole = pcall(function()
	return Player:GetAttribute("Rank")
end)

-- bbn searching + destroying page stuff compiled into one script
local function KatamariSearchEngine(searcherFrame: Instance, destroy: boolean, findSpacing: boolean)
	if not destroy then
		local gubbyTextBox = searcherFrame:FindFirstChild("Search"):FindFirstChild("TextBox") or ShopUI.Holder.Search.TextBox
		for _, frame in searcherFrame.ScrollingFrame:GetChildren() do
			if frame:IsA("Frame") then
				frame.Visible = string.find(frame.Name:lower(), gubbyTextBox.Text:lower()) and true or false
			end
		end
	else
		for _, frame in searcherFrame.ScrollingFrame:GetChildren() do
			if frame:IsA("Frame") then
				if findSpacing then 
					if frame.Name ~= "Spacing" then
						frame:Destroy()
					end
				else
					frame:Destroy()
				end
			end
		end
	end
end

KatamariSearchEngine(ShopUI.Holder.List.Animatronics, true)
KatamariSearchEngine(ShopUI.Holder.List.Survivors, true)

local v237 = nil
local function shopCharacterLoad(v238, v239)
	if v223 and v223.Name == v238 .. (v239 or "") then
		return
	else
		if v223 then
			v223:Destroy()
			v223 = nil
		end
		if v237 then
			v237:Destroy()
		end
		v224 = v238
		v225 = v239
		local l_v223_0 = v223
		local v241 = nil
		local v242 = nil
		local v243 = nil
		if v238:match("Survivor") then
			local v244 = string.split(v238, "-")
			v241 = game:GetService("ReplicatedStorage").Characters.Survivor:FindFirstChild(v244[2]):FindFirstChild(game:GetService("ReplicatedStorage").Characters.Survivor:GetAttribute("Default"))
			v242 = game:GetService("ReplicatedStorage").Characters.Survivor:FindFirstChild(v244[2]):FindFirstChild(game:GetService("ReplicatedStorage").Characters.Survivor:GetAttribute("Default"))
			if game:GetService("ReplicatedStorage").Characters.Survivor:FindFirstChild(v244[2]):FindFirstChild(v239) then
				v242 = game:GetService("ReplicatedStorage").Characters.Survivor:FindFirstChild(v244[2]):FindFirstChild(v239)
			end
			if v242:FindFirstChild("Configuration") then
				v243 = require(v242:FindFirstChild("Configuration"))
			else
				local l_FirstChild_0 = game:GetService("ReplicatedStorage").Characters.Survivor:FindFirstChild(v244[2]):FindFirstChild(game:GetService("ReplicatedStorage").Characters.Survivor:GetAttribute("Default"))
				v243 = if l_FirstChild_0:FindFirstChild("Configuration") then require(l_FirstChild_0:FindFirstChild("Configuration")) else require(v241:FindFirstChild("Configuration"))
			end
		else
			v241 = game:GetService("ReplicatedStorage").Characters:FindFirstChild(v238):FindFirstChild(game:GetService("ReplicatedStorage").Characters:FindFirstChild(v238):GetAttribute("Default"))
			v242 = game:GetService("ReplicatedStorage").Characters:FindFirstChild(v238):FindFirstChild(v239)
			v243 = if v242:FindFirstChild("Configuration") then require(v242:FindFirstChild("Configuration")) else require(v241:FindFirstChild("Configuration"))
		end
		if not v242:FindFirstChild("StarterCharacter") then
			v223 = game:GetService("ReplicatedStorage").Dummy:Clone()
			v223.Name = v238 .. (v239 or "")
			v223.Parent = workspace.MAPS.ShopModel
			local l_AppliedDescription_0 = Player.Character:FindFirstChildOfClass("Humanoid"):GetAppliedDescription()
			v223.Humanoid:ApplyDescription(l_AppliedDescription_0)
			v223.Humanoid.DisplayName = ""
		else
			v223 = v242:FindFirstChild("StarterCharacter"):Clone()
			v223.Name = v238 .. (v239 or "")
			v223.Parent = workspace.MAPS.ShopModel
		end
		v237 = nil
		if v242 and v242:FindFirstChild("Assets") then
			v237 = v242:FindFirstChild("Assets"):Clone()
		elseif v241 and v241:FindFirstChild("Assets") then
			v237 = v241:FindFirstChild("Assets"):Clone()
		end
		if v237 then
			if v242 and v242:FindFirstChild("AssetsReplace") then
				for _, v248 in v242:FindFirstChild("AssetsReplace"):GetChildren() do
					if v237:FindFirstChild(v248.Name) then
						v237:FindFirstChild(v248.Name):Destroy()
						v248:Clone().Parent = v237
					end
				end
			end
			for _, v250 in v237:GetChildren() do
				if v250:HasTag("ASSET") then
					local v251 = v250:Clone()
					v251:FindFirstChild("Weld").Enabled = true
					v251:FindFirstChild("Weld").Part0 = v223:FindFirstChild(v251:GetAttribute("WeldTo"))
					v251.Parent = v223
					for _, v253 in v251:GetChildren() do
						if v253:GetAttribute("Attach") then
							v253.Part0 = v223:FindFirstChild(v253:GetAttribute("Attach"))
						end
					end
				elseif v250.Name == "Idle1" or v250.Name == "Idle" then
					v228 = v223.Humanoid:LoadAnimation(v250)
					v228.Priority = Enum.AnimationPriority.Action2
					v228:Play(0)
				end
			end
		end
		for _, v255 in v223:GetDescendants() do
			if v255:IsA("SpotLight") then
				v255.Enabled = false
			end
		end
		if v242:FindFirstChild("Animate") then
			v228 = v223:FindFirstChildOfClass("Humanoid"):LoadAnimation(v242.Animate.idle:FindFirstChildOfClass("Animation"))
			v228.Priority = Enum.AnimationPriority.Action
			v228:Play(0)
		else
			v228 = v223:FindFirstChildOfClass("Humanoid"):LoadAnimation(v241.Animate.idle:FindFirstChildOfClass("Animation"))
			v228.Priority = Enum.AnimationPriority.Action
			v228:Play(0)
		end
		if v237:FindFirstChild("Spawn") then
			local v256 = v223:FindFirstChildOfClass("Humanoid"):LoadAnimation(v237:FindFirstChild("Spawn"))
			v256.Priority = Enum.AnimationPriority.Action4
			if v237:FindFirstChild("SpawnSFX") then
				local v257 = v237:FindFirstChild("SpawnSFX"):Clone()
				v257.Parent = workspace
				if v257.IsLoaded == false and v257.SoundId ~= "rbxassetid://0" then
					v257:GetPropertyChangedSignal("IsLoaded"):Wait()
				end
				v256:Play(0)
				v257:Play()
				task.delay(v257.TimeLength, function() --[[ Line: 1476 ]]
					-- upvalues: v257 (copy)
					v257:Destroy()
				end)
			else
				v256:Play(0)
			end
		end
		v223.HumanoidRootPart.Anchored = true
		if l_v223_0 then
			l_v223_0:Destroy()
		end
		local l_v223_1 = v223
		if not v242:FindFirstChild("StarterCharacter") then
			task.delay(0.05, function() --[[ Line: 1490 ]]
				-- upvalues: v223 (ref), l_v223_1 (copy)
				if v223 and v223.Parent and l_v223_1 == v223 then
					v223.HumanoidRootPart.CFrame = workspace.MAPS.ShopModel.GoToPosition.CFrame * CFrame.new(0, v223.Humanoid.HipHeight + 3, 0)
				end
			end)
			return
		else
			task.delay(0.05, function() --[[ Line: 1496 ]]
				-- upvalues: v223 (ref), l_v223_1 (copy)
				if v223 and v223.Parent and l_v223_1 == v223 then
					v223.HumanoidRootPart.CFrame = workspace.MAPS.ShopModel.GoToPosition.CFrame * CFrame.new(0, v223.Humanoid.HipHeight, 0)
				end
			end)
			return
		end
	end
end
local function Selection(v260, v261)
	v120 = v118:Invoke(999, "Data")

	local v262 = Maid.new()
	KatamariSearchEngine(ShopUI.Holder.Expanded.Page.Information, true, true)
	KatamariSearchEngine(ShopUI.Holder.Expanded.Page.Skins, true, true)
	KatamariSearchEngine(ShopUI.Holder.Expanded.Page.Emotes, true, true)
	if v260.Parent.Name == "Survivor" then
		shopCharacterLoad("Survivor-" .. v260.Name, "Normal")
		if table.find(v120.OwnedChars, "Survivor-" .. v260.Name) then
			ShopUI.Holder.Purchase.Purchased.Visible = true
		else
			ShopUI.Holder.Purchase.Purchased.Visible = false
		end
	else
		shopCharacterLoad(v260.Name, v260:GetAttribute("Default"))
		if table.find(v120.OwnedChars, v260.Name) then
			ShopUI.Holder.Purchase.Purchased.Visible = true
		else
			ShopUI.Holder.Purchase.Purchased.Visible = false
		end
	end
	ShopUI.Holder.Expanded.Map.Image = v261.MapRender
	ShopUI.Holder.Expanded.NameText.Text = v261.Name
	ShopUI.Holder.Expanded.Description.Text = v261.Description
	ShopUI.Holder.Expanded.Render.Render.Image = v261.Render
	ShopUI.Holder.Expanded.Render.Render.Size = v261.RenderSize
	ShopUI.Holder.Expanded.Render.Render.AnchorPoint = v261.RenderAnchor
	local v269 = nil
	v269 = if v260.Parent.Name == "Survivor" then require(v260:FindFirstChild("Normal"):FindFirstChild("Configuration")) else require(v260:FindFirstChild(v260:GetAttribute("Default")):FindFirstChild("Configuration"))
	local v270 = {
		"Health", 
		"Speed", 
		"RunSpeed", 
		"Stamina"
	}
	local v271 = script.ShopCards.Info:Clone()
	v271:FindFirstChild("Name").Text = "Cost"
	if v260:GetAttribute("COST") <= 0 then
		v271:FindFirstChild("Value").Text = "Free"
	else
		v271:FindFirstChild("Value").Text = v260:GetAttribute("COST")
	end
	v271:FindFirstChild("Value").TextColor3 = Color3.fromRGB(123, 214, 107)
	v271.Parent = ShopUI.Holder.Expanded.Page.Information.ScrollingFrame
	for _, v273 in v270 do
		if v269[v273] then
			local v274 = script.ShopCards.Info:Clone()
			v274:FindFirstChild("Name").Text = v273
			v274:FindFirstChild("Value").Text = v269[v273]
			v274.Parent = ShopUI.Holder.Expanded.Page.Information.ScrollingFrame
		end
	end
	local v275 = script.ShopCards.SummaryInfo:Clone()
	v275.Summary.Text = v261.Summary
	v275.Parent = ShopUI.Holder.Expanded.Page.Information.ScrollingFrame
	for _, v277 in v261.Moves do
		local v278 = {}
		local v279 = 0
		repeat
			if string.find(v277.Desc, "<c>", v279) then
				local v280 = string.find(v277.Desc, "<c>", v279)
				local v281 = string.find(v277.Desc, "<>", v280)
				table.insert(v278, {
					v280, 
					v281
				})
				v279 = v281
			end
			if string.find(v277.Desc, "<d>", v279) then
				local v282 = string.find(v277.Desc, "<d>", v279)
				local v283 = string.find(v277.Desc, "<>", v282)
				table.insert(v278, {
					v282, 
					v283, 
					"Damage"
				})
				v279 = v283
			end
			if string.find(v277.Desc, "<q>", v279) then
				local v284 = string.find(v277.Desc, "<q>", v279)
				local v285 = string.find(v277.Desc, "<>", v284)
				table.insert(v278, {
					v284, 
					v285, 
					nil, 
					true
				})
				v279 = v285
			end
			if string.find(v277.Desc, "<p>", v279) then
				local v286 = string.find(v277.Desc, "<p>", v279)
				local v287 = string.find(v277.Desc, "<>", v286)
				table.insert(v278, {
					v286, 
					v287, 
					"Damage", 
					true
				})
				v279 = v287
			end
			task.wait(0.01)
		until not string.find(v277.Desc, "<c>", v279) and not string.find(v277.Desc, "<d>", v279) and not string.find(v277.Desc, "<p>", v279) and not string.find(v277.Desc, "<q>", v279)
		local v288 = ""
		local v289 = nil
		for v290 = 1, #v277.Desc do
			for _, v292 in v278 do
				if v292[1] == v290 then
					v289 = v292[2] + 1
					if v292[3] and v292[3] ~= nil then
						if v292[4] then
							v288 = v288 .. v269[v292[3]][string.sub(v277.Desc, v292[1] + 3, v292[2] - 1)] * 100
						else
							v288 = v269[v292[3]][string.sub(v277.Desc, v292[1] + 3, v292[2] - 1)]
						end
					elseif v292[4] then
						v288 = v288 .. v269[string.sub(v277.Desc, v292[1] + 3, v292[2] - 1)] * 100
					else
						v288 = v288 .. v269[string.sub(v277.Desc, v292[1] + 3, v292[2] - 1)]
					end
				end
			end
			if v289 ~= nil then
				if v290 >= v289 then
					v289 = nil
				end
			else
				v288 = v288 .. string.sub(v277.Desc, v290, v290)
			end
		end
		local v293 = script.ShopCards.MoveCard:Clone()
		v293.Holder:FindFirstChild("Name").Text = v277.Name
		v293.Holder:FindFirstChild("Icon").Image = v277.Icon
		v293.Holder:FindFirstChild("Icon").Position = UDim2.new(0.15, 0, 0.458, 0)
		if v277.CustomIconPlacement then
			v293.Holder:FindFirstChild("Icon").Position = v277.CustomIconPlacement
		end
		if v277.ImageRectSize then
			v293.Holder:FindFirstChild("Icon").ImageRectSize = v277.ImageRectSize
		end
		if v277.ImageRectOffset then
			v293.Holder:FindFirstChild("Icon").ImageRectOffset = v277.ImageRectOffset
		end
		v293.Holder.Description.Text = v288
		v293.Parent = ShopUI.Holder.Expanded.Page.Information.ScrollingFrame
	end
	script.ShopCards.Spacing:Clone().Parent = ShopUI.Holder.Expanded.Page.Information.ScrollingFrame
	local v294 = 1
	v262:Mark(ShopUI.Holder.Expanded.TabButtons.Information.Button.MouseButton1Click:Connect(function() --[[ Line: 1672 ]]
		-- upvalues: v294 (ref), v260 (copy), v120 (ref), ShopUI (ref), v227 (ref), v229 (ref), v226 (ref), v228 (ref), v225 (ref), v259 (ref)
		if v294 == 1 then
			return
		else
			script.Parent.sfx.open:play()
			if v260.Parent.Name == "Survivor" then
				if table.find(v120.OwnedChars, "Survivor-" .. v260.Name) then
					ShopUI.Holder.Purchase.Purchased.Visible = true
				else
					ShopUI.Holder.Purchase.Purchased.Visible = false
				end
			elseif table.find(v120.OwnedChars, v260.Name) then
				ShopUI.Holder.Purchase.Purchased.Visible = true
			else
				ShopUI.Holder.Purchase.Purchased.Visible = false
			end
			local v295 = false
			if v227 then
				task.spawn(function() --[[ Line: 1693 ]]
					-- upvalues: v227 (ref)
					repeat
						local v296 = v227.Stop()
						task.wait()
					until v296 ~= false
					v227 = nil
				end)
				v295 = true
			end
			if v229 then
				v229:Destroy()
			end
			v226 = nil
			v294 = 1
			if v295 == true then
				v228:Play()
			end
			if v225 ~= v260:GetAttribute("Default") then
				if v260.Parent.Name == "Survivor" then
					shopCharacterLoad("Survivor-" .. v260.Name, "Normal")
					return
				else
					shopCharacterLoad(v260.Name, v260:GetAttribute("Default"))
				end
			end
			return
		end
	end))
	v262:Mark(ShopUI.Holder.Expanded.TabButtons.Skins.Button.MouseButton1Click:Connect(function() --[[ Line: 1719 ]]
		-- upvalues: v294 (ref), v260 (copy), v120 (ref), v225 (ref), ShopUI (ref), v227 (ref), v229 (ref), v226 (ref), v228 (ref)
		if v294 == 2 then
			return
		else
			script.Parent.sfx.open:play()
			if v260.Parent.Name == "Survivor" then
				if table.find(v120.OwnedSkins["Survivor-" .. v260.Name], v225) then
					ShopUI.Holder.Purchase.Purchased.Visible = true
				else
					ShopUI.Holder.Purchase.Purchased.Visible = false
				end
			elseif table.find(v120.OwnedSkins[v260.Name], v225) then
				ShopUI.Holder.Purchase.Purchased.Visible = true
			else
				ShopUI.Holder.Purchase.Purchased.Visible = false
			end
			local v297 = false
			if v227 then
				task.spawn(function() --[[ Line: 1739 ]]
					-- upvalues: v227 (ref)
					repeat
						local v298 = v227.Stop()
						task.wait()
					until v298 ~= false
					v227 = nil
				end)
				v297 = true
			end
			if v229 then
				v229:Destroy()
			end
			v294 = 2
			v226 = nil
			if v297 == true then
				v228:Play()
			end
			return
		end
	end))
	v262:Mark(ShopUI.Holder.Expanded.TabButtons.Emotes.Button.MouseButton1Click:Connect(function() --[[ Line: 1758 ]]
		-- upvalues: v294 (ref), ShopUI (ref), v227 (ref), v229 (ref), v226 (ref), v228 (ref)
		if v294 == 3 then
			return
		else
			ShopUI.Holder.Purchase.Purchased.Visible = false
			script.Parent.sfx.open:play()
			local v299 = false
			if v227 then
				task.spawn(function() --[[ Line: 1765 ]]
					-- upvalues: v227 (ref)
					repeat
						local v300 = v227.Stop()
						task.wait()
					until v300 ~= false
					v227 = nil
				end)
				v299 = true
			end
			if v229 then
				v229:Destroy()
			end
			v294 = 3
			v226 = nil
			if v299 == true then
				v228:Play()
			end
			return
		end
	end))
	v262:Mark(ShopUI.Holder.Purchase.Button.MouseButton1Click:Connect(function() --[[ Line: 1783 ]]
		-- upvalues: v294 (ref), v226 (ref), v225 (ref), v260 (copy), v120 (ref), v118 (ref), ShopUI (ref)
		script.Parent.sfx.open:play()
		if v294 == 3 then
			if v226 then
				script.RemoteEvent:FireServer("EmoteBuy", v226)
			end
		elseif v294 == 2 then
			if v225 then
				script.RemoteEvent:FireServer("SkinBuy", v225, v260.Name, v260.Parent.Name == "Survivor")
			end
		elseif v294 == 1 and v260 then
			if v260.Parent.Name == "Survivor" then
				script.RemoteEvent:FireServer("SurvivorBuy", v260.Name)
			else
				script.RemoteEvent:FireServer("AnimatronicBuy", v260.Name)
			end
		end
		v120 = v118:Invoke(999, "Data")
		if not v120 then
			return
		else
			if v294 == 1 then
				if v260.Parent.Name == "Survivor" then
					if table.find(v120.OwnedChars, "Survivor-" .. v260.Name) then
						ShopUI.Holder.Purchase.Purchased.Visible = true
					else
						ShopUI.Holder.Purchase.Purchased.Visible = false
					end
				elseif table.find(v120.OwnedChars, v260.Name) then
					ShopUI.Holder.Purchase.Purchased.Visible = true
				else
					ShopUI.Holder.Purchase.Purchased.Visible = false
				end
			elseif v294 == 2 then
				if table.find(v120.OwnedEmotes, v226) then
					ShopUI.Holder.Purchase.Purchased.Visible = true
				else
					ShopUI.Holder.Purchase.Purchased.Visible = false
				end
			elseif v294 == 3 then
				if v260.Parent.Name == "Survivor" then
					if table.find(v120.OwnedSkins["Survivor-" .. v260.Name], v225) then
						ShopUI.Holder.Purchase.Purchased.Visible = true
					else
						ShopUI.Holder.Purchase.Purchased.Visible = false
					end
				elseif table.find(v120.OwnedSkins[v260.Name], v225) then
					ShopUI.Holder.Purchase.Purchased.Visible = true
				else
					ShopUI.Holder.Purchase.Purchased.Visible = false
				end
			end
			for _, v302 in next, ShopUI.Holder.Expanded.Page:GetDescendants() do
				if v302.Name == "Owned" then
					local l_Parent_1 = v302.Parent
					if v260.Parent.Name == "Survivor" then
						if v120.OwnedSkins["Survivor-" .. v260.Name] and table.find(v120.OwnedSkins["Survivor-" .. v260.Name], l_Parent_1.Name) or v120.OwnedEmotes and table.find(v120.OwnedEmotes, l_Parent_1.Name) or v120.OwnedChars["Survivor-" .. v260.Name] and table.find(v120.OwnedChars["Survivor-" .. v260.Name], l_Parent_1.Name) then
							v302.Visible = true
						end
					elseif v120.OwnedSkins[v260.Name] and table.find(v120.OwnedSkins[v260.Name], l_Parent_1.Name) or v120.OwnedEmotes[v260.Name] and table.find(v120.OwnedEmotes[v260.Name], l_Parent_1.Name) or v120.OwnedChars[v260.Name] and table.find(v120.OwnedChars[v260.Name], l_Parent_1.Name) then
						v302.Visible = true
					end
				end
			end
			return
		end
	end))
	for _, skin in v260:GetChildren() do
		if (skin:GetAttribute("Type") ~= "ADMIN" or groupRole >= 35) and (skin:GetAttribute("Type") ~= "TESTER" or groupRole >= 10) then
			local v306 = script.ShopCards.SkinCards:Clone()
			v306.LayoutOrder = skin:GetAttribute("Cost")
			v306.Name = skin.Name
			v306:FindFirstChild("Button"):FindFirstChild("Name").Text = skin.Name
			v306:FindFirstChild("Button"):FindFirstChild("Price").Text = skin:GetAttribute("Cost")
			v306:FindFirstChild("Button"):FindFirstChild("Render").Image = "rbxassetid://" .. skin:GetAttribute("Icon")
			v306.Parent = ShopUI.Holder.Expanded.Page.Skins.ScrollingFrame
			if v260.Parent.Name == "Survivor" then
				if table.find(v120.OwnedSkins["Survivor-" .. v260.Name], skin.Name) then
					v306.Owned.Visible = true
				end
			elseif table.find(v120.OwnedSkins[v260.Name], skin.Name) then
				v306.Owned.Visible = true
			end
			v262:Mark(v306.Button.MouseButton1Click:Connect(function() --[[ Line: 1890 ]]
				-- upvalues: v225 (ref), skin (copy), v260 (copy), v120 (ref), ShopUI (ref), v259 (ref)
				if v225 == skin.Name then
					return
				else
					if v260.Parent.Name == "Survivor" then
						if table.find(v120.OwnedSkins["Survivor-" .. v260.Name], skin.Name) then
							ShopUI.Holder.Purchase.Purchased.Visible = true
						else
							ShopUI.Holder.Purchase.Purchased.Visible = false
						end
					elseif table.find(v120.OwnedSkins[v260.Name], skin.Name) then
						ShopUI.Holder.Purchase.Purchased.Visible = true
					else
						ShopUI.Holder.Purchase.Purchased.Visible = false
					end
					script.Parent.sfx.open:play()
					if v260.Parent.Name == "Survivor" then
						shopCharacterLoad("Survivor-" .. v260.Name, skin.Name)
						return
					else
						shopCharacterLoad(v260.Name, skin.Name)
						return
					end
				end
			end))
		end
	end
	for _, v308 in game:GetService("ReplicatedStorage").Modules.Emotes:GetChildren() do
		if (v308:GetAttribute("Character") == v260.Name or v308:GetAttribute("Character") == "Survivor" and v260.Parent.Name == "Survivor") and not v308:GetAttribute("ADMIN") then
			local v309 = script.ShopCards.EmoteCards:Clone()
			if string.split(v308.Name, "-") then
				v309:FindFirstChild("Button"):FindFirstChild("Name").Text = string.split(v308.Name, "-")[1]
				v309.Name = string.split(v308.Name, "-")[1]
			else
				v309:FindFirstChild("Button"):FindFirstChild("Name").Text = v308.Name
				v309.Name = v308.Name
			end
			v309:FindFirstChild("Button"):FindFirstChild("Price").Text = v308:GetAttribute("Price")
			v309.LayoutOrder = v308:GetAttribute("Price")
			v309.Button.Icon.Image = "rbxassetid://" .. v308:GetAttribute("Icon")
			v309.Parent = ShopUI.Holder.Expanded.Page.Emotes.ScrollingFrame
			if table.find(v120.OwnedEmotes, v308.Name) then
				v309.Owned.Visible = true
			end
			v262:Mark(v309.Button.MouseButton1Click:Connect(function() --[[ Line: 1933 ]]
				-- upvalues: v226 (ref), v308 (copy), v120 (ref), ShopUI (ref), v227 (ref), v229 (ref), v228 (ref), v223 (ref)
				if v226 == v308.Name then
					return
				else
					if table.find(v120.OwnedEmotes, v308.Name) then
						ShopUI.Holder.Purchase.Purchased.Visible = true
					else
						ShopUI.Holder.Purchase.Purchased.Visible = false
					end
					if v227 then
						if v227.Stop() == false then
							return
						else
							v227 = nil
						end
					end
					if v229 then
						v229:Destroy()
					end
					v228:Stop()
					v227 = require(v308).new({
						v223
					})
					v227.EmoteFunc()
					if v308:FindFirstChildOfClass("Sound") then
						v229 = v308:FindFirstChildOfClass("Sound"):Clone()
						v229.Parent = script.Parent.sfx
						v229:Play()
					end
					script.Parent.sfx.open:play()
					v226 = v308.Name
					return
				end
			end))
		end
	end
	v262:Mark(ShopUI.Holder.Expanded.Back.Button.MouseButton1Click:Connect(function() --[[ Line: 1968 ]]
		-- upvalues: v227 (ref), v229 (ref), v228 (ref), v262 (copy)
		script.Parent.sfx.open:play()
		if v227 then
			task.spawn(function() --[[ Line: 1971 ]]
				-- upvalues: v227 (ref)
				repeat
					local v310 = v227.Stop()
					task.wait()
				until v310 ~= false
				v227 = nil
			end)
		end
		if v229 then
			v229:Destroy()
		end
		v228:Play()
		v262:Sweep()
		v262:Destroy()
	end))
end

-- skins
ShopUI.Holder.Expanded.Page.Skins.Search.TextBox:GetPropertyChangedSignal("Text"):Connect(function()
	KatamariSearchEngine(ShopUI.Holder.Expanded.Page.Skins)
end)

-- emotes
ShopUI.Holder.Expanded.Page.Emotes.Search.TextBox:GetPropertyChangedSignal("Text"):Connect(function()
	KatamariSearchEngine(ShopUI.Holder.Expanded.Page.Emotes)
end)

-- characters
ShopUI.Holder.Search.TextBox:GetPropertyChangedSignal("Text"):Connect(function()
	KatamariSearchEngine(ShopUI.Holder.List.Animatronics)
	KatamariSearchEngine(ShopUI.Holder.List.Survivors)
end)

LobbyUIContainer.Buttons.Holder.Shop.Button.MouseButton1Click:Connect(function()
	PlayerUI.EmoteWheel.Visible = false
	if game:GetService("Lighting"):FindFirstChildOfClass("Atmosphere") then
		v222 = game:GetService("Lighting"):FindFirstChildOfClass("Atmosphere")
		v222.Parent = nil
	end

	if not ShopAtmosphere then ShopAtmosphere = script:WaitForChild("ShopAtmosphere"):Clone() end

	ShopAtmosphere.Parent = game:GetService("Lighting")
	KatamariSearchEngine(ShopUI.Holder.Expanded.Page.Emotes, true, true)
	KatamariSearchEngine(ShopUI.Holder.Expanded.Page.Information, true, true)
	KatamariSearchEngine(ShopUI.Holder.Expanded.Page.Skins, true, true)
	KatamariSearchEngine(ShopUI.Holder.List.Animatronics, true, true)
	KatamariSearchEngine(ShopUI.Holder.List.Survivors, true, true)
	for _, v331 in game:GetService("ReplicatedStorage").Characters:GetChildren() do
		if v11[v331.Name] and v331.Name ~= "Survivor" and (v331:GetAttribute("Type") ~= "ADMIN" or groupRole >= 35) and (v331:GetAttribute("Type") ~= "TESTER" or groupRole >= 10) then
			local v332 = v11[v331.Name]
			local SelectionCards = script.ShopCards.SelectionCards:Clone()
			SelectionCards.Button.NameText.Text = v332.Name
			SelectionCards.Button.Description.Text = v332.Description
			SelectionCards.Button.Origin.Text = v332.Origin
			SelectionCards.Button.Container.Render.Image = v332.Render
			SelectionCards.Button.Container.Render.Size = v332.RenderSize
			SelectionCards.Button.Container.Render.AnchorPoint = v332.RenderAnchor
			SelectionCards.Button.MapImage.Image = v332.MapRender
			SelectionCards.Button.Shadow.ImageColor3 = v332.InfoCardColor
			SelectionCards.Name = v331.Name
			SelectionCards.LayoutOrder = v331:GetAttribute("COST")
			SelectionCards.Parent = ShopUI.Holder.List.Animatronics.ScrollingFrame
			SelectionCards.Button.MouseButton1Click:Connect(function()
				script.Parent.sfx.open:play()
				Selection(v331, v332)
			end)
		end
	end
	for _, v335 in game:GetService("ReplicatedStorage").Characters.Survivor:GetChildren() do
		if v11.Survivor[v335.Name] and (v335:GetAttribute("Type") ~= "ADMIN" or groupRole >= 35) and (v335:GetAttribute("Type") ~= "TESTER" or groupRole >= 10) then
			local v336 = v11.Survivor[v335.Name]
			local v337 = script.ShopCards.SelectionCards:Clone()
			v337.Button.NameText.Text = v336.Name
			v337.Button.Description.Text = v336.Description
			v337.Button.Origin.Text = v336.Origin
			v337.Button.Container.Render.Image = v336.Render
			v337.Button.Container.Render.Size = v336.RenderSize
			v337.Button.Container.Render.AnchorPoint = v336.RenderAnchor
			v337.Button.MapImage.Image = v336.MapRender
			v337.Button.Shadow.ImageColor3 = v336.InfoCardColor
			v337.Name = v335.Name
			v337.LayoutOrder = v335:GetAttribute("COST")
			v337.Parent = ShopUI.Holder.List.Survivors.ScrollingFrame
			v337.Button.MouseButton1Click:Connect(function()
				script.Parent.sfx.open:play()
				Selection(v335, v336)
			end)
		end
	end
	shopCharacterLoad("Springtrap", game:GetService("ReplicatedStorage").Characters:FindFirstChild("Springtrap"):GetAttribute("Default"))
end)
local function currencyPlus()
	ShopUI.Visible = true
	PlayerUI.sfx.Click:Play()
	if game:GetService("Lighting"):FindFirstChildOfClass("Atmosphere") then
		v222 = game:GetService("Lighting"):FindFirstChildOfClass("Atmosphere")
		v222.Parent = nil
	end
	if not ShopAtmosphere then
		ShopAtmosphere = script:WaitForChild("ShopAtmosphere"):Clone()
	end
	ShopAtmosphere.Parent = game:GetService("Lighting")
	for _, v339 in ShopUI.Holder.Expanded.Page.Emotes.ScrollingFrame:GetChildren() do
		if v339:IsA("Frame") and v339.Name ~= "Spacing" then
			v339:Destroy()
		end
	end
	for _, v341 in ShopUI.Holder.Expanded.Page.Information.ScrollingFrame:GetChildren() do
		if v341:IsA("Frame") and v341.Name ~= "Spacing" then
			v341:Destroy()
		end
	end
	for _, v343 in ShopUI.Holder.Expanded.Page.Skins.ScrollingFrame:GetChildren() do
		if v343:IsA("Frame") and v343.Name ~= "Spacing" then
			v343:Destroy()
		end
	end
	shopCharacterLoad("Springtrap", game:GetService("ReplicatedStorage").Characters:FindFirstChild("Springtrap"):GetAttribute("Default"))
end
LobbyUIContainer.Currency.Holder.List.Currency.Plus.MouseButton1Click:Connect(function() --[[ Line: 2159 ]]
	-- upvalues: v344 (copy)
	currencyPlus()
end)
ShopUI.Currency.List.Currency.Plus.MouseButton1Click:Connect(function() --[[ Line: 2162 ]]
	-- upvalues: v344 (copy)
	currencyPlus()
end)
ShopUI:FindFirstChild("Button"):FindFirstChild("Back"):FindFirstChild("Button").MouseButton1Click:Connect(function() --[[ Line: 2166 ]]
	-- upvalues: v222 (ref), ShopAtmosphere (ref)
	if v222 then
		v222.Parent = game:GetService("Lighting")
		v222 = nil
	end
	ShopAtmosphere.Parent = nil
end)
local v345 = nil
local v346 = ""
local v347 = ""
local v348 = ""
local v349 = nil
local v350 = nil
local v351 = nil
InventoryUI:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 2185 ]]
	-- upvalues: InventoryUI (copy), ShopAtmosphere (ref), v222 (ref), v345 (ref), v346 (ref), v347 (ref), v348 (ref), v349 (ref), v351 (ref), v350 (ref)
	if InventoryUI.Visible == false then
		game:GetService("GamepadService"):DisableGamepadCursor()
		ShopAtmosphere.Parent = nil
		if v222 then
			v222.Parent = game:GetService("Lighting")
			v222 = nil
		end
		if v345 then
			v345:Destroy()
			v345 = nil
		end
		v346 = ""
		v347 = ""
		v348 = nil
		if v349 then
			task.spawn(function() --[[ Line: 2201 ]]
				-- upvalues: v349 (ref)
				repeat
					local v352 = v349.Stop()
					task.wait()
				until v352 ~= false
				v349 = nil
			end)
		end
		if v351 then
			v351:Destroy()
		end
		v350 = nil
		return
	else
		game:GetService("GamepadService"):EnableGamepadCursor(InventoryUI)
		return
	end
end)
local function v374(v353, v354) --[[ Line: 2217 ]] --[[ Name: inventoryCharacterLoad ]]
	-- upvalues: v345 (ref), v237 (ref), v346 (ref), v347 (ref), Player (copy), v350 (ref)
	if v345 and v345.Name == v353 .. (v354 or "") then
		return
	else
		if v345 then
			v345:Destroy()
			v345 = nil
		end
		if v237 then
			v237:Destroy()
		end
		v346 = v353
		v347 = v354
		local l_v345_0 = v345
		local v356 = nil
		local v357 = nil
		local v358 = nil
		if v353:match("Survivor") then
			local v359 = string.split(v353, "-")
			v356 = game:GetService("ReplicatedStorage").Characters.Survivor:FindFirstChild(v359[2]):FindFirstChild(game:GetService("ReplicatedStorage").Characters.Survivor:GetAttribute("Default"))
			v357 = game:GetService("ReplicatedStorage").Characters.Survivor:FindFirstChild(v359[2]):FindFirstChild(game:GetService("ReplicatedStorage").Characters.Survivor:GetAttribute("Default"))
			if game:GetService("ReplicatedStorage").Characters.Survivor:FindFirstChild(v359[2]):FindFirstChild(v354) then
				v357 = game:GetService("ReplicatedStorage").Characters.Survivor:FindFirstChild(v359[2]):FindFirstChild(v354)
			end
			if v357:FindFirstChild("Configuration") then
				v358 = require(v357:FindFirstChild("Configuration"))
			else
				local l_FirstChild_1 = game:GetService("ReplicatedStorage").Characters.Survivor:FindFirstChild(v359[2]):FindFirstChild(game:GetService("ReplicatedStorage").Characters.Survivor:GetAttribute("Default"))
				v358 = if l_FirstChild_1:FindFirstChild("Configuration") then require(l_FirstChild_1:FindFirstChild("Configuration")) else require(v356:FindFirstChild("Configuration"))
			end
		else
			v356 = game:GetService("ReplicatedStorage").Characters:FindFirstChild(v353):FindFirstChild(game:GetService("ReplicatedStorage").Characters:FindFirstChild(v353):GetAttribute("Default"))
			v357 = game:GetService("ReplicatedStorage").Characters:FindFirstChild(v353):FindFirstChild(v354)
			v358 = if v357:FindFirstChild("Configuration") then require(v357:FindFirstChild("Configuration")) else require(v356:FindFirstChild("Configuration"))
		end
		if not v357:FindFirstChild("StarterCharacter") then
			v345 = game:GetService("ReplicatedStorage").Dummy:Clone()
			v345.Name = v353 .. (v354 or "")
			v345.Parent = workspace.MAPS.InventoryModel
			local l_AppliedDescription_1 = Player.Character:FindFirstChildOfClass("Humanoid"):GetAppliedDescription()
			v345.Humanoid:ApplyDescription(l_AppliedDescription_1)
			v345.Humanoid.DisplayName = ""
		else
			v345 = v357:FindFirstChild("StarterCharacter"):Clone()
			v345.Name = v353 .. (v354 or "")
			v345.Parent = workspace.MAPS.InventoryModel
		end
		v237 = nil
		if v357 and v357:FindFirstChild("Assets") then
			v237 = v357:FindFirstChild("Assets"):Clone()
		elseif v356 and v356:FindFirstChild("Assets") then
			v237 = v356:FindFirstChild("Assets"):Clone()
		end
		if v357:FindFirstChild("AssetsReplace") then
			for _, v363 in v357:FindFirstChild("AssetsReplace"):GetChildren() do
				if v237:FindFirstChild(v363.Name) then
					v237:FindFirstChild(v363.Name):Destroy()
					v363:Clone().Parent = v237
				end
			end
		end
		if v237 then
			for _, v365 in v237:GetChildren() do
				if v365:HasTag("ASSET") then
					local v366 = v365:Clone()
					v366:FindFirstChild("Weld").Enabled = true
					v366:FindFirstChild("Weld").Part0 = v345:FindFirstChild(v366:GetAttribute("WeldTo"))
					v366.Parent = v345
					for _, v368 in v366:GetChildren() do
						if v368:GetAttribute("Attach") then
							v368.Part0 = v345:FindFirstChild(v368:GetAttribute("Attach"))
						end
					end
				elseif v365.Name == "Idle1" or v365.Name == "Idle" then
					v350 = v345.Humanoid.Animator:LoadAnimation(v365)
					v350.Priority = Enum.AnimationPriority.Action2
					v350:Play(0)
				end
			end
		end
		for _, v370 in v345:GetDescendants() do
			if v370:IsA("SpotLight") then
				v370.Enabled = false
			end
		end
		if v357:FindFirstChild("Animate") then
			v350 = v345:FindFirstChildOfClass("Humanoid"):LoadAnimation(v357.Animate.idle:FindFirstChildOfClass("Animation"))
			v350.Priority = Enum.AnimationPriority.Action
			v350:Play(0)
		else
			v350 = v345:FindFirstChildOfClass("Humanoid"):LoadAnimation(v356.Animate.idle:FindFirstChildOfClass("Animation"))
			v350.Priority = Enum.AnimationPriority.Action
			v350:Play(0)
		end
		if v237:FindFirstChild("Spawn") then
			local v371 = v345:FindFirstChildOfClass("Humanoid"):LoadAnimation(v237:FindFirstChild("Spawn"))
			v371.Priority = Enum.AnimationPriority.Action4
			if v237:FindFirstChild("SpawnSFX") then
				local v372 = v237:FindFirstChild("SpawnSFX"):Clone()
				v372.Parent = workspace
				if v372.IsLoaded == false and v372.SoundId ~= "rbxassetid://0" then
					v372:GetPropertyChangedSignal("IsLoaded"):Wait()
				end
				v371:Play(0)
				v372:Play()
				task.delay(v372.TimeLength, function() --[[ Line: 2347 ]]
					-- upvalues: v372 (copy)
					v372:Destroy()
				end)
			else
				v371:Play(0)
			end
		end
		v345.HumanoidRootPart.Anchored = true
		if l_v345_0 then
			l_v345_0:Destroy()
		end
		local l_v345_1 = v345
		if not v357:FindFirstChild("StarterCharacter") then
			task.delay(0.05, function() --[[ Line: 2361 ]]
				-- upvalues: v345 (ref), l_v345_1 (copy)
				if v345 and v345.Parent and l_v345_1 == v345 then
					v345.HumanoidRootPart.CFrame = workspace.MAPS.InventoryModel.GoToPosition.CFrame * CFrame.new(0, v345.Humanoid.HipHeight + 2.5, 0)
				end
			end)
			return
		else
			task.delay(0.05, function() --[[ Line: 2367 ]]
				-- upvalues: v345 (ref), l_v345_1 (copy)
				if v345 and v345.Parent and l_v345_1 == v345 then
					v345.HumanoidRootPart.CFrame = workspace.MAPS.InventoryModel.GoToPosition.CFrame * CFrame.new(0, v345.Humanoid.HipHeight, 0)
				end
			end)
			return
		end
	end
end
local v375 = nil
local function v428(v376, v377) --[[ Line: 2376 ]] --[[ Name: InventorySelection ]]
	-- upvalues: v375 (ref), v120 (ref), v118 (copy), Maid (copy), InventoryUI (copy), v374 (copy), v347 (ref), v349 (ref), v351 (ref), v348 (ref), v350 (ref), v4 (copy), v345 (ref)
	if v375 then
		v375:Sweep()
		v375:Destroy()
	end
	v120 = v118:Invoke(999, "Data")
	v375 = Maid.new()
	local v378 = nil
	for _, v380 in InventoryUI.Selected.Cosmetics.Emotes.ScrollingFrame:GetChildren() do
		if v380:IsA("Frame") and v380.Name ~= "Spacing" then
			v380:Destroy()
		end
	end
	for _, v382 in InventoryUI.Selected.Cosmetics.Skins.ScrollingFrame:GetChildren() do
		if v382:IsA("Frame") and v382.Name ~= "Spacing" then
			v382:Destroy()
		end
	end
	for _, v384 in InventoryUI.Selected.Information.ScrollingFrame:GetChildren() do
		if v384:IsA("Frame") and v384.Name ~= "Spacing" then
			v384:Destroy()
		end
	end
	local v385 = math.pow(v120.CHARACTER_LEVELS[v376][1] + 5, 3)
	local v386 = math.clamp(math.round(v120.CHARACTER_LEVELS[v376][2]) / v385 * 360, 0, 360)
	InventoryUI.Selected.Holder.Level.XP.Text = math.round(v120.CHARACTER_LEVELS[v376][2]) .. "/" .. v385
	InventoryUI.Selected.Holder.Level.Display.Level.Text = v120.CHARACTER_LEVELS[v376][1]
	InventoryUI.Selected.Holder.Level.Display.R.UIGradient.Rotation = math.clamp(v386, 0, 180) + -180
	InventoryUI.Selected.Holder.Level.Display.L.UIGradient.Rotation = math.clamp(v386, 180, 360) + -180
	if v376:match("Survivor") then
		InventoryUI.Selected.Holder:FindFirstChild("Name").Text = string.split(v376, "-")[2]
		InventoryUI.Selected.Holder:FindFirstChild("Description").Text = v377.Description
		InventoryUI.Selected.Holder:FindFirstChild("Render"):FindFirstChild("Render").Image = ""
		if v120.Character.Survivor == v376 then
			InventoryUI.Selected.Holder.Equip.Button:FindFirstChild("Name").Text = "EQUIPPED"
		else
			InventoryUI.Selected.Holder.Equip.Button:FindFirstChild("Name").Text = "EQUIP"
		end
		v378 = game:GetService("ReplicatedStorage").Characters:FindFirstChild("Survivor"):FindFirstChild(string.split(v376, "-")[2])
		v374(v376, v120.EquippedSkins[v376])
	else
		InventoryUI.Selected.Holder:FindFirstChild("Name").Text = v377.Name
		InventoryUI.Selected.Holder:FindFirstChild("Description").Text = v377.Description
		if v120.Character.Killer == v376 then
			InventoryUI.Selected.Holder.Equip.Button:FindFirstChild("Name").Text = "EQUIPPED"
		else
			InventoryUI.Selected.Holder.Equip.Button:FindFirstChild("Name").Text = "EQUIP"
		end
		v378 = game:GetService("ReplicatedStorage").Characters:FindFirstChild(v376)
		v374(v376, v120.EquippedSkins[v376])
		InventoryUI.Selected.Holder:FindFirstChild("Render"):FindFirstChild("Render").Image = "rbxassetid://" .. game:GetService("ReplicatedStorage").Characters:FindFirstChild(v376):FindFirstChild(v347):GetAttribute("Icon")
		if v377.SkinRenders and v377.SkinRenders[v347] then
			InventoryUI.Selected.Holder:FindFirstChild("Render"):FindFirstChild("Render").AnchorPoint = v377.SkinRenders[v347].RenderAnchor
			InventoryUI.Selected.Holder:FindFirstChild("Render"):FindFirstChild("Render").Size = v377.SkinRenders[v347].RenderSize
		else
			InventoryUI.Selected.Holder:FindFirstChild("Render"):FindFirstChild("Render").AnchorPoint = v377.RenderAnchor
			InventoryUI.Selected.Holder:FindFirstChild("Render"):FindFirstChild("Render").Size = v377.RenderSize
		end
	end
	local v387 = nil
	v387 = if v376:match("Survivor") then require(v378:FindFirstChild("Normal"):FindFirstChild("Configuration")) else require(v378:FindFirstChild(v378:GetAttribute("Default")):FindFirstChild("Configuration"))
	for _, v389 in {
		"Health", 
		"Speed", 
		"RunSpeed", 
		"Stamina"
		} do
		if v387[v389] then
			local v390 = script.InventoryCards.InfoCards:Clone()
			v390:FindFirstChild("Name").Text = v389
			v390:FindFirstChild("Value").Text = v387[v389]
			v390.Parent = InventoryUI.Selected.Information.ScrollingFrame
		end
	end
	local v391 = script.ShopCards.SummaryInfo:Clone()
	v391.Summary.Text = v377.Summary
	v391.Parent = InventoryUI.Selected.Information.ScrollingFrame
	for _, v393 in v377.Moves do
		local v394 = {}
		local v395 = 0
		repeat
			if string.find(v393.Desc, "<c>", v395) then
				local v396 = string.find(v393.Desc, "<c>", v395)
				local v397 = string.find(v393.Desc, "<>", v396)
				table.insert(v394, {
					v396, 
					v397
				})
				v395 = v397
			end
			if string.find(v393.Desc, "<d>", v395) then
				local v398 = string.find(v393.Desc, "<d>", v395)
				local v399 = string.find(v393.Desc, "<>", v398)
				table.insert(v394, {
					v398, 
					v399, 
					"Damage"
				})
				v395 = v399
			end
			if string.find(v393.Desc, "<q>", v395) then
				local v400 = string.find(v393.Desc, "<q>", v395)
				local v401 = string.find(v393.Desc, "<>", v400)
				table.insert(v394, {
					v400, 
					v401, 
					nil, 
					true
				})
				v395 = v401
			end
			if string.find(v393.Desc, "<p>", v395) then
				local v402 = string.find(v393.Desc, "<p>", v395)
				local v403 = string.find(v393.Desc, "<>", v402)
				table.insert(v394, {
					v402, 
					v403, 
					"Damage", 
					true
				})
				v395 = v403
			end
			task.wait(0.01)
		until not string.find(v393.Desc, "<c>", v395) and not string.find(v393.Desc, "<d>", v395) and not string.find(v393.Desc, "<p>", v395) and not string.find(v393.Desc, "<q>", v395)
		local v404 = ""
		local v405 = nil
		for v406 = 1, #v393.Desc do
			for _, v408 in v394 do
				if v408[1] == v406 then
					v405 = v408[2] + 1
					if v408[3] and v408[3] ~= nil then
						if v408[4] then
							v404 = v404 .. v387[v408[3]][string.sub(v393.Desc, v408[1] + 3, v408[2] - 1)] * 100
						else
							v404 = v404 .. v387[v408[3]][string.sub(v393.Desc, v408[1] + 3, v408[2] - 1)]
						end
					elseif v408[4] then
						v404 = v404 .. v387[string.sub(v393.Desc, v408[1] + 3, v408[2] - 1)] * 100
					else
						v404 = v404 .. v387[string.sub(v393.Desc, v408[1] + 3, v408[2] - 1)]
					end
				end
			end
			if v405 ~= nil then
				if v406 >= v405 then
					v405 = nil
				end
			else
				v404 = v404 .. string.sub(v393.Desc, v406, v406)
			end
		end
		local v409 = script.InventoryCards.MoveCards:Clone()
		v409.Holder:FindFirstChild("Name").Text = v393.Name
		v409.Holder:FindFirstChild("Icon").Image = v393.Icon
		v409.Holder.Description.Text = v404
		if v393.ImageRectSize then
			v409.Holder:FindFirstChild("Icon").ImageRectSize = v393.ImageRectSize
		end
		if v393.ImageRectOffset then
			v409.Holder:FindFirstChild("Icon").ImageRectOffset = v393.ImageRectOffset
		end
		v409.Parent = InventoryUI.Selected.Information.ScrollingFrame
	end
	script.InventoryCards.Spacing:Clone().Parent = InventoryUI.Selected.Information.ScrollingFrame
	local v410 = 1
	v375:Mark(InventoryUI.Selected.Cosmetics.TabButtons.Emotes.Button.MouseButton1Click:Connect(function() --[[ Line: 2556 ]]
		-- upvalues: v410 (ref), v349 (ref), v351 (ref), v348 (ref), v350 (ref)
		if v410 == 1 then
			return
		else
			script.Parent.sfx.open:play()
			local v411 = false
			if v349 then
				task.spawn(function() --[[ Line: 2561 ]]
					-- upvalues: v349 (ref)
					repeat
						local v412 = v349.Stop()
						task.wait()
					until v412 ~= false
					v349 = nil
				end)
				v411 = true
			end
			if v351 then
				v351:Destroy()
			end
			v348 = nil
			v410 = 1
			if v411 == true then
				v350:Play()
			end
			return
		end
	end))
	v375:Mark(InventoryUI.Selected.Cosmetics.TabButtons.Skins.Button.MouseButton1Click:Connect(function() --[[ Line: 2580 ]]
		-- upvalues: v410 (ref), v349 (ref), v351 (ref), v348 (ref), v350 (ref)
		if v410 == 2 then
			return
		else
			script.Parent.sfx.open:play()
			local v413 = false
			if v349 then
				v413 = true
				task.spawn(function() --[[ Line: 2587 ]]
					-- upvalues: v349 (ref)
					repeat
						local v414 = v349.Stop()
						task.wait()
					until v414 ~= false
					v349 = nil
				end)
			end
			if v351 then
				v351:Destroy()
			end
			v348 = nil
			v410 = 2
			if v413 == true then
				v350:Play()
			end
			return
		end
	end))
	v375:Mark(InventoryUI.Selected.Holder.Equip.Button.MouseButton1Click:Connect(function() --[[ Line: 2604 ]]
		-- upvalues: v120 (ref), v376 (copy), InventoryUI (ref), v4 (ref)
		if v120.Character.Killer == v376 or v120.Character.Survivor == v376 then
			return
		else
			script.Parent.sfx.open:play()
			if v376:match("Survivor") then
				v120.Character.Survivor = v376
				if v120.Character.Survivor == v376 then
					InventoryUI.Selected.Holder.Equip.Button:FindFirstChild("Name").Text = "EQUIPPED"
				else
					InventoryUI.Selected.Holder.Equip.Button:FindFirstChild("Name").Text = "EQUIP"
				end
				v4:Fire(true, "Equip", {
					"Survivor", 
					v376
				})
				return
			else
				v120.Character.Killer = v376
				if v120.Character.Killer == v376 then
					InventoryUI.Selected.Holder.Equip.Button:FindFirstChild("Name").Text = "EQUIPPED"
				else
					InventoryUI.Selected.Holder.Equip.Button:FindFirstChild("Name").Text = "EQUIP"
				end
				v4:Fire(true, "Equip", {
					"Killer", 
					v376
				})
				return
			end
		end
	end))
	if v376:match("Survivor") then
		for _, v416 in game:GetService("ReplicatedStorage").UniqueSkins:GetChildren() do
			if table.find(v120.OwnedSkins.SurvivorAll, v416.Name) then
				local v417 = script.InventoryCards.SkinCards:Clone()
				v417.LayoutOrder = v416:GetAttribute("Cost")
				v417.Name = v416.Name
				v417:FindFirstChild("Button"):FindFirstChild("Name").Text = v416.Name
				v417:FindFirstChild("Button"):FindFirstChild("Render").Image = "rbxassetid://" .. v416:GetAttribute("Icon")
				v417.Parent = InventoryUI.Selected.Cosmetics.Skins.ScrollingFrame
				if v120.EquippedSkins[v376] == v416.Name then
					v417.Button.Equipped.Visible = true
				end
				v375:Mark(v417.Button.MouseButton1Click:Connect(function() --[[ Line: 2643 ]]
					-- upvalues: v347 (ref), v416 (copy), v378 (ref), v374 (ref), v376 (copy)
					if v347 == v416.Name then
						return
					else
						script.Parent.sfx.open:play()
						if v378.Parent.Name == "Survivor" then
							v374(v376, v416.Name)
							return
						else
							v374(v376, v416.Name)
							return
						end
					end
				end))
			end
		end
	end
	for _, v419 in v378:GetChildren() do
		if table.find(v120.OwnedSkins[v376], v419.Name) then
			local v420 = script.InventoryCards.SkinCards:Clone()
			v420.LayoutOrder = v419:GetAttribute("Cost")
			v420.Name = v419.Name
			v420:FindFirstChild("Button"):FindFirstChild("Name").Text = v419.Name
			v420:FindFirstChild("Button"):FindFirstChild("Render").Image = "rbxassetid://" .. v419:GetAttribute("Icon")
			v420.Parent = InventoryUI.Selected.Cosmetics.Skins.ScrollingFrame
			if v120.EquippedSkins[v376] == v419.Name then
				v420.Button.Equipped.Visible = true
			end
			v375:Mark(v420.Button.MouseButton1Click:Connect(function() --[[ Line: 2671 ]]
				-- upvalues: v347 (ref), v419 (copy), v378 (ref), v374 (ref), v376 (copy)
				if v347 == v419.Name then
					return
				else
					script.Parent.sfx.open:play()
					if v378.Parent.Name == "Survivor" then
						v374(v376, v419.Name)
						return
					else
						v374(v376, v419.Name)
						return
					end
				end
			end))
		end
	end
	for _, v422 in game:GetService("ReplicatedStorage").Modules.Emotes:GetChildren() do
		if (v422:GetAttribute("Character") == v376 or v422:GetAttribute("Character") == "Survivor" and v378.Parent.Name == "Survivor") and table.find(v120.OwnedEmotes, v422.Name) then
			local v423 = script.InventoryCards.EmoteCards:Clone()
			if string.split(v422.Name, "-") then
				v423:FindFirstChild("Button"):FindFirstChild("Name").Text = string.split(v422.Name, "-")[1]
			else
				v423:FindFirstChild("Button"):FindFirstChild("Name").Text = v422.Name
			end
			v423.LayoutOrder = v422:GetAttribute("Price")
			v423.Button.Icon.Image = "rbxassetid://" .. v422:GetAttribute("Icon")
			v423.Name = v422.Name
			v423.Parent = InventoryUI.Selected.Cosmetics.Emotes.ScrollingFrame
			if v378.Parent.Name == "Survivor" then
				if table.find(v120.Emotes.Survivor, v422.Name) then
					v423.Button.Equipped.Visible = true
				end
			elseif table.find(v120.Emotes[v376], v422.Name) then
				v423.Button.Equipped.Visible = true
			end
			v375:Mark(v423.Button.MouseButton1Click:Connect(function() --[[ Line: 2706 ]]
				-- upvalues: v348 (ref), v422 (copy), v349 (ref), v351 (ref), v350 (ref), v345 (ref), InventoryUI (ref), v378 (ref), v120 (ref), v423 (copy), v376 (copy)
				if v348 == v422.Name then
					return
				else
					script.Parent.sfx.open:play()
					if v349 then
						if v349.Stop() == false then
							return
						else
							v349 = nil
						end
					end
					if v351 then
						v351:Destroy()
					end
					v350:Stop()
					v349 = require(v422).new({
						v345
					})
					v349.EmoteFunc()
					if v422:FindFirstChildOfClass("Sound") then
						v351 = v422:FindFirstChildOfClass("Sound"):Clone()
						v351.Parent = script.Parent.sfx
						v351:Play()
					end
					for _, v425 in InventoryUI.Selected.Cosmetics.Emotes.ScrollingFrame:GetChildren() do
						if v425:IsA("Frame") and v425.Name ~= "Spacing" then
							if v378.Parent.Name == "Survivor" then
								if table.find(v120.Emotes.Survivor, v422.Name) then
									v423.Button.Equipped.Visible = true
								else
									v423.Button.Equipped.Visible = false
								end
							elseif table.find(v120.Emotes[v376], v422.Name) then
								v423.Button.Equipped.Visible = true
							else
								v423.Button.Equipped.Visible = false
							end
						end
					end
					v348 = v422.Name
					return
				end
			end))
		end
	end
	v375:Mark(InventoryUI.Selected.Cosmetics.Back.Button.MouseButton1Click:Connect(function() --[[ Line: 2754 ]]
		-- upvalues: v349 (ref), v348 (ref), v351 (ref), v350 (ref), v376 (copy), InventoryUI (ref), v347 (ref), v377 (copy)
		script.Parent.sfx.open:play()
		if v349 then
			task.spawn(function() --[[ Line: 2758 ]]
				-- upvalues: v349 (ref), v348 (ref)
				repeat
					local v426 = v349.Stop()
					task.wait()
				until v426 ~= false
				v349 = nil
				v348 = nil
			end)
		end
		if v351 then
			v351:Destroy()
		end
		v350:Play()
		if game:GetService("ReplicatedStorage").Characters:FindFirstChild(v376) then
			InventoryUI.Selected.Holder:FindFirstChild("Render"):FindFirstChild("Render").Image = "rbxassetid://" .. game:GetService("ReplicatedStorage").Characters:FindFirstChild(v376):FindFirstChild(v347):GetAttribute("Icon")
		end
		if v376:match("Survivor") then
			local v427 = string.split(v376, "-")
			InventoryUI.Selected.Holder:FindFirstChild("Render"):FindFirstChild("Render").Image = "rbxassetid://" .. game:GetService("ReplicatedStorage").Characters:FindFirstChild("Survivor"):FindFirstChild(v427[2]):FindFirstChild(v347):GetAttribute("Icon")
		end
		if v377.SkinRenders and v377.SkinRenders[v347] then
			InventoryUI.Selected.Holder:FindFirstChild("Render"):FindFirstChild("Render").AnchorPoint = v377.SkinRenders[v347].RenderAnchor
			InventoryUI.Selected.Holder:FindFirstChild("Render"):FindFirstChild("Render").Size = v377.SkinRenders[v347].RenderSize
			return
		else
			InventoryUI.Selected.Holder:FindFirstChild("Render"):FindFirstChild("Render").AnchorPoint = v377.RenderAnchor
			InventoryUI.Selected.Holder:FindFirstChild("Render"):FindFirstChild("Render").Size = v377.RenderSize
			return
		end
	end))
end
local v429 = nil
InventoryUI.Selected.Cosmetics.Emotes.Equip.Button.MouseButton1Click:Connect(function() --[[ Line: 2793 ]]
	-- upvalues: InventoryUI (copy), v429 (ref), v346 (ref), v120 (ref), Maid (copy), v4 (copy), v348 (ref)
	if InventoryUI.EmoteEquip.Visible == true then
		return
	else
		if v429 then
			v429:Sweep()
			v429:Destroy()
			v429 = nil
		end
		InventoryUI.EmoteEquip.Visible = true
		local l_v346_0 = v346
		if v346:match("Survivor") then
			l_v346_0 = "Survivor"
		end
		for v431 = 1, 4 do
			if v120.Emotes[l_v346_0][v431] then
				InventoryUI.EmoteEquip:FindFirstChild("Emote" .. v431):FindFirstChild("ICON").Image = "rbxassetid://" .. game:GetService("ReplicatedStorage").Modules.Emotes:FindFirstChild(v120.Emotes[l_v346_0][v431]):GetAttribute("Icon")
				if string.split(v120.Emotes[l_v346_0][v431], "-") then
					InventoryUI.EmoteEquip:FindFirstChild("Emote" .. v431)["EMOTE-NAME"].Text = string.split(v120.Emotes[l_v346_0][v431], "-")[1]
				else
					InventoryUI.EmoteEquip:FindFirstChild("Emote" .. v431)["EMOTE-NAME"].Text = v120.Emotes[l_v346_0][v431]
				end
			end
		end
		v429 = Maid.new()
		local v432 = 0
		local function v436(v433) --[[ Line: 2819 ]] --[[ Name: Equip ]]
			-- upvalues: v4 (ref), l_v346_0 (ref), v348 (ref), v120 (ref), InventoryUI (ref), v346 (ref), v429 (ref)
			v4:Fire(true, "EquipEmote", {
				l_v346_0, 
				v433, 
				v348
			})
			v120.Emotes[l_v346_0][v433] = v348
			for _, v435 in InventoryUI.Selected.Cosmetics.Emotes.ScrollingFrame:GetChildren() do
				if v435:IsA("Frame") and v435.Name ~= "Spacing" then
					if v346:match("Survivor") then
						if table.find(v120.Emotes.Survivor, v435.Name) then
							v435.Button.Equipped.Visible = true
						end
					elseif table.find(v120.Emotes[l_v346_0], v435.Name) then
						v435.Button.Equipped.Visible = true
					end
				end
			end
			InventoryUI.EmoteEquip.Visible = false
			v429:Sweep()
			v429:Destroy()
			v429 = nil
		end
		v429:Mark(InventoryUI.EmoteEquip.Emote1.MouseButton1Click:Connect(function() --[[ Line: 2842 ]]
			-- upvalues: v436 (copy), v432 (ref)
			script.Parent.sfx.open:play()
			v436(v432 + 1)
		end))
		v429:Mark(InventoryUI.EmoteEquip.Emote2.MouseButton1Click:Connect(function() --[[ Line: 2846 ]]
			-- upvalues: v436 (copy), v432 (ref)
			script.Parent.sfx.open:play()
			v436(v432 + 2)
		end))
		v429:Mark(InventoryUI.EmoteEquip.Emote3.MouseButton1Click:Connect(function() --[[ Line: 2850 ]]
			-- upvalues: v436 (copy), v432 (ref)
			v436(v432 + 3)
		end))
		v429:Mark(InventoryUI.EmoteEquip.Emote4.MouseButton1Click:Connect(function() --[[ Line: 2853 ]]
			-- upvalues: v436 (copy), v432 (ref)
			v436(v432 + 4)
		end))
		v429:Mark(InventoryUI.EmoteEquip.PageChange.MouseButton1Click:Connect(function() --[[ Line: 2857 ]]
			-- upvalues: v432 (ref), v120 (ref), l_v346_0 (ref), InventoryUI (ref)
			script.Parent.sfx.open:play()
			if v432 == 4 then
				for v437 = 1, 4 do
					if v120.Emotes[l_v346_0][v437] then
						InventoryUI.EmoteEquip:FindFirstChild("Emote" .. v437):FindFirstChild("ICON").Image = "rbxassetid://" .. game:GetService("ReplicatedStorage").Modules.Emotes:FindFirstChild(v120.Emotes[l_v346_0][v437]):GetAttribute("Icon")
						if string.split(v120.Emotes[l_v346_0][v437], "-") then
							InventoryUI.EmoteEquip:FindFirstChild("Emote" .. v437)["EMOTE-NAME"].Text = string.split(v120.Emotes[l_v346_0][v437], "-")[1]
						else
							InventoryUI.EmoteEquip:FindFirstChild("Emote" .. v437)["EMOTE-NAME"].Text = v120.Emotes[l_v346_0][v437]
						end
					end
				end
				v432 = 0
				return
			else
				for v438 = 5, 8 do
					if v120.Emotes[l_v346_0][v438] then
						InventoryUI.EmoteEquip:FindFirstChild("Emote" .. v438 - 4):FindFirstChild("ICON").Image = "rbxassetid://" .. game:GetService("ReplicatedStorage").Modules.Emotes:FindFirstChild(v120.Emotes[l_v346_0][v438]):GetAttribute("Icon")
						if string.split(v120.Emotes[l_v346_0][v438], "-") then
							InventoryUI.EmoteEquip:FindFirstChild("Emote" .. v438 - 4)["EMOTE-NAME"].Text = string.split(v120.Emotes[l_v346_0][v438], "-")[1]
						else
							InventoryUI.EmoteEquip:FindFirstChild("Emote" .. v438 - 4)["EMOTE-NAME"].Text = v120.Emotes[l_v346_0][v438]
						end
					end
				end
				v432 = 4
				return
			end
		end))
		v429:Mark(InventoryUI.Selected.Cosmetics.Emotes.Equip.Button.MouseButton1Click:Connect(function() --[[ Line: 2888 ]]
			-- upvalues: InventoryUI (ref), v429 (ref)
			script.Parent.sfx.open:play()
			InventoryUI.EmoteEquip.Visible = false
			v429:Sweep()
			v429:Destroy()
			v429 = nil
		end))
		v429:Mark(InventoryUI.Selected.Cosmetics.Emotes.Equip.Button.MouseButton1Click:Connect(function() --[[ Line: 2896 ]]
			-- upvalues: InventoryUI (ref), v429 (ref)
			script.Parent.sfx.open:play()
			InventoryUI.EmoteEquip.Visible = false
			v429:Sweep()
			v429:Destroy()
			v429 = nil
		end))
		v429:Mark(InventoryUI.Selected.Cosmetics.Back.Button.MouseButton1Click:Connect(function() --[[ Line: 2904 ]]
			-- upvalues: InventoryUI (ref), v429 (ref)
			script.Parent.sfx.open:play()
			InventoryUI.EmoteEquip.Visible = false
			v429:Sweep()
			v429:Destroy()
			v429 = nil
		end))
		return
	end
end)
InventoryUI.Selected.Cosmetics.Skins.Equip.Button.MouseButton1Click:Connect(function() --[[ Line: 2913 ]]
	-- upvalues: v4 (copy), v346 (ref), v347 (ref), v120 (ref), InventoryUI (copy)
	script.Parent.sfx.open:play()
	v4:Fire(true, "EquipSkin", {
		v346, 
		v347
	})
	v120.EquippedSkins[v346] = v347
	for _, v440 in InventoryUI.Selected.Cosmetics.Skins.ScrollingFrame:GetChildren() do
		if v440:IsA("Frame") and v440.Name ~= "Spacing" then
			if v440.Name == v120.EquippedSkins[v346] then
				v440.Button.Equipped.Visible = true
			else
				v440.Button.Equipped.Visible = false
			end
		end
	end
end)
LobbyUIContainer.Buttons.Holder.Inventory.Button.MouseButton1Click:Connect(function() --[[ Line: 2928 ]]
	-- upvalues: PlayerUI (copy), v120 (ref), v118 (copy), v222 (ref), ShopAtmosphere (ref), InventoryUI (copy), v11 (copy), v428 (copy)
	PlayerUI.EmoteWheel.Visible = false
	v120 = v118:Invoke(999, "Data")
	if game:GetService("Lighting"):FindFirstChildOfClass("Atmosphere") then
		v222 = game:GetService("Lighting"):FindFirstChildOfClass("Atmosphere")
		v222.Parent = nil
	end
	if not ShopAtmosphere or not ShopAtmosphere.Parent then
		ShopAtmosphere = script:WaitForChild("ShopAtmosphere"):Clone()
	end
	ShopAtmosphere.Parent = game:GetService("Lighting")
	for _, v442 in InventoryUI.List.List.Survivors.ScrollingFrame:GetChildren() do
		if v442:IsA("Frame") and v442.Name ~= "Spacing" then
			v442:Destroy()
		end
	end
	for _, v444 in InventoryUI.List.List.Animatronics.ScrollingFrame:GetChildren() do
		if v444:IsA("Frame") and v444.Name ~= "Spacing" then
			v444:Destroy()
		end
	end
	InventoryUI.List.List.UIPageLayout:JumpTo(InventoryUI.List.List.Animatronics)

	for _, v446 in v120.OwnedChars do
		local v447 = 0
		local v448 = nil
		if v446:match("Survivor") then
			local v449 = string.split(v446, "-")
			if not game:GetService("ReplicatedStorage").Characters:FindFirstChild("Survivor"):FindFirstChild(v449[2]) then
				--[[ close >= 6 ]]
				continue
			else
				v447 = game:GetService("ReplicatedStorage").Characters:FindFirstChild("Survivor"):FindFirstChild(v449[2]):GetAttribute("COST")
				v448 = v11.Survivor[v449[2]]
			end
		elseif not game:GetService("ReplicatedStorage").Characters:FindFirstChild(v446) then
			--[[ close >= 6 ]]
			continue
		else
			v447 = game:GetService("ReplicatedStorage").Characters:FindFirstChild(v446):GetAttribute("COST")
			v448 = v11[v446]
		end
		if not v448 then
			--[[ close >= 6 ]]
		else
			local v450 = script.InventoryCards.SelectionCards:Clone()
			v450.Button.NameText.Text = v448.Name
			v450.Button.Container.Render.Image = v448.Render
			v450.Button.Container.Render.Size = v448.RenderSize
			v450.Button.Container.Render.AnchorPoint = v448.RenderAnchor
			v450.Button.MapImage.Image = v448.MapRender
			v450.Button.Shadow.ImageColor3 = v448.InfoCardColor
			v450.Name = v446
			v450.LayoutOrder = v447
			if v446:match("Survivor") then
				v450.Parent = InventoryUI.List.List.Survivors.ScrollingFrame
			else
				v450.Parent = InventoryUI.List.List.Animatronics.ScrollingFrame
			end
			do
				local l_v448_0 = v448
				v450.Button.MouseButton1Click:Connect(function() --[[ Line: 2982 ]]
					-- upvalues: v428 (ref), v446 (copy), l_v448_0 (ref)
					script.Parent.sfx.open:play()
					v428(v446, l_v448_0)
				end)
			end
		end
	end
	local l_Killer_0 = v120.Character.Killer
	local v453 = nil
	if l_Killer_0:match("Survivor") then
		local v454 = string.split(l_Killer_0, "-")
		v453 = v11.Survivor[v454[2]]
	else
		v453 = v11[l_Killer_0]
	end
	v428(l_Killer_0, v453)
end)
InventoryUI.List.TabButtons.Animatronics.Button.MouseButton1Click:Connect(function() --[[ Line: 2999 ]]
	-- upvalues: v120 (ref), v11 (copy), v428 (copy)
	local l_Killer_1 = v120.Character.Killer
	local v456 = nil
	if l_Killer_1:match("Survivor") then
		local v457 = string.split(l_Killer_1, "-")
		v456 = v11.Survivor[v457[2]]
	else
		v456 = v11[l_Killer_1]
	end
	v428(l_Killer_1, v456)
end)
InventoryUI.List.TabButtons.Survivors.Button.MouseButton1Click:Connect(function() --[[ Line: 3011 ]]
	-- upvalues: v120 (ref), v11 (copy), v428 (copy)
	local l_Survivor_0 = v120.Character.Survivor
	local v459 = nil
	if l_Survivor_0:match("Survivor") then
		local v460 = string.split(l_Survivor_0, "-")
		v459 = v11.Survivor[v460[2]]
	else
		v459 = v11[l_Survivor_0]
	end
	v428(l_Survivor_0, v459)
end)
InventoryUI.Selected.Cosmetics.Skins.Search.TextBox:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 3023 ]]
	-- upvalues: InventoryUI (copy)
	for _, v462 in InventoryUI.Selected.Cosmetics.Skins.ScrollingFrame:GetChildren() do
		if v462:IsA("Frame") then
			v462.Visible = string.find(v462.Name:lower(), InventoryUI.Selected.Cosmetics.Skins.Search.TextBox.Text:lower()) and true or false
		end
	end
end)
InventoryUI.Selected.Cosmetics.Emotes.Search.TextBox:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 3031 ]]
	-- upvalues: InventoryUI (copy)
	for _, v464 in InventoryUI.Selected.Cosmetics.Emotes.ScrollingFrame:GetChildren() do
		if v464:IsA("Frame") then
			v464.Visible = string.find(v464.Name:lower(), InventoryUI.Selected.Cosmetics.Emotes.Search.TextBox.Text:lower()) and true or false
		end
	end
end)
LobbyUIContainer.Buttons.Holder.Spectate.Button.MouseButton1Click:Connect(function() --[[ Line: 3041 ]]
	-- upvalues: v93 (copy)
	Spectate()
end)
script.Parent.UI.MobileOverlay.Holder.Shiftlock.Button.MouseButton1Click:Connect(function() --[[ Line: 3045 ]]
	-- upvalues: Player (copy)
	Player:SetAttribute("Mouselocked", not Player:GetAttribute("Mouselocked"))
end)
local v465 = false
local v466 = 0
local v467 = 0
local v468 = tick()
local l_UIAspectRatioConstraint_0 = Instance.new("UIAspectRatioConstraint")
local l_Text_0 = script.Parent:WaitForChild("UI"):FindFirstChild("DevMode"):FindFirstChild("ServerUptime"):FindFirstChild("Text")
local l_Text_1 = script.Parent:WaitForChild("UI"):FindFirstChild("DevMode"):FindFirstChild("FPS"):FindFirstChild("Text")
local l_Text_2 = script.Parent:WaitForChild("UI"):FindFirstChild("DevMode"):FindFirstChild("Ping"):FindFirstChild("Text")
local v473 = game:GetService("RunService"):IsRunning() and time or os.clock
local v474 = nil
local v475 = nil
local v476 = {}
local v477 = false
v475 = v473()
script.Parent:WaitForChild("UI"):FindFirstChild("DevMode"):FindFirstChild("Region"):FindFirstChild("Text").Text = workspace:WaitForChild("GAME"):WaitForChild("Region").Value
script.Parent:WaitForChild("UI"):FindFirstChild("DevMode"):FindFirstChild("Version"):FindFirstChild("Text").Text = "Server Version: " .. game.PlaceVersion
game:GetService("Workspace").DescendantAdded:Connect(function(v478) --[[ Line: 3070 ]]
	-- upvalues: Player (copy)
	if Player:GetAttribute("Potato") == true and v478:IsA("ParticleEmitter") then
		v478:Destroy()
		return
	else
		if Player:GetAttribute("Potato") == true and v478:IsA("Beam") then
			v478:Destroy()
		end
		return
	end
end)
game:GetService("RunService").RenderStepped:Connect(function() --[[ Line: 3078 ]]
	-- upvalues: v474 (ref), v473 (copy), v476 (copy), l_Text_1 (copy), v475 (ref), l_Text_2 (copy), Player (copy), l_Text_0 (copy), v468 (ref), l_UIAspectRatioConstraint_0 (copy), v14 (copy), v13 (copy), PlayerUI (copy), v465 (ref), v477 (ref), Character (ref), PlayerHealth (ref), v9 (ref), v466 (ref), v467 (ref), TweenService (copy)
	v474 = v473()
	for v479 = #v476, 1, -1 do
		v476[v479 + 1] = v476[v479] >= v474 - 1 and v476[v479] or nil
	end
	v476[1] = v474
	l_Text_1.Text = "FPS: " .. tostring((math.floor(v473() - v475 >= 1 and #v476 or #v476 / (v473() - v475))))
	l_Text_2.Text = "Ping: " .. math.round(Player:GetNetworkPing() * 1000)
	local v480 = math.floor(workspace.GAME:FindFirstChild("ServerUpTime").Value)
	local v481 = math.floor(v480 / 3600)
	local v482 = math.floor(v480 / 60) - v481 * 60
	v480 = v480 - v481 * 3600 - v482 * 60
	l_Text_0.Text = "Server Uptime: " .. string.format("%02d:%02d:%02d", v481, v482, v480)
	if tick() - v468 > 0.01 then
		v468 = tick()
	end
	if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health <= 0 then
		if script.Parent.Static.Visible == false then
			script.Parent.sfx.death:Play()
			script.Parent.Static.VideoFrame.TimePosition = 0
			script.Parent.Static.VideoFrame:Play()
		end
		script.Parent.Static.Visible = true
	else
		script.Parent.sfx.death:Pause()
		script.Parent.Static.VideoFrame:Pause()
		script.Parent.Static.Visible = false
	end
	if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("TouchGui") and game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("TouchGui"):FindFirstChild("JumpButton", true) then
		l_UIAspectRatioConstraint_0.Parent = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("TouchGui"):FindFirstChild("JumpButton", true)
		game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("TouchGui"):FindFirstChild("JumpButton", true).Position = UDim2.new(0.875, 0, 0.6, 0)
		game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("TouchGui"):FindFirstChild("JumpButton", true).Size = UDim2.new(0.15, 0, 0.15, 0)
	end
	GameUIContainer.Info.Holder.Health.Visible = game:GetService("Players").LocalPlayer:GetAttribute("TEAM") ~= "Killer"
	if game:GetService("UserInputService").TouchEnabled and not game:GetService("UserInputService").KeyboardEnabled and not game:GetService("UserInputService").MouseEnabled and LobbyUIContainer.Inventory.Visible == false and LobbyUIContainer.Spectate.Visible == false then
		script.Parent.UI.MobileOverlay.Visible = true
		local l_Crouch_0 = script.Parent.UI.MobileOverlay.Holder.Crouch
		local v484 = false
		if game:GetService("Players").LocalPlayer:GetAttribute("TEAM") ~= "Killer" then
			v484 = game:GetService("Players").LocalPlayer:GetAttribute("TEAM") ~= "Lobby"
		end
		l_Crouch_0.Visible = v484
	else
		script.Parent.UI.MobileOverlay.Visible = false
	end
	if GameUIContainer.Visible == false and LobbyUIContainer.Visible == false then
		script.Parent.UI.MobileOverlay.Visible = false
	end
	local l_magnitude_0 = (workspace.CurrentCamera.CFrame.p - workspace.CurrentCamera.Focus.p).magnitude
	if game:GetService("UserInputService").MouseBehavior == Enum.MouseBehavior.LockCenter and l_magnitude_0 > 2 then
		local l_AbsolutePosition_0 = script.Parent.AbsolutePosition
		if game:GetService("UserInputService").TouchEnabled or game:GetService("UserInputService").GamepadEnabled then
			script.Parent.Mouselock.Position = UDim2.new(0.5, 0, 0.5, 0)
		else
			script.Parent.Mouselock.Position = UDim2.new(0, Player:GetMouse().X - l_AbsolutePosition_0.X, 0, Player:GetMouse().Y - l_AbsolutePosition_0.Y)
		end
		game:GetService("TweenService"):Create(script.Parent.Mouselock, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			ImageTransparency = 0.5
		}):Play()
	else
		game:GetService("TweenService"):Create(script.Parent.Mouselock, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			ImageTransparency = 1
		}):Play()
	end
	if workspace.GAME.MODE.Value == "WAITING" then
		LobbyUIContainer.Timer.Holder.Am.Visible = false
		LobbyUIContainer.Timer.Holder.Text.Text = "W A I T I N G"
		LobbyUIContainer.Timer.Holder.Clock.Timer.Visible = false
		LobbyUIContainer.Timer.Holder.Clock.Timer2.Visible = false
	elseif workspace.GAME.MODE.Value == "INTERMISSION" then
		if LobbyUIContainer.Timer.Holder.Clock.Timer2.Visible == false then
			LobbyUIContainer.Timer.Holder.Clock.Timer2:FindFirstChild("1"):FindFirstChild("UIPageLayout").TweenTime = 0
			LobbyUIContainer.Timer.Holder.Clock.Timer2:FindFirstChild("2"):FindFirstChild("UIPageLayout").TweenTime = 0
		else
			LobbyUIContainer.Timer.Holder.Clock.Timer2:FindFirstChild("1"):FindFirstChild("UIPageLayout").TweenTime = 0.5
			LobbyUIContainer.Timer.Holder.Clock.Timer2:FindFirstChild("2"):FindFirstChild("UIPageLayout").TweenTime = 0.5
		end
		LobbyUIContainer.Timer.Holder.Am.Visible = false
		LobbyUIContainer.Timer.Holder.Text.Text = "I N T E R M I S S I O N"
		LobbyUIContainer.Timer.Holder.Clock.Timer.Visible = false
		LobbyUIContainer.Timer.Holder.Clock.Timer2.Visible = true
		local v487 = tostring(workspace.GAME.TIMER.Value)
		if workspace.GAME.TIMER.Value >= 0 then
			if string.len(v487) >= 2 then
				LobbyUIContainer.Timer.Holder.Clock.Timer2:FindFirstChild("1"):FindFirstChild("UIPageLayout"):JumpToIndex((tonumber((string.sub(v487, 1, 1)))))
				LobbyUIContainer.Timer.Holder.Clock.Timer2:FindFirstChild("2"):FindFirstChild("UIPageLayout"):JumpToIndex((tonumber((string.sub(v487, 2, 2)))))
			else
				LobbyUIContainer.Timer.Holder.Clock.Timer2:FindFirstChild("1"):FindFirstChild("UIPageLayout"):JumpToIndex(0)
				LobbyUIContainer.Timer.Holder.Clock.Timer2:FindFirstChild("2"):FindFirstChild("UIPageLayout"):JumpToIndex((tonumber(v487)))
			end
		end
	else
		if LobbyUIContainer.Timer.Holder.Clock.Timer.Visible == false then
			LobbyUIContainer.Timer.Holder.Clock.Timer:FindFirstChild("1"):FindFirstChild("UIPageLayout").TweenTime = 0
			LobbyUIContainer.Timer.Holder.Clock.Timer:FindFirstChild("2"):FindFirstChild("UIPageLayout").TweenTime = 0
			LobbyUIContainer.Timer.Holder.Clock.Timer:FindFirstChild("3"):FindFirstChild("UIPageLayout").TweenTime = 0
			LobbyUIContainer.Timer.Holder.Clock.Timer:FindFirstChild("4"):FindFirstChild("UIPageLayout").TweenTime = 0
			GameUIContainer.Timer.Holder.Clock.Timer:FindFirstChild("1"):FindFirstChild("UIPageLayout").TweenTime = 0
			GameUIContainer.Timer.Holder.Clock.Timer:FindFirstChild("2"):FindFirstChild("UIPageLayout").TweenTime = 0
			GameUIContainer.Timer.Holder.Clock.Timer:FindFirstChild("3"):FindFirstChild("UIPageLayout").TweenTime = 0
			GameUIContainer.Timer.Holder.Clock.Timer:FindFirstChild("4"):FindFirstChild("UIPageLayout").TweenTime = 0
		else
			LobbyUIContainer.Timer.Holder.Clock.Timer:FindFirstChild("1"):FindFirstChild("UIPageLayout").TweenTime = 0.5
			LobbyUIContainer.Timer.Holder.Clock.Timer:FindFirstChild("2"):FindFirstChild("UIPageLayout").TweenTime = 0.5
			LobbyUIContainer.Timer.Holder.Clock.Timer:FindFirstChild("3"):FindFirstChild("UIPageLayout").TweenTime = 0.5
			LobbyUIContainer.Timer.Holder.Clock.Timer:FindFirstChild("4"):FindFirstChild("UIPageLayout").TweenTime = 0.5
			GameUIContainer.Timer.Holder.Clock.Timer:FindFirstChild("1"):FindFirstChild("UIPageLayout").TweenTime = 0.5
			GameUIContainer.Timer.Holder.Clock.Timer:FindFirstChild("2"):FindFirstChild("UIPageLayout").TweenTime = 0.5
			GameUIContainer.Timer.Holder.Clock.Timer:FindFirstChild("3"):FindFirstChild("UIPageLayout").TweenTime = 0.5
			GameUIContainer.Timer.Holder.Clock.Timer:FindFirstChild("4"):FindFirstChild("UIPageLayout").TweenTime = 0.5
		end
		PlayerUI.UI.RoundKiller.Visible = false
		local v488 = convertToHMS((math.clamp(workspace.GAME.TIMER.Value - 1, 0, 1e999)))
		if string.len(v488[1]) >= 2 then
			LobbyUIContainer.Timer.Holder.Clock.Timer:FindFirstChild("1"):FindFirstChild("UIPageLayout"):JumpToIndex((tonumber((string.sub(v488[1], 1, 1)))))
			LobbyUIContainer.Timer.Holder.Clock.Timer:FindFirstChild("2"):FindFirstChild("UIPageLayout"):JumpToIndex((tonumber((string.sub(v488[1], 2, 2)))))
			GameUIContainer.Timer.Holder.Clock.Timer:FindFirstChild("1"):FindFirstChild("UIPageLayout"):JumpToIndex((tonumber((string.sub(v488[1], 1, 1)))))
			GameUIContainer.Timer.Holder.Clock.Timer:FindFirstChild("2"):FindFirstChild("UIPageLayout"):JumpToIndex((tonumber((string.sub(v488[1], 2, 2)))))
		else
			LobbyUIContainer.Timer.Holder.Clock.Timer:FindFirstChild("1"):FindFirstChild("UIPageLayout"):JumpToIndex(0)
			LobbyUIContainer.Timer.Holder.Clock.Timer:FindFirstChild("2"):FindFirstChild("UIPageLayout"):JumpToIndex((tonumber((string.sub(v488[1], 1, 1)))))
			GameUIContainer.Timer.Holder.Clock.Timer:FindFirstChild("1"):FindFirstChild("UIPageLayout"):JumpToIndex(0)
			GameUIContainer.Timer.Holder.Clock.Timer:FindFirstChild("2"):FindFirstChild("UIPageLayout"):JumpToIndex((tonumber((string.sub(v488[1], 1, 1)))))
		end
		if string.len(v488[2]) then
			LobbyUIContainer.Timer.Holder.Clock.Timer:FindFirstChild("3"):FindFirstChild("UIPageLayout"):JumpToIndex((tonumber((string.sub(v488[2], 1, 1)))))
			LobbyUIContainer.Timer.Holder.Clock.Timer:FindFirstChild("4"):FindFirstChild("UIPageLayout"):JumpToIndex((tonumber((string.sub(v488[2], 2, 2)))))
			GameUIContainer.Timer.Holder.Clock.Timer:FindFirstChild("3"):FindFirstChild("UIPageLayout"):JumpToIndex((tonumber((string.sub(v488[2], 1, 1)))))
			GameUIContainer.Timer.Holder.Clock.Timer:FindFirstChild("4"):FindFirstChild("UIPageLayout"):JumpToIndex((tonumber((string.sub(v488[2], 2, 2)))))
		end
		LobbyUIContainer.Timer.Holder.Am.Visible = true
		LobbyUIContainer.Timer.Holder.Text.Text = "T I M E R"
		LobbyUIContainer.Timer.Holder.Clock.Timer.Visible = true
		LobbyUIContainer.Timer.Holder.Clock.Timer2.Visible = false
		GameUIContainer.Timer.Holder.Am.Visible = true
		GameUIContainer.Timer.Holder.Text.Text = "T I M E R"
		GameUIContainer.Timer.Holder.Clock.Timer.Visible = true
		GameUIContainer.Timer.Holder.Clock.Timer2.Visible = false
		for _, v490 in GameUIContainer.Tasks.List:GetChildren() do
			if v490:IsA("Frame") then
				if workspace.GAME.Tasks:FindFirstChild(v490.Name) and workspace.GAME.Tasks:FindFirstChild(v490.Name):FindFirstChild("Enabled").Value == true then
					v490.Visible = true
					v490:FindFirstChild("Text").Holder.Text.Text = v490:FindFirstChild("Text").Holder.Text:GetAttribute("Text") .. "(" .. workspace.GAME.Tasks:FindFirstChild(v490.Name):FindFirstChild("count").Value .. "/" .. workspace.GAME.Tasks:FindFirstChild(v490.Name):FindFirstChild("total").Value .. ")"
				else
					v490.Visible = false
				end
			end
		end
		if workspace.GAME.TIMER.Value >= 360 then
			if v465 == false then
				v465 = true
			end
		else
			v465 = false
		end
	end
	if Player:GetAttribute("Performance") == true then
		script.Parent:WaitForChild("UI"):FindFirstChild("DevMode").Visible = true
	else
		script.Parent:WaitForChild("UI"):FindFirstChild("DevMode").Visible = false
	end
	if Player:GetAttribute("Potato") == true and v477 == false then
		v477 = true
		game:GetService("Lighting").GlobalShadows = false
	elseif Player:GetAttribute("Potato") == false and v477 == true then
		v477 = false
		game:GetService("Lighting").GlobalShadows = true
	end
	if workspace:WaitForChild("IGNORE"):FindFirstChild("ServerSidedVisual-" .. Player.Name) then
		if Player:GetAttribute("ServerSide") == true then
			workspace:WaitForChild("IGNORE"):FindFirstChild("ServerSidedVisual-" .. Player.Name).Transparency = 0.75
		else
			workspace:WaitForChild("IGNORE"):FindFirstChild("ServerSidedVisual-" .. Player.Name).Transparency = 1
		end
	end
	if not Character or not Character:GetAttribute("Stamina") or not Character:GetAttribute("MaxStamina") then
		return
	else
		if Character:GetAttribute("Running") and Character:GetAttribute("Running") == true then
			script.Parent.UI.MobileOverlay.Holder.Sprint.Icon.Image = "rbxassetid://121233376215866"
		else
			script.Parent.UI.MobileOverlay.Holder.Sprint.Icon.Image = "rbxassetid://131035664504986"
		end

		GameUIContainer.Stamina2.Visible = game:GetService("Players").LocalPlayer:GetAttribute("ExtraStaminaBar")
		local v491 = Character:GetAttribute("Dodges") and Character:GetAttribute("Dodges") / Character:WaitForChild("Humanoid").MaxHealth or 0
		local v492 = Character:WaitForChild("Humanoid").Health / Character:WaitForChild("Humanoid").MaxHealth
		local v493 = Character:GetAttribute("Stamina") / Character:GetAttribute("MaxStamina")
		if Character:GetAttribute("MaxStamina") == 0 then
			v493 = 0
		end
		local v494 = Character:WaitForChild("Humanoid").MaxHealth / Character:WaitForChild("Humanoid").Health
		if Character and Character:FindFirstChildOfClass("Humanoid") and PlayerHealth and Character:FindFirstChildOfClass("Humanoid").Health < PlayerHealth then
			task.spawn(function() --[[ Line: 3301 ]]
				-- upvalues: v14 (ref)
				local v495 = UDim2.new(Random.new():NextNumber(0, 0.2), 0, Random.new():NextNumber(0.175, 0.375), 0)
				local v496 = math.random(-15, 15)
				local v497 = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
				GameUIContainer.Info.Holder.Health.Position = v495
				GameUIContainer.Info.Holder.Health.Rotation = v496
				game:GetService("TweenService"):Create(GameUIContainer.Info.Holder.Health, v497, {
					Position = UDim2.new(0.105, 0, 0.274, 0), 
					Rotation = 0
				}):Play()
			end)
		end
		if Character and Character:GetAttribute("Dodges") and v9 and Character:GetAttribute("Dodges") < v9 then
			task.spawn(function() --[[ Line: 3312 ]]
				-- upvalues: v14 (ref)
				local v498 = UDim2.new(Random.new():NextNumber(0.1, 0.3), 0, Random.new():NextNumber(-0.1, 0.1), 0)
				local v499 = math.random(-15, 15)
				local v500 = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
				GameUIContainer.Info.Holder.Shield.Position = v498
				GameUIContainer.Info.Holder.Shield.Rotation = v499
				game:GetService("TweenService"):Create(GameUIContainer.Info.Holder.Shield, v500, {
					Position = UDim2.new(0.196, 0, 0.028, 0), 
					Rotation = 0
				}):Play()
			end)
		end
		v9 = Character:GetAttribute("Dodges")
		PlayerHealth = Character:FindFirstChildOfClass("Humanoid").Health
		if v9 > 0 then
			GameUIContainer.Info.Holder.Shield.Visible = true
		else
			GameUIContainer.Info.Holder.Shield.Visible = false
		end
		GameUIContainer.Info.Holder.Shield.Bar.Amount.Text = math.ceil((Character:GetAttribute("Dodges"))) .. "/" .. math.ceil(Character:WaitForChild("Humanoid").MaxHealth)
		GameUIContainer.Info.Holder.Health.Bar.Amount.Text = math.ceil(Character:WaitForChild("Humanoid").Health) .. "/" .. math.ceil(Character:WaitForChild("Humanoid").MaxHealth)
		if Character:GetAttribute("MaxStamina") <= 0 then
			GameUIContainer.Info.Holder.Stamina.Bar.Amount.Text = "0/0"
			GameUIContainer.Stamina2.Percentage.Text = "0/0"
		else
			GameUIContainer.Stamina2.Percentage.Text = math.ceil((Character:GetAttribute("Stamina"))) .. "/" .. math.ceil((Character:GetAttribute("MaxStamina")))
			GameUIContainer.Info.Holder.Stamina.Bar.Amount.Text = math.ceil((Character:GetAttribute("Stamina"))) .. "/" .. math.ceil((Character:GetAttribute("MaxStamina")))
		end
		if Character:WaitForChild("Humanoid").Health > 0 then
			PlayerUI.sfx.Heartbeat:SetAttribute("Volume", (math.clamp(v494 / 1.25 - 1, 0, 3)))
			PlayerUI.sfx.Heartbeat.Volume = math.clamp(v494 / 1.25 - 1, 0, 3)
			PlayerUI.sfx.Heartbeat.PlaybackSpeed = math.clamp(v494 / 2, 0.5, 1.5)
		else
			PlayerUI.sfx.Heartbeat:SetAttribute("Volume", 0)
			PlayerUI.sfx.Heartbeat.Volume = 0
			PlayerUI.sfx.Heartbeat.PlaybackSpeed = 0
		end
		if v492 < v466 and v467 - Character:FindFirstChildOfClass("Humanoid").Health >= 5 then
			GameUIContainer.Vignette.ImageColor3 = Color3.fromRGB(72, 0, 0)
			GameUIContainer.Vignette.ImageTransparency = 0
			game:GetService("TweenService"):Create(GameUIContainer.Vignette, TweenInfo.new(0.5), {
				ImageTransparency = 1
			}):Play()
			game:GetService("Workspace").CurrentCamera.FieldOfView = 80
			for _ = 1, math.random(8, 15) do
				local v502 = Random.new():NextNumber(0.25, 1)
				local v503 = script.BloodSplatter:Clone()
				v503.Size = UDim2.new(0, 0, 0, 0)
				v503.Position = UDim2.new(Random.new():NextNumber(0, 1), 0, Random.new():NextNumber(0, 1), 0)
				v503.Parent = GameUIContainer
				game:GetService("TweenService"):Create(v503, TweenInfo.new(0.25), {
					Size = UDim2.new(v502, 0, v502, 0)
				}):Play()
				task.delay(0.25, function() --[[ Line: 3365 ]]
					-- upvalues: v503 (copy)
					game:GetService("TweenService"):Create(v503, TweenInfo.new(1), {
						ImageTransparency = 1
					}):Play()
				end)
				task.delay(1.25, function() --[[ Line: 3368 ]]
					-- upvalues: v503 (copy)
					v503:Destroy()
				end)
			end
			GameUIContainer.Blood.ImageTransparency = 0
		end
		game:GetService("TweenService"):Create(GameUIContainer.Blood, TweenInfo.new(1), {
			ImageTransparency = math.clamp(v492, 0, 1)
		}):Play()
		if not Character:HasTag("CustomFOV") and not Player:HasTag("Cutscene") then
			TweenService:Create(game:GetService("Workspace").CurrentCamera, TweenInfo.new(0.5), {
				FieldOfView = 90
			}):Play()
		end
		v467 = Character:FindFirstChildOfClass("Humanoid").Health
		v466 = v492
		TweenService:Create(GameUIContainer.Stamina2.UIGradient, TweenInfo.new(0.1), {
			Offset = Vector2.new(math.clamp(v493, 0, 1) - 0.5, 0)
		}):Play()
		TweenService:Create(GameUIContainer.Info.Holder.Stamina.Bar.Fill.Fill.UIGradient, TweenInfo.new(0.1), {
			Offset = Vector2.new(math.clamp(v493, 0, 1) - 0.5, 0)
		}):Play()
		TweenService:Create(GameUIContainer.Info.Holder.Shield.Bar.Fill.Fill.UIGradient, TweenInfo.new(0.1), {
			Offset = Vector2.new(math.clamp(v491, 0, 1) - 0.5, 0)
		}):Play()
		TweenService:Create(GameUIContainer.Info.Holder.Shield.Bar.Fill.FillBack.UIGradient, TweenInfo.new(0.5), {
			Offset = Vector2.new(math.clamp(v491, 0, 1) - 0.5, 0)
		}):Play()
		TweenService:Create(GameUIContainer.Info.Holder.Health.Bar.Fill.Fill.UIGradient, TweenInfo.new(0.1), {
			Offset = Vector2.new(math.clamp(v492, 0, 1) - 0.5, 0)
		}):Play()
		TweenService:Create(GameUIContainer.Info.Holder.Health.Bar.Fill.FillBack.UIGradient, TweenInfo.new(0.5), {
			Offset = Vector2.new(math.clamp(v492, 0, 1) - 0.5, 0)
		}):Play()
		return
	end
end)