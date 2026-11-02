
local mouse = game.Players.LocalPlayer:GetMouse()


mouse.Button1Down:connect(function()
	script.Parent.Clicked:FireServer(mouse.Hit.p)
end)



Tool=script.Parent
function onEquippedLocal()
	if mouse == nil then
		return 
	end
	mouse.Icon = "rbxasset://textures\\GunCursor.png"
end

Tool.Equipped:connect(onEquippedLocal)




function onUnEquippedLocal()
	
	mouse.Icon = ""
end

Tool.Unequipped:connect(onUnEquippedLocal)