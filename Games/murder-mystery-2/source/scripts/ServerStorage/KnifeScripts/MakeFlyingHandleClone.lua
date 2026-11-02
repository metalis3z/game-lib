local function MakeFlyingHandle(Handle, Direction)
	local FlyingHandle = Handle:Clone()
	FlyingHandle.Name = "ThrowingKnife"
	FlyingHandle.Anchored = true;
	FlyingHandle.CanCollide = false;
	FlyingHandle.Transparency = 0
	FlyingHandle.CFrame = CFrame.new(Handle.CFrame.p,Direction.p);
	Instance.new("Vector3Value",FlyingHandle).Name = "VelocityV";
	--FlyingHandle.RotVelocity = FlyingHandle.CFrame:vectorToWorldSpace(Vector3.new(250, 0, 0))
	FlyingHandle.Velocity = Vector3.new();
	FlyingHandle.RotVelocity = Vector3.new();
	
	return FlyingHandle
end

return MakeFlyingHandle