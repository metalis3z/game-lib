local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_CreateController_result1 = Knit_upvr.CreateController({
	Name = "OrbController";
	_orbStorage = {};
})
local var4_upvw  -- DataController
local var5_upvw  -- SoundController
local var6_upvw  -- OrbService
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var8_upvw  -- Util (itemUtils)
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local Orbs_upvr = workspace:WaitForChild("Debris"):WaitForChild("Orbs")

-- Apply initial bounce velocity to a freshly-spawned orb Part
function any_CreateController_result1.orbVelocity(arg1, arg2)
	local randint_upvr_2 = math.random(-20, 20)
	local randint_upvr = math.random(-20, 20)
	arg2.Anchored = false
	arg2.Velocity = Vector3.new(randint_upvr_2, 25, randint_upvr)
	task.spawn(function()
		task.wait(0.75)
		for i = 1, 10 do
			arg2.Velocity = Vector3.new(randint_upvr_2 / i, 0, randint_upvr / i)
			task.wait(0.02)
		end
		arg2.Velocity = Vector3.new(0, 0, 0)
		arg2.Anchored = true
	end)
end

-- Magnetically pull nearby orbs towards the local player
function any_CreateController_result1.alignPosition(arg1, arg2)
	task.spawn(function()
		repeat
			for _, v in Orbs_upvr:GetChildren() do
				-- FIX: nil-guard on _orbStorage entry before accessing .spawnTime
				local storageEntry = arg1._orbStorage[v.Name]
				if storageEntry and tick() - storageEntry.spawnTime >= 1.5
					and 10 >= (v.Position - LocalPlayer_upvr.Character:WaitForChild("HumanoidRootPart").Position).Magnitude
					and v:IsDescendantOf(Orbs_upvr)
					and not LocalPlayer_upvr.Character.HumanoidRootPart:FindFirstChild("_orbAttachment"..v.Name) then
					local AlignPosition = Instance.new("AlignPosition")
					AlignPosition.MaxForce = 100000000000000
					AlignPosition.Responsiveness = 75
					AlignPosition.Parent = v
					local Attachment = Instance.new("Attachment")
					local Attachment_2 = Instance.new("Attachment")
					Attachment_2.Name = "_orbAttachment"..v.Name
					AlignPosition.Attachment0 = Attachment
					AlignPosition.Attachment1 = Attachment_2
					Attachment.Parent = v
					Attachment_2.Parent = LocalPlayer_upvr.Character.HumanoidRootPart
					v.Anchored = false
				end
			end
			task.wait(0.08)
		until #Orbs_upvr:GetChildren() == 0
	end)
end

local Assets_upvr = ReplicatedStorage_upvr.Assets

-- Spawn visual orb Parts on the client from server-provided orb data
function any_CreateController_result1.createOrbs(arg1, arg2, arg3)
	local var29 = arg3
	if not var29 then
		var29 = {}
	end
	if not var4_upvw.data then
		return
	end
	for _, var28 in arg2 do
		task.wait(0.15)
		local Part_upvr = Instance.new("Part")
		local clone = Assets_upvr.Billboards.Orb:Clone()
		-- FIX: var28.item is a plain orbId string from OrbService, NOT an Items object.
		-- OrbService sends {orbId, position, item=orbId}. We cannot call :getIcon() on a string.
		-- Use a default orb icon instead; real item icon would require server to send item class data.
		clone.ImageLabel.Image = "rbxassetid://0"
		if var8_upvw and var8_upvw.itemUtils and type(var28.item) == "table" then
			local ok, icon = pcall(function()
				return var8_upvw.itemUtils.createItemFromData(var28.item):getIcon()
			end)
			if ok and icon then
				clone.ImageLabel.Image = icon
			end
		end
		clone.Parent = Part_upvr
		Assets_upvr.VFX.Orb:Clone().Parent = Part_upvr
		Part_upvr.CanQuery = false
		Part_upvr.Shape = Enum.PartType.Ball
		Part_upvr.Size = Vector3.new(2, 2, 2)
		Part_upvr.Transparency = 1
		Part_upvr.Name = var28.orbId
		Part_upvr.Parent = Orbs_upvr
		Part_upvr.CollisionGroup = "orbs"
		local cframe = var29.cframe
		if not cframe then
			cframe = LocalPlayer_upvr.Character.HumanoidRootPart.CFrame
		end
		Part_upvr.CFrame = cframe
		var28.spawnTime = tick()
		arg1._orbStorage[var28.orbId] = var28
		arg1:orbVelocity(Part_upvr)
		task.spawn(function()
			task.wait(math.random(25, 30))
			if Part_upvr:IsDescendantOf(game) then
				local tbl_3 = {}
				tbl_3[1] = Part_upvr.Name
				arg1:collectOrbs(tbl_3)
			end
		end)
		local tbl_2 = {}
		tbl_2.parent = Part_upvr
		tbl_2.volume = 0.3
		tbl_2.playbackSpeed = Random.new():NextNumber(1, 1.1)
		tbl_2.rollOffMinDistance = 5
		tbl_2.rollOffMaxDistance = 30
		tbl_2.rollOffMode = Enum.RollOffMode.LinearSquare
		var5_upvw:play("Orb Spawn", tbl_2)
	end
end

-- Collect orbs: either a specific list (arg2) or all nearby ones
-- FIX 1: removed duplicate nested for-loop (decompiler artifact — two `for _, v_3 in Orbs_upvr:GetChildren()` statements)
-- FIX 2: loop condition changed from `until ... and arg2` (never exits when arg2 is nil)
--         to `until #Orbs_upvr:GetChildren() == 0 or not arg2` so it runs once when called
--         with a specific list, and loops until empty when called without one.
function any_CreateController_result1.collectOrbs(arg1, arg2)
	repeat
		local tbl = {}
		-- If a specific list of orb IDs was given, seed the collect list
		if arg2 ~= nil and typeof(arg2) == "table" then
			for _, v_2 in pairs(arg2) do
				tbl[#tbl + 1] = v_2
			end
		end
		-- Also grab any orbs within proximity (4 studs) that have settled
		for _, v_3 in Orbs_upvr:GetChildren() do
			local orbStorageEntry = arg1._orbStorage[v_3.Name]
			if LocalPlayer_upvr.Character
				and LocalPlayer_upvr.Character:FindFirstChild("HumanoidRootPart")
				and (v_3.Position - LocalPlayer_upvr.Character.HumanoidRootPart.Position).Magnitude <= 4
				and (not orbStorageEntry or not orbStorageEntry.spawnTime or tick() - orbStorageEntry.spawnTime >= 2) then
				tbl[#tbl + 1] = v_3.Name
				local SOME = LocalPlayer_upvr.Character.HumanoidRootPart:FindFirstChild("_orbAttachment"..v_3.Name)
				if SOME then
					SOME:Destroy()
				end
			end
		end
		if #tbl ~= 0 then
			var6_upvw.collectOrbs:Fire(tbl)
			for _, v_4 in pairs(tbl) do
				if Orbs_upvr:FindFirstChild(v_4) then
					Orbs_upvr[v_4]:Destroy()
				end
				var5_upvw:play("Orb Collect", {
					volume = 0.25;
					playbackSpeed = Random.new():NextNumber(1.1, 1.25);
				})
			end
		end
		task.wait(0.01)
	-- FIX: when called with a specific list (arg2 ~= nil) only run one iteration;
	--      when called without arg2 (nil), loop until no orbs remain.
	until #Orbs_upvr:GetChildren() == 0 or arg2 ~= nil
end

local var62_upvw = false

-- Listen for new orbs being added and trigger alignment + collection
function any_CreateController_result1.orbsAdded(arg1)
	task.spawn(function()
		Orbs_upvr.ChildAdded:Connect(function()
			if var62_upvw == false then
				var62_upvw = true
				arg1:alignPosition()
				arg1:collectOrbs()
				var62_upvw = false
			end
		end)
	end)
end

function any_CreateController_result1.KnitStart(arg1)
	task.spawn(function()
		repeat
			task.wait()
		until var4_upvw.data
		arg1:orbsAdded()
	end)
	var6_upvw.createOrbs:Connect(function(...)
		arg1:createOrbs(...)
	end)
end

local var67_upvw
function any_CreateController_result1.KnitInit(arg1)
	var6_upvw = Knit_upvr.GetService("OrbService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("SoundController")
	var67_upvw = Knit_upvr.GetController("UIController")
	var8_upvw = require(ReplicatedStorage_upvr.Shared.Util)
end

return any_CreateController_result1