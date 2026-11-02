local remote = script.Parent
local car = remote.Parent
local objectsFolder = remote.Objects
local tireMarkTrails = {}

--- CONFIG

local Tire_Mark_Offset = 0.05		-- Offset added to position of tire mark part (prevents tire marks clipping)
local Tire_Mark_Width = 0.375		-- (0-1) Percentage of wheel part width used for tire marks

local Max_SQ_Volume = 5				-- Max volume of squeal sfx


--- FUNCTIONS

local function CreateTireMarkPart(wheel)
	local tireMarkPart = Instance.new("Part")
	tireMarkPart.Parent = wheel.WheelFixed
	tireMarkPart.Name = "Mark"
	tireMarkPart.Transparency = 1
	tireMarkPart.Anchored = true
	tireMarkPart.CanCollide = false
	
	tireMarkPart.Size = Vector3.new(0.05, 0.05, wheel.Size.Z * Tire_Mark_Width)		-- 50% the width of wheel
	
	return tireMarkPart
end

local function WeldToAxle(wheel, part, cf)
	local Axle = wheel.Axle
	local Weld = Instance.new("Weld", Axle)

	Weld.Part0 = Axle
	Weld.Part1 = part
	Weld.C0 = Axle.CFrame:inverse() * Axle.CFrame
	Weld.C1 = wheel.Arm.CFrame:ToWorldSpace(cf):inverse() * Axle.CFrame
end

local function CreateAttachment(part, cf)
	local attach = Instance.new("Attachment")
	attach.Parent = part
	attach.CFrame = cf
	
	return attach
end

--- SETUP

for _, wheel in pairs(car.Wheels:GetChildren()) do
	for _, object in pairs(objectsFolder:GetChildren()) do
		local objectClone = wheel:FindFirstChild(object.Name) or object:Clone()
		objectClone.Parent = wheel
	end

	-- Check if tiremark part already exists in wheel
	if wheel.WheelFixed:FindFirstChild("Mark") and wheel.WheelFixed.Mark:FindFirstChildOfClass("Trail") then
		tireMarkTrails[wheel.Name] = wheel.WheelFixed.Mark:FindFirstChildOfClass("Trail")
		
	-- Create tire mark part
	else

		-- Create base part
		local tireMarkPart = CreateTireMarkPart(wheel)
		
		-- Temporarily position near car to prevent flinging
		local offset = CFrame.new(0, -(wheel.Size.Y / 2) + Tire_Mark_Offset, 0) 		-- 0.05 studs above the bottom of the wheel
		local rotation = CFrame.Angles(0, math.rad(90), 0)				-- rotated to be perpendicular to direction of wheel
		local newCF = offset * rotation
		tireMarkPart.CFrame = wheel.Arm.CFrame:ToWorldSpace(newCF)
		
		-- Weld to axle
		WeldToAxle(wheel, tireMarkPart, newCF)
		tireMarkPart.Anchored = false

		-- Create and position attachments
		local attach1 = CreateAttachment(tireMarkPart, CFrame.new(0, 0, tireMarkPart.Size.Z / 2))
		local attach2 = CreateAttachment(tireMarkPart, CFrame.new(0, 0, -tireMarkPart.Size.Z / 2))

		-- Configure trail
		local mark = wheel.TireMark
		mark.Parent = tireMarkPart
		mark.Attachment0 = attach1
		mark.Attachment1 = attach2

		tireMarkTrails[wheel.Name] = mark
	end
end

--- UPDATE

local function Update(plr, wheelInfo, Skid_Minimum_Threshold, Skid_Maximum_Threshold, Skid_Mark_Threshold)

	for _, wheel in pairs(car.Wheels:GetChildren()) do

		local value = wheelInfo[wheel.Name]["SkidValue"]
		
		--Update squeal
		wheel.SQ.Volume = value * Max_SQ_Volume
		
		-- Update smoke
		local multiplier = value * (Skid_Maximum_Threshold - Skid_Minimum_Threshold)
		local offset = Skid_Minimum_Threshold
		if value == 0 then offset = 0; end
		
		wheel.Smoke.Rate = value + offset
		
		-- Update tire marks
		if value > Skid_Mark_Threshold then
			tireMarkTrails[wheel.Name].Enabled = true
		else
			tireMarkTrails[wheel.Name].Enabled = false
		end
	end

end


remote.OnServerEvent:Connect(Update)