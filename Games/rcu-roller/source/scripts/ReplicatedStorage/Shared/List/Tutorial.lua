-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:18:30
-- Luau version 6, Types version 3
-- Time taken: 0.009281 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local Bars = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("HUD"):WaitForChild("Bars")
local Right_upvr = Bars:WaitForChild("Right")
local Left_upvr = Bars:WaitForChild("Left")
local Bottom_upvr = Bars:WaitForChild("Bottom")
local Top_upvr = Bars:WaitForChild("Top")
local module = {}
local tbl_6 = {
	text = "Get 100 Clicks!";
	arrowPosition = UDim2.fromScale(0.386, 0.884);
	arrowRotation = 0;
}
local function stageIsAvailable(arg1) -- Line 23
	return true
end
tbl_6.stageIsAvailable = stageIsAvailable
local function stageIsCompleted(arg1) -- Line 26
	local var9
	if 100 > arg1.clicks then
		var9 = false
	else
		var9 = true
	end
	return var9
end
tbl_6.stageIsCompleted = stageIsCompleted
local function getStageProgress(arg1) -- Line 30
	return math.floor(arg1.clicks), 100
end
tbl_6.getStageProgress = getStageProgress
local function arrowIsVisible(arg1) -- Line 34
	local var10
	if arg1.clicks >= 33 then
		var10 = false
	else
		var10 = true
	end
	return var10
end
tbl_6.arrowIsVisible = arrowIsVisible
local function onStart() -- Line 38
	--[[ Upvalues[5]:
		[1]: Right_upvr (readonly)
		[2]: Left_upvr (readonly)
		[3]: Bottom_upvr (readonly)
		[4]: Top_upvr (readonly)
		[5]: Knit_upvr (readonly)
	]]
	Right_upvr.Visible = false
	Left_upvr.Row1.Visible = false
	Bottom_upvr.Auto.Visible = false
	Bottom_upvr.Mounts.Visible = false
	Top_upvr.Rebirths.Visible = false
	Top_upvr.Gems.Visible = false
	for _, v in Left_upvr.Row2:GetChildren() do
		if v:IsA("Frame") and v.Name ~= "Rebirth" then
			v.Visible = false
		end
	end
	Knit_upvr.GetController("PlayerController"):hideCharacters(true)
	Knit_upvr.GetController("PetController"):togglePets(false, false)
end
tbl_6.onStart = onStart
local function onCompleted() -- Line 57
end
tbl_6.onCompleted = onCompleted
module[1] = tbl_6
local tbl_4 = {
	text = "Get your first rebirth!";
	arrowPosition = UDim2.fromScale(0.076, 0.466);
	arrowRotation = 180;
	playFinishedAnimation = false;
}
local function stageIsAvailable(arg1) -- Line 70
	return true
end
tbl_4.stageIsAvailable = stageIsAvailable
local function stageIsCompleted(arg1) -- Line 73
	--[[ Upvalues[1]:
		[1]: Knit_upvr (readonly)
	]]
	return Knit_upvr.GetController("UIController"):isFrameOpen()
end
tbl_4.stageIsCompleted = stageIsCompleted
local function getStageProgress(arg1) -- Line 77
	return 0, 1
end
tbl_4.getStageProgress = getStageProgress
local function arrowIsVisible(arg1) -- Line 81
	return true
end
tbl_4.arrowIsVisible = arrowIsVisible
local function onStart() -- Line 85
	--[[ Upvalues[4]:
		[1]: Right_upvr (readonly)
		[2]: Left_upvr (readonly)
		[3]: Bottom_upvr (readonly)
		[4]: Knit_upvr (readonly)
	]]
	Right_upvr.Visible = false
	Left_upvr.Row1.Visible = false
	Bottom_upvr.Auto.Visible = false
	Bottom_upvr.Mounts.Visible = false
	for _, v_2 in Left_upvr.Row2:GetChildren() do
		if v_2:IsA("Frame") and v_2.Name ~= "Rebirth" then
			v_2.Visible = false
		end
	end
	Knit_upvr.GetController("PlayerController"):hideCharacters(true)
	Knit_upvr.GetController("PetController"):togglePets(false, false)
end
tbl_4.onStart = onStart
local function onCompleted() -- Line 101
	--[[ Upvalues[1]:
		[1]: Top_upvr (readonly)
	]]
	Top_upvr.Rebirths.Visible = true
	Top_upvr.Gems.Visible = true
end
tbl_4.onCompleted = onCompleted
module[2] = tbl_4
local tbl_2 = {
	text = "Get your first rebirth!";
	arrowPosition = UDim2.fromScale(0.225, 0.386);
	arrowRotation = 0;
}
local function stageIsAvailable(arg1) -- Line 113
	return true
end
tbl_2.stageIsAvailable = stageIsAvailable
local function stageIsCompleted(arg1) -- Line 116
	local var23
	if 1 > arg1.rebirths then
		var23 = false
	else
		var23 = true
	end
	return var23
end
tbl_2.stageIsCompleted = stageIsCompleted
local function getStageProgress(arg1) -- Line 120
	return arg1.rebirths, 1
end
tbl_2.getStageProgress = getStageProgress
local function arrowIsVisible(arg1) -- Line 124
	--[[ Upvalues[1]:
		[1]: Knit_upvr (readonly)
	]]
	return Knit_upvr.GetController("UIController"):isFrameOpen()
end
tbl_2.arrowIsVisible = arrowIsVisible
local function onStart() -- Line 128
	--[[ Upvalues[4]:
		[1]: Right_upvr (readonly)
		[2]: Left_upvr (readonly)
		[3]: Bottom_upvr (readonly)
		[4]: Knit_upvr (readonly)
	]]
	Right_upvr.Visible = false
	Left_upvr.Row1.Visible = false
	Bottom_upvr.Auto.Visible = false
	Bottom_upvr.Mounts.Visible = false
	for _, v_3 in Left_upvr.Row2:GetChildren() do
		if v_3:IsA("Frame") and v_3.Name ~= "Rebirth" then
			v_3.Visible = false
		end
	end
	Knit_upvr.GetController("PlayerController"):hideCharacters(true)
	Knit_upvr.GetController("PetController"):togglePets(false, false)
end
tbl_2.onStart = onStart
local function onCompleted() -- Line 144
	--[[ Upvalues[1]:
		[1]: Top_upvr (readonly)
	]]
	Top_upvr.Rebirths.Visible = true
	Top_upvr.Gems.Visible = true
end
tbl_2.onCompleted = onCompleted
module[3] = tbl_2
local tbl_3 = {
	text = "Get 250 Clicks!";
	arrowPosition = UDim2.fromScale(0.386, 0.884);
	arrowRotation = 0;
}
local function stageIsAvailable(arg1) -- Line 156
	return true
end
tbl_3.stageIsAvailable = stageIsAvailable
local function stageIsCompleted(arg1) -- Line 159
	local var30
	if 250 > arg1.clicks then
		var30 = false
	else
		var30 = true
	end
	return var30
end
tbl_3.stageIsCompleted = stageIsCompleted
local function getStageProgress(arg1) -- Line 163
	return math.floor(arg1.clicks), 250
end
tbl_3.getStageProgress = getStageProgress
local function arrowIsVisible(arg1) -- Line 167
	local var31
	if arg1.clicks >= 25 then
		var31 = false
	else
		var31 = true
	end
	return var31
end
tbl_3.arrowIsVisible = arrowIsVisible
local function onStart() -- Line 171
	--[[ Upvalues[5]:
		[1]: Right_upvr (readonly)
		[2]: Left_upvr (readonly)
		[3]: Bottom_upvr (readonly)
		[4]: Top_upvr (readonly)
		[5]: Knit_upvr (readonly)
	]]
	Right_upvr.Visible = false
	Left_upvr.Row1.Visible = false
	Bottom_upvr.Auto.Visible = false
	Bottom_upvr.Mounts.Visible = false
	Top_upvr.Rebirths.Visible = false
	Top_upvr.Gems.Visible = false
	for _, v_4 in Left_upvr.Row2:GetChildren() do
		if v_4:IsA("Frame") and v_4.Name ~= "Rebirth" then
			v_4.Visible = false
		end
	end
	Knit_upvr.GetController("PlayerController"):hideCharacters(true)
	Knit_upvr.GetController("PetController"):togglePets(false, false)
end
tbl_3.onStart = onStart
local function onCompleted() -- Line 190
	--[[ Upvalues[1]:
		[1]: Top_upvr (readonly)
	]]
	Top_upvr.Rebirths.Visible = true
	Top_upvr.Gems.Visible = true
end
tbl_3.onCompleted = onCompleted
module[4] = tbl_3
local tbl_5 = {
	text = "Open your first egg!";
	arrowPosition = UDim2.fromScale(0, 0);
	arrowRotation = 0;
}
local function stageIsAvailable(arg1) -- Line 202
	return true
end
tbl_5.stageIsAvailable = stageIsAvailable
local function stageIsCompleted(arg1) -- Line 205
	local var38
	if 1 > arg1.stats.eggsOpened then
		var38 = false
	else
		var38 = true
	end
	return var38
end
tbl_5.stageIsCompleted = stageIsCompleted
local function getStageProgress(arg1) -- Line 209
	return arg1.stats.eggsOpened, 1
end
tbl_5.getStageProgress = getStageProgress
local function beamIsAvailable(arg1) -- Line 213
	return true
end
tbl_5.beamIsAvailable = beamIsAvailable
local function getBeamPart() -- Line 216
	return workspace.Game.Maps.Spawn.Eggs.Basic.Egg.PrimaryPart
end
tbl_5.getBeamPart = getBeamPart
local function arrowIsVisible(arg1) -- Line 220
	return false
end
tbl_5.arrowIsVisible = arrowIsVisible
local function onStart() -- Line 224
	--[[ Upvalues[4]:
		[1]: Right_upvr (readonly)
		[2]: Left_upvr (readonly)
		[3]: Bottom_upvr (readonly)
		[4]: Knit_upvr (readonly)
	]]
	Right_upvr.Visible = false
	Left_upvr.Row1.Visible = false
	Bottom_upvr.Auto.Visible = false
	Bottom_upvr.Mounts.Visible = false
	for _, v_5 in Left_upvr.Row2:GetChildren() do
		if v_5:IsA("Frame") and v_5.Name ~= "Rebirth" then
			v_5.Visible = false
		end
	end
	Knit_upvr.GetController("PlayerController"):hideCharacters(true)
	Knit_upvr.GetController("PetController"):togglePets(false, false)
end
tbl_5.onStart = onStart
local function onCompleted() -- Line 240
	--[[ Upvalues[2]:
		[1]: Top_upvr (readonly)
		[2]: Left_upvr (readonly)
	]]
	Top_upvr.Rebirths.Visible = true
	Top_upvr.Gems.Visible = true
	Left_upvr.Row2.Pets.Visible = true
end
tbl_5.onCompleted = onCompleted
module[5] = tbl_5
local tbl_8 = {
	text = "Get 2 Rebirths!";
	arrowPosition = UDim2.fromScale(0.076, 0.523);
	arrowRotation = 180;
}
local function stageIsAvailable(arg1) -- Line 253
	return true
end
tbl_8.stageIsAvailable = stageIsAvailable
local function stageIsCompleted(arg1) -- Line 256
	local var45
	if 3 > arg1.rebirths then
		var45 = false
	else
		var45 = true
	end
	return var45
end
tbl_8.stageIsCompleted = stageIsCompleted
local function getStageProgress(arg1) -- Line 260
	return arg1.rebirths - 1, 2
end
tbl_8.getStageProgress = getStageProgress
local function arrowIsVisible(arg1) -- Line 264
	local var46 = false
	if 600 <= arg1.clicks then
		if arg1.rebirths >= 3 then
			var46 = false
		else
			var46 = true
		end
	end
	return var46
end
tbl_8.arrowIsVisible = arrowIsVisible
local function onStart() -- Line 268
	--[[ Upvalues[4]:
		[1]: Right_upvr (readonly)
		[2]: Left_upvr (readonly)
		[3]: Bottom_upvr (readonly)
		[4]: Knit_upvr (readonly)
	]]
	Right_upvr.Visible = false
	Left_upvr.Row1.Visible = false
	Bottom_upvr.Auto.Visible = false
	Bottom_upvr.Mounts.Visible = false
	for _, v_6 in Left_upvr.Row2:GetChildren() do
		if v_6:IsA("Frame") and v_6.Name ~= "Rebirth" and v_6.Name ~= "Pets" then
			v_6.Visible = false
		end
	end
	Knit_upvr.GetController("PlayerController"):hideCharacters(true)
	Knit_upvr.GetController("PetController"):togglePets(false, false)
end
tbl_8.onStart = onStart
local function onCompleted() -- Line 284
	--[[ Upvalues[2]:
		[1]: Top_upvr (readonly)
		[2]: Left_upvr (readonly)
	]]
	Top_upvr.Rebirths.Visible = true
	Top_upvr.Gems.Visible = true
	Left_upvr.Row2.Pets.Visible = true
end
tbl_8.onCompleted = onCompleted
module[6] = tbl_8
local tbl_7 = {
	text = "Buy a Rebirth Button Upgrade!";
	arrowPosition = UDim2.fromScale(0, 0);
	arrowRotation = 0;
	playFinishedAnimation = false;
}
local function stageIsAvailable(arg1) -- Line 299
	return true
end
tbl_7.stageIsAvailable = stageIsAvailable
local function stageIsCompleted(arg1) -- Line 302
	--[[ Upvalues[1]:
		[1]: Knit_upvr (readonly)
	]]
	local var53
	if Knit_upvr.GetController("UIController"):getCurrentFrameOpen() ~= "UpgradesFrame" then
		var53 = false
	else
		var53 = true
	end
	return var53
end
tbl_7.stageIsCompleted = stageIsCompleted
local function beamIsAvailable(arg1) -- Line 306
	return true
end
tbl_7.beamIsAvailable = beamIsAvailable
local function getBeamPart() -- Line 309
	return workspace.Game.Maps.Spawn.Machines.Upgrades.Touch
end
tbl_7.getBeamPart = getBeamPart
local function getStageProgress(arg1) -- Line 313
	return 0, 1
end
tbl_7.getStageProgress = getStageProgress
local function arrowIsVisible(arg1) -- Line 317
	return false
end
tbl_7.arrowIsVisible = arrowIsVisible
local function onStart() -- Line 321
	--[[ Upvalues[4]:
		[1]: Right_upvr (readonly)
		[2]: Left_upvr (readonly)
		[3]: Bottom_upvr (readonly)
		[4]: Knit_upvr (readonly)
	]]
	Right_upvr.Visible = false
	Left_upvr.Row1.Visible = false
	Bottom_upvr.Auto.Visible = false
	Bottom_upvr.Mounts.Visible = false
	for _, v_7 in Left_upvr.Row2:GetChildren() do
		if v_7:IsA("Frame") and v_7.Name ~= "Rebirth" and v_7.Name ~= "Pets" then
			v_7.Visible = false
		end
	end
	Knit_upvr.GetController("PlayerController"):hideCharacters(true)
	Knit_upvr.GetController("PetController"):togglePets(false, false)
end
tbl_7.onStart = onStart
local function onCompleted() -- Line 337
	--[[ Upvalues[2]:
		[1]: Top_upvr (readonly)
		[2]: Left_upvr (readonly)
	]]
	Top_upvr.Rebirths.Visible = true
	Top_upvr.Gems.Visible = true
	Left_upvr.Row2.Pets.Visible = true
end
tbl_7.onCompleted = onCompleted
module[7] = tbl_7
local tbl = {
	text = "Buy a Rebirth Button Upgrade!";
	arrowPosition = UDim2.fromScale(0.366, 0.528);
	arrowRotation = 0;
}
local function stageIsAvailable(arg1) -- Line 350
	return true
end
tbl.stageIsAvailable = stageIsAvailable
local function stageIsCompleted(arg1) -- Line 353
	local var60
	if arg1.upgrades.rebirthButtons == nil then
		var60 = false
	else
		var60 = true
	end
	return var60
end
tbl.stageIsCompleted = stageIsCompleted
local function getStageProgress(arg1) -- Line 357
	return 0, 1
end
tbl.getStageProgress = getStageProgress
local function arrowIsVisible(arg1) -- Line 361
	--[[ Upvalues[1]:
		[1]: Knit_upvr (readonly)
	]]
	local var61
	if Knit_upvr.GetController("UIController"):getCurrentFrameOpen() ~= "UpgradesFrame" then
		var61 = false
	else
		var61 = true
	end
	return var61
end
tbl.arrowIsVisible = arrowIsVisible
local function onStart() -- Line 365
	--[[ Upvalues[4]:
		[1]: Right_upvr (readonly)
		[2]: Left_upvr (readonly)
		[3]: Bottom_upvr (readonly)
		[4]: Knit_upvr (readonly)
	]]
	Right_upvr.Visible = false
	Left_upvr.Row1.Visible = false
	Bottom_upvr.Auto.Visible = false
	Bottom_upvr.Mounts.Visible = false
	for _, v_8 in Left_upvr.Row2:GetChildren() do
		if v_8:IsA("Frame") and v_8.Name ~= "Rebirth" and v_8.Name ~= "Pets" then
			v_8.Visible = false
		end
	end
	Knit_upvr.GetController("PlayerController"):hideCharacters(true)
	Knit_upvr.GetController("PetController"):togglePets(false, false)
end
tbl.onStart = onStart
local function onCompleted() -- Line 381
	--[[ Upvalues[2]:
		[1]: Top_upvr (readonly)
		[2]: Left_upvr (readonly)
	]]
	Top_upvr.Rebirths.Visible = true
	Top_upvr.Gems.Visible = true
	Left_upvr.Row2.Pets.Visible = true
end
tbl.onCompleted = onCompleted
module[8] = tbl
module[9] = {
	text = "Open 2 eggs!";
	arrowPosition = UDim2.fromScale(0, 0);
	arrowRotation = 0;
	stageIsAvailable = function(arg1) -- Line 394, Named "stageIsAvailable"
		return true
	end;
	stageIsCompleted = function(arg1) -- Line 397, Named "stageIsCompleted"
		local var68
		if 3 > arg1.stats.eggsOpened then
			var68 = false
		else
			var68 = true
		end
		return var68
	end;
	beamIsAvailable = function(arg1) -- Line 401, Named "beamIsAvailable"
		local var69
		if 1250 > arg1.clicks then
			var69 = false
		else
			var69 = true
		end
		return var69
	end;
	getBeamPart = function() -- Line 404, Named "getBeamPart"
		return workspace.Game.Maps.Spawn.Eggs.Basic.Egg.PrimaryPart
	end;
	getStageProgress = function(arg1) -- Line 408, Named "getStageProgress"
		return arg1.stats.eggsOpened - 1, 2
	end;
	arrowIsVisible = function(arg1) -- Line 412, Named "arrowIsVisible"
		return false
	end;
	onStart = function() -- Line 416, Named "onStart"
		--[[ Upvalues[4]:
			[1]: Right_upvr (readonly)
			[2]: Left_upvr (readonly)
			[3]: Bottom_upvr (readonly)
			[4]: Knit_upvr (readonly)
		]]
		Right_upvr.Visible = false
		Left_upvr.Row1.Visible = false
		Bottom_upvr.Auto.Visible = false
		Bottom_upvr.Mounts.Visible = false
		for _, v_9 in Left_upvr.Row2:GetChildren() do
			if v_9:IsA("Frame") and v_9.Name ~= "Rebirth" and v_9.Name ~= "Pets" then
				v_9.Visible = false
			end
		end
		Knit_upvr.GetController("PlayerController"):hideCharacters(true)
		Knit_upvr.GetController("PetController"):togglePets(false, false)
	end;
	onCompleted = function() -- Line 432, Named "onCompleted"
		--[[ Upvalues[4]:
			[1]: Right_upvr (readonly)
			[2]: Left_upvr (readonly)
			[3]: Bottom_upvr (readonly)
			[4]: Knit_upvr (readonly)
		]]
		Right_upvr.Visible = true
		Left_upvr.Row1.Visible = true
		Bottom_upvr.Auto.Visible = true
		Bottom_upvr.Mounts.Visible = true
		for _, v_10 in Left_upvr.Row2:GetChildren() do
			if v_10:IsA("Frame") and v_10.Name ~= "Clans" then
				v_10.Visible = true
			end
		end
		Knit_upvr.GetController("PlayerController"):hideCharacters(false)
		Knit_upvr.GetController("PetController"):togglePets(false, true)
	end;
}
return module