--credit to quartz games studio
local LocalPlayer = game.Players.LocalPlayer

repeat
	task.wait()
until LocalPlayer:HasTag("ControllersStarted")

local GuiController = require(LocalPlayer.PlayerScripts:WaitForChild("Controllers"):WaitForChild("GuiController"))

for v1, v2 in script.Parent:GetChildren() do
	if v2:IsA("TextButton") and not v2.Name:find("Debug") then
		local v3 = LocalPlayer.PlayerGui:FindFirstChild(v2.Name)

		if v3 then
			GuiController:Hook("Click", v2).Clicked:Connect(function() --[[ Line: 13 | Upvalues: GuiController (copy), v3 (copy) ]]
				GuiController:Open(v3.Name)
			end)

			continue
		end

		v2.Visible = false
	end
end