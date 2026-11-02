local mouse = game.Players.LocalPlayer:GetMouse()
mouse.Icon = "rbxasset://textures\\GunCursor.png"

mouse.Button1Down:connect(function()
	mouse.Icon = ""
	workspace.Main.Clicked:FireServer(mouse.Hit.p)
end)



local Tool = script.Parent

function onUnequippedLocal()
	mouse.Icon = ""
end
Tool.Unequipped:connect(onUnequippedLocal)
