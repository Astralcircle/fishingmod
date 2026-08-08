fishingmod.AddCatch{
	friendly = "Personality Core",
	type = "fishing_mod_catch_cores",
	rareness = 2500,
	yank = 0,
	mindepth = 400,
	maxdepth = 20000,
	expgain = 80,
	levelrequired = 20,
	remove_on_release = false,
	value = 100,
	bait = {
		"models/hunter/misc/sphere1x1.mdl",
	}
}

local ENT = {}

ENT.Type = "anim"
ENT.Base = "fishing_mod_base"

if SERVER then

	function ENT:Initialize()

		self:SetModel("models/hunter/misc/sphere075x075.mdl")
		self:SetColor(Color(55, 0, 255))
		self:PhysicsInit(SOLID_VPHYSICS)
	end

end

scripted_ents.Register(ENT, "fishing_mod_catch_cores", true)
