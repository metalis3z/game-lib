-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local t = {}
local t2 = {
	ModelAdded = require(ReplicatedStorage.Library.Modules.Packages.Signal).new(),
	ApplyModelHidden = function(p1, p2) --[[ ApplyModelHidden | Line: 22 | Upvalues: Asserts (copy) ]]
		Asserts.Model(p1)
		Asserts.boolean(p2)

		for i, v in ipairs(p1:GetDescendants()) do
			if v:IsA("BasePart") then
				v.LocalTransparencyModifier = if p2 then 1 else 0
			end
		end
	end,
	ResolveModel = function(p1) --[[ ResolveModel | Line: 33 | Upvalues: Asserts (copy), Workspace (copy) ]]
		Asserts.string(p1)

		local v1 = Workspace:FindFirstChild(p1)

		if v1 == nil then
			return nil
		end

		assert(v1:IsA("Model"), (("Workspace area egg %* must be a Model"):format(p1)))

		return v1
	end
}

function t2.SetHidden(p1, p2) --[[ SetHidden | Line: 43 | Upvalues: Asserts (copy), t (copy), Workspace (copy), t2 (copy) ]]
	Asserts.string(p1)
	Asserts.boolean(p2)

	if p2 then
		t[p1] = true
	else
		t[p1] = nil
	end

	for i, v in ipairs(Workspace:GetChildren()) do
		if v.Name == p1 and v:IsA("Model") then
			t2.ApplyModelHidden(v, p2)
		end
	end
end
function t2.Start() --[[ Start | Line: 59 | Upvalues: Workspace (copy), t (copy), t2 (copy) ]]
	Workspace.ChildAdded:Connect(function(p1) --[[ Line: 60 | Upvalues: Workspace (ref), t (ref), t2 (ref) ]]
		if not p1:IsA("Model") or p1.Parent ~= Workspace then
			return
		end

		if t[p1.Name] == true then
			t2.ApplyModelHidden(p1, true)
		end

		t2.ModelAdded:Fire(p1)
	end)
end

return table.freeze(t2)