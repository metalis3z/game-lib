local Animator = {}
local joints = {}
local Tool = script.Parent
local abort = false
local isAnimating = false

function Animator.setJoints(j)
	joints = j
end

function Animator.abort()
	if (isAnimating) then abort = true end
end

--These all take a value from 0 to 1
local smoothers = {
	["SmoothEnd"] = function(x) return math.sin(x*math.pi/2) end;
	["SmoothStart"] = function(x) return 1-math.sin((1-x)*math.pi/2) end;
	["SmoothBoth"] = function(x) return math.pow(math.sin(x*math.pi/2),2) end;
	["SmoothNone"] = function(x) return x end;
}

function Animator.runAnim(anim,speed)
	repeat wait() until not abort
	isAnimating = true
	
	local frames = anim:children()
	
	for count = 0,#frames-2 do
		local frame = anim["Frame" .. count]
		local tEnd = frame.Time.Value
		local func = smoothers[frame.Smooth.Value]
		
		local nextframe = anim["Frame" .. (count+1)]
		
		local charThis,charNext = frame.Character,nextframe.Character
		local wepThis,wepNext = frame.Weapon,nextframe.Weapon
		
		if (frame:findFirstChild("Action")) then
			require(frame.Action)(Tool)
		end
		
		local t = 0
		while (t < tEnd and not abort) do
			t = t + wait()*speed
			local factor = func(t/tEnd)
			
			--Animate character
			joints.rootweld.C1 = charThis.Torso.Value:lerp(charNext.Torso.Value,factor):inverse()
			joints.lshoulder.C1 = charThis.LeftArm.Value:lerp(charNext.LeftArm.Value,factor):inverse()
			joints.rshoulder.C1 = charThis.RightArm.Value:lerp(charNext.RightArm.Value,factor):inverse()
			joints.neck.C1 = charThis.Head.Value:lerp(charNext.Head.Value,factor):inverse()
			
			--Animate weapon
			joints.wepmain.C1 = wepThis.MainPart.Value:lerp(wepNext.MainPart.Value,factor):inverse()
			for name,weld in pairs(joints) do
				local valueThis,valueNext = wepThis:findFirstChild(name),wepNext:findFirstChild(name)
				if (valueThis and valueNext) then
					weld.C1 = valueThis.Value:lerp(valueNext.Value,factor):inverse()
				end
			end
		end
		
		--Make sure joints are set for...
		--Character
		joints.rootweld.C1 = charNext.Torso.Value:inverse()
		joints.lshoulder.C1 = charNext.LeftArm.Value:inverse()
		joints.rshoulder.C1 = charNext.RightArm.Value:inverse()
		joints.neck.C1 = charNext.Head.Value:inverse()
		
		--Weapon
		joints.wepmain.C1 = wepNext.MainPart.Value:inverse()
		for name,weld in pairs(joints) do
			local valueNext = wepNext:findFirstChild(name)
			if (valueNext) then
				weld.C1 = valueNext.Value:inverse()
			end
		end
		
		if (abort) then break end
	end
	isAnimating = false
	abort = false
end

function Animator.setDummyPose(dummy,frame)
	dummy.Character.Torso.CFrame = dummy.Character.HumanoidRootPart.CFrame * frame.Character.Torso.Value
	dummy.Character.Head.CFrame = dummy.Character.Torso.CFrame * frame.Character.Head.Value
	dummy.Character["Left Arm"].CFrame = dummy.Character.Torso.CFrame * frame.Character.LeftArm.Value
	dummy.Character["Right Arm"].CFrame = dummy.Character.Torso.CFrame * frame.Character.RightArm.Value
	
	dummy.GunModel.MainPart.CFrame = dummy.Character.Torso.CFrame * frame.Weapon.MainPart.Value
	for _,a in pairs(dummy.GunModel:children()) do
		if (a.Name ~= "MainPart") then
			a.CFrame = dummy.GunModel.MainPart.CFrame * frame.Weapon[a.Name].Value
		end
	end
end

return Animator