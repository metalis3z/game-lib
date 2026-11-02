--Made by Stickmasterluke


sp=script.Parent

db=true

firerate=22
power=50
rate=1/30

debris=game:GetService("Debris")
equipped=false
check=true

local event = script.Parent:WaitForChild("RemoteEvent")


function onEquipped(mouse)
	equipped=true
	if mouse~=nil then
		mouse.Button1Down:connect(function()
			if db then
			event:FireServer(mouse.Hit,check)
			db=false			
			wait(firerate)
			db=true			
			end
		end)
	end
end

function onUnequipped()
	equipped=false
	sp.Handle.Transparency=0
end

sp.Equipped:connect(onEquipped)
sp.Unequipped:connect(onUnequipped)





