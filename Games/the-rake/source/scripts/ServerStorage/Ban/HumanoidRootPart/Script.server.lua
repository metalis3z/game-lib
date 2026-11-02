local part = script.Parent
local downForce = -part:GetMass()*workspace.Gravity
local force = -downForce
local bodyForce = Instance.new("BodyForce")
bodyForce.Force = Vector3.new(0,force,0)
bodyForce.Parent = part