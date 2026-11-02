-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:23:01
-- Luau version 6, Types version 3
-- Time taken: 0.001641 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "WeldSpin";
})
local tbl_upvr = {}
local RunService_upvr = game:GetService("RunService")
function any_new_result1.spin(arg1) -- Line 28
	--[[ Upvalues[2]:
		[1]: tbl_upvr (readonly)
		[2]: RunService_upvr (readonly)
	]]
	tbl_upvr[#tbl_upvr + 1] = RunService_upvr.Heartbeat:Connect(function(arg1_2) -- Line 29
		-- KONSTANTWARNING fixed: each axis spins by deltaTime * 3000 if the attribute is set
		local speed = arg1_2 * 3000
		local rotX = arg1.Instance:GetAttribute("axisX") and speed or 0
		local rotY = arg1.Instance:GetAttribute("axisY") and speed or 0
		local rotZ = arg1.Instance:GetAttribute("axisZ") and speed or 0
		arg1.Instance.C0 = arg1.Instance.C0 * CFrame.Angles(math.rad(rotX), math.rad(rotY), math.rad(rotZ))
	end)
end
function any_new_result1.Start(arg1) -- Line 40
	arg1:spin()
end
function any_new_result1.Stop(arg1) -- Line 44
	--[[ Upvalues[1]:
		[1]: tbl_upvr (readonly)
	]]
	for i, v in tbl_upvr do
		v:Disconnect()
		tbl_upvr[i] = nil
	end
end
local var11_upvw
function any_new_result1.Construct(arg1) -- Line 51
	--[[ Upvalues[2]:
		[1]: var11_upvw (read and write)
		[2]: Knit_upvr (readonly)
	]]
	var11_upvw = Knit_upvr.GetController("DataController")
end
return any_new_result1