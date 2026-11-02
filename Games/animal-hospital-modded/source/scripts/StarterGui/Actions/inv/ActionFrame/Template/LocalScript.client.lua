local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))

game:GetService("SocialService")

local LocalPlayer = game.Players.LocalPlayer
local Selection = LocalPlayer.PlayerGui.CharacterSelection.Selection
local v1 = script.Parent

-- Blindaje: el Template crudo corre con Name = "Template" (o una acción sin
-- animación) -> Animations[nombre] es nil -> require(nil) crasheaba en bucle.
-- Solo seguimos si existe la animación con ese nombre (los clones reales sí).
local animModule = game.ReplicatedStorage.GameData.Actions.Animations:FindFirstChild(script.Parent.Name)
if not animModule then
	return
end

local v2 = require(animModule)
local Animator = (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("Humanoid"):WaitForChild("Animator")
local Animation2 = Instance.new("Animation")

Animation2.AnimationId = v2.Animation

local v4 = Animator:LoadAnimation(Animation2)
local v5 = false

Lib.Buttons.OnActivate(v1, function() --[[ Line: 21 | Upvalues: v5 (ref), v4 (copy), v2 (copy) ]]
	if v5 == false then
		v4:Play()
		v5 = true
		script.Parent.text.Text = "Stop"

		return
	end

	if v5 ~= true then
		return
	end

	v4:Stop()
	v5 = false
	script.Parent.text.Text = v2.Name
end)
