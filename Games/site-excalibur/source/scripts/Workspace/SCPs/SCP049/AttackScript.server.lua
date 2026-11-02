local SCP966MainScript = script;
local SCP966 = SCP966MainScript.Parent;
local SCP966Humanoid = SCP966:FindFirstChild("Humanoid")
local Head = SCP966:FindFirstChild("Head");
local HumanoidRootPart = SCP966:FindFirstChild("HumanoidRootPart");
local LeftArm = SCP966:FindFirstChild("LeftHand");
local LeftLeg = SCP966:FindFirstChild("LeftUpperLeg");
local RightArm = SCP966:FindFirstChild("RightHand");
local RightLeg = SCP966:FindFirstChild("RightUpperLeg");
local Torso = SCP966:FindFirstChild("UpperTorso");
local SCP966AttackEnable = true;
function FindTargetToTerrorise(TargetPosition)
local PlayerList = game.Workspace:children();
local TargetTorso = nil;
local VisibleDistance = 5;
local TempTargetModel = nil;
local TargetHumanoid = nil;
local TargetModel = nil;
for Check = 1, #PlayerList do
TargetModel = PlayerList[Check]
if (TargetModel.className == "Model") and (TargetModel ~= SCP966) and (TargetModel.Name ~= SCP966.Name) and (TargetModel.Name ~= "SCP-106") and (TargetModel.Name ~= "SCP-173") and (TargetModel.Name ~= "SCP-096") then
TempTargetModel = TargetModel:findFirstChild("UpperTorso")
TargetHumanoid = TargetModel:findFirstChild("Humanoid")
if (TempTargetModel ~= nil) and (TargetHumanoid ~= nil) and (TargetHumanoid.Health > 0) then
if (TempTargetModel.Position - TargetPosition).magnitude < VisibleDistance then
TargetTorso = TempTargetModel
VisibleDistance = (TempTargetModel.Position - TargetPosition).magnitude
end
end
end
end
return TargetTorso
end
while true do
wait(0)
local SCP966ChosenTarget = FindTargetToTerrorise(Head.Position);
if SCP966ChosenTarget ~= nil then
if SCP966AttackEnable == false then return end
SCP966AttackEnable = false
local SCP966Damage = 999
local SelectedAttackList = {"NeckSnap1", "NeckSnap2", "NeckSnap3"};
local SelectedAttackSound = Torso[math.random(1, #SelectedAttackList)];
SelectedAttackSound:Play()
SCP966ChosenTarget.Parent.Humanoid:TakeDamage(SCP966Damage)
wait(0.5)
SCP966AttackEnable = true
end
end