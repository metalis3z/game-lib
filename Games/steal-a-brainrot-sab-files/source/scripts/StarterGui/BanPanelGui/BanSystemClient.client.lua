local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local banEvent = RS:WaitForChild("BanSystemEvent")
local ADMIN_ID = 9834833917,4515418871

local gui = script.Parent
local panel = gui:WaitForChild("MainPanel")
local input = panel:WaitForChild("UsernameInput")
local banBtn = panel:WaitForChild("BanButton")
local unbanBtn = panel:WaitForChild("UnbanButton")
local status = panel:WaitForChild("StatusFrame"):WaitForChild("StatusLabel")
local closeBtn = panel:WaitForChild("Header"):WaitForChild("CloseButton")
local toggleBtn = gui:WaitForChild("ToggleButton")

if player.UserId ~= ADMIN_ID then panel.Visible = false; toggleBtn.Visible = false; return end

local function setStatus(msg, color)
	status.Text = msg
	status.TextColor3 = color or Color3.fromRGB(150,150,170)
end

local function openPanel()
	panel.Size = UDim2.new(0, 420, 0, 0)
	panel.Position = UDim2.new(0, 15, 1, -25)
	panel.Visible = true
	toggleBtn.Visible = false
	TweenService:Create(panel, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 420, 0, 320), Position = UDim2.new(0, 15, 1, -340)}):Play()
end

local function closePanel()
	local t = TweenService:Create(panel, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 420, 0, 0), Position = UDim2.new(0, 15, 1, -25)})
	t:Play()
	t.Completed:Connect(function() panel.Visible = false; toggleBtn.Visible = true end)
end

banBtn.MouseButton1Click:Connect(function()
	local u = input.Text:gsub("^%s+",""):gsub("%s+$","")
	if u == "" then setStatus("⚠ Entrez un pseudo.", Color3.fromRGB(255,180,50)); return end
	setStatus("Bannissement...", Color3.fromRGB(150,180,255))
	banEvent:FireServer("ban", u)
end)

unbanBtn.MouseButton1Click:Connect(function()
	local u = input.Text:gsub("^%s+",""):gsub("%s+$","")
	if u == "" then setStatus("⚠ Entrez un pseudo.", Color3.fromRGB(255,180,50)); return end
	setStatus("Debannissement...", Color3.fromRGB(150,180,255))
	banEvent:FireServer("unban", u)
end)

closeBtn.MouseButton1Click:Connect(closePanel)
toggleBtn.MouseButton1Click:Connect(openPanel)

banEvent.OnClientEvent:Connect(function(msg)
	if string.find(msg, "✅") then setStatus(msg, Color3.fromRGB(80,220,120))
	elseif string.find(msg, "⚠") then setStatus(msg, Color3.fromRGB(255,100,100))
	else setStatus(msg, Color3.fromRGB(180,180,200)) end
end)