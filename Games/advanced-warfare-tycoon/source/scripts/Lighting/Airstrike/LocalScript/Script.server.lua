--Made by Stickmasterluke


sp=script.Parent


jetheight=150

bombs=3
droprange=450


alive=true
debris=game:GetService("Debris")

function waitfor(a,b)
	while a:FindFirstChild(b)==nil do
		wait()
	end
	return a:FindFirstChild(b)
end

head=waitfor(sp,"Head")
hum=waitfor(sp,"Humanoid")
torso=waitfor(sp,"Torso")
ct=waitfor(sp,"creator")
tl=waitfor(sp,"TargetLocation")

torso.Touched:connect(function(hit)
	if hit and hit.Parent and hit.Parent~=sp and hit.Name~="Effect" then
		if hum then
			hum.Health=0
		end
	end
end)

delay(0,function()
	local jsound=Instance.new("Sound")
	jsound.Name="JetScream"
	jsound.SoundId="http://www.roblox.com/asset/?id=88862455"
	jsound.Volume=.6
	debris:AddItem(jsound,10)
	jsound.Parent=game.Workspace
	wait(2)
	jsound:Play()
end)

hum.Changed:connect(function(prop)
	if alive then
		if hum then
			if hum.Health<=0 then
				alive=false
				if torso then
					hum:remove()
					local e=Instance.new("Explosion")
					e.Position=torso.Position
					e.BlastPressure=0
					e.BlastRadius=15
					e.ExplosionType=2
					e.Parent=game.Workspace
					local f=Instance.new("Fire")
					f.Size=100
					f.Heat=100
					f.Parent=torso
					if head then
						head:remove()
					end
					torso.Velocity=torso.Velocity+Vector3.new((math.random()-.5)*50,(math.random()-.5)*50,(math.random()-.5)*50)
					wait(3)
					if torso then
						torso.Transparency=1
						torso.Velocity=torso.Velocity+Vector3.new((math.random()-.5)*50,(math.random()-.5)*50,(math.random()-.5)*50)
					end
					wait(3)
				end
				sp:remove()
			end
		else
			alive=false
			sp:remove()
		end
	end
end)

while alive do
	if torso and tl then
		if bombs>0 then
			if (torso.Position-tl.Value).magnitude<droprange then
				bombs=bombs-1
				local b=Instance.new("Part")
				b.Name="Effect"
				b.formFactor="Custom"
				b.Size=Vector3.new(3,3,10)*.5
				b.CanCollide=false
				b.CFrame=torso.CFrame
				b.Velocity=torso.Velocity
				ct:clone().Parent=b
				local s=script.Script:clone()
				s.Parent=b
				s.Disabled=false
				local so=Instance.new("Sound")
				so.SoundId="rbxasset://sounds/collide.wav"
				so.Volume=1
				so.Pitch=.75
				so.Parent=b
				local mesh=Instance.new("SpecialMesh")
				mesh.MeshId="http://www.roblox.com/asset/?id=88782666"
				mesh.TextureId="http://www.roblox.com/asset/?id=88782631"
				mesh.Scale=Vector3.new(6,6,6)
				mesh.Parent=b
				debris:AddItem(b,10)
				b.Parent=game.Workspace
			end
			torso.Velocity=((tl.Value+Vector3.new(0,jetheight,0))-torso.Position).unit*torso.Velocity.magnitude
		else
			torso.Velocity=torso.Velocity+Vector3.new(0,10,0)
		end
		torso.CFrame=CFrame.new(torso.Position,torso.Position+torso.Velocity)
	end
	wait(.25)
end


