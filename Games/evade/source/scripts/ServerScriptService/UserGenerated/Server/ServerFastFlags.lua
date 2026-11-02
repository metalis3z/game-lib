local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local FastFlags = {}
FastFlags.__index = FastFlags

local replicatedFlags = {}

local function validate(value, assertFn, default)
	if assertFn then
		local ok, err = pcall(assertFn, value)
		if not ok then
			warn("[FastFlags] Replicated value failed assert, using default:", default, "Error:", err)
			return default
		end
	end
	return value
end

function FastFlags.Replicated(name, assertFn, default)
	if replicatedFlags[name] then
		return replicatedFlags[name]
	end

	local flag = {
		Name = name,
		Default = default,
		Value = default
	}

	function flag:Get()
		return self.Value
	end

	function flag:Update(value)
		self.Value = validate(value, assertFn, self.Default)
	end

	local remoteName = "FastFlag_" .. name
	local remote = ReplicatedStorage:FindFirstChild(remoteName)
	if remote and remote:IsA("RemoteEvent") then
		remote.OnClientEvent:Connect(function(newValue)
			flag:Update(newValue)
			print("[FastFlags] Updated replicated flag:", name, "->", flag.Value)
		end)
	end

	replicatedFlags[name] = flag
	return flag
end

function FastFlags.GetAll()
	local t = {}
	for name, flag in pairs(replicatedFlags) do
		t[name] = flag:Get()
	end
	return t
end

return FastFlags
