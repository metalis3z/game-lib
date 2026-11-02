

local ps = game:GetService("Players")

local tool = script.Parent
local gui = tool:WaitForChild("SprayGui")
local remoteFunc = tool.RemoteFunction

local plr = ps.LocalPlayer
local plrGui = plr.PlayerGui
local mouse = plr:GetMouse()

local guiId = "80373023"
local currentGui, guiTextBox, guiImage

local guiIdCon


local function setMouseIcon()
	mouse.Icon = tool.Enabled and "rbxasset://textures\\GunCursor.png" or "rbxasset://textures\\GunWaitCursor.png"
end


tool.Equipped:Connect(function()
	plr = ps:GetPlayerFromCharacter(tool.Parent)
	plrGui = plr.PlayerGui
	
	currentGui = gui:Clone()
	guiTextBox = currentGui.Frame.Frame.TextBox
	guiImage = currentGui.Frame.ImageLabel
	
	guiTextBox.Text = guiId
	guiImage.Image = "rbxassetid://" .. guiId
	
	if guiIdCon then
		guiIdCon:Disconnect()
	end
	guiImage.Image =  "https://www.roblox.com/asset-thumbnail/image?assetId="..guiTextBox.Text.."&width=420&height=420&format=png"
	guiIdCon = guiTextBox:GetPropertyChangedSignal("Text"):Connect(function()
		guiImage.Image =  "https://www.roblox.com/asset-thumbnail/image?assetId="..guiTextBox.Text.."&width=420&height=420&format=png"
	end)
	
	currentGui.Parent = plrGui
	
	setMouseIcon()
end)

tool.Unequipped:Connect(function()
	mouse.Icon = ""
	guiId = guiTextBox.Text
	currentGui:Destroy()
end)


tool:GetPropertyChangedSignal("Enabled"):Connect(function()
	local parent = tool.Parent
	if parent and parent:IsA("Model") then
		setMouseIcon()
	end
end)


remoteFunc.OnClientInvoke = function()
	return mouse.Hit, mouse.TargetSurface, mouse.Target, guiTextBox.Text
end


