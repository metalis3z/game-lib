local Player = game.Players.LocalPlayer

repeat wait() until Player ~= nil
local Character = Player.Character
repeat wait() until Character ~= nil

local Humanoid = Character:WaitForChild("Humanoid",1)
repeat wait() until Humanoid ~= nil

local Tool = script.Parent

local Info = TweenInfo.new(
    .3, -- Time
	Enum.EasingStyle.Linear, -- EasingStyle
	Enum.EasingDirection.Out, -- EasingDirection
	0, -- RepeatCount (when less than zero the tween will loop indefinitely)
	false, -- Reverses (tween will reverse once reaching it's goal)
	0 -- DelayTime
)

local TweenService = game:GetService("TweenService")
local CurrentCamera = workspace.CurrentCamera

local InfoZoom = {FieldOfView = 89}
local InfoZoom2 = {FieldOfView = 70}


local Tween = TweenService:Create(CurrentCamera,Info,InfoZoom)
local Tween2 = TweenService:Create(CurrentCamera,Info,InfoZoom2)



Tool.Equipped:Connect(function()
	Tween:Play()

end)

Tool.Unequipped:Connect(function()
	Tween2:Play()

end)