-- Reference copy for study. Game: Pet RNG (pet-rng)
-- Original: ReplicatedStorage/Engine/Modules/Transition.lua  (luau, 36 lines)
-- Categories: ui-animation 16.6
-- What it does: Teleport transition: fades a full-screen frame in, tweens MaxVisibleGraphemes for a typewriter title, moves the character, then fades everything out.

local tweenService = game:GetService("TweenService")

local Transition = {}

Transition.Start = function(player: Player, pos, text, text2)
	local playerGui = player.PlayerGui
	local gui = playerGui:WaitForChild("GUI")
	local transitionFrame = gui:WaitForChild("Transition")
	local loadingImage = transitionFrame:WaitForChild("Loading")
	local title = transitionFrame:WaitForChild("Title")
	local bonus = transitionFrame:WaitForChild("Bonus")
	local characters = string.split(text, "")
	bonus.Text = text2
	title.Text = text
	title.TextTransparency = 0
	title.UIStroke.Transparency = 0
	title.MaxVisibleGraphemes = 0
	
	tweenService:Create(transitionFrame, TweenInfo.new(.25), {BackgroundTransparency = 0}):Play()
	tweenService:Create(bonus, TweenInfo.new(.25), {TextTransparency = 0}):Play()
	tweenService:Create(bonus.UIStroke, TweenInfo.new(.25), {Transparency = 0}):Play()
	tweenService:Create(loadingImage, TweenInfo.new(.25), {ImageTransparency = 0}):Play()
	tweenService:Create(title, TweenInfo.new(.75), {MaxVisibleGraphemes = #characters}):Play()
	wait(1)
	player.Character:MoveTo(pos)
	wait(.25)
	tweenService:Create(loadingImage, TweenInfo.new(.25), {ImageTransparency = 1}):Play()
	tweenService:Create(title, TweenInfo.new(.25), {TextTransparency = 1}):Play()
	tweenService:Create(title.UIStroke, TweenInfo.new(.25), {Transparency = 1}):Play()
	tweenService:Create(bonus, TweenInfo.new(.25), {TextTransparency = 1}):Play()
	tweenService:Create(bonus.UIStroke, TweenInfo.new(.25), {Transparency = 1}):Play()
	tweenService:Create(transitionFrame, TweenInfo.new(.25), {BackgroundTransparency = 1}):Play()
end

return Transition
