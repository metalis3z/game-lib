--Made by Stickmasterluke


local sp =script.Parent
local debris = game:GetService("Debris")

local firerate = 22
local power = 50
local rate = 1/30
local equipped = nil
local check = true


function onEquipped(mouse)
	equipped=true
	if mouse~=nil then
		if check then
			mouse.Icon="rbxasset://textures\\GunCursor.png"
		else
			mouse.Icon="rbxasset://textures\\GunWaitCursor.png"
		end
		mouse.Button1Down:connect(function()
			local hu=sp.Parent:FindFirstChild("Humanoid")
			local t=sp.Parent:FindFirstChild("UpperTorso")
			if check and hu and hu.Health>0 and t then
				check=false
				mouse.Icon="rbxasset://textures\\GunWaitCursor.png"
				script.Parent.RemoteEvent:FireServer(sp, mouse.Hit.p, firerate, power)
				wait(firerate)
				mouse.Icon="rbxasset://textures\\GunCursor.png"
				check=true
			end
		end)
	end
end

function onUnequipped()
	equipped=false
end

sp.Equipped:connect(onEquipped)
sp.Unequipped:connect(onUnequipped)





