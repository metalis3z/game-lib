--Made by Stickmasterluke


sp=script.Parent


cooldown=10
jetheight=200
jetdistance=2000
jetspeed=300


debris=game:GetService("Debris")
location=Vector3.new(0,0,0)
check=true
marked=false

talkinggrip=CFrame.new(0.121005774, -1.07626426, 1.151003, -0.571957648, 0.032301072, -0.819646955, 0.0999610648, 0.994521916, -0.0305611696, 0.814169705, -0.0994124785, -0.572053254)
holdinggrip=CFrame.new(-0.329237193, -0.576264262, 0.157275885, -0.29237175, 0, -0.956304729, 0.0999610648, 0.994521916, -0.0305611696, 0.951066017, -0.104528464, -0.290770113)

function waitfor(parent,name)
	while parent:FindFirstChild(name)==nil do
		wait()
	end
	return parent:FindFirstChild(name)
end

laststrike=waitfor(sp,"LastStrike")

function onEquipped(mouse)
	equipped=true
	local plr=game.Players.LocalPlayer
	sp.Grip=holdinggrip
	if mouse~=nil and plr~=nil then
		if tick()-cooldown<laststrike.Value then
			mouse.Icon="rbxasset://textures\\GunWaitCursor.png"
			wait(laststrike.Value-(tick()-cooldown))
			mouse.Icon="rbxasset://textures\\GunCursor.png"
		else
			mouse.Icon="rbxasset://textures\\GunCursor.png"
		end
		mouse.Button1Down:connect(function()
			if tick()-cooldown>laststrike.Value and mouse.Target and mouse.Target~=nil and mouse.Hit then
				location=mouse.Hit.p
				local chr=sp.Parent
				if chr and check then
					local t=chr:FindFirstChild("Torso")
					local h=chr:FindFirstChild("Humanoid")
					if t and h and h.Health>0 then
						check=false
						laststrike.Value=tick()
						mouse.Icon="rbxasset://textures\\GunWaitCursor.png"
						sp.Grip=talkinggrip
						local sound=sp.Handle:FindFirstChild("Sound")
						if sound~=nil then
							sound:Play()
						end

						local tp=Instance.new("Part")
						tp.Transparency=.5
						tp.Name="Effect"
						tp.Anchored=true
						tp.CanCollide=false
						tp.Size=Vector3.new(0,0,0)
						tp.BrickColor=BrickColor.new("Lime green")
						tp.CFrame=CFrame.new(location)*CFrame.Angles(math.pi/2,0,0)
						local me=Instance.new("SpecialMesh")
						me.MeshId="http://www.roblox.com/asset/?id=3270017"
						me.Scale=Vector3.new(40,40,1)
						me.Parent=tp
						debris:AddItem(tp,5)
						tp.Parent=game.Workspace
						delay(0,function()
							while tp and tp.Transparency<1 do
								tp.Transparency=tp.Transparency+.025
								wait(.15)
							end
							if tp then
								tp:remove()
							end
						end)

						local m=Instance.new("Model")
						m.Name="F22 Bombing Jet"
						local p=Instance.new("Part")
						p.Locked=true
						p.Name="Torso"
						p.Transparency=0
						p.CanCollide=true
						p.TopSurface="Smooth"
						p.BottomSurface="Smooth"
						p.formFactor="Custom"
						p.Size=Vector3.new(20,5,20)
						p.CFrame=CFrame.new(location+Vector3.new(0,jetheight,0))*CFrame.Angles(0,math.pi*2*math.random(),0)*CFrame.new(0,0,jetdistance)
						p.Parent=m

						local mesh=Instance.new("SpecialMesh")
						mesh.MeshId="http://www.roblox.com/asset/?id=88775328"
						mesh.TextureId="http://www.roblox.com/asset/?id=88775716"
						mesh.Scale=Vector3.new(10,10,10)
						mesh.Parent=p

						local smoke=Instance.new("Smoke")
						smoke.RiseVelocity=20
						smoke.Parent=p

						local he=Instance.new("Part")
						he.Locked=true
						he.Name="Head"
						he.formFactor="Custom"
						he.Transparency=1
						he.Size=Vector3.new(0,0,0)
						he.Parent=m

						local bf=Instance.new("BodyForce")
						bf.force=Vector3.new(0,(p:GetMass()+he:GetMass())*196.2,0)
						bf.Parent=p

						local w=Instance.new("Weld")
						w.Name="Neck"
						w.Part0=p
						w.Part1=he
						w.Parent=p

						local h=Instance.new("Humanoid")
						h.MaxHealth=5
						h.Health=5
						h.WalkSpeed=0
						h.Sit=true
						h.Parent=m

						local tl=Instance.new("Vector3Value")
						tl.Name="TargetLocation"
						tl.Value=location
						tl.Parent=m

						local ct=Instance.new("ObjectValue")
						ct.Value=game.Players.LocalPlayer
						ct.Name="creator"
						ct.Parent=m

						local s=script.Script:clone()
						s.Parent=m
						s.Disabled=false

						local vel=((location+Vector3.new(0,jetheight,0))-p.Position).unit*jetspeed
						p.Velocity=vel
						he.Velocity=vel

						debris:AddItem(m,20)
						m.Parent=game.Workspace

						wait(5)
						local sound=sp.Handle:FindFirstChild("Sound")
						if sound~=nil then
							sound:Stop()
						end
						sp.Grip=holdinggrip
						wait(cooldown-5)
						mouse.Icon="rbxasset://textures\\GunCursor.png"
						check=true
					end
				end
			end
		end)
	end
end

function onUnequipped()
	equipped=false
end

sp.Equipped:connect(onEquipped)
sp.Unequipped:connect(onUnequipped)


