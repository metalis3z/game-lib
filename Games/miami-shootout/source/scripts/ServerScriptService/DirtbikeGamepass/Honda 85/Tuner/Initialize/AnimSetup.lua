local MiscWeld = {}

function MakeWeld(x,y,type,s) 
	if type==nil then type="Weld" end
	local W=Instance.new(type)
	W.Part0=x W.Part1=y 
	W.C0=x.CFrame:inverse()*x.CFrame 
	W.C1=y.CFrame:inverse()*x.CFrame 
	W.Parent=x 
	if type=="Motor" and s~=nil then 
		W.MaxVelocity=s 
	end 
	return W	
end
function ModelWeld(a,b) 
	if a:IsA("BasePart") then 
		MakeWeld(b,a,"Weld") 
	elseif a:IsA("Model") then 
		for i,v in pairs(a:GetChildren()) do 
			ModelWeld(v,b) 
		end 
	end 
end

car = script.Parent.Parent.Parent
misc = car:WaitForChild("Misc")

---------------------------
--[[
	--Main anchor point is the DriveSeat <car.DriveSeat>	
	
	Usage:
		MakeWeld(Part1,Part2,WeldType*,MotorVelocity**) *default is "Weld"  **Applies to Motor welds only
		ModelWeld(Model,MainPart)
	Example:
		MakeWeld(car.DriveSeat,misc.PassengerSeat)
		MakeWeld(car.DriveSeat,misc.SteeringWheel,"Motor",.2)
		ModelWeld(car.DriveSeat,misc.Door)
]]

--Weld stuff here


--Anims

--R6
MakeWeld(car.Misc.Anims.R6.RightArm.Z,car.Misc.Anims.R6.RightArm.Y,"Motor6D").Name="M"
MakeWeld(car.Misc.Anims.R6.RightArm.Y,car.DriveSeat,"Motor6D").Name="M"
ModelWeld(misc.Anims.R6.RightArm.Parts,misc.Anims.R6.RightArm.Z)
MakeWeld(car.Misc.Anims.R6.LeftArm.Z,car.Misc.Anims.R6.LeftArm.Y,"Motor6D").Name="M"
MakeWeld(car.Misc.Anims.R6.LeftArm.Y,car.DriveSeat,"Motor6D").Name="M"
ModelWeld(misc.Anims.R6.LeftArm.Parts,misc.Anims.R6.LeftArm.Z)

MakeWeld(car.Misc.Anims.R6.LeftLeg.X,car.Misc.Anims.R6.LeftLeg.Z,"Motor6D").Name="M"
MakeWeld(car.Misc.Anims.R6.LeftLeg.Z,car.DriveSeat,"Motor6D").Name="M"
ModelWeld(misc.Anims.R6.LeftLeg.Parts,misc.Anims.R6.LeftLeg.X)

MakeWeld(car.Misc.Anims.R6.RightLeg.X,car.Misc.Anims.R6.RightLeg.Z,"Motor6D").Name="M"
MakeWeld(car.Misc.Anims.R6.RightLeg.Z,car.Misc.Anims.R6.RightLeg.I,"Motor6D").Name="M"
MakeWeld(car.Misc.Anims.R6.RightLeg.I,car.DriveSeat,"Motor6D").Name="M"
ModelWeld(misc.Anims.R6.RightLeg.Parts,misc.Anims.R6.RightLeg.X)

MakeWeld(car.Misc.Anims.R6.Torso.Z,car.DriveSeat,"Motor6D").Name="M"
MakeWeld(car.Misc.Anims.R6.Torso.X,car.Misc.Anims.R6.Torso.Z,"Motor6D").Name="M"
ModelWeld(misc.Anims.R6.Torso.Parts,misc.Anims.R6.Torso.X)

MakeWeld(car.Misc.Anims.R6.Head.X,car.Misc.Anims.R6.Head.Y,"Motor6D").Name="M"
MakeWeld(car.Misc.Anims.R6.Head.Y,car.Misc.Anims.R6.Head.Z,"Motor6D").Name="M"
MakeWeld(car.Misc.Anims.R6.Head.Z,car.Misc.Anims.R6.Torso.X,"Motor6D").Name="M"
ModelWeld(misc.Anims.R6.Head.Parts,misc.Anims.R6.Head.X)

--R15

--Head
MakeWeld(car.Misc.Anims.R15.Torso.Head.X,car.Misc.Anims.R15.Torso.Head.Y,"Motor6D").Name="M"
MakeWeld(car.Misc.Anims.R15.Torso.Head.Y,car.Misc.Anims.R15.Torso.Head.Z,"Motor6D").Name="M"
MakeWeld(car.Misc.Anims.R15.Torso.Head.Z,car.Misc.Anims.R15.Torso.UpperTorso.Z,"Motor6D").Name="M"
ModelWeld(misc.Anims.R15.Torso.Head.Parts,misc.Anims.R15.Torso.Head.X)

--Torso
MakeWeld(car.Misc.Anims.R15.Torso.LowerTorso.X,car.DriveSeat,"Motor6D").Name="M"
MakeWeld(car.Misc.Anims.R15.Torso.LowerTorso.Z,car.Misc.Anims.R15.Torso.LowerTorso.X,"Motor6D").Name="M"
MakeWeld(car.Misc.Anims.R15.Torso.LowerTorso.Y,car.Misc.Anims.R15.Torso.LowerTorso.Z,"Motor6D").Name="M"
ModelWeld(car.Misc.Anims.R15.Torso.LowerTorso.Parts,car.Misc.Anims.R15.Torso.LowerTorso.Y)

MakeWeld(car.Misc.Anims.R15.Torso.UpperTorso.Z,car.Misc.Anims.R15.Torso.LowerTorso.Y,"Motor6D").Name="M"
ModelWeld(car.Misc.Anims.R15.Torso.UpperTorso.Parts,car.Misc.Anims.R15.Torso.UpperTorso.Z)

--Right Arm
MakeWeld(car.Misc.Anims.R15.RightArm.Hand.Y,car.DriveSeat,"Motor6D").Name="M"
MakeWeld(car.Misc.Anims.R15.RightArm.Hand.Z,car.Misc.Anims.R15.RightArm.Hand.Y,"Motor6D").Name="M"
MakeWeld(car.Misc.Anims.R15.RightArm.Hand.X,car.Misc.Anims.R15.RightArm.Hand.Z,"Motor6D").Name="M"
ModelWeld(car.Misc.Anims.R15.RightArm.Hand.Parts,car.Misc.Anims.R15.RightArm.Hand.X)

MakeWeld(car.Misc.Anims.R15.RightArm.LowerArm.X,car.Misc.Anims.R15.RightArm.Hand.X,"Motor6D").Name="M"
ModelWeld(car.Misc.Anims.R15.RightArm.LowerArm.Parts,car.Misc.Anims.R15.RightArm.LowerArm.X)

MakeWeld(car.Misc.Anims.R15.RightArm.UpperArm.X,car.Misc.Anims.R15.RightArm.LowerArm.X,"Motor6D").Name="M"
ModelWeld(car.Misc.Anims.R15.RightArm.UpperArm.Parts,car.Misc.Anims.R15.RightArm.UpperArm.X)

--Right Leg
MakeWeld(car.Misc.Anims.R15.RightLeg.Foot.I,car.DriveSeat,"Motor6D").Name="M"
MakeWeld(car.Misc.Anims.R15.RightLeg.Foot.Y,car.Misc.Anims.R15.RightLeg.Foot.I,"Motor6D").Name="M"
MakeWeld(car.Misc.Anims.R15.RightLeg.Foot.Z,car.Misc.Anims.R15.RightLeg.Foot.Y,"Motor6D").Name="M"
MakeWeld(car.Misc.Anims.R15.RightLeg.Foot.X,car.Misc.Anims.R15.RightLeg.Foot.Z,"Motor6D").Name="M"
ModelWeld(car.Misc.Anims.R15.RightLeg.Foot.Parts,car.Misc.Anims.R15.RightLeg.Foot.X)

MakeWeld(car.Misc.Anims.R15.RightLeg.LowerLeg.X,car.Misc.Anims.R15.RightLeg.Foot.X,"Motor6D").Name="M"
ModelWeld(car.Misc.Anims.R15.RightLeg.LowerLeg.Parts,car.Misc.Anims.R15.RightLeg.LowerLeg.X)

MakeWeld(car.Misc.Anims.R15.RightLeg.UpperLeg.X,car.Misc.Anims.R15.RightLeg.LowerLeg.X,"Motor6D").Name="M"
ModelWeld(car.Misc.Anims.R15.RightLeg.UpperLeg.Parts,car.Misc.Anims.R15.RightLeg.UpperLeg.X)

--Left Arm
MakeWeld(car.Misc.Anims.R15.LeftArm.Hand.Y,car.DriveSeat,"Motor6D").Name="M"
MakeWeld(car.Misc.Anims.R15.LeftArm.Hand.Z,car.Misc.Anims.R15.LeftArm.Hand.Y,"Motor6D").Name="M"
MakeWeld(car.Misc.Anims.R15.LeftArm.Hand.X,car.Misc.Anims.R15.LeftArm.Hand.Z,"Motor6D").Name="M"
ModelWeld(car.Misc.Anims.R15.LeftArm.Hand.Parts,car.Misc.Anims.R15.LeftArm.Hand.X)

MakeWeld(car.Misc.Anims.R15.LeftArm.LowerArm.X,car.Misc.Anims.R15.LeftArm.Hand.X,"Motor6D").Name="M"
ModelWeld(car.Misc.Anims.R15.LeftArm.LowerArm.Parts,car.Misc.Anims.R15.LeftArm.LowerArm.X)

MakeWeld(car.Misc.Anims.R15.LeftArm.UpperArm.X,car.Misc.Anims.R15.LeftArm.LowerArm.X,"Motor6D").Name="M"
ModelWeld(car.Misc.Anims.R15.LeftArm.UpperArm.Parts,car.Misc.Anims.R15.LeftArm.UpperArm.X)

--Left Leg
MakeWeld(car.Misc.Anims.R15.LeftLeg.Foot.Y,car.DriveSeat,"Motor6D").Name="M"
MakeWeld(car.Misc.Anims.R15.LeftLeg.Foot.Z,car.Misc.Anims.R15.LeftLeg.Foot.Y,"Motor6D").Name="M"
MakeWeld(car.Misc.Anims.R15.LeftLeg.Foot.X,car.Misc.Anims.R15.LeftLeg.Foot.Z,"Motor6D").Name="M"
ModelWeld(car.Misc.Anims.R15.LeftLeg.Foot.Parts,car.Misc.Anims.R15.LeftLeg.Foot.X)

MakeWeld(car.Misc.Anims.R15.LeftLeg.LowerLeg.X,car.Misc.Anims.R15.LeftLeg.Foot.X,"Motor6D").Name="M"
ModelWeld(car.Misc.Anims.R15.LeftLeg.LowerLeg.Parts,car.Misc.Anims.R15.LeftLeg.LowerLeg.X)

MakeWeld(car.Misc.Anims.R15.LeftLeg.UpperLeg.X,car.Misc.Anims.R15.LeftLeg.LowerLeg.X,"Motor6D").Name="M"
ModelWeld(car.Misc.Anims.R15.LeftLeg.UpperLeg.Parts,car.Misc.Anims.R15.LeftLeg.UpperLeg.X)


function animPose(seat,pose)
	local C
	local S=seat
	local WS={}
	local HW={}
	
	local seatOffset = 	CFrame.new(0,0,0)
	
	
	S.ChildRemoved:connect(function(child)		
		if child.Name=="SeatWeld" and child:IsA("Weld") then 
			for i,v in pairs(WS) do
				if v~=0 then 
					if v[4]~=nil then 
						v[4]:Destroy()
						v[1].Part1=v[5]
					else 
						if v[2]~=nil then 
							v[1].C0=v[2] v[1].C1=v[3]
						else 
							v[1]:Destroy()
						end
					end
				end
			end 
			for i,v in pairs(HW) do
				v[1]:Destroy()
				v[2]:Destroy()
				v[3].Transparency=0
			end
			C=nil
			WS = {}
			HW = {}
		end 
	end)
	
	S.ChildAdded:connect(function(child)
		if child.Name=="SeatWeld" and child:IsA("Weld") and game.Players:GetPlayerFromCharacter(child.Part1.Parent)~=nil then
			C = child.Part1.Parent
			S.SeatWeld.C0 = seatOffset
			S.SeatWeld.C1 = CFrame.new()
			
			local pkTor = false
			for i,v in pairs(C:GetChildren()) do
				if v:IsA("CharacterMesh") and v.BodyPart == Enum.BodyPart.Torso then
					pkTor=true
					break
				end
			end
			
			local function MW(x,y)
				local WW=Instance.new("Weld",x) WW.Part0=x WW.Part1=y return WW
			end
			
			if C:FindFirstChild("HumanoidRootPart")~=nil and C:FindFirstChild("Torso")~=nil then
				S.SeatWeld.C0=seatOffset
				S.SeatWeld.C1=CFrame.new()
				C.HumanoidRootPart.RootJoint.Part1=nil
				table.insert(WS,{C.HumanoidRootPart.RootJoint,C.HumanoidRootPart.RootJoint.C0,C.HumanoidRootPart.RootJoint.C1,MW(C.HumanoidRootPart,C.Torso),C.Torso})
				if C.Torso:FindFirstChild("Neck")~=nil then
					local H=C.Head:Clone()
					H.Name="Part"
					H.Parent=C
					local WH=MW(C.Torso,H)
					WH.C0=C.Torso.Neck.C0
					WH.C1=C.Torso.Neck.C0
					C.Head.Transparency=1
			
					table.insert(HW,{H,WH,C.Head})
					table.insert(WS,{WH,nil,nil,nil,nil})
					for i,v in pairs(C.Head:GetChildren()) do
						if v:IsA("Weld") then
							local pp=v.Part1:Clone()
							pp.Parent=C
							v.Part1.Transparency=1
							
							local ww=MW(H,pp)
							ww.C0=v.C0
							ww.C1=v.C1
							table.insert(HW,{pp,ww,v.Part1})
						end
					end	
				else
					table.insert(WS,0)
				end
				if C.Torso:FindFirstChild("Left Shoulder")~=nil then
					C.Torso:FindFirstChild("Left Shoulder").Part1=nil
					table.insert(WS,{C.Torso:FindFirstChild("Left Shoulder"),C.Torso:FindFirstChild("Left Shoulder").C0,C.Torso:FindFirstChild("Left Shoulder").C1,MW(C.Torso,C:FindFirstChild("Left Arm")),C:FindFirstChild("Left Arm")})
				else
					table.insert(WS,0)
				end
				if C.Torso:FindFirstChild("Right Shoulder")~=nil then
					C.Torso:FindFirstChild("Right Shoulder").Part1=nil
					table.insert(WS,{C.Torso:FindFirstChild("Right Shoulder"),C.Torso:FindFirstChild("Right Shoulder").C0,C.Torso:FindFirstChild("Right Shoulder").C1,MW(C.Torso,C:FindFirstChild("Right Arm")),C:FindFirstChild("Right Arm")})
				else
					table.insert(WS,0)
				end
				if C.Torso:FindFirstChild("Left Hip")~=nil then
					C.Torso:FindFirstChild("Left Hip").Part1=nil
					table.insert(WS,{C.Torso:FindFirstChild("Left Hip"),C.Torso:FindFirstChild("Left Hip").C0,C.Torso:FindFirstChild("Left Hip").C1,MW(C.Torso,C:FindFirstChild("Left Leg")),C:FindFirstChild("Left Leg")})
				else
					table.insert(WS,0)
				end
				if C.Torso:FindFirstChild("Right Hip")~=nil then
					C.Torso:FindFirstChild("Right Hip").Part1=nil
					table.insert(WS,{C.Torso:FindFirstChild("Right Hip"),C.Torso:FindFirstChild("Right Hip").C0,C.Torso:FindFirstChild("Right Hip").C1,MW(C.Torso,C:FindFirstChild("Right Leg")),C:FindFirstChild("Right Leg")})
				else
					table.insert(WS,0)
				end
			end
			
			for i,v in pairs(WS) do
				local cfp = pose[i]
				if i==3 then
					for i,v in pairs(C:GetChildren()) do
						if v:IsA("CharacterMesh") and v.BodyPart == Enum.BodyPart.LeftArm then
							cfp = pose[7]
							break
						end
					end
				elseif i==4 then
					for i,v in pairs(C:GetChildren()) do
						if v:IsA("CharacterMesh") and v.BodyPart == Enum.BodyPart.RightArm then
							cfp = pose[8]
							break
						end
					end
				end
				if v[4]~=nil then
					v[4].C0=cfp
					v[4].C1=CFrame.new()
				else
					v[1].C0=cfp
					v[1].C1=CFrame.new()
				end
			end
		end
	end)
end

local Passenger={
CFrame.new(0.00701141357, 1.09911013, 0.0404243469, 1, 3.80970855e-09, -4.35450502e-08, 0, 0.996194661, 0.087155968, 4.37113883e-08, -0.087155968, 0.996194661), --Torso
CFrame.new(0, 1.50000381, 0, 1, 0, 0, 0, 0.996194661, -0.087155968, 0, 0.087155968, 0.996194661), --Head
CFrame.new(-0.876424789, -0.214377403, -0.478406906, 0.819151819, -0.573576868, 7.37368282e-07, 0.519837081, 0.742402971, -0.422619611, 0.242404267, 0.346189946, 0.906307161), --Larm
CFrame.new(0.876424789, -0.214377403, -0.478406906, 0.819151819, 0.573576868, -7.37368282e-07, -0.519837081, 0.742402971, -0.422619611, -0.242404267, 0.346189946, 0.906307161), --Rarm
CFrame.new(-1.27365112, -1.25288582, -1.13527107, 0.98480773, -0.173648179, 0, 0.171010077, 0.969846308, 0.173647881, -0.0301536396, -0.171009779, 0.984807789), --Lleg
CFrame.new(1.27365112, -1.25288582, -1.13527298, 0.98480773, 0.173648179, 0, -0.171010077, 0.969846308, 0.173647881, 0.0301536396, -0.171009779, 0.984807789) --Rleg
}

--animPose(car.Body.Seat,Passenger)



---------------------------
return MiscWeld