-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:22
-- Luau version 6, Types version 3
-- Time taken: 0.009122 seconds

ScreenGui = script.Parent -- Setting global
PlayerGui = ScreenGui.Parent -- Setting global
Player = PlayerGui.Parent -- Setting global
Frame = ScreenGui.Frame -- Setting global
Debris = game:GetService("Debris") -- Setting global
function Create(arg1) -- Line 10
	local any_upvr = Instance.new(arg1)
	return function(arg1_2) -- Line 12
		--[[ Upvalues[1]:
			[1]: any_upvr (readonly)
		]]
		for i, v in pairs(arg1_2) do
			any_upvr[i] = v
		end
		return any_upvr
	end
end
BaseUrl = "http://www.roblox.com/asset/?id=" -- Setting global
Frame:ClearAllChildren()
Frame.Visible = true
Images = {276120078, 276120139, 276120200} -- Setting global
Random = math.random -- Setting global
UDim2 = UDim2.new -- Setting global
Rate = 0.01 -- Setting global
BaseParticle = Create("ImageLabel")({
	Name = "Particle";
	BackgroundTransparency = 1;
	BorderSizePixel = 0;
	ZIndex = 2;
}) -- Setting global
Directions = {
	Straight = {
		Min = UDim2(0, 30, 0, 0);
		Max = UDim2(0, 60, 0, 0);
	};
	Left = {
		Min = UDim2(0, 0, 0, -10);
		Max = UDim2(0, 0, 0, 10);
	};
	Right = {
		Min = UDim2(0, 20, 0, 0);
		Max = UDim2(0, 50, 0, 0);
	};
} -- Setting global
MaximumParticles = 450 -- Setting global
LastTick = 0 -- Setting global
WaitTime = 0 -- Setting global
Particles = {} -- Setting global
function CreateParticle() -- Line 60
	local Random_result1 = Random(1, 3)
	local var16
	local function INLINED() -- Internal function, doesn't exist in bytecode
		var16 = Directions.Straight
		return var16
	end
	local function INLINED_2() -- Internal function, doesn't exist in bytecode
		var16 = Directions.Left
		return var16
	end
	if Random_result1 ~= 1 or not INLINED() or Random_result1 ~= 2 or not INLINED_2() then
		var16 = Directions.Right
	end
	var16 = Random(10, 25)
	local clone = BaseParticle:Clone()
	clone.ImageTransparency = Random(0, 500) * 0.001
	clone.Rotation = Random(0, 360)
	clone.Image = BaseUrl..Images[Random(1, #Images)]
	clone.Size = UDim2(0, var16, 0, var16)
	clone.Position = UDim2(0, 0 - var16, 0, Random(0, Frame.Size.Y.Offset - var16))
	clone.Parent = Frame
	table.insert(Particles, {
		Frame = clone;
		Direction = var16;
	})
end
function SpawnParticles() -- Line 74
	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [21] 17. Error Block 5 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [21] 17. Error Block 5 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [9] 9. Error Block 7 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect
	-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [21.65666]
	if Random(1, 100) < 1 then
		-- KONSTANTWARNING: GOTO [21] #17
	end
	-- KONSTANTERROR: [9] 9. Error Block 7 end (CF ANALYSIS FAILED)
end
function AnimateParticles() -- Line 84
	for i_2, v_2 in pairs(Particles) do
		local UDim2_result1 = UDim2(0, Random(v_2.Direction.Min.X.Offset, v_2.Direction.Max.X.Offset), 0, Random(v_2.Direction.Min.Y.Offset, v_2.Direction.Max.Y.Offset))
		local Frame_2 = v_2.Frame
		Frame_2.Position = v_2.Frame.Position + UDim2(0, UDim2_result1.X.Offset, 0, UDim2_result1.Y.Offset)
		if 360 <= v_2.Frame.Rotation then
			Frame_2 = 1
		else
			Frame_2 = v_2.Frame.Rotation + 5
		end
		v_2.Rotation = Frame_2
		if Frame.Size.Y.Offset <= v_2.Frame.Position.Y.Offset or Frame.Size.X.Offset <= v_2.Frame.Position.X.Offset or v_2.Frame.Position.X.Offset <= 0 - v_2.Frame.Size.X.Offset then
			v_2.Frame:Destroy()
			table.remove(Particles, i_2)
		end
	end
end
function FunctionParticles() -- Line 96
	Spawn(function() -- Line 97
		while true do
			if WaitTime < tick() - LastTick then
				LastTick = tick() -- Setting global
				WaitTime = 0 -- Setting global
				SpawnParticles()
			end
			AnimateParticles()
			wait(Rate)
		end
	end)
end
function FixScreenSize() -- Line 110
	Frame.Size = UDim2(0, ScreenGui.AbsoluteSize.X, 0, ScreenGui.AbsoluteSize.Y + 36)
	Frame.Position = UDim2(0, 0, 0, -36)
end
function DestroyGui() -- Line 115
	Debris:AddItem(ScreenGui, 2)
end
ScreenGui.Changed:connect(function(arg1) -- Line 119
	if arg1 == "AbsoluteSize" then
		FixScreenSize()
	end
end)
FixScreenSize()
FunctionParticles()