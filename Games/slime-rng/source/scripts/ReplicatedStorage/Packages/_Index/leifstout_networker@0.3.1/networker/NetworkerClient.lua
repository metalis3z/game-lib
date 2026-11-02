-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: NetworkerClient, time of decompilation: Sun May  3 10:10:38 2026 ]]
local RunService = game:GetService("RunService")
local ParentParent = script.Parent.Parent
local Signal = require(ParentParent.Signal)
local NetworkerUtils = require(script.Parent.NetworkerUtils)
local t1 = {}

t1.__index = t1

function t1.new(p1, t2: {[any]: any}) -- line: 34
	-- upvalues: RunService (copy), t1 (copy), NetworkerUtils (copy)
	assert(RunService:IsClient(), "NetworkerClient can only be created on the client")

	local t3 = {
		networkTag = p1,
		changedSignals = {}
	}

	setmetatable(t3, t1)

	if not RunService:IsRunning() then
		return t3
	end

	if typeof(p1) == "Instance" then
		local NetworkerUtilsINSTANCE_ATTRIBUTE = p1:GetAttribute(NetworkerUtils.INSTANCE_ATTRIBUTE)

		if not NetworkerUtilsINSTANCE_ATTRIBUTE then
			p1:GetAttributeChangedSignal(NetworkerUtils.INSTANCE_ATTRIBUTE):Wait()
			NetworkerUtilsINSTANCE_ATTRIBUTE = p1:GetAttribute(NetworkerUtils.INSTANCE_ATTRIBUTE)
		end

		assert(NetworkerUtilsINSTANCE_ATTRIBUTE, "NetworkerClient instance does not have a networkTag attribute")
		t3.networkTag = NetworkerUtilsINSTANCE_ATTRIBUTE
	end

	local t3networkTag = script.Parent:WaitForChild("_remotes"):WaitForChild(t3.networkTag)

	t3.remotes = t3networkTag
	t3networkTag.Destroying:Once(function() -- line: 62
		-- upvalues: t3 (copy)
		t3:destroy()
	end)
	t3networkTag.RemoteEvent.OnClientEvent:Connect(function(s1: string, s2: string, ...) -- line: 66
		-- upvalues: NetworkerUtils (copy), t2 (copy), t3 (copy), t3networkTag (copy)
		if s1 == NetworkerUtils.SET_TAG then
			t2[s2] = ...

			if t3.changedSignals[s2] then
				t3.changedSignals[s2]:Fire(t2[s2])
			end

			return
		end

		assert(t2[s1], "Method " .. s1 .. " does not exist on networkTag " .. t3networkTag.Name)
		t2[s1](t2, s2, ...)
	end)

	return t3
end
function t1.getServerChangedSignal(p2, s3: string) -- line: 87
	-- upvalues: Signal (copy)
	if not p2.changedSignals[s3] then
		p2.changedSignals[s3] = Signal.new()
	end

	return p2.changedSignals[s3]
end
function t1.fire(p3, s4: string, ...) -- line: 101
	-- upvalues: RunService (copy)
	if RunService:IsRunning() then
		p3.remotes.RemoteEvent:FireServer(s4, ...)
	end
end
function t1.fetch(p4, s5: string, ...) -- line: 114
	-- upvalues: RunService (copy)
	if not RunService:IsRunning() then
		return nil
	end

	return p4.remotes.RemoteFunction:InvokeServer(s5, ...)
end
function t1.destroy(p5) -- line: 126
	if p5.remotes then
		p5.remotes:Destroy()
	end

	for _, v19 in p5.changedSignals do
		v19:Destroy()
	end

	if p5.instanceConn then
		p5.instanceConn:Disconnect()
	end
end

return t1
