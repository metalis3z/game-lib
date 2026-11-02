local plr = game.Players.LocalPlayer
local CamFix = script.Parent:WaitForChild("Reset")
local cam = game.Workspace.CurrentCamera

CamFix.MouseButton1Down:connect(function()
if cam and plr and plr.Character and CamFix then
local fixCam = cam:Clone()
cam:Destroy()
wait(.1)
fixCam.Parent = plr.Character
for i,v in pairs(plr.Character:GetChildren()) do
if v and v:IsA("Humanoid") then
fixCam.CameraSubject = v
fixCam.CameraType = "Custom"
end
end
plr:LoadCharacter()
end
end)