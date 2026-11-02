sp=script.Parent

local event = script.Parent:WaitForChild("RemoteEvent")


firerate=22
power=50
rate=1/30

debris=game:GetService("Debris")
equipped=false

timer=20
soundinterval=1


starttime=tick()
attached=false
debris=game:GetService("Debris")


local tool = script.Parent
local clickEvent = tool.RemoteEvent
local clickEventConnection
 
local function createPart(location, check)
		local hu=sp.Parent:FindFirstChild("Humanoid")
			local t=sp.Parent:FindFirstChild("UpperTorso")
			if check and hu and hu.Health>0 and t then
				check=false
				sp.Handle.Transparency=1
				local sound=sp.Handle:FindFirstChild("Throw")
				if sound~=nil then
					sound:Play()
				end
				local shoulder=t:FindFirstChild("RightUpperArm")
				if shoulder~=nil then
					shoulder.CurrentAngle=2
				end
				local p=sp.Handle:clone()
				p.CanCollide=true
				p.Transparency=0
				local vec=(location.p-t.Position).unit
				p.CFrame=CFrame.new(t.Position,t.Position+vec)*CFrame.new(0,0,-5)
				p.Velocity=(vec*power)+Vector3.new(0,20,0)
				local s=script.Script:clone()
				s.Parent=p
				s.Disabled=false
				local ct=Instance.new("ObjectValue")
				ct.Name="creator"
				ct.Value=game.Players.LocalPlayer
				ct.Parent=p
				debris:AddItem(p,firerate+10)
				p.Parent=game.Workspace
				wait(firerate)
				sp.Handle.Transparency=0
				check=true
			end
end
 
local function onClick(player, clickLocation, check)
	createPart(clickLocation, check)
end
 
local function onEquip()
	clickEventConnection = clickEvent.OnServerEvent:connect(onClick)
end
 
local function onUnequip()
	clickEventConnection:disconnect()
end

tool.Equipped:connect(onEquip)
tool.Unequipped:connect(onUnequip)