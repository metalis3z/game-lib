local v0 = {
	AnimationTargetLocation = nil, 
	ItemReceived = Instance.new("BindableEvent"), 
	ItemClaimsComplete = Instance.new("BindableEvent")
};
v0.AddNewItem = function(_, v2, v3, v4)
	v0.ItemReceived:Fire(v2, v3, v4);
end;
return v0;