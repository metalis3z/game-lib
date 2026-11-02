-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("TweenService")
local v2 = game:GetService("CollectionService")
local v3 = TweenInfo.new(2, Enum.EasingStyle.Linear)
local v_u_4 = script:WaitForChild("Secret"):WaitForChild("UIGradient")
local v_u_5 = script:WaitForChild("Secret"):WaitForChild("UIStroke"):WaitForChild("UIGradient")
local v_u_6 = script:WaitForChild("Celestial"):WaitForChild("UIGradient")
local v_u_7 = script:WaitForChild("Celestial"):WaitForChild("UIStroke"):WaitForChild("UIGradient")
local v_u_8 = script:WaitForChild("Godly"):WaitForChild("UIGradient")
local v_u_9 = script:WaitForChild("Godly"):WaitForChild("UIStroke"):WaitForChild("UIGradient")
local v_u_10 = script:WaitForChild("Moon"):WaitForChild("UIGradient")
local v_u_11 = script:WaitForChild("Moon"):WaitForChild("UIStroke"):WaitForChild("UIGradient")
local v_u_12 = {}
function TextFunction(p13, p14)
	-- upvalues: (copy) v_u_4, (copy) v_u_6, (copy) v_u_8, (copy) v_u_10, (copy) v_u_5, (copy) v_u_7, (copy) v_u_9, (copy) v_u_11, (copy) v_u_12
	local v15 = p14 == "Secret" and v_u_4 or (p14 == "Celestial" and v_u_6 or p14 == "Godly" and v_u_8)
	if not v15 then
		if p14 == "Moon" then
			v15 = v_u_10
		else
			v15 = false
		end
	end
	local v16 = v15:Clone()
	local v17 = (p14 == "Secret" and v_u_5 or p14 == "Celestial" and v_u_7 or (p14 == "Godly" and v_u_9 or v_u_11)).Parent:Clone()
	if p13:FindFirstChildOfClass("UIGradient") then
		p13:FindFirstChildOfClass("UIGradient"):Destroy()
	end
	if p13:FindFirstChildOfClass("UIStroke") then
		v17.StrokeSizingMode = p13:FindFirstChildOfClass("UIStroke").StrokeSizingMode
		v17.Thickness = p13:FindFirstChildOfClass("UIStroke").Thickness
		p13:FindFirstChildOfClass("UIStroke"):Destroy()
	end
	v16.Parent = p13
	v17.Parent = p13
	v17.Color = Color3.fromRGB(255, 255, 255)
	local v18 = v_u_12
	table.insert(v18, p13)
end
local v19 = 0
for _, v_u_20 in {
	"Secret",
	"Celestial",
	"Godly",
	"Moon"
} do
	for _, v21 in v2:GetTagged(v_u_20) do
		TextFunction(v21, v_u_20)
	end
	v2:GetInstanceAddedSignal(v_u_20):Connect(function(p22)
		-- upvalues: (copy) v_u_20
		TextFunction(p22, v_u_20)
	end)
	v2:GetInstanceRemovedSignal(v_u_20):Connect(function(p23)
		-- upvalues: (copy) v_u_12
		table.remove(v_u_12, table.find(v_u_12, p23))
	end)
end
v_u_4.Changed:Connect(function()
	-- upvalues: (copy) v_u_12, (copy) v_u_4, (copy) v_u_5
	for _, v24 in v_u_12 do
		v24.UIGradient.Offset = v_u_4.Offset
		v24.UIGradient.Rotation = v_u_4.Rotation
		v24.UIStroke.UIGradient.Offset = v_u_5.Offset
		v24.UIStroke.UIGradient.Rotation = v_u_5.Rotation
	end
end)
while true do
	local v25 = v1:Create(v_u_4, v3, {
		["Offset"] = Vector2.new(0, 0.5)
	})
	v25:Play()
	local v26 = v1:Create(v_u_5, v3, {
		["Offset"] = Vector2.new(0, 0.5)
	})
	v26:Play()
	v25.Completed:Wait()
	v26:Cancel()
	local v27 = v19 + 1
	v19 = v27 == 2 and 0 or v27
	v_u_4.Rotation = v19 * 180 + 90
	v_u_5.Rotation = v19 * 180 + 90
	v_u_4.Offset = Vector2.new(0, -0.5)
	v_u_5.Offset = Vector2.new(0, -0.5)
end
