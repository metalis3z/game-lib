-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:21:33
-- Luau version 6, Types version 3
-- Time taken: 0.000889 seconds

local InventoryFrame = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("InventoryFrame")
local Displays = InventoryFrame:WaitForChild("Displays")
local Pets_upvr = Displays:WaitForChild("Pets")
local Archive_upvr = Displays:WaitForChild("Archive")
local module = {}
local List_upvr = InventoryFrame:WaitForChild("Utility"):WaitForChild("Tools"):WaitForChild("List")
function module.archive(arg1) -- Line 25
	--[[ Upvalues[3]:
		[1]: List_upvr (readonly)
		[2]: Archive_upvr (readonly)
		[3]: Pets_upvr (readonly)
	]]
	List_upvr.Archive.Visible = not arg1
	List_upvr.EquipBest.Visible = not arg1
	List_upvr.MassLock.Visible = not arg1
	List_upvr.Shrink.Visible = not arg1
	List_upvr.Blank.Visible = arg1
	List_upvr.Close.Visible = arg1
	List_upvr.Deposit.Visible = arg1
	List_upvr.Withdraw.Visible = arg1
	Archive_upvr.Visible = arg1
	Pets_upvr.Visible = not arg1
end
local Bottom_upvr = InventoryFrame:WaitForChild("Bottom")
function module.archiveChange(arg1) -- Line 40
	--[[ Upvalues[3]:
		[1]: Bottom_upvr (readonly)
		[2]: Archive_upvr (readonly)
		[3]: Pets_upvr (readonly)
	]]
	Bottom_upvr.Visible = arg1
	Archive_upvr.Visible = not arg1
	Pets_upvr.Visible = arg1
end
return module