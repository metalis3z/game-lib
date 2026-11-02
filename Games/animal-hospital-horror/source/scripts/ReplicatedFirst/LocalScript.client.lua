local RootPart = game.ReplicatedStorage.NPCs.DummyTest.RootPart
local CollectionService = game:GetService("CollectionService")

local function tagBone(p1, p2) --[[ tagBone | Line: 9 | Upvalues: CollectionService (copy) ]]
	if p1 then
		CollectionService:AddTag(p1, p2)
		print("Tagged " .. p1.Name .. " with " .. p2)
	else
		warn("Bone not found for tag: " .. p2)
	end
end

local spine = RootPart:FindFirstChild("spine")

if not spine then
	warn("Root spine bone not found!")

	return
end

local v1 = spine:FindFirstChild("spine.001")
local v2 = if v1 then v1:FindFirstChild("spine.002") else v1
local v3 = if v2 then v2:FindFirstChild("spine.003") else v2
local v4 = if v3 then v3:FindFirstChild("spine.004") else v3
local v5 = if v4 then v4:FindFirstChild("spine.005") else v4
local v6 = if v5 then v5:FindFirstChild("spine.006") else v5

if v6 then
	CollectionService:AddTag(v6, "Head")
	print("Tagged " .. v6.Name .. " with Head")
else
	warn("Bone not found for tag: Head")
end

if v3 then
	CollectionService:AddTag(v3, "UpperTorso")
	print("Tagged " .. v3.Name .. " with UpperTorso")
else
	warn("Bone not found for tag: UpperTorso")
end

if v1 then
	CollectionService:AddTag(v1, "LowerTorso")
	print("Tagged " .. v1.Name .. " with LowerTorso")
else
	warn("Bone not found for tag: LowerTorso")
end

local v7 = if v3 then v3:FindFirstChild("shoulder.L") else v3
local v8 = if v7 then v7:FindFirstChild("upper_arm.L") else v7
local v9 = if v8 then v8:FindFirstChild("forearm.L") else v8
local v10 = if v9 then v9:FindFirstChild("hand.L") else v9

if v8 then
	CollectionService:AddTag(v8, "LeftUpperArm")
	print("Tagged " .. v8.Name .. " with LeftUpperArm")
else
	warn("Bone not found for tag: LeftUpperArm")
end

if v9 then
	CollectionService:AddTag(v9, "LeftLowerArm")
	print("Tagged " .. v9.Name .. " with LeftLowerArm")
else
	warn("Bone not found for tag: LeftLowerArm")
end

if v10 then
	CollectionService:AddTag(v10, "LeftHand")
	print("Tagged " .. v10.Name .. " with LeftHand")
else
	warn("Bone not found for tag: LeftHand")
end

local v11 = if v3 then v3:FindFirstChild("shoulder.R") else v3
local v12 = if v11 then v11:FindFirstChild("upper_arm.R") else v11
local v13 = if v12 then v12:FindFirstChild("forearm.R") else v12
local v14 = if v13 then v13:FindFirstChild("hand.R") else v13

if v12 then
	CollectionService:AddTag(v12, "RightUpperArm")
	print("Tagged " .. v12.Name .. " with RightUpperArm")
else
	warn("Bone not found for tag: RightUpperArm")
end

if v13 then
	CollectionService:AddTag(v13, "RightLowerArm")
	print("Tagged " .. v13.Name .. " with RightLowerArm")
else
	warn("Bone not found for tag: RightLowerArm")
end

if v14 then
	CollectionService:AddTag(v14, "RightHand")
	print("Tagged " .. v14.Name .. " with RightHand")
else
	warn("Bone not found for tag: RightHand")
end

local v15 = spine:FindFirstChild("thigh.L")
local v16 = if v15 then v15:FindFirstChild("shin.L") else v15
local v17 = if v16 then v16:FindFirstChild("foot.L") else v16

if v15 then
	CollectionService:AddTag(v15, "LeftUpperLeg")
	print("Tagged " .. v15.Name .. " with LeftUpperLeg")
else
	warn("Bone not found for tag: LeftUpperLeg")
end

if v16 then
	CollectionService:AddTag(v16, "LeftLowerLeg")
	print("Tagged " .. v16.Name .. " with LeftLowerLeg")
else
	warn("Bone not found for tag: LeftLowerLeg")
end

if v17 then
	CollectionService:AddTag(v17, "LeftFoot")
	print("Tagged " .. v17.Name .. " with LeftFoot")
else
	warn("Bone not found for tag: LeftFoot")
end

local v18 = spine:FindFirstChild("thigh.R")
local v19 = if v18 then v18:FindFirstChild("shin.R") else v18
local v20 = if v19 then v19:FindFirstChild("foot.R") else v19

if v18 then
	CollectionService:AddTag(v18, "RightUpperLeg")
	print("Tagged " .. v18.Name .. " with RightUpperLeg")
else
	warn("Bone not found for tag: RightUpperLeg")
end

if v19 then
	CollectionService:AddTag(v19, "RightLowerLeg")
	print("Tagged " .. v19.Name .. " with RightLowerLeg")
else
	warn("Bone not found for tag: RightLowerLeg")
end

if v20 then
	CollectionService:AddTag(v20, "RightFoot")
	print("Tagged " .. v20.Name .. " with RightFoot")
else
	warn("Bone not found for tag: RightFoot")
end

print("\226\156\147 All tags added successfully!")