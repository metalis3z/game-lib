
----------------
--[[SETTINGS]]--
----------------

local ViewAccessories = false
local ViewHeadAccessories = false
local RealisticView = true
local AutoLockFirstPerson = true

------------
--[[CODE]]--
------------
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Offset = Vector3.new()

local Player = Players.LocalPlayer

function Update()
	local Character = Player.Character --I'll have this here, should the script be in StarterPlayerScripts
	local Camera = workspace.CurrentCamera --In case they delete the camera or something.
	if not Character then
		return
	end
	
	local Humanoid = Character:WaitForChild("Humanoid")
	local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
	local Head = Character:WaitForChild("Head")
	
	for Index, Item in ipairs(Character:GetChildren()) do
		if Item:IsA("BasePart") then
			if Item.Name ~= "Head" then
				Item.LocalTransparencyModifier = 0
			end
		elseif Item:IsA("Accoutrement") then
			local Handle = Item:FindFirstChild("Handle")
			if Handle then
				local ConnectedToHead = (Handle:FindFirstChild("HatAttachment") or Handle:FindFirstChild("HairAttachment") or Handle:FindFirstChild("FaceAttachment") or Handle:FindFirstChild("NeckAttachment")) ~= nil
				if ConnectedToHead then
					if ViewAccessories and ViewHeadAccessories  then
						Handle.LocalTransparencyModifier = 0
					end
				elseif ViewAccessories then
						Handle.LocalTransparencyModifier = 0
					end
			end
		end
	end
	
	if (RealisticView and Player.CameraMode == Enum.CameraMode.LockFirstPerson)
		or (Character:WaitForChild("Head").LocalTransparencyModifier == 1) then
		--Above: Adding [or (Character:WaitForChild("Head").LocalTransparencyModifier == 1)] will make it so we can
		--detect if the player is in first-person
		local Origin = Camera.CFrame
		local Out = Camera.CFrame * CFrame.new(0, 2, -0.5)
		local Y_Diff = (Origin.Y - Out.Y) * -1.5
		local Z_Diff = 1
		local Extra_X = 0.75
		local Extra_Y = 1
		
		local Camera_Offset = Vector3.new(0, 0.3, math.min(Y_Diff - Z_Diff, -0.4))
		
		--Update #2: R15 offsets cause issues with this code block. This next one will fix that.
		local UpperTorso = Character:FindFirstChild("UpperTorso")
		if UpperTorso then
			local OffsetVal = HumanoidRootPart.CFrame:toObjectSpace(Head.CFrame).p
			Offset = Camera_Offset + (OffsetVal - Vector3.new(0, 0, -0.4))
		else
			Offset = Camera_Offset
		end
		
		Humanoid.CameraOffset = Offset
	else
		Humanoid.CameraOffset = Vector3.new()
	end
end

--if AutoLockFirstPerson then
	--Player.CameraMode = Enum.CameraMode.LockFirstPerson
--end

RunService.RenderStepped:Connect(Update)