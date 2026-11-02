local UserInputService = game:GetService("UserInputService")
local Toggles = false
local BackpackKey = Enum.KeyCode.Backquote

UserInputService.InputBegan:Connect(function(Input) 
if Input.KeyCode == BackpackKey or UserInputService:IsKeyDown(BackpackKey) then
if not Toggles then
UserInputService.MouseBehavior = Enum.MouseBehavior.Default
Toggles = true
elseif Toggles then
UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
Toggles = false
end
end
end)