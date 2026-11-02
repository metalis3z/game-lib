local tool=script.Parent
local handle=tool.Handle

local remotefunction=tool.RemoteFunction
local debris=game:GetService("Debris")

function remotefunction.OnServerInvoke(player,command,value)
	if command=="protect" then
		if value[2] then
			local currentvest=value[1]:FindFirstChild("VestArmour")
			if currentvest then
				currentvest:Destroy()
			end
			local vest=Instance.new("Hat")
			vest.Name="VestArmour"
			handle:Clone().Parent=vest
			vest.AttachmentPos=Vector3.new(0,0.63,0.05)
			vest.Parent=value[1]
			
			tool.Handle.Transparency=1
			wait(2)
			tool.Handle.Transparency=0
		end
	end
end