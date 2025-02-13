if SERVER then

	AddCSLuaFile("autorun/fishing_mod_init.lua")
	AddCSLuaFile("fishing_mod/sh_init.lua")
	AddCSLuaFile("fishing_mod/cl_init.lua")
	AddCSLuaFile("fishing_mod/cl_networking.lua")
	AddCSLuaFile("fishing_mod/cl_shop_menu.lua")
	include("fishing_mod/sv_init.lua")
	
	--Moved to ClassicBox Misc and Materials
	--resource.AddFile("sound/fishingrod/reel.wav")
	
else

	include("fishing_mod/cl_init.lua")
	concommand.Add("fishing_mod_menu", function() 
		fishingmod.UpgradeMenu = vgui.Create('Fishingmod:ShopMenu') fishingmod.UpgradeMenu:SetVisible(true) 
	end)

end

include("fishing_mod/sh_init.lua")