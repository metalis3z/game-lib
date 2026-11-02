--Stickmasterluke


sp=script.Parent


timer=20
soundinterval=1


starttime=tick()
attached=false
debris=game:GetService("Debris")


function makeconfetti()
	sp.Anchored = true	
end


sp.Touched:connect(function(hit)
	if (not attached) and hit and hit~=nil and sp~=nil then
		local ct=sp:FindFirstChild("creator")
		if ct.Value~=nil and ct.Value.Character~=nil then
			if hit.Parent~=ct.Value.Character and hit.Name~="Handle" and hit.Name~="Effect" then
				local h=hit.Parent:FindFirstChild("Humanoid")
				local t=hit.Parent:FindFirstChild("UpperTorso")
					local w=Instance.new("Weld")
					w.Part0=t
					w.Part1=sp
					w.C0=CFrame.new(0,0,.8)*CFrame.Angles(math.pi/2,3.5,0)
					w.Parent=sp
				end
			end
		end
	end)


while true do
	local percent=(tick()-starttime)/timer
	t1,t2=wait(((1-percent)*soundinterval))
	local beep=sp:FindFirstChild("Beep")
	if beep~=nil then
		beep:Play()
	end
	local bbg=sp:FindFirstChild("BillboardGui")
	if bbg~=nil then
		bbg.Adornee=sp
		li=bbg:FindFirstChild("LightImage")
		if li~=nil then
			li.Visible=true
		end
	end
	if percent>1 then
		break
	end
	wait(.1)
	if li then
		li.Visible=false
	end
end

wait(.5)
local smoke=sp:FindFirstChild("Smoke")
if smoke then
	smoke.Enabled=true
end
wait(.5)
local fusesound=sp:FindFirstChild("Fuse")
if fusesound~=nil then
	fusesound:Play()
end
local bbg=sp:FindFirstChild("BillboardGui")
if bbg~=nil then
	bbg.Adornee=sp
	li=bbg:FindFirstChild("LightImage")
	if li~=nil then
		li.Visible=false
	end
end
for i=1,7 do
	makeconfetti()
end
wait(.5)
if smoke then
	smoke.Enabled=false
end
sp.Transparency = 1
wait(2.5)
sp:Destroy()

