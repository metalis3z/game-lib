--Stickmasterluke


sp=script.Parent


blastRadius=19
blastPressure=2*10^6

exploded=false


function damaged(hit)
	local ct=sp:FindFirstChild("creator")
	if ct.Value~=nil and (hit.Name=="Head" or hit.Name=="Torso") then
		local h=hit.Parent:FindFirstChild("Humanoid")
		if h~=nil then
			for i,v in ipairs(h:GetChildren()) do
				if v.Name=="creator" then
					v:remove()
				end
			end
			ct:clone().Parent=h
		end
	end
end

function explode()
	if not exploded then
		exploded=true
		sp.Anchored=true
		sp.Transparency=1
		local s=sp:FindFirstChild("Sound")
		if s~=nil then
			s:Play()
		end
		local e=Instance.new("Explosion")
		e.Position=sp.Position
		e.BlastPressure=blastPressure
		e.BlastRadius=blastRadius
		e.ExplosionType=2
		e.Hit:connect(damaged)
		e.Parent=game.Workspace
		wait(.5)
		if sp and sp~=nil and sp.Parent~=nil then
			sp:remove()
		end
	end
end


sp.Touched:connect(function(hit)
	if hit and hit.Parent then
		if hit.Name~="Effect" and hit.Parent.Name~="F22 Bombing Jet" then
			explode()
		end
	end
end)






