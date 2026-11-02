--credit to prince games studio
local t = {}
local ClientModules = game:GetService("ReplicatedStorage"):WaitForChild("ClientModules")
local FieldOfViewController = require(game.StarterPlayer.StarterPlayerScripts.Controllers.FieldOfViewController)
local Blur = require(ClientModules.Blur)
local t2 = {}

function t.Show(p1) --[[ Show | Line: 12 | Upvalues: t2 (copy), FieldOfViewController (copy), Blur (copy) ]]
	if not table.find(t2, p1) then
		table.insert(t2, p1)
	end

	FieldOfViewController.SetFov(60, 0.3)
	Blur.SetBlur(15, 0.1)
end
function t.Hide(p1) --[[ Hide | Line: 21 | Upvalues: t2 (copy), FieldOfViewController (copy), Blur (copy) ]]
	local v1 = table.find(t2, p1)

	if v1 then
		table.remove(t2, v1)
	end

	if #t2 ~= 0 then
		return
	end

	FieldOfViewController.SetCoreFov(70)
	FieldOfViewController.SetFov(70, 0.3)
	Blur.SetBlur(0, 0.3)
end
function t.CanInteract() --[[ CanInteract | Line: 34 | Upvalues: t2 (copy) ]]
	return #t2 == 0
end

return t