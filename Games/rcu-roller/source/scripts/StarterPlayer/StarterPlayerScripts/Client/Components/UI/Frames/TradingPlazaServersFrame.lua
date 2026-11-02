-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:30
-- Luau version 6, Types version 3
-- Time taken: 0.002969 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "TradingPlazaServersFrame";
})
local var4_upvw
local var5_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Players_upvr = game:GetService("Players")
local var8_upvw
local var9_upvw
local Holder_upvr = Players_upvr.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("TradingPlazaServersFrame"):WaitForChild("Main"):WaitForChild("List"):WaitForChild("Holder")
function any_new_result1.serverExists(arg1, arg2, arg3) -- Line 39
	for _, v in arg2 do
		if v.key == arg3 then
			return true
		end
	end
end
local Assets_upvr = ReplicatedStorage_upvr.Assets
function any_new_result1.setupFrames(arg1) -- Line 47
	--[[ Upvalues[6]:
		[1]: var5_upvw (read and write)
		[2]: Holder_upvr (readonly)
		[3]: Assets_upvr (readonly)
		[4]: Players_upvr (readonly)
		[5]: var8_upvw (read and write)
		[6]: var9_upvw (read and write)
	]]
	for _, v_2 in Holder_upvr:GetChildren() do
		if v_2:IsA("Frame") and not arg1:serverExists(var5_upvw:getServers(), v_2.Name) then
			v_2:Destroy()
		end
	end
	for _, v_3 in var5_upvw:getServers() do
		local key_upvr = v_3.key
		if not Holder_upvr:FindFirstChild(key_upvr) then
			local var26 = Assets_upvr
			local clone = var26.UI.TradingPlazaServer:Clone()
			local Main = clone.Main
			if game.JobId ~= key_upvr then
				var26 = false
			else
				var26 = true
			end
			Main.State.Join.Visible = not var26
			Main.State.Cannot.Visible = var26
			Main.Members.Text = `{v_3.value.players}/{Players_upvr.MaxPlayers}`
			Main.ServerId.Text = `Server ID: {tonumber(key_upvr:sub(-5), 36) % 10000}`
			clone.Name = key_upvr
			clone.Parent = Holder_upvr
			var8_upvw.new(Main.State):buttonUp(function() -- Line 79
				--[[ Upvalues[3]:
					[1]: key_upvr (readonly)
					[2]: var9_upvw (copied, read and write)
					[3]: var5_upvw (copied, read and write)
				]]
				if game.JobId == key_upvr then
					var9_upvw.print(`Kan inte joina eftersom \xE4r samma server (serverId: {key_upvr})`)
				else
					var5_upvw:teleportToServer(key_upvr)
				end
			end)
		end

	end
end
function any_new_result1.removeFrames(arg1) -- Line 90
	--[[ Upvalues[1]:
		[1]: Holder_upvr (readonly)
	]]
	for _, v_4 in Holder_upvr:GetChildren() do
		if v_4:IsA("Frame") then
			v_4:Destroy()
		end
	end
end
function any_new_result1.update(arg1) -- Line 97
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	if os.time() - (arg1._debounce or 0) < 30 then
	else
		arg1._debounce = os.time()
		if not var4_upvw:isFrameOpen() then return end
		if var4_upvw:getCurrentFrameOpen() ~= "TradingPlazaServersFrame" then return end
		arg1:removeFrames()
		arg1:setupFrames()
	end
end
function any_new_result1.opened(arg1) -- Line 116
	arg1:setupFrames()
end
function any_new_result1.closed(arg1) -- Line 120
	arg1:removeFrames()
end
function any_new_result1.Start(arg1) -- Line 124
	--[[ Upvalues[2]:
		[1]: Knit_upvr (readonly)
		[2]: var4_upvw (read and write)
	]]
	Knit_upvr.listenToUpdate:Connect(function() -- Line 126
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update()
	end)
	arg1._debounce = os.time()
	arg1:opened()
	var4_upvw:listenToOpen("TradingPlazaServersFrame"):Connect(function() -- Line 133
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:opened()
	end)
	var4_upvw:listenToClose("TradingPlazaServersFrame"):Connect(function() -- Line 136
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:closed()
	end)
end
local var38_upvw
local var39_upvw
function any_new_result1.Construct(arg1) -- Line 141
	--[[ Upvalues[8]:
		[1]: var5_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var38_upvw (read and write)
		[4]: var4_upvw (read and write)
		[5]: var39_upvw (read and write)
		[6]: var8_upvw (read and write)
		[7]: var9_upvw (read and write)
		[8]: ReplicatedStorage_upvr (readonly)
	]]
	var5_upvw = Knit_upvr.GetService("TradingPlazaService")
	var38_upvw = Knit_upvr.GetController("DataController")
	var4_upvw = Knit_upvr.GetController("UIController")
	var39_upvw = Knit_upvr.GetController("SoundController")
	var8_upvw = require(Knit_upvr.Modules.Button)
	var9_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
end
return any_new_result1