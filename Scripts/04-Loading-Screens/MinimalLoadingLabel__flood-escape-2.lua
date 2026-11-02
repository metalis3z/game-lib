-- Reference copy for study. Game: Flood Escape 2 (flood-escape-2)
-- Original: ReplicatedFirst/LocalScript.client.lua
-- What it does: Smallest possible custom loading screen: a full-screen TextLabel created in code, default screen removed, destroyed once game.Loaded fires.

local var0 = Instance.new("ScreenGui")
var0.IgnoreGuiInset = true
local var1 = Instance.new("TextLabel")
var1.Size = UDim2.new(1, 0, 1, 0)
var1.BackgroundColor3 = Color3.fromRGB(0, 20, 40)
var1.Font = Enum.Font.Ubuntu
var1.TextColor3 = Color3.new(0.8, 0.8, 0.8)
var1.Text = "Loading Flood Escape 2"
var1.TextSize = 28
var1.Parent = var0
var0.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
game:GetService("ReplicatedFirst"):RemoveDefaultLoadingScreen()
if not game:IsLoaded() then
	game.Loaded:Wait()
end
var0:Destroy()