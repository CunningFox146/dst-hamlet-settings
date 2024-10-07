
local AddRecipePostInit = AddRecipePostInit
local AddRecipePostInitAny = AddRecipePostInitAny
local AddPrefabPostInit = AddPrefabPostInit
local AddSimPostInit = AddSimPostInit
local AddPlayerPostInit = AddPlayerPostInit

local SKILLTREES_ENABLED = GetModConfigData("SKILLTREE")
local FARMING_ENABLED = GetModConfigData("FARMING")
local FIX_RECIPES = GetModConfigData("FIX_RECIPES")
local PICKUP_SOUNDS = GetModConfigData("PICKUP_SOUNDS")

GLOBAL.setfenv(1, GLOBAL)

local TechTree = require("techtree")

-- all references to package are still pointing to the old reference
-- so if we don't to break every file which references those modules
-- we'll just replace all old member references with re-imported ones
local function ResetPackageMembers(package_path)
    local defs = require(package_path)
    package.loaded[package_path] = nil
    local new_defs = require(package_path)

    for k, v in pairs(defs) do
        defs[k] = new_defs[k]
    end
end

local enable_recipe = function(recipe) recipe.disabled_worlds = nil end
local disable_recipe = function(recipe) recipe.level = TechTree.Create(TECH.LOST) end

if FARMING_ENABLED then
    local FARMING_RECIPES = {
        "farm_plow_item",
        "seedpouch",
        "compostingbin",
        "farm_hoe",
        "golden_farm_hoe",
        "soil_amender",
        "wateringcan",
        "trophyscale_oversizedveggies",
        "plantregistryhat",
        "trophyscale_oversizedveggies",
        "tillweedsalve",
        "premiumwateringcan",
    }
    
    local FARMING_DISABLE_RECIPES = {
        "slow_farmplot",
        "fast_farmplot"
    }

    for i, recipe in ipairs(FARMING_RECIPES) do
        AddRecipePostInit(recipe, enable_recipe)
    end

    for i, recipe in ipairs(FARMING_DISABLE_RECIPES) do
        AddRecipePostInit(recipe, disable_recipe)
    end
    
    AddRecipePostInit("nutrientsgoggleshat", function(recipe)
        recipe.level = TechTree.Create(TECH.MAGIC_ONE)
    end)

    AddPrefabPostInit("wateringcan", function(inst)
        if inst.components.fillable then
            inst.components.fillable.acceptsoceanwater = true
        end
    end)
end

if SKILLTREES_ENABLED then
    ResetPackageMembers("prefabs/skilltree_defs")
    ResetPackageMembers("widgets/skilltreetoast")
end

if FIX_RECIPES then
    local INGREDIENTS_FIX_LOOKUP = {
        {target = "horrorfuel", ingredient = "infused_iron", ratio = 0.5},
        {target = "dreadstone", ingredient = "infused_iron", ratio = 0.5},
        {target = "purebrilliance", ingredient = "infused_iron", ratio = 0.5},

        {target = "moonrocknugget", ingredient = "iron", ratio = 1},
        {target = "marble", ingredient = "iron", ratio = 1.5},
        {target = "moonglass", ingredient = "iron", ratio = 3},

        {target = "thulecite", ingredient = "alloy", ratio = 1},
        {target = "thulecite_pieces", ingredient = "alloy", ratio = 0.25},

        --{target = "lightninggoathorn", ingredient = "bill_quill", ratio = 2.5},
        {target = "beefalowool", ingredient = "silk", ratio = 2.25},
        {target = "goose_feather", ingredient = "feather_thunder", ratio = 2.25},
        {target = "moonbutterflywings", ingredient = "butterflywings", ratio = 2},
        {target = "driftwood_log", ingredient = "cork", ratio = 3},
        {target = "tentaclespots", ingredient = "snakeskin", ratio = 2},
        {target = "turf_marsh", ingredient = "compost", ratio = 2},
        {target = "oceanfish_small_9_inv", ingredient = "pondfish", ratio = 1},
        {target = "wagpunk_bits", ingredient = "gears", ratio = 2},
        {target = "manrabbit_tail", ingredient = "silk", ratio = 3},
        {target = "slurtleslime", ingredient = "venomgland", ratio = 0.75},
        {target = "cookiecuttershell", ingredient = "weevole_carapace", ratio = 2.5},
        {target = "saltrock", ingredient = "snake_bone", ratio = 1},
        --{target = "coontail", ingredient = "snakeskin", ratio = 3},
        {target = "malbatross_beak", ingredient = "hippo_antler", ratio = 2},
        {target = "glommerfuel", ingredient = "nectar_pod", ratio = 10},
    }

    local function CalculateAmount(amount, ratio)
        return math.max(1, math.floor(amount * ratio + 0.5))
    end

    AddRecipePostInitAny(function(recipe)
        for i, ingredient in ipairs(recipe.ingredients) do
            for k, lookup in ipairs(INGREDIENTS_FIX_LOOKUP) do
                if ingredient.type == lookup.target then
                    -- recalling constructor is a shitty idea <---- nerd
                    ingredient._ctor(ingredient, lookup.ingredient, CalculateAmount(ingredient.amount, lookup.ratio))
                end
            end
        end
    end)

    local ENABLE_RECIPES = {
        "beefalohat",
        "turf_carpetfloor",
        --"boatpatch",
        "carnivaldecor_figure",
        "pocket_scale",
        "sunkenchest",
        "scarecrow",
        --"boatpatch_kelp",
        "wateringcan",
        "purplemooneye",
        "trophyscale_oversizedveggies",
        --"beefalo_groomer",
        --"brush",
        --"seedpouch",
        --"compostingbin",
        --"boat_grass_item",
        --"farm_hoe",
        "portablecookpot",
        "whip",
        "sewing_mannequin",
        "yotc_carrat_race_checkpoint",
        --"bearger_fur",
        "mermhead",
        "scrap_monoclehat",
        --"slow_farmplot",
        "heatrock",
        --"earmuffshat",
        "cookiecutterhat",
        "icehat",
        --"rabbithouse",
        --"malbatross_feathered_weave",
        "yotc_carrat_gym_direction",
        "turf_carpetfloor2",
        "armorslurper",
        "yotc_carrat_gym_reaction",
        --"kelphat",
        "carnivalgame_shooting_station",
        --"plantregistryhat",
        "carnival_plaza",
        --"hawaiianshirt",
        "carnivalgame_memory_station",
        --"fast_farmplot",
        "merm_tool",
        "mermarmorupgradedhat",
        "carnivaldecor_banner",
        "mermarmorhat",
        --"catcoonhat",
        "scraphat",
        "eyeturret",
        "oar_monkey",
        "shieldofterror",
        "eyemaskhat",
        "thurible",
        "treegrowthsolution",
        "yellowmooneye",
        "armorskeleton",
        "spiderhat",
        --"hivehat",
        "turf_mosaic_grey",
        "alterguardianhat",
        --"pighead",
        "winona_teleport_pad",
        "beehat",
        --"shadow_forge",
        --"lunar_forge",
        --"dock_woodposts",
        --"boat_cannon",
        --"boat_bumper_yotd",
        --"winterhat",
        --"boat_bumper_kelp",
        --"boat_rotator",
        --"boat_magnet",
        --"watermelonhat",
        --"ocean_trawler",
        "kitcoonden",
        --"healingsalve_acid",
        --"oar",
        "kitcoondecor1",
        --"raincoat",
        "turf_mosaic_red",
        "yotc_carrat_gym_stamina",
        "yotc_carrat_gym_speed",
        "carnival_prizebooth",
        "yotc_carrat_race_start",
        "opalstaff",
        --"portablespicer",
        "orangemooneye",
        "bluemooneye",
        --"mast_malbatross",
        --"mast_broken",
        --"anchor",
        --"steeringwheel",
        "greenmooneye",
        "portableblender",
        "yotc_carrat_race_finish",
        --"supertacklecontainer",
        "wall_stone_2_item",
        --"punchingbag_shadow",
        --"farm_plow_item",
        "wall_ruins_2_item",
        --"mastupgrade_lightningrod",
        --"mastupgrade_lamp_yotd",
        "turf_dragonfly",
        "mastupgrade_lamp",
        "megaflare",
        "golden_farm_hoe",
        "succulent_potted",
        "carnivalgame_herding_station",
        "armormarble",
        "carnivalgame_feedchicks_station",
        "carnivalcannon_sparkle",
        "carnivaldecor_lamp",
        "carnivaldecor_eggride2",
        "carnivaldecor_figure_season2",
        "carnivaldecor_plant",
        "security_pulse_cage_full",
        "potatosack",
        "sweatervest",
        "rainhat",
        --"beef_bell",
        --"oceanfishingrod",
        "carnivalgame_wheelspin_station",
        "book_gardening",
        --"beemine",
        "kitcoondecor2",
        --"saddle_war",
        --"boat_bumper_shell",
        "record",
        "yotb_post",
        "tillweedsalve",
        "deerclopseyeball_sentryward",
        "saddlehorn",
        "punchingbag",
        "nightstick",
        --"carnivalcannon_streamer",
        --"carnivaldecor_eggride1",
        "sentryward",
        --"soil_amender",
        --"coldfire",
        "phonograph",
        "pumpkin_lantern",
        "trunkvest_winter",
        --"mast",
        --"sculptingtable",
        --"oar_driftwood",
        "mermthrone",
        --"trunkvest_summer",
        --"blowdart_yellow",
        "turf_checkerfloor",
        --"winterometer",
        --"featherhat",
        --"reflectivevest",
        "turf_mosaic_blue",
        "punchingbag_lunar",
        --"marblebean",
        --"tacklecontainer",
        --"researchlab4",
        --"goggleshat",
        --"pottedfern",
        --"saddle_basic",
        --"archive_resonator",
        --"trophyscale_fish",
        --"seafaring_prototyper",
        "terrariumchest",
        "wall_scrap_item",
        "skeletonhat",
        "moondial",
        "yotc_carrat_scale",
        --"pighouse",
        "carnivaldecor_eggride4",
        "carnivalgame_puckdrop_station",
        "carnivalcannon_confetti",
        "merm_tool_upgraded",
        --"saltlick",
        "moonrockcrater",
        --"saddle_race",
        --"beebox",
        "carnivaldecor_eggride3",
        --"coldfirepit",
        --"boat_bumper_kelp_kit",
        --"premiumwateringcan",
        "wall_moonrock_item",
        --"tacklestation",
        "saltbox",
        --"saltlick_improved",
        "bedroll_furry",
        "redmooneye",
        "featherfan",
        --"ocean_trawler_kit",
        --"fish_box",
        --"rope_bridge_kit",
    }

    for i, recipe in ipairs(ENABLE_RECIPES) do
        AddRecipePostInit(recipe, enable_recipe)
    end
end

if PICKUP_SOUNDS then
    local ORIGINAL_SOUNDS = deepcopy(PICKUPSOUNDS)

    AddPlayerPostInit(function(inst)
        inst:DoTaskInTime(1, function()
            PICKUPSOUNDS = ORIGINAL_SOUNDS
        end)
    end)
end