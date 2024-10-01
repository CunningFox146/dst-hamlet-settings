name = "Hamlet Options"
description = "Adds options to turn on skill tree and farming in Hamlet"
author = "CunningFox146"
version = "1.0.1"

forumthread = ""

api_version = 10
priority = -80085

dst_compatible = true
all_clients_require_mod = false
server_only_mod = false

icon_atlas = "modicon.xml"
icon = "modicon.tex"

mod_dependencies = {
    {
        workshop = "workshop-3322803908",
    },
}

configuration_options =
{
	{
	    name = "SKILLTREE",
	    label = "Skill trees",
	    options = {
	    	{description = "On", data = true},
	    	{description = "Off", data = false},
	    },
	    default = true,
	    hover = "Bring back skill trees",
	},

	{
	    name = "FARMING",
	    label = "Farming",
	    options = {
	    	{description = "On", data = true},
	    	{description = "Off", data = false},
	    },
	    default = true,
	    hover = "Bring back updated farming",
	},
	
	{
	    name = "FIX_RECIPES",
	    label = "DST recipies",
	    options = {
	    	{description = "On", data = true},
	    	{description = "Off", data = false},
	    },
	    default = true,
	    hover = "Bring back DST recipies and change their ingredients",
	},
	
	{
	    name = "PICKUP_SOUNDS",
	    label = "Pickup Sounds",
	    options = {
	    	{description = "On", data = true},
	    	{description = "Off", data = false},
	    },
	    default = true,
	    hover = "Bring back DST pickup sounds",
	},
}