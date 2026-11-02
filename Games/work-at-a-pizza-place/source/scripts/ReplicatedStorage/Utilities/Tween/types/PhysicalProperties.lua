return function(a, b, t)
	return PhysicalProperties.new(
		(b.Density - a.Density)*t + a.Density,
		(b.Friction - a.Friction)*t + a.Friction,
		(b.Elasticity - a.Elasticity)*t + a.Elasticity,
		(b.FrictionWeight - a.FrictionWeight)*t + a.FrictionWeight,
		(b.ElasticityWeight - a.ElasticityWeight)*t + a.ElasticityWeight
	)
end