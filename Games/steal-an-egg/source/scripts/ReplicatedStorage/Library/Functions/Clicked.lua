-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local t = {}
local v1 = false

local function create(p1, p2) --[[ create | Line: 5 | Upvalues: t (copy) ]]
	local v1 = p2:lower()

	if v1 ~= "mouse1down" and (v1 ~= "mouse1up" and (v1 ~= "mouse1click" and (v1 ~= "mouse2down" and (v1 ~= "mouse2up" and v1 ~= "mouse2click")))) then
		error("Functions.Clicked - \"" .. v1 .. "\" is an invalid event type. Check spelling!")
	end

	local v2 = t[p1]

	if not v2 then
		v2 = {}
		t[p1] = v2
	end

	local v3 = v2[v1]

	if v3 then
		return v3
	end

	local v4 = Instance.new("BindableEvent")

	v2[v1] = v4

	return v4
end

local function fire(p1) --[[ fire | Line: 31 | Upvalues: Players (copy), t (copy) ]]
	local v1 = p1:lower()
	local Target = Players.LocalPlayer:GetMouse().Target
	local v2 = if Target.ClassName == "Folder" then true elseif Target.ClassName == "Model" then true else false

	if not (Target and Target.Parent) then
		return
	end

	for k, v in pairs(t) do
		if v2 and (k.ClassName == "Folder" or k.ClassName == "Model") and Target:IsDescendantOf(k) then
			if v[v1] then
				v[v1]:Fire()

				return
			end

			continue
		end

		if Target == k and v[v1] then
			v[v1]:Fire()

			return
		end
	end
end

local function init() --[[ init | Line: 53 | Upvalues: v1 (ref), Players (copy), fire (copy) ]]
	v1 = true

	local v12 = Players.LocalPlayer:GetMouse()

	v12.Button1Down:Connect(function() --[[ Line: 56 | Upvalues: fire (ref), v12 (copy) ]]
		fire("mouse1down")
		v12.Button1Up:Wait()
		fire("mouse1click")
	end)
	v12.Button1Up:Connect(function() --[[ Line: 61 | Upvalues: fire (ref) ]]
		fire("mouse1up")
	end)
	v12.Button2Down:Connect(function() --[[ Line: 64 | Upvalues: fire (ref), v12 (copy) ]]
		fire("mouse2down")
		v12.Button2Up:Wait()
		fire("mouse2click")
	end)
	v12.Button2Up:Connect(function() --[[ Line: 69 | Upvalues: fire (ref) ]]
		fire("mouse2up")
	end)
end

return function(p1, p2) --[[ Line: 74 | Upvalues: v1 (ref), init (copy), create (copy) ]]
	if v1 then
		return create(p1, p2 or "mouse1click")
	end

	init()

	return create(p1, p2 or "mouse1click")
end