-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Reference, time of decompilation: Sun May  3 10:09:27 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t1 = {
	objectName = "TopbarPlusReference"
}

function t1.addToReplicatedStorage() -- line: 10
	-- upvalues: ReplicatedStorage (copy), t1 (copy)
	if ReplicatedStorage:FindFirstChild(t1.objectName) then
		return false
	end

	local ObjectValue = Instance.new("ObjectValue")

	ObjectValue.Name = t1.objectName
	ObjectValue.Value = script.Parent
	ObjectValue.Parent = ReplicatedStorage

	return ObjectValue
end
function t1.getObject() -- line: 22
	-- upvalues: ReplicatedStorage (copy), t1 (copy)
	local t1objectName = ReplicatedStorage:FindFirstChild(t1.objectName)

	if t1objectName then
		return t1objectName
	end

	return false
end

return t1
