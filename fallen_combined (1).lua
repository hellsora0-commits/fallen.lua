-- Target Armor Hotbar | premium UI edition
-- armor only + draggable + clean UI + border color/rainbow + glow + hover + rarity + HP bar + target pulse

local TAB_ID = "Fallen"

local ARMOR_MAP = {
    ["Armor_153"] = "Cloth Head Wrap",
    ["Armor_115"] = "Cloth Shirt",
    ["Armor_116"] = "Cloth Pants",
    ["Armor_156"] = "Cloth Handwraps",
    ["Armor_117"] = "Cloth Footwraps",

    ["Armor_124"] = "Wooden Chestplate",
    ["Armor_125"] = "Wooden Leggings",
    ["Armor_123"] = "Wooden Helmet",

    ["Armor_145"] = "Salvaged Helmet",
    ["Armor_146"] = "Salvaged Chestplate",
    ["Armor_147"] = "Salvaged Leggings",
    ["Armor_155"] = "Salvaged Gloves",

    ["Armor_148"] = "Military Helmet",
    ["Armor_149"] = "Military Chestplate",
    ["Armor_150"] = "Military Leggings",
    ["Armor_157"] = "Military Gloves",

    ["Armor_271"] = "Altyn Helmet",
    ["Armor_272"] = "Boris Chestplate",

    ["Armor_141"] = "Steel Helmet",
    ["Armor_142"] = "Steel Chestplate",
    ["Armor_143"] = "Steel Leggings",

    ["Armor_158"] = "Leather Gloves",
    ["Armor_113"] = "Shorts",
    ["Armor_59"] = "Hoodie",
    ["Armor_63"] = "Pants",
    ["Armor_60"] = "Hazmat Suit",
    ["Armor_111"] = "Boots",
    ["Armor_121"] = "Boots",
    ["Armor_112"] = "Collared Shirt",
    ["Armor_122"] = "Flannel Jacket",
    ["Armor_114"] = "Tank Top",
    ["Armor_159"] = "Wetsuit",
    ["Armor_154"] = "Baseball Cap",
    ["Armor_152"] = "Balaclava",

    ["Armor_223"] = "Bruno's Helmet",
    ["Armor_222"] = "Bruno's Chestplate",
    ["Armor_298"] = "Bone Armor",

    ["Salvaged_Backpack"] = "Salvaged Backpack"
}

local ICON_URLS = {
    ["Bruno's Helmet"] = {
        "https://static.wikia.nocookie.net/fallen-survival-new/images/f/f1/Brunohelmet.png/revision/latest?format=original",
        "https://static.wikia.nocookie.net/fallen-survival-new/images/f/f1/Brunohelmet.png/revision/latest/scale-to-width-down/100?cb=20250108175533"
    },
    ["Bruno's Chestplate"] = {
        "https://static.wikia.nocookie.net/fallen-survival-new/images/6/62/Brunochest.png/revision/latest?format=original",
        "https://static.wikia.nocookie.net/fallen-survival-new/images/6/62/Brunochest.png/revision/latest/scale-to-width-down/100?cb=20250108175253"
    },
    ["Altyn Helmet"] = {
        "https://static.wikia.nocookie.net/fallen-survival-new/images/7/7f/Borishelmet.png/revision/latest?format=original",
        "https://static.wikia.nocookie.net/fallen-survival-new/images/7/7f/Borishelmet.png/revision/latest/scale-to-width-down/100?cb=20250108175818"
    },
    ["Boris Chestplate"] = {
        "https://static.wikia.nocookie.net/fallen-survival-new/images/f/fb/Borischest.png/revision/latest?format=original",
        "https://static.wikia.nocookie.net/fallen-survival-new/images/f/fb/Borischest.png/revision/latest/scale-to-width-down/100?cb=20250108175533"
    },

    ["Hoodie"] = {
        "https://static.wikia.nocookie.net/fallen-survival-new/images/9/95/Hoodie.png/revision/latest?format=original",
        "https://static.wikia.nocookie.net/fallen-survival-new/images/9/95/Hoodie.png/revision/latest/scale-to-width-down/100?cb=20250108171940"
    },
    ["Pants"] = {
        "https://static.wikia.nocookie.net/fallen-survival-new/images/7/7c/Pants1.png/revision/latest?format=original",
        "https://static.wikia.nocookie.net/fallen-survival-new/images/7/7c/Pants1.png/revision/latest?cb=20250108173612"
    },
    ["Boots"] = {
        "https://static.wikia.nocookie.net/fallen-survival-new/images/5/59/Boots.png/revision/latest?format=original",
        "https://static.wikia.nocookie.net/fallen-survival-new/images/5/59/Boots.png/revision/latest/scale-to-width-down/100?cb=20250108173821"
    },

    ["Steel Helmet"] = {
        "https://static.wikia.nocookie.net/fallen-survival-new/images/4/49/Steel_Helmet.png/revision/latest?format=original",
        "https://static.wikia.nocookie.net/fallen-survival-new/images/4/49/Steel_Helmet.png/revision/latest/scale-to-width-down/100?cb=20250108133300"
    },
    ["Steel Chestplate"] = {
        "https://static.wikia.nocookie.net/fallen-survival-new/images/3/3b/Steelchest.png/revision/latest?format=original",
        "https://static.wikia.nocookie.net/fallen-survival-new/images/3/3b/Steelchest.png/revision/latest/scale-to-width-down/100?cb=20250108174335"
    },
    ["Steel Leggings"] = {
        "https://static.wikia.nocookie.net/fallen-survival-new/images/d/d6/Steellegs.png/revision/latest?format=original",
        "https://static.wikia.nocookie.net/fallen-survival-new/images/d/d6/Steellegs.png/revision/latest/scale-to-width-down/100?cb=20250108174457"
    },

    ["Military Gloves"] = {
        "https://static.wikia.nocookie.net/fallen-survival-new/images/a/a8/Salvagedgloves.png/revision/latest?format=original",
        "https://static.wikia.nocookie.net/fallen-survival-new/images/a/a8/Salvagedgloves.png/revision/latest/scale-to-width-down/100?cb=20250108175140"
    },
    ["Military Helmet"] = {
        "https://static.wikia.nocookie.net/fallen-survival-new/images/9/9f/Militaryhelmet.png/revision/latest?format=original",
        "https://static.wikia.nocookie.net/fallen-survival-new/images/9/9f/Militaryhelmet.png/revision/latest/scale-to-width-down/100?cb=20250108174723"
    },
    ["Military Chestplate"] = {
        "https://static.wikia.nocookie.net/fallen-survival-new/images/c/c6/Militarychest.png/revision/latest?format=original",
        "https://static.wikia.nocookie.net/fallen-survival-new/images/c/c6/Militarychest.png/revision/latest/scale-to-width-down/100?cb=20250108174935"
    },
    ["Military Leggings"] = {
        "https://static.wikia.nocookie.net/fallen-survival-new/images/7/70/Militarylegs.png/revision/latest?format=original",
        "https://static.wikia.nocookie.net/fallen-survival-new/images/7/70/Militarylegs.png/revision/latest/scale-to-width-down/100?cb=20250108174723"
    },

    ["Cloth Head Wrap"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/4/49/Clothhelmet.png/revision/latest?format=original" },
    ["Cloth Shirt"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/8/8d/Clothshirt.png/revision/latest?format=original" },
    ["Cloth Pants"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/6/61/Clothpants.png/revision/latest?format=original" },
    ["Cloth Footwraps"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/e/e8/Clothboots.png/revision/latest?format=original" },
    ["Cloth Handwraps"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/9/98/Clothgloves.png/revision/latest?format=original" },

    ["Wooden Helmet"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/2/20/Woodhelm.png/revision/latest?format=original" },
    ["Wooden Chestplate"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/8/87/Woodchest.png/revision/latest?format=original" },
    ["Wooden Leggings"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/f/f8/Woodleg.png/revision/latest?format=original" },

    ["Salvaged Helmet"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/4/46/Salvagedhelm.png/revision/latest?format=original" },
    ["Salvaged Chestplate"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/e/e2/Salvagedchest.png/revision/latest?format=original" },
    ["Salvaged Leggings"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/b/be/Salvagedlegs.png/revision/latest?format=original" },
    ["Salvaged Gloves"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/a/a8/Salvagedgloves.png/revision/latest?format=original" },

    ["Leather Gloves"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/6/62/Leathergloves.png/revision/latest?format=original" },
    ["Shorts"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/4/47/Pants.png/revision/latest?format=original" },
    ["Collared Shirt"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/b/ba/Collaredshirt.png/revision/latest?format=original" },
    ["Flannel Jacket"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/2/26/Flanneljacket.png/revision/latest?format=original" },
    ["Tank Top"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/2/2b/Tanktop.png/revision/latest?format=original" },
    ["Baseball Cap"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/9/91/Cap.png/revision/latest?format=original" },
    ["Balaclava"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/2/2a/Balaclava.png/revision/latest?format=original" },
    ["Wetsuit"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/5/5f/Wetsuit.png/revision/latest?format=original" },
    ["Hazmat Suit"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/6/68/Hazmat.png/revision/latest?format=original" },
    ["Bone Armor"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/7/7d/Bonearmour.png/revision/latest?format=original" }
}

local WEAPON_ICON_URLS = {
    ["Altyn Helmet"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/7/7f/Borishelmet.png/revision/latest/scale-to-width-down/100?cb=20250108175818" },
    ["Auto Turret"] = { "https://static.wikia.nocookie.net/play-rust/images/f/f9/Auto_Turret_icon.png/revision/latest?cb=20151106062203" },
    ["Balaclava"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/2/2a/Balaclava.png/revision/latest/scale-to-width-down/100?cb=20250108174723" },
    ["Bandage"] = { "https://static.wikia.nocookie.net/play-rust/images/f/f8/Bandage_icon.png/revision/latest?cb=20151106061541" },
    ["Base Cabinet"] = { "https://static.wikia.nocookie.net/play-rust/images/5/57/Tool_Cupboard_icon.png/revision/latest?cb=20151106061824" },
    ["Baseball Cap"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/9/91/Cap.png/revision/latest/scale-to-width-down/100?cb=20250108174935" },
    ["Bear Trap"] = { "https://www.corrosionhour.com/wp-content/uploads/2021/06/rust-trap-bear-300x300.png" },
    ["Blueberry"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/a/af/Blueberries.png/revision/latest/scale-to-width-down/100?cb=20250108163924" },
    ["Blueprint"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/9/98/Blueprint.png/revision/latest?cb=20250108011413" },
    ["Bone Armor"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/7/7d/Bonearmour.png/revision/latest/scale-to-width-down/100?cb=20250108175533" },
    ["Bone Tool"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/4/4e/Bone_Tool.png/revision/latest?cb=20250111164426" },
    ["Boots"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/5/59/Boots.png/revision/latest/scale-to-width-down/100?cb=20250108173821" },
    ["Boris Chestplate"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/f/fb/Borischest.png/revision/latest/scale-to-width-down/100?cb=20250108175533" },
    ["Boris Helmet"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/7/7f/Borishelmet.png/revision/latest/scale-to-width-down/100?cb=20250108175818" },
    ["Boris's Chestplate"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/f/fb/Borischest.png/revision/latest/scale-to-width-down/100?cb=20250108175533" },
    ["Boulder"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/2/21/Boulder.png/revision/latest?cb=20250407023615" },
    ["Bruno Chestplate"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/6/62/Brunochest.png/revision/latest/scale-to-width-down/100?cb=20250108175253" },
    ["Bruno Helmet"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/f/f1/Brunohelmet.png/revision/latest/scale-to-width-down/100?cb=20250108175533" },
    ["Bruno's Chestplate"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/6/62/Brunochest.png/revision/latest/scale-to-width-down/100?cb=20250108175253" },
    ["Bruno's Helmet"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/f/f1/Brunohelmet.png/revision/latest/scale-to-width-down/100?cb=20250108175533" },
    ["Cactus"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/6/6b/Cactusflesh.png/revision/latest/scale-to-width-down/100?cb=20250108160111" },
    ["Chainsaw"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/c/cc/Chainsaw.png/revision/latest?cb=20250111164731" },
    ["Cloth Footwraps"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/e/e8/Clothboots.png/revision/latest/scale-to-width-down/100?cb=20250108173612" },
    ["Cloth Handwraps"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/9/98/Clothgloves.png/revision/latest/scale-to-width-down/100?cb=20250108175253" },
    ["Cloth Head Wrap"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/4/49/Clothhelmet.png/revision/latest/scale-to-width-down/100?cb=20250108175140" },
    ["Cloth Headwrap"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/4/49/Clothhelmet.png/revision/latest/scale-to-width-down/100?cb=20250108175140" },
    ["Cloth Hoodie"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/9/95/Hoodie.png/revision/latest/scale-to-width-down/100?cb=20250108171940" },
    ["Cloth Pants"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/6/61/Clothpants.png/revision/latest/scale-to-width-down/100?cb=20250108174207" },
    ["Cloth Shirt"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/8/8d/Clothshirt.png/revision/latest/scale-to-width-down/100?cb=20250108200247" },
    ["Collared Shirt"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/b/ba/Collaredshirt.png/revision/latest/scale-to-width-down/100?cb=20250108173822" },
    ["Corn"] = { "https://static.wikia.nocookie.net/play-rust/images/0/0a/Corn_icon.png/revision/latest?cb=20151106061809" },
    ["Crossbow"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/5/51/Crossbow_.png/revision/latest/scale-to-width-down/180?cb=20250108154725" },
    ["Dynamite Bundle"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/b/b3/Dynamite_Bundle.png/revision/latest?cb=20250112104649" },
    ["Dynamite Stick"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/2/20/Dynamite_Stick.png/revision/latest?cb=20250112104836" },
    ["Flannel Jacket"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/2/26/Flanneljacket.png/revision/latest/scale-to-width-down/100?cb=20250108174334" },
    ["Garage Door"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/a/a6/Garage_Door.png/revision/latest?cb=20250111213531" },
    ["Hammer"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/8/81/Hammer.png/revision/latest?cb=20250108004728" },
    ["Hard Hat"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/4/4e/Hardhat.png/revision/latest/scale-to-width-down/100?cb=20250108174723" },
    ["Hazmat Suit"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/6/68/Hazmat.png/revision/latest?cb=20250108173611" },
    ["Hemp"] = { "https://static.wikia.nocookie.net/play-rust/images/c/c9/Hemp_Clone_icon.png/revision/latest?cb=20170122060314" },
    ["Hemp Fiber"] = { "https://static.wikia.nocookie.net/play-rust/images/c/c9/Hemp_Clone_icon.png/revision/latest?cb=20170122060314" },
    ["Hoodie"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/9/95/Hoodie.png/revision/latest/scale-to-width-down/100?cb=20250108171940" },
    ["Iron Shard Hatchet"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/d/d7/Iron_Shard_Hatchet.png/revision/latest?cb=20250111164603" },
    ["Iron Shard Pickaxe"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/d/d0/Iron_Shard_Pickaxe.png/revision/latest?cb=20250111164539" },
    ["Landmine"] = { "https://www.corrosionhour.com/wp-content/uploads/2022/04/rust-trap-landmine-homemade-300x300.png" },
    ["Large Battery"] = { "https://www.corrosionhour.com/wp-content/uploads/2021/06/rust-electric-battery-rechargable-large-300x300.png" },
    ["Large Box"] = { "https://www.corrosionhour.com/wp-content/uploads/2021/06/rust-box-wooden-large-300x300.png" },
    ["Large Medkit"] = { "https://static.wikia.nocookie.net/play-rust/images/9/99/Large_Medkit_icon.png/revision/latest?cb=20151106054425" },
    ["Leather Boots"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/6/6d/Leatherboots.png/revision/latest/scale-to-width-down/100?cb=20250108174207" },
    ["Leather Gloves"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/6/62/Leathergloves.png/revision/latest/scale-to-width-down/100?cb=20250108175140" },
    ["Leather Pants"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/3/3b/Leatherpants.png/revision/latest/scale-to-width-down/100?cb=20250108173822" },
    ["Leather Poncho"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/b/ba/Leatherponcho.png/revision/latest/scale-to-width-down/100?cb=20250108173822" },
    ["Leather Shirt"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/0/0a/Leathertunic.png/revision/latest/scale-to-width-down/100?cb=20250108174207" },
    ["Leather_Pants"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/3/3b/Leatherpants.png/revision/latest/scale-to-width-down/100?cb=20250108173822" },
    ["Lemon"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/3/35/Lemon.png/revision/latest/scale-to-width-down/100?cb=20250108163730" },
    ["Machete"] = { "https://static.wikia.nocookie.net/play-rust/images/3/34/Machete_icon.png/revision/latest?cb=20151106060741" },
    ["Medium Battery"] = { "https://www.corrosionhour.com/wp-content/uploads/2021/06/rust-electric-battery-rechargable-medium-300x300.png" },
    ["Metal"] = { "https://static.wikia.nocookie.net/play-rust/images/2/22/Sulfur_Ore_icon.png/revision/latest?cb=20151106061904" },
    ["Metal Door"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/c/cd/Metal_Door.png/revision/latest?cb=20250112101940" },
    ["Metal Double Door"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/e/e5/Metal_Double_Door.png/revision/latest?cb=20250111213501" },
    ["Metal Node"] = { "https://static.wikia.nocookie.net/play-rust/images/2/22/Sulfur_Ore_icon.png/revision/latest?cb=20151106061904" },
    ["Metal Ore"] = { "https://static.wikia.nocookie.net/play-rust/images/0/0a/Metal_Ore_icon.png/revision/latest?cb=20151106060814" },
    ["MetalNode"] = { "https://static.wikia.nocookie.net/play-rust/images/2/22/Sulfur_Ore_icon.png/revision/latest?cb=20151106061904" },
    ["Metal_Node"] = { "https://static.wikia.nocookie.net/play-rust/images/2/22/Sulfur_Ore_icon.png/revision/latest?cb=20151106061904" },
    ["Military AA12"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/5/57/Military_AA12.png/revision/latest/scale-to-width-down/180?cb=20250109110407" },
    ["Military Backpack"] = { "https://www.corrosionhour.com/wp-content/uploads/2024/01/rust-largebackpack-300x300.png" },
    ["Military Barret"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/2/26/Military_Barrett_.png/revision/latest/scale-to-width-down/180?cb=20250108155608" },
    ["Military Barrett"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/2/26/Military_Barrett_.png/revision/latest/scale-to-width-down/180?cb=20250108155608" },
    ["Military Chestplate"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/c/c6/Militarychest.png/revision/latest/scale-to-width-down/100?cb=20250108174935" },
    ["Military Gloves"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/a/a8/Salvagedgloves.png/revision/latest/scale-to-width-down/100?cb=20250108175140" },
    ["Military Helmet"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/9/9f/Militaryhelmet.png/revision/latest/scale-to-width-down/100?cb=20250108174723" },
    ["Military Leggings"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/7/70/Militarylegs.png/revision/latest/scale-to-width-down/100?cb=20250108174723" },
    ["Military M39"] = { "https://static.wikia.nocookie.net/play-rust/images/3/36/M39_Rifle_icon.png/revision/latest?cb=20190420225317" },
    ["Military M4A1"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/b/b3/Military_M4A1.png/revision/latest/scale-to-width-down/180?cb=20250108152536" },
    ["Military MP7"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/6/69/Military_MP7_.png/revision/latest/scale-to-width-down/180?cb=20250108153052" },
    ["Military PKM"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/a/a6/Military_PKM.png/revision/latest/scale-to-width-down/180?cb=20250108152201" },
    ["Military USP"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/c/c8/Military_USP_.png/revision/latest/scale-to-width-down/180?cb=20250108155646" },
    ["Mining Drill"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/f/f0/Mining_Drill.png/revision/latest?cb=20250111164710" },
    ["Nail Gun"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/6/68/Nail_Gun_.png/revision/latest/scale-to-width-down/180?cb=20250108154650" },
    ["Nailgun"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/6/68/Nail_Gun_.png/revision/latest/scale-to-width-down/180?cb=20250108154650" },
    ["Pants"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/7/7c/Pants1.png/revision/latest?cb=20250108173612" },
    ["Phosphate"] = { "https://static.wikia.nocookie.net/play-rust/images/2/22/Sulfur_Ore_icon.png/revision/latest?cb=20151106061904" },
    ["Pumpkin"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/6/64/Pumpkin.png/revision/latest/scale-to-width-down/100?cb=20250108163605" },
    ["Pumpkin Launcher"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/b/b1/Pumpkin_Launcher_.png/revision/latest?cb=20250108161011" },
    ["Raspberry"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/7/7e/Raspberries.png/revision/latest/scale-to-width-down/100?cb=20250108163842" },
    ["Salvaged AK4"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/a/ab/Fallen_-_Ak47.png/revision/latest/scale-to-width-down/180?cb=20250107194018" },
    ["Salvaged AK47"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/a/ab/Fallen_-_Ak47.png/revision/latest/scale-to-width-down/180?cb=20250107194018" },
    ["Salvaged AK74u"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/a/a5/Salvaged_AK74U_.png/revision/latest/scale-to-width-down/180?cb=20250108153258" },
    ["Salvaged Backpack"] = { "https://www.corrosionhour.com/wp-content/uploads/2024/01/rust-smallbackpack-300x300.png" },
    ["Salvaged Break Action"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/7/78/Salvaged_Break_Action.png/revision/latest/scale-to-width-down/180?cb=20250109110155" },
    ["Salvaged Chestplate"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/e/e2/Salvagedchest.png/revision/latest/scale-to-width-down/100?cb=20250108174457" },
    ["Salvaged Gloves"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/a/a8/Salvagedgloves.png/revision/latest/scale-to-width-down/100?cb=20250108175140" },
    ["Salvaged Helmet"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/4/46/Salvagedhelm.png/revision/latest/scale-to-width-down/100?cb=20250108174457" },
    ["Salvaged Leggings"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/b/be/Salvagedlegs.png/revision/latest/scale-to-width-down/100?cb=20250108175140" },
    ["Salvaged M14"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/5/55/Salvaged_M14_.png/revision/latest/scale-to-width-down/180?cb=20250108155717" },
    ["Salvaged Metal Door"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/d/d4/Salvaged_Metal_Door.png/revision/latest?cb=20250111213231" },
    ["Salvaged P250"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/1/1c/Salvaged_P250.png/revision/latest/scale-to-width-down/180?cb=20250108155928" },
    ["Salvaged Pipe Rifle"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/5/50/Pipe_Rifle.png/revision/latest/scale-to-width-down/180?cb=20250109111303" },
    ["Salvaged Pump Action"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/0/0a/Salvaged_Pump_Action.png/revision/latest/scale-to-width-down/180?cb=20250109110837" },
    ["Salvaged Python"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/2/2d/Salvaged_Python_.png/revision/latest/scale-to-width-down/180?cb=20250108155754" },
    ["Salvaged RPG"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/1/11/Salvaged_RPG_.png/revision/latest?cb=20250108161113" },
    ["Salvaged SMG"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/d/d4/Salvaged_SMG_.png/revision/latest/scale-to-width-down/180?cb=20250108153138" },
    ["Salvaged Shotgun"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/a/a0/Salvaged_Shotgun_.png/revision/latest/scale-to-width-down/180?cb=20250108154605" },
    ["Salvaged Skorpion"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/c/c6/Salvaged_Skorpion_.png/revision/latest/scale-to-width-down/180?cb=20250108153325" },
    ["Salvaged Sniper"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/5/56/Salvaged_Sniper.png/revision/latest/scale-to-width-down/180?cb=20250302204446" },
    ["Shorts"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/4/47/Pants.png/revision/latest/scale-to-width-down/100?cb=20250108174206" },
    ["Shotgun Turret"] = { "https://static.wikia.nocookie.net/play-rust/images/6/6c/Shotgun_Trap_icon.png/revision/latest/scale-to-width-down/268?cb=20170721103159" },
    ["Sleeping Bag"] = { "https://www.corrosionhour.com/wp-content/uploads/2021/06/rust-sleepingbag-300x300.png" },
    ["Small Battery"] = { "https://www.corrosionhour.com/wp-content/uploads/2021/06/rust-electric-battery-rechargable-small-300x300.png" },
    ["Small Box"] = { "https://www.corrosionhour.com/wp-content/uploads/2021/06/rust-box-wooden-300x300.png" },
    ["Small Medkit"] = { "https://static.wikia.nocookie.net/play-rust/images/9/99/Medical_Syringe_icon.png/revision/latest?cb=20151106061059" },
    ["Steel Axe"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/c/ce/Steel_Axe.png/revision/latest?cb=20250111164646" },
    ["Steel Chestplate"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/3/3b/Steelchest.png/revision/latest/scale-to-width-down/100?cb=20250108174335" },
    ["Steel Door"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/6/61/Steel_Door.png/revision/latest?cb=20250112102424" },
    ["Steel Double Door"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/e/ec/Steel_Double_Door.png/revision/latest?cb=20250111213604" },
    ["Steel Helmet"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/4/49/Steel_Helmet.png/revision/latest/scale-to-width-down/100?cb=20250108133300" },
    ["Steel Leggings"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/d/d6/Steellegs.png/revision/latest/scale-to-width-down/100?cb=20250108174457" },
    ["Steel Pickaxe"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/d/d1/Steel_Pickaxe.png/revision/latest?cb=20250111164626" },
    ["Stone"] = { "https://static.wikia.nocookie.net/play-rust/images/8/85/Stones_icon.png/revision/latest?cb=20150405123145" },
    ["Stone Hatchet"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/d/d6/Stone_Hatchet.png/revision/latest?cb=20250111164512" },
    ["Stone Node"] = { "https://static.wikia.nocookie.net/play-rust/images/8/85/Stones_icon.png/revision/latest?cb=20150405123145" },
    ["Stone Ore"] = { "https://static.wikia.nocookie.net/play-rust/images/8/85/Stones_icon.png/revision/latest?cb=20150405123145" },
    ["Stone Pickaxe"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/4/40/Stone_Pickaxe.png/revision/latest?cb=20250111164447" },
    ["Stone Spear"] = { "https://static.wikia.nocookie.net/play-rust/images/0/0a/Stone_Spear_icon.png/revision/latest?cb=20151106061726" },
    ["StoneNode"] = { "https://static.wikia.nocookie.net/play-rust/images/8/85/Stones_icon.png/revision/latest?cb=20150405123145" },
    ["Stone_Node"] = { "https://static.wikia.nocookie.net/play-rust/images/8/85/Stones_icon.png/revision/latest?cb=20150405123145" },
    ["Stones"] = { "https://static.wikia.nocookie.net/play-rust/images/8/85/Stones_icon.png/revision/latest?cb=20150405123145" },
    ["Storage Cabinet"] = { "https://www.corrosionhour.com/wp-content/uploads/2021/06/rust-coffin-storage-300x300.png" },
    ["Sulfur"] = { "https://static.wikia.nocookie.net/play-rust/images/2/22/Sulfur_Ore_icon.png/revision/latest?cb=20151106061904" },
    ["Sulfur Node"] = { "https://static.wikia.nocookie.net/play-rust/images/2/22/Sulfur_Ore_icon.png/revision/latest?cb=20151106061904" },
    ["Sulfur Ore"] = { "https://static.wikia.nocookie.net/play-rust/images/2/22/Sulfur_Ore_icon.png/revision/latest?cb=20151106061904" },
    ["SulfurNode"] = { "https://static.wikia.nocookie.net/play-rust/images/2/22/Sulfur_Ore_icon.png/revision/latest?cb=20151106061904" },
    ["Sulfur_Node"] = { "https://static.wikia.nocookie.net/play-rust/images/2/22/Sulfur_Ore_icon.png/revision/latest?cb=20151106061904" },
    ["Tactical Gloves"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/a/a8/Salvagedgloves.png/revision/latest/scale-to-width-down/100?cb=20250108175140" },
    ["Tank Top"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/2/2b/Tanktop.png/revision/latest/scale-to-width-down/100?cb=20250108173612" },
    ["Timed Charge"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/6/6d/Timed_Charge.png/revision/latest?cb=20250112104716" },
    ["Tomato"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/9/9d/Tomato.png/revision/latest/scale-to-width-down/100?cb=20250108164012" },
    ["Trap Door"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/9/9f/Trap_Door.png/revision/latest?cb=20250112102923" },
    ["Tree"] = { "https://static.wikia.nocookie.net/play-rust/images/f/f2/Wood_icon.png/revision/latest?cb=20151106061551" },
    ["Tree Large"] = { "https://static.wikia.nocookie.net/play-rust/images/f/f2/Wood_icon.png/revision/latest?cb=20151106061551" },
    ["Tree Medium"] = { "https://static.wikia.nocookie.net/play-rust/images/f/f2/Wood_icon.png/revision/latest?cb=20151106061551" },
    ["Tree Small"] = { "https://static.wikia.nocookie.net/play-rust/images/f/f2/Wood_icon.png/revision/latest?cb=20151106061551" },
    ["Tree XL"] = { "https://static.wikia.nocookie.net/play-rust/images/f/f2/Wood_icon.png/revision/latest?cb=20151106061551" },
    ["Wetsuit"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/5/5f/Wetsuit.png/revision/latest?cb=20250108175934" },
    ["Windmill"] = { "https://static.wikia.nocookie.net/play-rust/images/f/f2/Wind_Turbine_icon.png/revision/latest/scale-to-width-down/1000?cb=20151106061147" },
    ["Wire Cutters"] = { "https://static.wikia.nocookie.net/play-rust/images/e/e0/Wire_Tool_icon.png/revision/latest?cb=20230420081635" },
    ["Wooden Bow"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/1/13/Wooden_Bow_.png/revision/latest/scale-to-width-down/180?cb=20250108154800" },
    ["Wooden Chestplate"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/8/87/Woodchest.png/revision/latest/scale-to-width-down/100?cb=20250108174335" },
    ["Wooden Door"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/2/2c/Wooden_Door.png/revision/latest?cb=20250111212634" },
    ["Wooden Double Door"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/a/af/Wooden_Double_Door.png/revision/latest?cb=20250112101523" },
    ["Wooden Helmet"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/2/20/Woodhelm.png/revision/latest/scale-to-width-down/100?cb=20250108174335" },
    ["Wooden Leggings"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/f/f8/Woodleg.png/revision/latest/scale-to-width-down/100?cb=20250108174456" },
    ["Wooden Spear"] = { "https://static.wikia.nocookie.net/fallen-survival-new/images/1/17/Wooden_Spear.png/revision/latest?cb=20250407032830" },
    ["Wool"] = { "https://static.wikia.nocookie.net/play-rust/images/c/c9/Hemp_Clone_icon.png/revision/latest?cb=20170122060314" },
    ["metal_node"] = { "https://static.wikia.nocookie.net/play-rust/images/2/22/Sulfur_Ore_icon.png/revision/latest?cb=20151106061904" },
    ["stone_node"] = { "https://static.wikia.nocookie.net/play-rust/images/8/85/Stones_icon.png/revision/latest?cb=20150405123145" },
    ["sulfur_node"] = { "https://static.wikia.nocookie.net/play-rust/images/2/22/Sulfur_Ore_icon.png/revision/latest?cb=20151106061904" },
}

local WEAPON_ITEMS = {
    ["Blade"] = true,
    ["Blueberries"] = true,
    ["Cactus Flesh"] = true,
    ["Cactus flesh"] = true,
    ["Cactusflesh"] = true,
    ["Chocolate Bar"] = true,
    ["Circuit Board"] = true,
    ["Circuit Boards"] = true,
    ["Circuit board"] = true,
    ["Copper Cogs"] = true,
    ["Duct Tape"] = true,
    ["Fish Can"] = true,
    ["Glue"] = true,
    ["Ligther"] = true,
    ["Metal Plating"] = true,
    ["Metal Scraps"] = true,
    ["Milk"] = true,
    ["Pink Card"] = true,
    ["Pink Keycard"] = true,
    ["Pipe"] = true,
    ["Pistol Receiver"] = true,
    ["Power Cell"] = true,
    ["Power cell"] = true,
    ["Purple Card"] = true,
    ["Purple Keycard"] = true,
    ["Raspberries"] = true,
    ["Red Card"] = true,
    ["Red Keycard"] = true,
    ["Rifle Receiver"] = true,
    ["Rope"] = true,
    ["SMG Receiver"] = true,
    ["SMG receiver"] = true,
    ["Semi Receiver"] = true,
    ["Spring"] = true,
    ["Tape"] = true,
    ["Tarp"] = true,
    ["Thread"] = true,
    ["Yellow Card"] = true,
    ["Yellow Keycard"] = true,
    ["lighter"] = true,
    ["Altyn Helmet"] = true,
    ["Auto Turret"] = true,
    ["Balaclava"] = true,
    ["Bandage"] = true,
    ["Base Cabinet"] = true,
    ["Baseball Cap"] = true,
    ["Bear Trap"] = true,
    ["Blueberry"] = true,
    ["Blueprint"] = true,
    ["Bone Armor"] = true,
    ["Bone Tool"] = true,
    ["Boots"] = true,
    ["Boris Chestplate"] = true,
    ["Boris Helmet"] = true,
    ["Boris's Chestplate"] = true,
    ["Boulder"] = true,
    ["Bruno Chestplate"] = true,
    ["Bruno Helmet"] = true,
    ["Bruno's Chestplate"] = true,
    ["Bruno's Helmet"] = true,
    ["Bruno's M4A1"] = true,
    ["Cactus"] = true,
    ["Chainsaw"] = true,
    ["Cloth Footwraps"] = true,
    ["Cloth Handwraps"] = true,
    ["Cloth Head Wrap"] = true,
    ["Cloth Headwrap"] = true,
    ["Cloth Hoodie"] = true,
    ["Cloth Pants"] = true,
    ["Cloth Shirt"] = true,
    ["Collared Shirt"] = true,
    ["Corn"] = true,
    ["Crossbow"] = true,
    ["Dynamite Bundle"] = true,
    ["Dynamite Stick"] = true,
    ["Flannel Jacket"] = true,
    ["Garage Door"] = true,
    ["Halloween Scythe"] = true,
    ["Hammer"] = true,
    ["Hard Hat"] = true,
    ["Hazmat Suit"] = true,
    ["Hemp"] = true,
    ["Hemp Fiber"] = true,
    ["Hoodie"] = true,
    ["Iron Shard Hatchet"] = true,
    ["Iron Shard Pickaxe"] = true,
    ["Landmine"] = true,
    ["Large Battery"] = true,
    ["Large Box"] = true,
    ["Large Medkit"] = true,
    ["Leather Boots"] = true,
    ["Leather Gloves"] = true,
    ["Leather Pants"] = true,
    ["Leather Poncho"] = true,
    ["Leather Shirt"] = true,
    ["Leather_Pants"] = true,
    ["Lemon"] = true,
    ["Lighter"] = true,
    ["Machete"] = true,
    ["Medium Battery"] = true,
    ["Metal"] = true,
    ["Metal Door"] = true,
    ["Metal Double Door"] = true,
    ["Metal Node"] = true,
    ["Metal Ore"] = true,
    ["MetalNode"] = true,
    ["Metal_Node"] = true,
    ["Military AA12"] = true,
    ["Military Backpack"] = true,
    ["Military Barret"] = true,
    ["Military Barrett"] = true,
    ["Military Chestplate"] = true,
    ["Military Gloves"] = true,
    ["Military Grenade Launcher"] = true,
    ["Military Helmet"] = true,
    ["Military Leggings"] = true,
    ["Military M39"] = true,
    ["Military M4A1"] = true,
    ["Military MP7"] = true,
    ["Military PKM"] = true,
    ["Military USP"] = true,
    ["Mining Drill"] = true,
    ["Nail Gun"] = true,
    ["Nailgun"] = true,
    ["Pants"] = true,
    ["Phosphate"] = true,
    ["Pumpkin"] = true,
    ["Pumpkin Launcher"] = true,
    ["Raspberry"] = true,
    ["Salvaged AK4"] = true,
    ["Salvaged AK47"] = true,
    ["Salvaged AK74u"] = true,
    ["Salvaged Backpack"] = true,
    ["Salvaged Break Action"] = true,
    ["Salvaged Chestplate"] = true,
    ["Salvaged Double Barrel"] = true,
    ["Salvaged Gloves"] = true,
    ["Salvaged Grenade Launcher"] = true,
    ["Salvaged Helmet"] = true,
    ["Salvaged Leggings"] = true,
    ["Salvaged M14"] = true,
    ["Salvaged Metal Door"] = true,
    ["Salvaged P250"] = true,
    ["Salvaged Pipe Rifle"] = true,
    ["Salvaged Pump Action"] = true,
    ["Salvaged Python"] = true,
    ["Salvaged RPG"] = true,
    ["Salvaged SMG"] = true,
    ["Salvaged Shotgun"] = true,
    ["Salvaged Shovel"] = true,
    ["Salvaged Skorpion"] = true,
    ["Salvaged Sniper"] = true,
    ["Saw Bat"] = true,
    ["Shorts"] = true,
    ["Shotgun Turret"] = true,
    ["Sleeping Bag"] = true,
    ["Small Battery"] = true,
    ["Small Box"] = true,
    ["Small Medkit"] = true,
    ["Steel Axe"] = true,
    ["Steel Chestplate"] = true,
    ["Steel Door"] = true,
    ["Steel Double Door"] = true,
    ["Steel Helmet"] = true,
    ["Steel Leggings"] = true,
    ["Steel Pickaxe"] = true,
    ["Steel Shovel"] = true,
    ["Stone"] = true,
    ["Stone Hatchet"] = true,
    ["Stone Node"] = true,
    ["Stone Ore"] = true,
    ["Stone Pickaxe"] = true,
    ["Stone Spear"] = true,
    ["StoneNode"] = true,
    ["Stone_Node"] = true,
    ["Stones"] = true,
    ["Storage Cabinet"] = true,
    ["Sulfur"] = true,
    ["Sulfur Node"] = true,
    ["Sulfur Ore"] = true,
    ["SulfurNode"] = true,
    ["Sulfur_Node"] = true,
    ["Tactical Gloves"] = true,
    ["Tank Top"] = true,
    ["Timed Charge"] = true,
    ["Tomato"] = true,
    ["Trap Door"] = true,
    ["Tree"] = true,
    ["Tree Large"] = true,
    ["Tree Medium"] = true,
    ["Tree Small"] = true,
    ["Tree XL"] = true,
    ["Wetsuit"] = true,
    ["Windmill"] = true,
    ["Wire Cutters"] = true,
    ["Wooden Bow"] = true,
    ["Wooden Chestplate"] = true,
    ["Wooden Door"] = true,
    ["Wooden Double Door"] = true,
    ["Wooden Helmet"] = true,
    ["Wooden Leggings"] = true,
    ["Wooden Spear"] = true,
    ["Wool"] = true,
    ["metal_node"] = true,
    ["stone_node"] = true,
    ["sulfur_node"] = true,
}


local function armor_norm_item_key(s)
    s = tostring(s or "")
    s = string.lower(s)
    s = string.gsub(s, "[^%w]", "")
    return s
end

local WEAPON_ICON_LOOKUP = nil


local WEAPON_ICON_ALIASES = {
    ["AK47"] = "Salvaged AK47",
    ["AK74u"] = "Salvaged AK74u",
    ["M4A1"] = "Military M4A1",
    ["M4"] = "Military M4A1",
    ["P250"] = "Salvaged P250",
    ["Python"] = "Salvaged Python",
    ["SMG"] = "Salvaged SMG",
    ["M14"] = "Salvaged M14",
    ["RPG"] = "Salvaged RPG",
    ["Sniper"] = "Salvaged Sniper",
    ["Skorpion"] = "Salvaged Skorpion",
    ["Shotgun"] = "Salvaged Shotgun",
    ["Pump Action"] = "Salvaged Pump Action",
    ["Pipe Rifle"] = "Salvaged Pipe Rifle",
    ["Double Barrel"] = "Salvaged Double Barrel",
    ["Crossbow"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/5/51/Crossbow_.png/revision/latest/scale-to-width-down/180?cb=20250108154725",
    ["Bow"] = "Wooden Bow",
    ["Nailgun"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/6/68/Nail_Gun_.png/revision/latest/scale-to-width-down/180?cb=20250108154650",
    ["Nail Gun"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/6/68/Nail_Gun_.png/revision/latest/scale-to-width-down/180?cb=20250108154650",
}

local function get_weapon_icon_urls(name)
    if not name then return nil end

    local raw = tostring(name)

    if WEAPON_ICON_ALIASES and WEAPON_ICON_ALIASES[raw] and WEAPON_ICON_URLS[WEAPON_ICON_ALIASES[raw]] then
        return WEAPON_ICON_URLS[WEAPON_ICON_ALIASES[raw]]
    end

    if WEAPON_ICON_URLS[raw] then
        return WEAPON_ICON_URLS[raw]
    end

    if not WEAPON_ICON_LOOKUP then
        WEAPON_ICON_LOOKUP = {}

        for k, v in pairs(WEAPON_ICON_URLS) do
            WEAPON_ICON_LOOKUP[armor_norm_item_key(k)] = v
        end
    end

    local nk = armor_norm_item_key(raw)

    if WEAPON_ICON_LOOKUP[nk] then
        return WEAPON_ICON_LOOKUP[nk]
    end

    -- remove common prefixes/suffixes
    local variants = {
        nk,
        string.gsub(nk, "salvaged", ""),
        string.gsub(nk, "military", ""),
        string.gsub(nk, "improvised", ""),
        string.gsub(nk, "steel", ""),
        string.gsub(nk, "wooden", ""),
        string.gsub(nk, "custom", "")
    }

    for _, var in ipairs(variants) do
        if var ~= "" and WEAPON_ICON_LOOKUP[var] then
            return WEAPON_ICON_LOOKUP[var]
        end
    end

    -- fuzzy search
    for k, v in pairs(WEAPON_ICON_URLS) do
        local kk = armor_norm_item_key(k)

        for _, var in ipairs(variants) do
            if var ~= "" and kk ~= "" then
                if string.find(kk, var, 1, true) or string.find(var, kk, 1, true) then
                    return v
                end
            end
        end
    end

    return nil
end


local RARITY = {
    ["Cloth"]    = {0.75, 0.75, 0.75},
    ["Wooden"]   = {0.65, 0.42, 0.20},
    ["Leather"]  = {0.75, 0.45, 0.22},
    ["Salvaged"] = {0.30, 0.75, 1.00},
    ["Steel"]    = {0.78, 0.82, 0.88},
    ["Military"] = {0.15, 1.00, 0.35},
    ["Altyn"]    = {1.00, 0.25, 0.15},
    ["Boris"]    = {1.00, 0.18, 0.12},
    ["Bruno"]    = {1.00, 0.72, 0.12},
    ["Bone"]     = {0.95, 0.88, 0.68},
    ["Hazmat"]   = {1.00, 0.92, 0.10},
    ["Backpack"] = {0.55, 0.75, 1.00}
}

local icon_state = {}
local WEAPON_DIRECT_ICON_URLS = {
    ["Yellow Card"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/a/a2/Yellow_Keycard.png/revision/latest?format=original",
    ["Thread"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/0/0e/Thread.png/revision/latest?format=original",
    ["Tarp"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/4/4d/Tarp.png/revision/latest?format=original",
    ["Tape"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/0/06/Tape.png/revision/latest?format=original",
    ["Spring"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/c/cf/Spring.png/revision/latest?format=original",
    ["Semi Receiver"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/2/2d/Semi_Receiver.png/revision/latest?format=original",
    ["SMG receiver"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/9/94/SMG_Receiver.png/revision/latest?format=original",
    ["SMG Receiver"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/9/94/SMG_Receiver.png/revision/latest?format=original",
    ["Rope"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/b/b2/Rope.png/revision/latest?format=original",
    ["Rifle Receiver"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/8/80/Rifle_Receiver1.png/revision/latest?format=original",
    ["Red Card"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/4/4e/Red_Keycard.png/revision/latest?format=original",
    ["Raspberries"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/7/7e/Raspberries.png/revision/latest/scale-to-width-down/100?cb=20250108163842",
    ["Purple Card"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/8/87/Purple_Keycard.png/revision/latest?format=original",
    ["Power cell"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/0/09/Power_Cell.png/revision/latest?format=original",
    ["Power Cell"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/0/09/Power_Cell.png/revision/latest?format=original",
    ["Pistol Receiver"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/4/49/Pistol_Receiver.png/revision/latest?format=original",
    ["Pipe"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/6/6e/Pipe.png/revision/latest?format=original",
    ["Pink Card"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/6/68/Pink_Keycard.png/revision/latest?format=original",
    ["Milk"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/4/4d/Milk.png/revision/latest?format=original",
    ["Metal Scraps"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/1/16/Metal_Scraps.png/revision/latest?format=original",
    ["Metal Plating"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/5/5c/Metal_Plating.png/revision/latest?format=original",
    ["Glue"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/e/e7/Glue.png/revision/latest?format=original",
    ["Fish Can"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/7/7e/Fish_Can.png/revision/latest?format=original",
    ["Duct Tape"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/0/06/Tape.png/revision/latest?format=original",
    ["Copper Cogs"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/c/c4/Copper_Cogs.png/revision/latest?format=original",
    ["Circuit board"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/9/9f/Circuit_Boards.png/revision/latest?format=original",
    ["Circuit Boards"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/9/9f/Circuit_Boards.png/revision/latest?format=original",
    ["Chocolate Bar"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/2/28/Chocolate_Bar.png/revision/latest?format=original",
    ["Cactus flesh"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/6/6b/Cactusflesh.png/revision/latest/scale-to-width-down/100?cb=20250108160111",
    ["Blueberries"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/a/af/Blueberries.png/revision/latest/scale-to-width-down/100?cb=20250108163924",
    ["Blade"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/6/6e/Blade.png/revision/latest?format=original",
    ["Lighter"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/c/c4/Lighter.png/revision/latest/scale-to-width-down/55?cb=20250407023539",
    ["Altyn Helmet"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/7/7f/Borishelmet.png/revision/latest/scale-to-width-down/100?cb=20250108175818",
    ["Auto Turret"] = "https://static.wikia.nocookie.net/play-rust/images/f/f9/Auto_Turret_icon.png/revision/latest?cb=20151106062203",
    ["Balaclava"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/2/2a/Balaclava.png/revision/latest/scale-to-width-down/100?cb=20250108174723",
    ["Bandage"] = "https://static.wikia.nocookie.net/play-rust/images/f/f8/Bandage_icon.png/revision/latest?cb=20151106061541",
    ["Base Cabinet"] = "https://static.wikia.nocookie.net/play-rust/images/5/57/Tool_Cupboard_icon.png/revision/latest?cb=20151106061824",
    ["Baseball Cap"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/9/91/Cap.png/revision/latest/scale-to-width-down/100?cb=20250108174935",
    ["Bear Trap"] = "https://www.corrosionhour.com/wp-content/uploads/2021/06/rust-trap-bear-300x300.png",
    ["Blueberry"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/a/af/Blueberries.png/revision/latest/scale-to-width-down/100?cb=20250108163924",
    ["Blueprint"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/9/98/Blueprint.png/revision/latest?cb=20250108011413",
    ["Bone Armor"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/7/7d/Bonearmour.png/revision/latest/scale-to-width-down/100?cb=20250108175533",
    ["Bone Tool"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/4/4e/Bone_Tool.png/revision/latest?cb=20250111164426",
    ["Boots"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/5/59/Boots.png/revision/latest/scale-to-width-down/100?cb=20250108173821",
    ["Boris Chestplate"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/f/fb/Borischest.png/revision/latest/scale-to-width-down/100?cb=20250108175533",
    ["Boris Helmet"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/7/7f/Borishelmet.png/revision/latest/scale-to-width-down/100?cb=20250108175818",
    ["Boris's Chestplate"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/f/fb/Borischest.png/revision/latest/scale-to-width-down/100?cb=20250108175533",
    ["Boulder"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/2/21/Boulder.png/revision/latest?cb=20250407023615",
    ["Bruno Chestplate"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/6/62/Brunochest.png/revision/latest/scale-to-width-down/100?cb=20250108175253",
    ["Bruno Helmet"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/f/f1/Brunohelmet.png/revision/latest/scale-to-width-down/100?cb=20250108175533",
    ["Bruno's Chestplate"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/6/62/Brunochest.png/revision/latest/scale-to-width-down/100?cb=20250108175253",
    ["Bruno's Helmet"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/f/f1/Brunohelmet.png/revision/latest/scale-to-width-down/100?cb=20250108175533",
    ["Cactus"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/6/6b/Cactusflesh.png/revision/latest/scale-to-width-down/100?cb=20250108160111",
    ["Chainsaw"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/c/cc/Chainsaw.png/revision/latest?cb=20250111164731",
    ["Cloth Footwraps"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/e/e8/Clothboots.png/revision/latest/scale-to-width-down/100?cb=20250108173612",
    ["Cloth Handwraps"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/9/98/Clothgloves.png/revision/latest/scale-to-width-down/100?cb=20250108175253",
    ["Cloth Head Wrap"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/4/49/Clothhelmet.png/revision/latest/scale-to-width-down/100?cb=20250108175140",
    ["Cloth Headwrap"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/4/49/Clothhelmet.png/revision/latest/scale-to-width-down/100?cb=20250108175140",
    ["Cloth Hoodie"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/9/95/Hoodie.png/revision/latest/scale-to-width-down/100?cb=20250108171940",
    ["Cloth Pants"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/6/61/Clothpants.png/revision/latest/scale-to-width-down/100?cb=20250108174207",
    ["Cloth Shirt"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/8/8d/Clothshirt.png/revision/latest/scale-to-width-down/100?cb=20250108200247",
    ["Collared Shirt"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/b/ba/Collaredshirt.png/revision/latest/scale-to-width-down/100?cb=20250108173822",
    ["Corn"] = "https://static.wikia.nocookie.net/play-rust/images/0/0a/Corn_icon.png/revision/latest?cb=20151106061809",
    ["Crossbow"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/5/51/Crossbow_.png/revision/latest/scale-to-width-down/180?cb=20250108154725",
    ["Dynamite Bundle"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/b/b3/Dynamite_Bundle.png/revision/latest?cb=20250112104649",
    ["Dynamite Stick"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/2/20/Dynamite_Stick.png/revision/latest?cb=20250112104836",
    ["Flannel Jacket"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/2/26/Flanneljacket.png/revision/latest/scale-to-width-down/100?cb=20250108174334",
    ["Garage Door"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/a/a6/Garage_Door.png/revision/latest?cb=20250111213531",
    ["Hammer"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/8/81/Hammer.png/revision/latest?cb=20250108004728",
    ["Hard Hat"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/4/4e/Hardhat.png/revision/latest/scale-to-width-down/100?cb=20250108174723",
    ["Hazmat Suit"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/6/68/Hazmat.png/revision/latest?cb=20250108173611",
    ["Hemp"] = "https://static.wikia.nocookie.net/play-rust/images/c/c9/Hemp_Clone_icon.png/revision/latest?cb=20170122060314",
    ["Hemp Fiber"] = "https://static.wikia.nocookie.net/play-rust/images/c/c9/Hemp_Clone_icon.png/revision/latest?cb=20170122060314",
    ["Hoodie"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/9/95/Hoodie.png/revision/latest/scale-to-width-down/100?cb=20250108171940",
    ["Iron Shard Hatchet"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/d/d7/Iron_Shard_Hatchet.png/revision/latest?cb=20250111164603",
    ["Iron Shard Pickaxe"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/d/d0/Iron_Shard_Pickaxe.png/revision/latest?cb=20250111164539",
    ["Landmine"] = "https://www.corrosionhour.com/wp-content/uploads/2022/04/rust-trap-landmine-homemade-300x300.png",
    ["Large Battery"] = "https://www.corrosionhour.com/wp-content/uploads/2021/06/rust-electric-battery-rechargable-large-300x300.png",
    ["Large Box"] = "https://www.corrosionhour.com/wp-content/uploads/2021/06/rust-box-wooden-large-300x300.png",
    ["Large Medkit"] = "https://static.wikia.nocookie.net/play-rust/images/9/99/Large_Medkit_icon.png/revision/latest?cb=20151106054425",
    ["Leather Boots"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/6/6d/Leatherboots.png/revision/latest/scale-to-width-down/100?cb=20250108174207",
    ["Leather Gloves"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/6/62/Leathergloves.png/revision/latest/scale-to-width-down/100?cb=20250108175140",
    ["Leather Pants"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/3/3b/Leatherpants.png/revision/latest/scale-to-width-down/100?cb=20250108173822",
    ["Leather Poncho"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/b/ba/Leatherponcho.png/revision/latest/scale-to-width-down/100?cb=20250108173822",
    ["Leather Shirt"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/0/0a/Leathertunic.png/revision/latest/scale-to-width-down/100?cb=20250108174207",
    ["Leather_Pants"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/3/3b/Leatherpants.png/revision/latest/scale-to-width-down/100?cb=20250108173822",
    ["Lemon"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/3/35/Lemon.png/revision/latest/scale-to-width-down/100?cb=20250108163730",
    ["Machete"] = "https://static.wikia.nocookie.net/play-rust/images/3/34/Machete_icon.png/revision/latest?cb=20151106060741",
    ["Medium Battery"] = "https://www.corrosionhour.com/wp-content/uploads/2021/06/rust-electric-battery-rechargable-medium-300x300.png",
    ["Metal"] = "https://static.wikia.nocookie.net/play-rust/images/2/22/Sulfur_Ore_icon.png/revision/latest?cb=20151106061904",
    ["Metal Door"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/c/cd/Metal_Door.png/revision/latest?cb=20250112101940",
    ["Metal Double Door"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/e/e5/Metal_Double_Door.png/revision/latest?cb=20250111213501",
    ["Metal Node"] = "https://static.wikia.nocookie.net/play-rust/images/2/22/Sulfur_Ore_icon.png/revision/latest?cb=20151106061904",
    ["Metal Ore"] = "https://static.wikia.nocookie.net/play-rust/images/0/0a/Metal_Ore_icon.png/revision/latest?cb=20151106060814",
    ["MetalNode"] = "https://static.wikia.nocookie.net/play-rust/images/2/22/Sulfur_Ore_icon.png/revision/latest?cb=20151106061904",
    ["Metal_Node"] = "https://static.wikia.nocookie.net/play-rust/images/2/22/Sulfur_Ore_icon.png/revision/latest?cb=20151106061904",
    ["Military AA12"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/5/57/Military_AA12.png/revision/latest/scale-to-width-down/180?cb=20250109110407",
    ["Military Backpack"] = "https://www.corrosionhour.com/wp-content/uploads/2024/01/rust-largebackpack-300x300.png",
    ["Military Barret"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/2/26/Military_Barrett_.png/revision/latest/scale-to-width-down/180?cb=20250108155608",
    ["Military Barrett"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/2/26/Military_Barrett_.png/revision/latest/scale-to-width-down/180?cb=20250108155608",
    ["Military Chestplate"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/c/c6/Militarychest.png/revision/latest/scale-to-width-down/100?cb=20250108174935",
    ["Military Gloves"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/a/a8/Salvagedgloves.png/revision/latest/scale-to-width-down/100?cb=20250108175140",
    ["Military Helmet"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/9/9f/Militaryhelmet.png/revision/latest/scale-to-width-down/100?cb=20250108174723",
    ["Military Leggings"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/7/70/Militarylegs.png/revision/latest/scale-to-width-down/100?cb=20250108174723",
    ["Military M39"] = "https://static.wikia.nocookie.net/play-rust/images/3/36/M39_Rifle_icon.png/revision/latest?cb=20190420225317",
    ["Military M4A1"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/b/b3/Military_M4A1.png/revision/latest/scale-to-width-down/180?cb=20250108152536",
    ["Military MP7"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/6/69/Military_MP7_.png/revision/latest/scale-to-width-down/180?cb=20250108153052",
    ["Military PKM"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/a/a6/Military_PKM.png/revision/latest/scale-to-width-down/180?cb=20250108152201",
    ["Military USP"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/c/c8/Military_USP_.png/revision/latest/scale-to-width-down/180?cb=20250108155646",
    ["Mining Drill"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/f/f0/Mining_Drill.png/revision/latest?cb=20250111164710",
    ["Nail Gun"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/6/68/Nail_Gun_.png/revision/latest/scale-to-width-down/180?cb=20250108154650",
    ["Nailgun"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/6/68/Nail_Gun_.png/revision/latest/scale-to-width-down/180?cb=20250108154650",
    ["Pants"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/7/7c/Pants1.png/revision/latest?cb=20250108173612",
    ["Phosphate"] = "https://static.wikia.nocookie.net/play-rust/images/2/22/Sulfur_Ore_icon.png/revision/latest?cb=20151106061904",
    ["Pumpkin"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/6/64/Pumpkin.png/revision/latest/scale-to-width-down/100?cb=20250108163605",
    ["Pumpkin Launcher"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/b/b1/Pumpkin_Launcher_.png/revision/latest?cb=20250108161011",
    ["Raspberry"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/7/7e/Raspberries.png/revision/latest/scale-to-width-down/100?cb=20250108163842",
    ["Salvaged AK4"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/a/ab/Fallen_-_Ak47.png/revision/latest/scale-to-width-down/180?cb=20250107194018",
    ["Salvaged AK47"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/a/ab/Fallen_-_Ak47.png/revision/latest/scale-to-width-down/180?cb=20250107194018",
    ["Salvaged AK74u"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/a/a5/Salvaged_AK74U_.png/revision/latest/scale-to-width-down/180?cb=20250108153258",
    ["Salvaged Backpack"] = "https://www.corrosionhour.com/wp-content/uploads/2024/01/rust-smallbackpack-300x300.png",
    ["Salvaged Break Action"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/7/78/Salvaged_Break_Action.png/revision/latest/scale-to-width-down/180?cb=20250109110155",
    ["Salvaged Chestplate"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/e/e2/Salvagedchest.png/revision/latest/scale-to-width-down/100?cb=20250108174457",
    ["Salvaged Gloves"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/a/a8/Salvagedgloves.png/revision/latest/scale-to-width-down/100?cb=20250108175140",
    ["Salvaged Helmet"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/4/46/Salvagedhelm.png/revision/latest/scale-to-width-down/100?cb=20250108174457",
    ["Salvaged Leggings"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/b/be/Salvagedlegs.png/revision/latest/scale-to-width-down/100?cb=20250108175140",
    ["Salvaged M14"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/5/55/Salvaged_M14_.png/revision/latest/scale-to-width-down/180?cb=20250108155717",
    ["Salvaged Metal Door"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/d/d4/Salvaged_Metal_Door.png/revision/latest?cb=20250111213231",
    ["Salvaged P250"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/1/1c/Salvaged_P250.png/revision/latest/scale-to-width-down/180?cb=20250108155928",
    ["Salvaged Pipe Rifle"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/5/50/Pipe_Rifle.png/revision/latest/scale-to-width-down/180?cb=20250109111303",
    ["Salvaged Pump Action"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/0/0a/Salvaged_Pump_Action.png/revision/latest/scale-to-width-down/180?cb=20250109110837",
    ["Salvaged Python"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/2/2d/Salvaged_Python_.png/revision/latest/scale-to-width-down/180?cb=20250108155754",
    ["Salvaged RPG"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/1/11/Salvaged_RPG_.png/revision/latest?cb=20250108161113",
    ["Salvaged SMG"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/d/d4/Salvaged_SMG_.png/revision/latest/scale-to-width-down/180?cb=20250108153138",
    ["Salvaged Shotgun"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/a/a0/Salvaged_Shotgun_.png/revision/latest/scale-to-width-down/180?cb=20250108154605",
    ["Salvaged Skorpion"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/c/c6/Salvaged_Skorpion_.png/revision/latest/scale-to-width-down/180?cb=20250108153325",
    ["Salvaged Sniper"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/5/56/Salvaged_Sniper.png/revision/latest/scale-to-width-down/180?cb=20250302204446",
    ["Shorts"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/4/47/Pants.png/revision/latest/scale-to-width-down/100?cb=20250108174206",
    ["Shotgun Turret"] = "https://static.wikia.nocookie.net/play-rust/images/6/6c/Shotgun_Trap_icon.png/revision/latest/scale-to-width-down/268?cb=20170721103159",
    ["Sleeping Bag"] = "https://www.corrosionhour.com/wp-content/uploads/2021/06/rust-sleepingbag-300x300.png",
    ["Small Battery"] = "https://www.corrosionhour.com/wp-content/uploads/2021/06/rust-electric-battery-rechargable-small-300x300.png",
    ["Small Box"] = "https://www.corrosionhour.com/wp-content/uploads/2021/06/rust-box-wooden-300x300.png",
    ["Small Medkit"] = "https://static.wikia.nocookie.net/play-rust/images/9/99/Medical_Syringe_icon.png/revision/latest?cb=20151106061059",
    ["Steel Axe"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/c/ce/Steel_Axe.png/revision/latest?cb=20250111164646",
    ["Steel Chestplate"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/3/3b/Steelchest.png/revision/latest/scale-to-width-down/100?cb=20250108174335",
    ["Steel Door"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/6/61/Steel_Door.png/revision/latest?cb=20250112102424",
    ["Steel Double Door"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/e/ec/Steel_Double_Door.png/revision/latest?cb=20250111213604",
    ["Steel Helmet"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/4/49/Steel_Helmet.png/revision/latest/scale-to-width-down/100?cb=20250108133300",
    ["Steel Leggings"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/d/d6/Steellegs.png/revision/latest/scale-to-width-down/100?cb=20250108174457",
    ["Steel Pickaxe"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/d/d1/Steel_Pickaxe.png/revision/latest?cb=20250111164626",
    ["Stone"] = "https://static.wikia.nocookie.net/play-rust/images/8/85/Stones_icon.png/revision/latest?cb=20150405123145",
    ["Stone Hatchet"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/d/d6/Stone_Hatchet.png/revision/latest?cb=20250111164512",
    ["Stone Node"] = "https://static.wikia.nocookie.net/play-rust/images/8/85/Stones_icon.png/revision/latest?cb=20150405123145",
    ["Stone Ore"] = "https://static.wikia.nocookie.net/play-rust/images/8/85/Stones_icon.png/revision/latest?cb=20150405123145",
    ["Stone Pickaxe"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/4/40/Stone_Pickaxe.png/revision/latest?cb=20250111164447",
    ["Stone Spear"] = "https://static.wikia.nocookie.net/play-rust/images/0/0a/Stone_Spear_icon.png/revision/latest?cb=20151106061726",
    ["StoneNode"] = "https://static.wikia.nocookie.net/play-rust/images/8/85/Stones_icon.png/revision/latest?cb=20150405123145",
    ["Stone_Node"] = "https://static.wikia.nocookie.net/play-rust/images/8/85/Stones_icon.png/revision/latest?cb=20150405123145",
    ["Stones"] = "https://static.wikia.nocookie.net/play-rust/images/8/85/Stones_icon.png/revision/latest?cb=20150405123145",
    ["Storage Cabinet"] = "https://www.corrosionhour.com/wp-content/uploads/2021/06/rust-coffin-storage-300x300.png",
    ["Sulfur"] = "https://static.wikia.nocookie.net/play-rust/images/2/22/Sulfur_Ore_icon.png/revision/latest?cb=20151106061904",
    ["Sulfur Node"] = "https://static.wikia.nocookie.net/play-rust/images/2/22/Sulfur_Ore_icon.png/revision/latest?cb=20151106061904",
    ["Sulfur Ore"] = "https://static.wikia.nocookie.net/play-rust/images/2/22/Sulfur_Ore_icon.png/revision/latest?cb=20151106061904",
    ["SulfurNode"] = "https://static.wikia.nocookie.net/play-rust/images/2/22/Sulfur_Ore_icon.png/revision/latest?cb=20151106061904",
    ["Sulfur_Node"] = "https://static.wikia.nocookie.net/play-rust/images/2/22/Sulfur_Ore_icon.png/revision/latest?cb=20151106061904",
    ["Tactical Gloves"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/a/a8/Salvagedgloves.png/revision/latest/scale-to-width-down/100?cb=20250108175140",
    ["Tank Top"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/2/2b/Tanktop.png/revision/latest/scale-to-width-down/100?cb=20250108173612",
    ["Timed Charge"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/6/6d/Timed_Charge.png/revision/latest?cb=20250112104716",
    ["Tomato"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/9/9d/Tomato.png/revision/latest/scale-to-width-down/100?cb=20250108164012",
    ["Trap Door"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/9/9f/Trap_Door.png/revision/latest?cb=20250112102923",
    ["Tree"] = "https://static.wikia.nocookie.net/play-rust/images/f/f2/Wood_icon.png/revision/latest?cb=20151106061551",
    ["Tree Large"] = "https://static.wikia.nocookie.net/play-rust/images/f/f2/Wood_icon.png/revision/latest?cb=20151106061551",
    ["Tree Medium"] = "https://static.wikia.nocookie.net/play-rust/images/f/f2/Wood_icon.png/revision/latest?cb=20151106061551",
    ["Tree Small"] = "https://static.wikia.nocookie.net/play-rust/images/f/f2/Wood_icon.png/revision/latest?cb=20151106061551",
    ["Tree XL"] = "https://static.wikia.nocookie.net/play-rust/images/f/f2/Wood_icon.png/revision/latest?cb=20151106061551",
    ["Wetsuit"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/5/5f/Wetsuit.png/revision/latest?cb=20250108175934",
    ["Windmill"] = "https://static.wikia.nocookie.net/play-rust/images/f/f2/Wind_Turbine_icon.png/revision/latest/scale-to-width-down/1000?cb=20151106061147",
    ["Wire Cutters"] = "https://static.wikia.nocookie.net/play-rust/images/e/e0/Wire_Tool_icon.png/revision/latest?cb=20230420081635",
    ["Wooden Bow"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/1/13/Wooden_Bow_.png/revision/latest/scale-to-width-down/180?cb=20250108154800",
    ["Wooden Chestplate"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/8/87/Woodchest.png/revision/latest/scale-to-width-down/100?cb=20250108174335",
    ["Wooden Door"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/2/2c/Wooden_Door.png/revision/latest?cb=20250111212634",
    ["Wooden Double Door"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/a/af/Wooden_Double_Door.png/revision/latest?cb=20250112101523",
    ["Wooden Helmet"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/2/20/Woodhelm.png/revision/latest/scale-to-width-down/100?cb=20250108174335",
    ["Wooden Leggings"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/f/f8/Woodleg.png/revision/latest/scale-to-width-down/100?cb=20250108174456",
    ["Wooden Spear"] = "https://static.wikia.nocookie.net/fallen-survival-new/images/1/17/Wooden_Spear.png/revision/latest?cb=20250407032830",
    ["Wool"] = "https://static.wikia.nocookie.net/play-rust/images/c/c9/Hemp_Clone_icon.png/revision/latest?cb=20170122060314",
    ["metal_node"] = "https://static.wikia.nocookie.net/play-rust/images/2/22/Sulfur_Ore_icon.png/revision/latest?cb=20151106061904",
    ["stone_node"] = "https://static.wikia.nocookie.net/play-rust/images/8/85/Stones_icon.png/revision/latest?cb=20150405123145",
    ["sulfur_node"] = "https://static.wikia.nocookie.net/play-rust/images/2/22/Sulfur_Ore_icon.png/revision/latest?cb=20151106061904",
}

local WEAPON_DIRECT_ALIASES = {
    ["Blueberries"] = "Blueberry",
    ["Cactus Flesh"] = "Cactus flesh",
    ["Cactusflesh"] = "Cactus flesh",
    ["Circuit Board"] = "Circuit board",
    ["Circuit Boards"] = "Circuit board",
    ["Pink Keycard"] = "Pink Card",
    ["Power Cell"] = "Power cell",
    ["Purple Keycard"] = "Purple Card",
    ["Raspberries"] = "Raspberry",
    ["Red Keycard"] = "Red Card",
    ["SMG Receiver"] = "SMG receiver",
    ["Yellow Keycard"] = "Yellow Card",
    ["Ligther"] = "Lighter",
    ["lighter"] = "Lighter",
    ["Torch"] = "Lighter",
    ["Flashlight"] = "Lighter",
    ["AA12"] = "Military AA12",
    ["AK-47"] = "Salvaged AK47",
    ["AK4"] = "Salvaged AK4",
    ["AK47"] = "Salvaged AK47",
    ["AK74U"] = "Salvaged AK74u",
    ["AK74u"] = "Salvaged AK74u",
    ["Axe"] = "Steel Axe",
    ["Barret"] = "Military Barrett",
    ["Barrett"] = "Military Barrett",
    ["Bow"] = "Wooden Bow",
    ["Break Action"] = "Salvaged Break Action",
    ["C4"] = "Timed Charge",
    ["Charge"] = "Timed Charge",
    ["Crossbow"] = "Crossbow",
    ["Double Barrel"] = "Salvaged Double Barrel",
    ["Drill"] = "Mining Drill",
    ["Dynamite"] = "Dynamite Stick",
    ["Hatchet"] = "Stone Hatchet",
    ["M14"] = "Salvaged M14",
    ["M39"] = "Military M39",
    ["M4"] = "Military M4A1",
    ["M4A1"] = "Military M4A1",
    ["MP7"] = "Military MP7",
    ["Medkit"] = "Large Medkit",
    ["Military Barret"] = "Military Barrett",
    ["Nail Gun"] = "Nail Gun",
    ["Nailgun"] = "Nail Gun",
    ["P250"] = "Salvaged P250",
    ["PKM"] = "Military PKM",
    ["Pickaxe"] = "Stone Pickaxe",
    ["Pipe Rifle"] = "Salvaged Pipe Rifle",
    ["Pump Action"] = "Salvaged Pump Action",
    ["Python"] = "Salvaged Python",
    ["RPG"] = "Salvaged RPG",
    ["SMG"] = "Salvaged SMG",
    ["Shotgun"] = "Salvaged Shotgun",
    ["Skorpion"] = "Salvaged Skorpion",
    ["Sniper"] = "Salvaged Sniper",
    ["USP"] = "Military USP",
}

local item_cache = {}
local hover_alpha = {}
local target_alpha = 0
local last_target_key = nil
local pulse_until = 0

local hotbar_x = 960
local hotbar_y = 760
local draw_x = hotbar_x
local draw_y = hotbar_y
local dragging = false
local drag_dx = 0
local drag_dy = 0
local hotbar_vertical = false


UIManager.CreateTab(TAB_ID, "Fallen")

UIManager.CreateText("armoriso_title", "Armor ESP")
UIManager.SetElementParent("armoriso_title", TAB_ID)

UIManager.CreateCheckbox("armoriso_target_enabled", "Enabled", true)
UIManager.SetElementParent("armoriso_target_enabled", TAB_ID)

UIManager.CreateCheckbox("armoriso_show_weapon", "Show Weapon Slot", true)
UIManager.SetElementParent("armoriso_show_weapon", TAB_ID)
UIManager.SetElementSameLine("armoriso_show_weapon", true)

UIManager.CreateColorPicker("armoriso_border_color", "Border Color", 1, 1, 1, 1)
UIManager.SetElementParent("armoriso_border_color", TAB_ID)
UIManager.SetElementSameLine("armoriso_border_color", true)

UIManager.CreateCheckbox("armoriso_rainbow_border", "Rainbow Border", false)
UIManager.SetElementParent("armoriso_rainbow_border", TAB_ID)
UIManager.SetElementSameLine("armoriso_rainbow_border", true)

UIManager.CreateSliderInt("armoriso_target_size", "Size", 20, 96, 50)
UIManager.SetElementParent("armoriso_target_size", TAB_ID)

UIManager.CreateSliderInt("armoriso_max_distance", "Max Distance", 50, 3000, 1000)
UIManager.SetElementParent("armoriso_max_distance", TAB_ID)

UIManager.CreateSliderInt("armoriso_glow_power", "Glow Power", 0, 100, 55)
UIManager.SetElementParent("armoriso_glow_power", TAB_ID)

UIManager.CreateButton("armoriso_reload_icons", "Reload Icons", function()
    icon_state = {}
    weapon_icon_state = {}
    weapon_icon_state = {}
    item_cache = {}
    notify("Isolated Armor Hotbar V12 Clean loaded", "success")
end)
UIManager.SetElementParent("armoriso_reload_icons", TAB_ID)

local function clamp(v, a, b)
    if v < a then return a end
    if v > b then return b end
    return v
end

local function lerp(a, b, t)
    return a + (b - a) * t
end

local function add_unique(list, seen, value)
    if value and value ~= "" and not seen[value] then
        table.insert(list, value)
        seen[value] = true
    end
end

local function hsv_to_rgb(h, s, v)
    local i = math.floor(h * 6)
    local f = h * 6 - i
    local p = v * (1 - s)
    local q = v * (1 - f * s)
    local t = v * (1 - (1 - f) * s)
    i = i % 6

    if i == 0 then return v, t, p end
    if i == 1 then return q, v, p end
    if i == 2 then return p, v, t end
    if i == 3 then return p, q, v end
    if i == 4 then return t, p, v end
    return v, p, q
end

local function normalize_color_value(v, fallback)
    v = v or fallback
    if v > 1 then v = v / 255 end
    return clamp(v, 0, 1)
end

local function read_picker_color(id)
    local c = UIManager.GetColorPickerValue(id)
    if not c then return 1, 1, 1, 1 end

    local r = c.r or c.R or c.X or c[1] or 1
    local g = c.g or c.G or c.Y or c[2] or 1
    local b = c.b or c.B or c.Z or c[3] or 1
    local a = c.a or c.A or c.W or c[4] or 1

    return normalize_color_value(r, 1),
           normalize_color_value(g, 1),
           normalize_color_value(b, 1),
           normalize_color_value(a, 1)
end

local function get_base_border_color()
    if UIManager.GetCheckboxValue("armoriso_rainbow_border") then
        local h = (tick() * 0.18) % 1
        local r, g, b = hsv_to_rgb(h, 1, 1)
        return r, g, b, 1
    end

    return read_picker_color("armoriso_border_color")
end

local function get_rarity_color(name)
    if not name then return nil end

    if string.find(name, "Backpack") then
        return RARITY.Backpack[1], RARITY.Backpack[2], RARITY.Backpack[3], 1
    end

    for key, col in pairs(RARITY) do
        if string.find(name, key) then
            return col[1], col[2], col[3], 1
        end
    end

    return nil
end

local function get_border_color_for_item(name)
    return get_base_border_color()
end

local function normalize_armor_id(name)
    if not name then return nil end

    local id = string.match(name, "Armor[_%s]%d+")
    if not id then return nil end

    id = string.gsub(id, " ", "_")

    if id == "Armor_308" or id == "Armor_309" then
        return nil
    end

    return id
end

local function get_icon(name)
    local urls = ICON_URLS[name] or get_weapon_icon_urls(name)
    if not urls then return nil end

    local st = icon_state[name]
    if not st then
        st = {
            index = 1,
            handle = Drawing.LoadImage(urls[1]),
            dead = false
        }
        icon_state[name] = st
    end

    if st.dead then return nil end

    if st.handle and Drawing.IsImageReady(st.handle) then
        return st.handle
    end

    if st.handle and Drawing.IsImageFailed(st.handle) then
        st.index = st.index + 1

        if urls[st.index] then
            st.handle = Drawing.LoadImage(urls[st.index])
            return st.handle
        end

        st.dead = true
        return nil
    end

    return st.handle
end

local function safe_name(inst)
    if not inst then return nil end
    local ok, name = pcall(function()
        return inst:get_name()
    end)
    if ok then return name end
    return nil
end

local function get_character(p)
    if p.character_addr and p.character_addr ~= 0 then
        local char = rbx.instance(p.character_addr)
        if char then return char end
    end

    if p.hrp_addr and p.hrp_addr ~= 0 then
        local hrp = rbx.instance(p.hrp_addr)
        if hrp then return hrp:parent() end
    end

    local ps = rbx.players_service()
    if ps then
        local plr = ps:find_first_child(p.name)
        if plr then
            return plr:get_character()
        end
    end

    return nil
end

local function get_player_instance(p)
    if p.player_addr and p.player_addr ~= 0 then
        return rbx.instance(p.player_addr)
    end

    local ps = rbx.players_service()
    if ps then
        return ps:find_first_child(p.name)
    end

    return nil
end

local function scan_armor(root, out, seen, depth)
    if not root or depth > 12 then return end

    local ok, children = pcall(function()
        return root:get_children()
    end)

    if not ok or not children then return end

    for _, child in ipairs(children) do
        local name = safe_name(child)
        local id = normalize_armor_id(name)

        if id then
            add_unique(out, seen, ARMOR_MAP[id])
        end

        scan_armor(child, out, seen, depth + 1)
    end
end

local function resolve_full_player(t)
    for _, p in ipairs(players.get_all()) do
        if p.address == t.address or p.name == t.name then
            return p
        end
    end

    return t
end

local function armor_clean_tool_name(name)
    if not name or name == "" then return nil end

    -- strip common instance suffix/path noise
    name = tostring(name)
    name = string.gsub(name, "^%s+", "")
    name = string.gsub(name, "%s+$", "")

    if name == "" then return nil end
    return name
end

local function armor_is_armor_or_clothing_name(name)
    if not name then return false end

    if ARMOR_MAP[name] then return true end

    for _, armor_name in pairs(ARMOR_MAP) do
        if name == armor_name then
            return true
        end
    end

    local lowered = string.lower(name)
    local bad = {
        "pants", "shirt", "helmet", "chestplate", "leggings", "gloves",
        "boots", "hoodie", "hazmat", "balaclava", "cap", "wetsuit",
        "backpack", "armor", "footwraps", "handwraps", "head wrap",
        "jacket", "tank top", "shorts"
    }

    for _, key in ipairs(bad) do
        if string.find(lowered, key, 1, true) then
            return true
        end
    end

    return false
end

local function armor_is_weapon_name(name)
    if not name or name == "" then return false end
    if armor_is_armor_or_clothing_name(name) then return false end
    if WEAPON_ITEMS[name] then return true end

    local lowered = string.lower(name)
    local good = {
        "ak", "m4", "m39", "aa12", "mp7", "pkm", "usp", "barret", "barrett",
        "shotgun", "smg", "p250", "python", "rpg", "sniper", "bow", "spear",
        "nail", "grenade", "launcher", "axe", "pickaxe", "hatchet", "shovel",
        "drill", "chainsaw", "machete", "medkit", "bandage", "wire cutters",
        "dynamite", "charge", "hammer", "blueprint", "boulder", "lighter",
        "crossbow", "revolver", "rifle", "skorpion"
    }

    for _, key in ipairs(good) do
        if string.find(lowered, key, 1, true) then
            return true
        end
    end

    return false
end

local function armor_get_target_tool_name(target)
    if not target then return nil end

    local direct_fields = {
        target.tool,
        target.weapon,
        target.item,
        target.equipped_tool,
        target.held_item,
        target.current_tool,
        target.current_weapon
    }

    for _, v in ipairs(direct_fields) do
        if type(v) == "string" and v ~= "" then
            local name = armor_clean_tool_name(v)
            if armor_is_weapon_name(name) then
                return name
            end
        end
    end

    local addr_fields = {
        target.tool_addr,
        target.weapon_addr,
        target.item_addr
    }

    for _, addr in ipairs(addr_fields) do
        if addr and addr ~= 0 then
            local ok, inst = pcall(function()
                return rbx.instance(addr)
            end)

            if ok and inst then
                local name = armor_clean_tool_name(safe_name(inst))
                if armor_is_weapon_name(name) then
                    return name
                end
            end
        end
    end

    local char = get_character(target)
    if char then
        local methods = {
            "get_tool",
            "get_equipped_tool",
            "get_held_tool",
            "get_current_tool"
        }

        for _, m in ipairs(methods) do
            local ok, tool = pcall(function()
                return char[m](char)
            end)

            if ok and tool then
                local name = armor_clean_tool_name(safe_name(tool))
                if armor_is_weapon_name(name) then
                    return name
                end
            end
        end

        local ok2, tool2 = pcall(function()
            return char:find_first_child_of_class("Tool")
        end)

        if ok2 and tool2 then
            local name = armor_clean_tool_name(safe_name(tool2))
            if armor_is_weapon_name(name) then
                return name
            end
        end

        local ok_children, children = pcall(function()
            return char:get_children()
        end)

        if ok_children and children then
            for _, child in ipairs(children) do
                local name = armor_clean_tool_name(safe_name(child))
                if armor_is_weapon_name(name) then
                    local ok_class, cls = pcall(function()
                        return child:get_class()
                    end)

                    if (ok_class and cls == "Tool") or WEAPON_ITEMS[name] then
                        return name
                    end
                end
            end
        end
    end

    return nil
end


local function get_items(raw_target)
    local p = resolve_full_player(raw_target)
    local key = p.address or p.name
    local now = tick()

    if item_cache[key] and now - item_cache[key].time < 0.12 then
        return item_cache[key].items
    end

    local items = {}
    local seen = {}

    if UIManager.GetCheckboxValue("armoriso_show_weapon") then
        local tool_name = armor_get_target_tool_name(p)
        if tool_name then
            add_unique(items, seen, "__weapon__" .. tool_name)
        end
    end

    local char = get_character(p)
    if char then scan_armor(char, items, seen, 0) end

    local plr = get_player_instance(p)
    if plr then scan_armor(plr, items, seen, 0) end

    item_cache[key] = {
        time = now,
        items = items
    }

    return items
end

local function short_name(name)
    local a, b = string.match(name or "", "^(%S+)%s+(%S+)")
    if a and b then
        return string.sub(a, 1, 1) .. string.sub(b, 1, 1)
    end
    return string.sub(name or "?", 1, 2)
end

local function point_in_rect(px, py, x, y, w, h)
    return px >= x and py >= y and px <= x + w and py <= y + h
end

local function draw_glow(x, y, size, r, g, b, strength, alpha_mul)
    if not true then return end
    if strength <= 0 then return end

    local base = (strength / 100) * (alpha_mul or 1)
    Drawing.DrawBoxFilled(x - 8, y - 8, x + size + 8, y + size + 8, r, g, b, 0.035 * base)
    Drawing.DrawBoxFilled(x - 5, y - 5, x + size + 5, y + size + 5, r, g, b, 0.055 * base)
    Drawing.DrawBoxFilled(x - 2, y - 2, x + size + 2, y + size + 2, r, g, b, 0.070 * base)
end

local function draw_fake_rounded_panel(x, y, w, h, alpha)
    -- clean flat panel without corner artifacts
    Drawing.DrawBoxFilled(
        x,
        y,
        x + w,
        y + h,
        0.010,
        0.010,
        0.014,
        alpha
    )
end


local weapon_icon_state = {}

local function weapon_norm_name(s)
    s = tostring(s or "")
    s = string.lower(s)
    s = string.gsub(s, "[^%w]", "")
    return s
end

local function weapon_make_fandom_fallbacks(url)
    local out = {}
    local seen = {}

    local function add(u)
        if u and u ~= "" and not seen[u] then
            table.insert(out, u)
            seen[u] = true
        end
    end

    if not url then return out end

    -- Prefer original PNG from Fandom first. Drawing.LoadImage is pickier than WinINet.
    local base = string.match(url, "^(.-)/revision/latest")
    if base then
        add(base .. "/revision/latest?format=original")
        add(base .. "/revision/latest/scale-to-width-down/180?format=original")
        add(base .. "/revision/latest/scale-to-width-down/100?format=original")
    end

    add(url)

    if string.find(url, "?", 1, true) then
        add(url .. "&format=original")
    else
        add(url .. "?format=original")
    end

    return out
end

local function get_weapon_icon_url(name)
    if not name then return nil end

    if WEAPON_DIRECT_ICON_URLS[name] then
        return WEAPON_DIRECT_ICON_URLS[name]
    end

    local alias = WEAPON_DIRECT_ALIASES[name]
    if alias and WEAPON_DIRECT_ICON_URLS[alias] then
        return WEAPON_DIRECT_ICON_URLS[alias]
    end

    local nn = weapon_norm_name(name)

    if alias then
        nn = weapon_norm_name(alias)
    end

    for k, url in pairs(WEAPON_DIRECT_ICON_URLS) do
        local kk = weapon_norm_name(k)

        if kk == nn then
            return url
        end
    end

    for k, url in pairs(WEAPON_DIRECT_ICON_URLS) do
        local kk = weapon_norm_name(k)

        if nn ~= "" and kk ~= "" then
            if string.find(kk, nn, 1, true) or string.find(nn, kk, 1, true) then
                return url
            end
        end
    end

    return nil
end

local function get_weapon_icon(name)
    local url = get_weapon_icon_url(name)
    if not url then return nil end

    local st = weapon_icon_state[name]
    if not st then
        local urls = weapon_make_fandom_fallbacks(url)
        st = {
            urls = urls,
            index = 1,
            handle = urls[1] and Drawing.LoadImage(urls[1]) or nil,
            dead = false
        }
        weapon_icon_state[name] = st
    end

    if st.dead then return nil end

    if st.handle and Drawing.IsImageReady(st.handle) then
        return st.handle
    end

    if st.handle and Drawing.IsImageFailed(st.handle) then
        st.index = st.index + 1

        if st.urls and st.urls[st.index] then
            st.handle = Drawing.LoadImage(st.urls[st.index])
            return st.handle
        end

        st.dead = true
        return nil
    end

    return st.handle
end


local function draw_slot(name, x, y, size, mouse, global_alpha)
    local is_weapon = false
    local display_name = name

    if type(name) == "string" and string.sub(name, 1, 10) == "__weapon__" then
        is_weapon = true
        display_name = string.sub(name, 11)
    end

    local br, bg, bb, ba = get_border_color_for_item(display_name)

    if is_weapon then
        br, bg, bb, ba = 1.0, 0.82, 0.25, 1.0
    end
    local glow_power = UIManager.GetSliderIntValue("armoriso_glow_power")
    local hover = false

    if mouse and point_in_rect(mouse.X, mouse.Y, x, y, size, size) then
        hover = true
    end

    hover_alpha[display_name] = lerp(hover_alpha[display_name] or 0, hover and 1 or 0, 0.22)
    local ha = hover_alpha[display_name]

    local pulse = 0
    if tick() < pulse_until then
        pulse = (pulse_until - tick()) / 0.45
    end

    local scale = 1 + ha * 0.11 + pulse * 0.045
    local ds = size * scale
    local dx = x - (ds - size) / 2
    local dy = y - (ds - size) / 2

    draw_glow(dx, dy, ds, br, bg, bb, glow_power, global_alpha + ha * 0.6)

    Drawing.DrawBoxFilled(dx, dy, dx + ds, dy + ds, 0.03, 0.03, 0.035, 0.78 * global_alpha)
    Drawing.DrawBoxFilled(dx + 3, dy + 3, dx + ds - 3, dy + ds - 3, 0.005, 0.005, 0.007, 0.35 * global_alpha)

    -- subtle highlight line
    Drawing.DrawLine(dx + 3, dy + 3, dx + ds - 3, dy + 3, 1, 1, 1, 0.10 * global_alpha, 1)

    -- animated inner scan when hovered
    if ha > 0.03 then
        local scan_y = dy + 5 + ((tick() * 80) % math.max(1, ds - 10))
        Drawing.DrawLine(dx + 5, scan_y, dx + ds - 5, scan_y, br, bg, bb, 0.22 * ha, 1.2)
    end

    Drawing.DrawBox(dx - 1, dy - 1, dx + ds + 1, dy + ds + 1, br, bg, bb, ba * global_alpha, 2)
    Drawing.DrawBox(dx, dy, dx + ds, dy + ds, br, bg, bb, 0.55 * global_alpha, 1)

    local icon = is_weapon and get_weapon_icon(display_name) or get_icon(display_name)

    if icon and Drawing.IsImageReady(icon) then
        Drawing.DrawImage(icon, dx + 4, dy + 4, ds - 8, ds - 8)
    else
        if is_weapon then
            Drawing.DrawTextWithOutline(
                dx + ds / 2,
                dy + ds / 2 - 6,
                "WPN",
                1.0, 0.82, 0.25, 1 * global_alpha,
                0, 0, 0, 1 * global_alpha
            )
        else
            Drawing.DrawTextWithOutline(
                dx + ds / 2,
                dy + ds / 2 - 6,
                short_name(display_name),
                1, 1, 1, 1 * global_alpha,
                0, 0, 0, 1 * global_alpha
            )
        end
    end

    if true and ha > 0.04 then
        local label_w = string.len(display_name) * 6 + 12
        local lx = dx + ds / 2 - label_w / 2
        local ly = dy - 24
        Drawing.DrawBoxFilled(lx, ly, lx + label_w, ly + 17, 0.01, 0.01, 0.012, 0.72 * ha)
        Drawing.DrawBox(lx, ly, lx + label_w, ly + 17, br, bg, bb, 0.65 * ha, 1)
        Drawing.DrawTextWithOutline(dx + ds / 2, ly + 3, display_name, 1, 1, 1, ha, 0, 0, 0, ha)
    end
end

local function get_target_user_id(target)
    if target.user_id and target.user_id ~= 0 then
        return target.user_id
    end

    local plr = get_player_instance(target)
    if not plr then return nil end

    local ok, uid = pcall(function()
        return plr:user_id()
    end)

    if ok and uid and uid ~= 0 then
        return uid
    end

    return nil
end

local function draw_animated_hotbar_frame(x, y, w, h, alpha)
    local base_r, base_g, base_b, base_a = get_base_border_color()

    Drawing.DrawBox(x, y, x + w, y + h, base_r, base_g, base_b, 0.18 * alpha, 1)

    local perimeter = (w + h) * 2
    local head = (tick() * 145) % perimeter
    local trail = 155
    local thickness = 3

    local function point_at(p)
        p = p % perimeter

        if p < w then
            return x + p, y
        elseif p < w + h then
            return x + w, y + (p - w)
        elseif p < w + h + w then
            return x + w - (p - w - h), y + h
        end

        return x, y + h - (p - w - h - w)
    end

    local function draw_piece(p1, p2, r, g, b, a, th)
        local x1, y1 = point_at(p1)
        local x2, y2 = point_at(p2)

        if math.abs(x1 - x2) > 14 and math.abs(y1 - y2) > 14 then
            return
        end

        Drawing.DrawLine(x1, y1, x2, y2, r, g, b, a, th)
    end

    Drawing.DrawBoxFilled(x - 3, y - 3, x + w + 3, y + h + 3, base_r, base_g, base_b, 0.014 * alpha)

    local pieces = 24
    local step = trail / pieces

    for i = 0, pieces - 1 do
        local k = i / pieces
        local fade = 1 - k
        local p1 = head - i * step
        local p2 = head - (i + 1) * step

        local mix = fade * 0.35
        local r = base_r + (1 - base_r) * mix
        local g = base_g + (1 - base_g) * mix
        local b = base_b + (1 - base_b) * mix
        local a = base_a * alpha * (0.10 + fade * 0.85)

        draw_piece(p1, p2, r, g, b, a, thickness)
    end
end

local function get_viewport_size()
    local d = ScreenSize()
    if d and d.Width and d.Height then
        return d.Width, d.Height
    end

    local rd = rbx.screen_dim()
    if rd and rd.Width and rd.Height then
        return rd.Width, rd.Height
    end

    return 1920, 1080
end

local function clamp_hotbar_position(cx, cy, w, h)
    local sw, sh = get_viewport_size()
    local margin = 8

    local min_x = margin + w / 2
    local max_x = sw - margin - w / 2
    local min_y = margin + h / 2
    local max_y = sh - margin - h / 2

    if min_x > max_x then
        min_x = sw / 2
        max_x = sw / 2
    end

    if min_y > max_y then
        min_y = sh / 2
        max_y = sh / 2
    end

    return clamp(cx, min_x, max_x), clamp(cy, min_y, max_y)
end

local function draw_target_hp_bar(target, x, y, w, alpha)
    local hp = target.health or 0
    local maxhp = target.max_health or 100
    if maxhp <= 0 then maxhp = 100 end

    local frac = clamp(hp / maxhp, 0, 1)
    local r = 1 - frac
    local g = frac

    Drawing.DrawBoxFilled(x, y, x + w * frac, y + 5, r, g, 0.12, 0.95 * alpha)
    Drawing.DrawBox(x, y, x + w, y + 5, 1, 1, 1, 0.10 * alpha, 1)

    Drawing.DrawTextWithOutline(
        x + w / 2,
        y - 1,
        string.format("%.0f / %.0f", hp, maxhp),
        1, 1, 1, 0.90 * alpha,
        0, 0, 0, alpha
    )
end

local function armor_players_available()
    local ok, all = pcall(function()
        return players.get_all()
    end)

    if not ok or not all or #all <= 0 then
        return false
    end

    for _, p in ipairs(all) do
        if p and not p.is_self and p.address and p.address ~= 0 then
            if not p.is_knocked and (not p.health or p.health > 1) then
                return true
            end
        end
    end

    return false
end

local function armor_target_valid(target)
    if not target then return false end
    if target.is_self then return false end
    if target.is_knocked then return false end
    if target.is_dead then return false end

    if target.health ~= nil then
        local hp = tonumber(target.health) or 0
        if hp <= 1 then
            return false
        end
    end

    if target.max_health ~= nil then
        local maxhp = tonumber(target.max_health) or 100
        if maxhp <= 0 then
            return false
        end
    end

    if not target.address or target.address == 0 then return false end
    if not target.position then return false end
    if not target.head_pos then return false end

    if not target.position.X or not target.position.Y or not target.position.Z then return false end
    if not target.head_pos.X or not target.head_pos.Y or not target.head_pos.Z then return false end

    if target.position.X == 0 and target.position.Y == 0 and target.position.Z == 0 then return false end
    if target.head_pos.X == 0 and target.head_pos.Y == 0 and target.head_pos.Z == 0 then return false end

    local max_dist = 1000
    pcall(function()
        max_dist = UIManager.GetSliderIntValue("armoriso_max_distance") or 1000
    end)

    if target.distance and target.distance > max_dist then
        return false
    end

    return true
end


local function armor_refresh_target_by_address(addr)
    if not addr then return nil end

    local all = players.get_all()
    for _, p in ipairs(all) do
        if p.address == addr and armor_target_valid(p) then
            return p
        end
    end

    return nil
end


local function draw_target_hotbar(target)
    if not armor_target_valid(target) then
        target_alpha = lerp(target_alpha, 0, 0.18)
        return
    end

    local fresh_target = armor_refresh_target_by_address(target.address)
    if not fresh_target then
        target_alpha = lerp(target_alpha, 0, 0.18)
        return
    end
    target = fresh_target

    local items = get_items(target)
    if #items <= 0 then
        target_alpha = lerp(target_alpha, 0, 0.12)
        return
    end

    target_alpha = lerp(target_alpha, 1, 0.12)

    local key = target.address or target.name
    if key ~= last_target_key then
        last_target_key = key
        pulse_until = tick() + 0.45
    end

    local size = UIManager.GetSliderIntValue("armoriso_target_size")
    local gap = 6
    local panel_pad = 10
    local name_h = 36
    local sw, sh = get_viewport_size()

    local horiz_w = (#items * size) + ((#items - 1) * gap)
    local horiz_h = size
    local vert_w = size
    local vert_h = (#items * size) + ((#items - 1) * gap)

    local horiz_panel_w = horiz_w + panel_pad * 2
    local horiz_panel_h = horiz_h + name_h + 12
    local vert_panel_w = vert_w + panel_pad * 2
    local vert_panel_h = vert_h + name_h + 12

    local mouse = Windows.GetMousePos()
    local lmb = Windows.IsKeyPressed(0x01)

    local current_panel_w = hotbar_vertical and vert_panel_w or horiz_panel_w
    local current_panel_h = hotbar_vertical and vert_panel_h or horiz_panel_h
    local current_start_x = hotbar_x - current_panel_w / 2
    local current_start_y = hotbar_y - name_h

    if mouse then
        if lmb and not dragging and point_in_rect(mouse.X, mouse.Y, current_start_x, current_start_y, current_panel_w, current_panel_h) then
            dragging = true
            drag_dx = mouse.X - hotbar_x
            drag_dy = mouse.Y - hotbar_y
        elseif not lmb then
            dragging = false
        end

        if dragging then
            hotbar_x = mouse.X - drag_dx
            hotbar_y = mouse.Y - drag_dy
        end
    end

    -- Auto-rotate into a vertical column near left/right screen edge or when horizontal is too wide.
    local horiz_left = hotbar_x - horiz_panel_w / 2
    local horiz_right = hotbar_x + horiz_panel_w / 2
    local edge_trigger = 12

    if not hotbar_vertical then
        if horiz_panel_w > sw - 16 or horiz_left < edge_trigger or horiz_right > sw - edge_trigger then
            hotbar_vertical = true
        end
    else
        -- Return to horizontal only when there is enough room away from edges.
        if horiz_panel_w <= sw - 16 and hotbar_x - horiz_panel_w / 2 > 80 and hotbar_x + horiz_panel_w / 2 < sw - 80 then
            hotbar_vertical = false
        end
    end

    local is_vertical = hotbar_vertical
    local total_w = is_vertical and vert_w or horiz_w
    local total_h = is_vertical and vert_h or horiz_h
    local panel_w = is_vertical and vert_panel_w or horiz_panel_w
    local panel_h = is_vertical and vert_panel_h or horiz_panel_h

    -- Hard clamp: you cannot drag it offscreen.
    hotbar_x, hotbar_y = clamp_hotbar_position(hotbar_x, hotbar_y + (panel_h / 2 - name_h), panel_w, panel_h)
    hotbar_y = hotbar_y - (panel_h / 2 - name_h)

    draw_x = lerp(draw_x, hotbar_x, dragging and 0.35 or 0.16)
    draw_y = lerp(draw_y, hotbar_y, dragging and 0.35 or 0.16)

    local start_x = draw_x - total_w / 2
    local start_y = draw_y

    if is_vertical then
        start_x = draw_x - size / 2
        start_y = draw_y
    end

    local panel_x = draw_x - panel_w / 2
    local panel_y = draw_y - name_h

    local br, bg, bb, ba = get_base_border_color()
    local pulse = 0
    if tick() < pulse_until then
        pulse = (pulse_until - tick()) / 0.45
    end

    draw_fake_rounded_panel(panel_x, panel_y, panel_w, panel_h, 0.58 * target_alpha)
    Drawing.DrawBox(panel_x, panel_y, panel_x + panel_w, panel_y + panel_h, br, bg, bb, (0.16 + pulse * 0.22) * target_alpha, 1)
    draw_animated_hotbar_frame(panel_x, panel_y, panel_w, panel_h, target_alpha)

    Drawing.DrawTextWithOutline(
        draw_x,
        draw_y - 31,
        target.name,
        1, 1, 1, target_alpha,
        0, 0, 0, target_alpha
    )

    draw_target_hp_bar(target, panel_x + panel_pad, draw_y - 13, panel_w - panel_pad * 2, target_alpha)

    for i, item in ipairs(items) do
        local x, y

        if is_vertical then
            x = draw_x - size / 2
            y = draw_y + (i - 1) * (size + gap)
        else
            x = draw_x - total_w / 2 + (i - 1) * (size + gap)
            y = draw_y
        end

        draw_slot(item, x, y, size, mouse, target_alpha)
    end
end

hooks.on_render(function()
    if not UIManager.GetCheckboxValue("armoriso_target_enabled") then return end

    local ok, err = pcall(function()
        if not armor_players_available() then
            target_alpha = lerp(target_alpha, 0, 0.18)
            last_target_key = nil
            return
        end

        local target = players.get_closest_to_crosshair(280)
        if not armor_target_valid(target) then
            target_alpha = lerp(target_alpha, 0, 0.18)
            last_target_key = nil
            return
        end

        draw_target_hotbar(target)
    end)

    if not ok then
        -- keep render alive if one item/icon fails
        target_alpha = lerp(target_alpha, 0, 0.18)
        last_target_key = nil
    end
end)

notify("Isolated Armor Hotbar V12 Clean loaded", "success")

-- =========================================================
-- Fallen by Kaytee ESP -> one-tab Workspace port for your Lua API
-- NOT copied from the example: full Kaytee object set, but optimized with example-style caches.
-- Everything OFF by default.
-- =========================================================

local K1_TAB = TAB_ID

local k1 = {
    show_distance = true,
    world_range = 500,
    loot_range = 350,
    base_range = 220,

    workspace_folders = {
        nodes = nil,
        plants = nil,
        animals = nil,
        drops = nil,
        bases = nil,
        loners = nil,
        last = 0
    },

    base_folder_cache = {},
    loot_folder_cache = {},

    last_base_cache = 0,
    last_loot_cache = 0,
    last_loot_signature = "",
    last_base_signature = ""
}

local function k1_color(r, g, b, a)
    return { r = r, g = g, b = b, a = a or 1 }
end

-- NODE_MAP + PLANT_MAP + ANIMAL_MAP + Drops
local K1_WORLD_ITEMS = {
    { id = "stone_node", title = "Stone Node", label = "Stone", folder = "nodes", names = { ["Stone_Node"] = true }, color = k1_color(0.55, 0.55, 0.55, 1) },
    { id = "metal_node", title = "Metal Node", label = "Metal", folder = "nodes", names = { ["Metal_Node"] = true }, color = k1_color(0.70, 0.55, 0.35, 1) },
    { id = "phosphate_node", title = "Phosphate Node", label = "Phosphate", folder = "nodes", names = { ["Phosphate_Node"] = true }, color = k1_color(0.25, 0.85, 0.25, 1) },

    { id = "corn_plant", title = "Corn Plant", label = "Corn", folder = "plants", names = { ["Corn Plant"] = true }, color = k1_color(1.00, 0.90, 0.25, 1) },
    { id = "tomato_plant", title = "Tomato Plant", label = "Tomato", folder = "plants", names = { ["Tomato Plant"] = true }, color = k1_color(1.00, 0.30, 0.30, 1) },
    { id = "lemon_plant", title = "Lemon Plant", label = "Lemon", folder = "plants", names = { ["Lemon Plant"] = true }, color = k1_color(1.00, 1.00, 0.30, 1) },
    { id = "raspberry_plant", title = "Raspberry Plant", label = "Raspberry", folder = "plants", names = { ["Raspberry Plant"] = true }, color = k1_color(0.90, 0.20, 0.50, 1) },
    { id = "blueberry_plant", title = "Blueberry Plant", label = "Blueberry", folder = "plants", names = { ["Blueberry Plant"] = true }, color = k1_color(0.30, 0.35, 1.00, 1) },
    { id = "wool_plant", title = "Wool Plant", label = "Wool", folder = "plants", names = { ["Wool Plant"] = true }, color = k1_color(0.90, 0.90, 0.90, 1) },
    { id = "pumpkin_plant", title = "Pumpkin Plant", label = "Pumpkin", folder = "plants", names = { ["Pumpkin Plant"] = true }, color = k1_color(1.00, 0.50, 0.10, 1) },

    { id = "deer", title = "Deer", label = "Deer", folder = "animals", names = { ["PREFAB_ANIMAL_DEER"] = true, ["Deer"] = true }, color = k1_color(0.65, 0.42, 0.20, 1) },
    { id = "boar", title = "Wild Boar", label = "Boar", folder = "animals", names = { ["PREFAB_ANIMAL_WILDBOAR"] = true, ["Wild Boar"] = true, ["WildBoar"] = true, ["Boar"] = true }, color = k1_color(0.45, 0.32, 0.20, 1) },
    { id = "wolf", title = "Wolf", label = "Wolf", folder = "animals", names = { ["PREFAB_ANIMAL_WOLF"] = true, ["Wolf"] = true }, color = k1_color(0.55, 0.55, 0.55, 1) },

    { id = "dropped_item", title = "Dropped Items", label = "Item", folder = "drops", names = nil, color = k1_color(1.00, 0.80, 0.05, 1) }
}

-- LOOT_MAP from Kaytee
local K1_LOOT_ITEMS = {
    { id = "wooden_crate", title = "Wooden Crate", label = "Wooden Crate", names = { ["Wooden Crate"] = true, ["Locked Wooden Crate"] = true }, color = k1_color(0.60, 0.40, 0.20, 1) },
    { id = "metal_crate", title = "Metal Crate", label = "Metal Crate", names = { ["Metal Crate"] = true, ["Locked Metal Crate"] = true }, color = k1_color(0.55, 0.55, 0.65, 1) },
    { id = "steel_crate", title = "Steel Crate", label = "Steel Crate", names = { ["Steel Crate"] = true, ["Locked Steel Crate"] = true }, color = k1_color(0.75, 0.75, 0.85, 1) },
    { id = "food_crate", title = "Food Crate", label = "Food Crate", names = { ["Food Crate"] = true }, color = k1_color(0.25, 0.85, 0.25, 1) },
    { id = "timed_crate", title = "Timed Crate", label = "Timed Crate", names = { ["Timed Crate"] = true }, color = k1_color(1.00, 0.50, 0.05, 1) },
    { id = "care_package", title = "Care Package", label = "Care Package", names = { ["Care Package"] = true }, color = k1_color(1.00, 0.20, 0.20, 1) },
    { id = "trash_can", title = "Trash Can", label = "Trash Can", names = { ["Trash Can"] = true }, color = k1_color(0.45, 0.45, 0.45, 1) },
    { id = "oil_barrel", title = "Oil Barrel", label = "Oil Barrel", names = { ["Oil Barrel"] = true }, color = k1_color(0.20, 0.20, 0.20, 1) },
    { id = "body_bag", title = "Body Bag", label = "Body Bag", names = { ["Body Bag"] = true }, color = k1_color(0.35, 0.35, 0.35, 1) },
    { id = "sleeper", title = "Sleeper", label = "Sleeper", names = { ["Sleeper"] = true }, color = k1_color(0.80, 0.40, 0.80, 1) },
    { id = "wooden_boat", title = "Wooden Boat", label = "Wooden Boat", names = { ["Wooden Boat"] = true }, color = k1_color(0.55, 0.32, 0.12, 1) },
    { id = "military_boat", title = "Military Boat", label = "Military Boat", names = { ["Military Boat"] = true }, color = k1_color(0.35, 0.45, 0.35, 1) },
    { id = "flycopter", title = "Salvaged Flycopter", label = "Flycopter", names = { ["Salvaged Flycopter"] = true, ["Flycopter"] = true }, color = k1_color(0.50, 0.70, 0.90, 1) }
}

-- BASE_MAP from Kaytee
local K1_BASE_ITEMS = {
    { id = "base_cabinet", title = "Base Cabinet", label = "Base Cabinet", names = { ["Base Cabinet"] = true, ["Cabinet"] = true }, color = k1_color(1.00, 0.80, 0.05, 1), box = true, sx = 4, sy = 4, sz = 4 },
    { id = "storage_cabinet", title = "Storage Cabinet", label = "Storage Cabinet", names = { ["Storage Cabinet"] = true, ["Large Cabinet"] = true }, color = k1_color(0.60, 0.40, 0.20, 1), box = true, sx = 4, sy = 4, sz = 4 },
    { id = "small_box", title = "Small Storage Box", label = "Small Box", names = { ["Small Storage Box"] = true, ["Small Box"] = true }, color = k1_color(0.50, 0.30, 0.10, 1), box = true, sx = 3, sy = 3, sz = 3 },
    { id = "large_box", title = "Large Storage Box", label = "Large Box", names = { ["Large Storage Box"] = true, ["Large Box"] = true }, color = k1_color(0.65, 0.42, 0.20, 1), box = true, sx = 4, sy = 4, sz = 4 },
    { id = "wooden_door", title = "Wooden Door", label = "Wooden Door", names = { ["Wooden Door"] = true }, color = k1_color(0.50, 0.30, 0.10, 1), box = true, sx = 4, sy = 6, sz = 1 },
    { id = "wooden_double_door", title = "Wooden Double Door", label = "Wooden Double Door", names = { ["Wooden Double Door"] = true }, color = k1_color(0.50, 0.30, 0.10, 1), box = true, sx = 6, sy = 6, sz = 1 },
    { id = "salvaged_door", title = "Salvaged Metal Door", label = "Salvaged Door", names = { ["Salvaged Metal Door"] = true }, color = k1_color(0.45, 0.45, 0.55, 1), box = true, sx = 4, sy = 6, sz = 1 },
    { id = "metal_door", title = "Metal Door", label = "Metal Door", names = { ["Metal Door"] = true }, color = k1_color(0.55, 0.55, 0.65, 1), box = true, sx = 4, sy = 6, sz = 1 },
    { id = "metal_double_door", title = "Metal Double Door", label = "Metal Double Door", names = { ["Metal Double Door"] = true }, color = k1_color(0.55, 0.55, 0.65, 1), box = true, sx = 6, sy = 6, sz = 1 },
    { id = "steel_door", title = "Steel Door", label = "Steel Door", names = { ["Steel Door"] = true }, color = k1_color(0.75, 0.75, 0.85, 1), box = true, sx = 4, sy = 6, sz = 1 },
    { id = "steel_double_door", title = "Steel Double Door", label = "Steel Double Door", names = { ["Steel Double Door"] = true }, color = k1_color(0.75, 0.75, 0.85, 1), box = true, sx = 6, sy = 6, sz = 1 },
    { id = "trap_door", title = "Trap Door", label = "Trap Door", names = { ["Trap Door"] = true }, color = k1_color(0.45, 0.38, 0.30, 1), box = true, sx = 4, sy = 1, sz = 4 },
    { id = "triangle_trap_door", title = "Triangle Trap Door", label = "Triangle Trap Door", names = { ["Triangle Trap Door"] = true }, color = k1_color(0.45, 0.38, 0.30, 1), box = true, sx = 4, sy = 1, sz = 4 },
    { id = "garage_door", title = "Garage Door", label = "Garage Door", names = { ["Garage Door"] = true }, color = k1_color(0.50, 0.50, 0.58, 1), box = true, sx = 7, sy = 7, sz = 1 },
    { id = "sleeping_bag", title = "Sleeping Bag", label = "Sleeping Bag", names = { ["Sleeping Bag"] = true }, color = k1_color(0.80, 0.20, 0.20, 1), box = true, sx = 4, sy = 1, sz = 5 },
    { id = "shotgun_turret", title = "Shotgun Turret", label = "Shotgun Turret", names = { ["Shotgun Turret"] = true }, color = k1_color(1.00, 0.30, 0.30, 1), box = true, sx = 4, sy = 4, sz = 4 },
    { id = "auto_turret", title = "Auto Turret", label = "Auto Turret", names = { ["Auto Turret"] = true }, color = k1_color(1.00, 0.20, 0.20, 1), box = true, sx = 4, sy = 4, sz = 4 },
    { id = "small_battery", title = "Small Battery", label = "Small Battery", names = { ["Small Battery"] = true }, color = k1_color(0.20, 0.60, 0.20, 1), box = true, sx = 3, sy = 3, sz = 3 },
    { id = "medium_battery", title = "Medium Battery", label = "Medium Battery", names = { ["Medium Battery"] = true }, color = k1_color(0.30, 0.70, 0.30, 1), box = true, sx = 4, sy = 4, sz = 4 },
    { id = "large_battery", title = "Large Battery", label = "Large Battery", names = { ["Large Battery"] = true }, color = k1_color(0.40, 0.80, 0.40, 1), box = true, sx = 4, sy = 4, sz = 4 },
    { id = "solar_panel", title = "Solar Panel", label = "Solar Panel", names = { ["Solar Panel"] = true }, color = k1_color(0.20, 0.40, 0.85, 1), box = true, sx = 5, sy = 2, sz = 1 },
    { id = "windmill", title = "Windmill", label = "Windmill", names = { ["Windmill"] = true }, color = k1_color(0.65, 0.65, 0.65, 1), box = true, sx = 7, sy = 10, sz = 7 }
}

local function k1_enabled(id)
    return UIManager.GetCheckboxValue("k1_" .. id) == true
end

local function k1_color_value(id, fallback)
    local c = UIManager.GetColorPickerValue("k1_" .. id .. "_color")
    fallback = fallback or k1_color(1, 1, 1, 1)
    if not c then return fallback.r, fallback.g, fallback.b, fallback.a end

    local r = c.r or c.R or c.X or c[1] or fallback.r
    local g = c.g or c.G or c.Y or c[2] or fallback.g
    local b = c.b or c.B or c.Z or c[3] or fallback.b
    local a = c.a or c.A or c.W or c[4] or fallback.a

    if r > 1 then r = r / 255 end
    if g > 1 then g = g / 255 end
    if b > 1 then b = b / 255 end
    if a > 1 then a = a / 255 end

    return r, g, b, a
end

local function k1_children(obj)
    if not obj then return nil end
    local ok, children = pcall(function() return GetChildren(obj) end)
    if ok then return children end
    return nil
end

local function k1_find(parent, name)
    local ok, obj = pcall(function() return FindFirstChild(parent, name) end)
    if ok then return obj end
    return nil
end

local function k1_part_pos(model)
    if not model then return nil end
    if model.Position then return model.Position end

    local children = k1_children(model)
    if not children then return nil end

    for i = 1, #children do
        local child = children[i]
        if child and child.Position and (child.ClassName == "Part" or child.ClassName == "MeshPart" or child.ClassName == "UnionOperation") then
            return child.Position
        end
    end

    for i = 1, #children do
        local child = children[i]
        if child and child.ClassName == "Model" then
            local pos = k1_part_pos(child)
            if pos then return pos end
        end
    end

    return nil
end

local function k1_part_info(model)
    if not model then return nil end

    local function make_info(part)
        if not part or not part.Position then return nil end

        local sx, sy, sz = 4, 4, 4
        if part.Size then
            sx = part.Size.X or sx
            sy = part.Size.Y or sy
            sz = part.Size.Z or sz
        end

        return {
            pos = part.Position,
            sx = sx,
            sy = sy,
            sz = sz
        }
    end

    -- For models from Bases this is usually the correct center.
    local main = k1_find(model, "Main")
    local info = make_info(main)
    if info then return info end

    local primary = k1_find(model, "PrimaryPart")
    info = make_info(primary)
    if info then return info end

    info = make_info(model)
    if info then return info end

    local children = k1_children(model)
    if not children then return nil end

    -- Prefer the largest part, not the first tiny detail on the side.
    local best = nil
    local best_volume = -1

    for i = 1, #children do
        local child = children[i]
        if child and child.Position and child.Size and (child.ClassName == "Part" or child.ClassName == "MeshPart" or child.ClassName == "UnionOperation") then
            local sx = child.Size.X or 1
            local sy = child.Size.Y or 1
            local sz = child.Size.Z or 1
            local volume = sx * sy * sz

            if volume > best_volume then
                best_volume = volume
                best = child
            end
        end
    end

    info = make_info(best)
    if info then return info end

    for i = 1, #children do
        local child = children[i]
        if child and child.ClassName == "Model" then
            info = k1_part_info(child)
            if info then return info end
        end
    end

    return nil
end

local function k1_dist(a, b)
    local dx = a.X - b.X
    local dy = a.Y - b.Y
    local dz = a.Z - b.Z
    return math.sqrt(dx * dx + dy * dy + dz * dz) * 0.28
end

local function k1_screen(pos)
    local s = Drawing.WorldToScreen(pos)
    if s and s.X and s.X ~= -1 then return s end
    return nil
end

local function k1_draw_box3d(pos, sx, sy, sz, r, g, b, a, thickness)
    -- Your working example used global DrawBox3D, not Drawing.DrawBox3D.
    if DrawBox3D then
        return
    end

    if Drawing and Drawing.DrawBox3D then
    end
end

local function k1_draw_line(x1, y1, x2, y2, r, g, b, a, thickness)
    if Drawing.DrawLine then
        Drawing.DrawLine(x1, y1, x2, y2, r, g, b, a, thickness or 1)
    end
end

local function k1_draw_2d_box(x, y, w, h, r, g, b, a)
    if w < 2 or h < 2 then return end

    local len = math.min(18, math.max(6, math.min(w, h) * 0.28))
    local th = 2

    -- corner style: cleaner than giant full cube
    k1_draw_line(x, y, x + len, y, r, g, b, a, th)
    k1_draw_line(x, y, x, y + len, r, g, b, a, th)

    k1_draw_line(x + w, y, x + w - len, y, r, g, b, a, th)
    k1_draw_line(x + w, y, x + w, y + len, r, g, b, a, th)

    k1_draw_line(x, y + h, x + len, y + h, r, g, b, a, th)
    k1_draw_line(x, y + h, x, y + h - len, r, g, b, a, th)

    k1_draw_line(x + w, y + h, x + w - len, y + h, r, g, b, a, th)
    k1_draw_line(x + w, y + h, x + w, y + h - len, r, g, b, a, th)
end

local function k1_base_screen_box_size(id, dist)
    local base_w = 46
    local base_h = 30

    if id == "wooden_door" or id == "salvaged_door" or id == "metal_door" or id == "steel_door" then
        base_w, base_h = 34, 58
    elseif id == "wooden_double_door" or id == "metal_double_door" or id == "steel_double_door" or id == "garage_door" then
        base_w, base_h = 58, 58
    elseif id == "small_box" then
        base_w, base_h = 32, 24
    elseif id == "large_box" or id == "storage_cabinet" or id == "base_cabinet" then
        base_w, base_h = 42, 34
    elseif id == "sleeping_bag" then
        base_w, base_h = 54, 20
    elseif id == "shotgun_turret" or id == "auto_turret" then
        base_w, base_h = 36, 36
    elseif id == "solar_panel" then
        base_w, base_h = 56, 24
    elseif id == "windmill" then
        base_w, base_h = 70, 90
    end

    local scale = 1.0
    if dist > 0 then
        scale = math.max(0.45, math.min(1.35, 42 / dist))
    end

    return base_w * scale, base_h * scale
end

local function k1_part_data(part)
    if not part or not part.Position then return nil end

    local sx, sy, sz = 2, 2, 2
    if part.Size then
        sx = part.Size.X or sx
        sy = part.Size.Y or sy
        sz = part.Size.Z or sz
    end

    return {
        x = part.Position.X,
        y = part.Position.Y,
        z = part.Position.Z,
        sx = sx,
        sy = sy,
        sz = sz
    }
end

local function k1_collect_model_parts(model)
    local parts = {}

    local main = k1_find(model, "Main")
    local data = k1_part_data(main)
    if data then
        parts[#parts + 1] = data
    end

    local children = k1_children(model)
    if children then
        for _, child in ipairs(children) do
            if #parts >= 12 then break end

            if child and child.Position and (child.ClassName == "Part" or child.ClassName == "MeshPart" or child.ClassName == "UnionOperation") then
                data = k1_part_data(child)
                if data then parts[#parts + 1] = data end
            end
        end
    end

    if #parts == 0 then
        local pos = k1_part_pos(model)
        if pos then
            parts[1] = {
                x = pos.X,
                y = pos.Y,
                z = pos.Z,
                sx = 3,
                sy = 3,
                sz = 3
            }
        end
    end

    return parts
end

local function k1_project_bounds(parts)
    if not parts or #parts == 0 then return nil end

    local min_x, min_y = 999999, 999999
    local max_x, max_y = -999999, -999999
    local valid = false

    for _, p in ipairs(parts) do
        local hx = (p.sx or 2) * 0.5
        local hy = (p.sy or 2) * 0.5
        local hz = (p.sz or 2) * 0.5

        local corners = {
            {p.x - hx, p.y - hy, p.z - hz},
            {p.x + hx, p.y - hy, p.z - hz},
            {p.x - hx, p.y + hy, p.z - hz},
            {p.x + hx, p.y + hy, p.z - hz},
            {p.x - hx, p.y - hy, p.z + hz},
            {p.x + hx, p.y - hy, p.z + hz},
            {p.x - hx, p.y + hy, p.z + hz},
            {p.x + hx, p.y + hy, p.z + hz}
        }

        for i = 1, 8 do
            local c = corners[i]
            local s = Drawing.WorldToScreen({ X = c[1], Y = c[2], Z = c[3] })

            if s and s.X and s.X ~= -1 then
                valid = true
                if s.X < min_x then min_x = s.X end
                if s.X > max_x then max_x = s.X end
                if s.Y < min_y then min_y = s.Y end
                if s.Y > max_y then max_y = s.Y end
            end
        end
    end

    if not valid then return nil end

    local w = max_x - min_x
    local h = max_y - min_y

    if w <= 1 or h <= 1 then return nil end

    -- clamp absurd boxes caused by offscreen corner projection
    if w > 900 or h > 700 then return nil end

    return min_x, min_y, w, h
end

local function k1_refresh_folders()
    local now = tick()
    if now - k1.workspace_folders.last < 6 and k1.workspace_folders.bases then return end

    k1.workspace_folders.last = now
    k1.workspace_folders.nodes = k1_find("Workspace", "Nodes")
    k1.workspace_folders.plants = k1_find("Workspace", "Plants")
    k1.workspace_folders.animals = k1_find("Workspace", "Animals")
    k1.workspace_folders.drops = k1_find("Workspace", "Drops")
    k1.workspace_folders.bases = k1_find("Workspace", "Bases")
    k1.workspace_folders.loners = k1.workspace_folders.bases and k1_find(k1.workspace_folders.bases, "Loners") or nil
end

local function k1_any(list)
    for _, cfg in ipairs(list) do
        if k1_enabled(cfg.id) then return true end
    end
    return false
end

local function k1_signature(list)
    local sig = ""

    for _, cfg in ipairs(list) do
        if k1_enabled(cfg.id) then
            sig = sig .. cfg.id .. ";"
        end
    end

    return sig
end

local function k1_draw(pos, label, id, color, range, my, box, sx, sy, sz, is_base)
    if not pos then return end

    local dist = k1_dist(pos, my)
    if dist > range then return end

    local s = k1_screen(pos)
    if not s then return end

    local r, g, b, a = k1_color_value(id, color)

    if box and ((not is_base) or UIManager.GetCheckboxValue("k1_base_outline")) then
        k1_draw_box3d(pos, sx or 4, sy or 4, sz or 4, r, g, b, a, 2)
    end

    if (not is_base) or UIManager.GetCheckboxValue("k1_base_text") then
        Drawing.DrawTextWithOutline(s.X, s.Y, label, r, g, b, a, 0, 0, 0, 1)

        if UIManager.GetCheckboxValue("k1_show_distance") then
            Drawing.DrawTextWithOutline(s.X, s.Y + 14, string.format("%.0fm", dist), r, g, b, a, 0, 0, 0, 1)
        end
    end
end

local function k1_draw_world(my)
    if not k1_any(K1_WORLD_ITEMS) then return end

    k1_refresh_folders()

    local range = UIManager.GetSliderIntValue("k1_world_range") or 500

    for _, cfg in ipairs(K1_WORLD_ITEMS) do
        if k1_enabled(cfg.id) then
            local folder = k1.workspace_folders[cfg.folder]
            local children = k1_children(folder)

            if children then
                for i = 1, #children do
                    local model = children[i]
                    if model and model.Name and (not cfg.names or cfg.names[model.Name]) then
                        local pos = k1_part_pos(model)
                        local label = cfg.id == "dropped_item" and (model.Name or cfg.label) or cfg.label
                        k1_draw(pos, label, cfg.id, cfg.color, range, my, false)
                    end
                end
            end
        end
    end
end

local function k1_rescan_loot()
    k1.loot_folder_cache = {}

    if not k1_any(K1_LOOT_ITEMS) then return end

    k1_refresh_folders()

    local loners = k1.workspace_folders.loners
    local type_folders = k1_children(loners)
    if not type_folders then return end

    for _, type_folder in ipairs(type_folders) do
        if #k1.loot_folder_cache >= 120 then break end

        if type_folder and type_folder.Name then
            for _, cfg in ipairs(K1_LOOT_ITEMS) do
                if k1_enabled(cfg.id) and cfg.names[type_folder.Name] then
                    local models = k1_children(type_folder)

                    if models then
                        for _, model in ipairs(models) do
                            if #k1.loot_folder_cache >= 120 then break end

                            local pos = nil

                            local main = k1_find(model, "Main")
                            if main and main.Position then pos = main.Position end

                            if not pos then
                                local inner = k1_find(model, type_folder.Name)
                                local inner_main = inner and k1_find(inner, "Main")
                                if inner_main and inner_main.Position then pos = inner_main.Position end
                            end

                            if not pos then
                                pos = k1_part_pos(model)
                            end

                            if pos then
                                table.insert(k1.loot_folder_cache, {
                                    pos = pos,
                                    cfg = cfg
                                })
                            end
                        end
                    end

                    break
                end
            end
        end
    end
end

local function k1_draw_loot(my)
    if not k1_any(K1_LOOT_ITEMS) then
        k1.loot_folder_cache = {}
        k1.last_loot_signature = ""
        return
    end

    local now = tick()
    local sig = k1_signature(K1_LOOT_ITEMS)

    if sig ~= k1.last_loot_signature then
        k1.last_loot_signature = sig
        k1.last_loot_cache = now

        pcall(function()
            k1_rescan_loot()
        end)
    end

    local range = UIManager.GetSliderIntValue("k1_loot_range") or 350

    for _, entry in ipairs(k1.loot_folder_cache) do
        if entry and entry.cfg and entry.pos and k1_enabled(entry.cfg.id) then
            k1_draw(entry.pos, entry.cfg.label, entry.cfg.id, entry.cfg.color, range, my, false)
        end
    end
end

local function k1_rescan_base()
    k1.base_folder_cache = {}

    k1_refresh_folders()

    local bases = k1.workspace_folders.bases
    local bases_children = k1_children(bases)
    if not bases_children then return end

    for _, base_folder in ipairs(bases_children) do
        if #k1.base_folder_cache >= 180 then break end

        if base_folder and base_folder.Name ~= "Loners" then
            local base_children = k1_children(base_folder)

            if base_children then
                for _, type_folder in ipairs(base_children) do
                    if #k1.base_folder_cache >= 180 then break end

                    if type_folder and type_folder.Name then
                        for _, cfg in ipairs(K1_BASE_ITEMS) do
                            if k1_enabled(cfg.id) and cfg.names[type_folder.Name] then
                                local children = k1_children(type_folder)

                                if children then
                                    for _, model in ipairs(children) do
                                        if #k1.base_folder_cache >= 180 then break end

                                        if model and model.ClassName == "Model" then
                                            local pos = k1_part_pos(model)

                                            if pos then
                                                table.insert(k1.base_folder_cache, {
                                                    pos = pos,
                                                    cfg = cfg
                                                })
                                            end
                                        end
                                    end
                                else
                                    local pos = k1_part_pos(type_folder)

                                    if pos then
                                        table.insert(k1.base_folder_cache, {
                                            pos = pos,
                                            cfg = cfg
                                        })
                                    end
                                end

                                break
                            end
                        end
                    end
                end
            end
        end
    end
end

local function k1_draw_base(my)
    if not k1_any(K1_BASE_ITEMS) then
        k1.base_folder_cache = {}
        k1.last_base_signature = ""
        return
    end

    local now = tick()
    local sig = k1_signature(K1_BASE_ITEMS)

    if sig ~= k1.last_base_signature then
        k1.last_base_signature = sig
        k1.last_base_cache = now
        pcall(function()
            k1_rescan_base()
        end)
    end

    local range = UIManager.GetSliderIntValue("k1_base_range") or 220

    for _, entry in ipairs(k1.base_folder_cache) do
        if entry and entry.cfg and k1_enabled(entry.cfg.id) and entry.pos then
            local dist = k1_dist(entry.pos, my)

            if dist <= range then
                local screen = k1_screen(entry.pos)

                if screen then
                    local r, g, b, a = k1_color_value(entry.cfg.id, entry.cfg.color)
                if true then
                        Drawing.DrawTextWithOutline(screen.X, screen.Y, entry.cfg.label, r, g, b, a, 0, 0, 0, 1)

                        if UIManager.GetCheckboxValue("k1_show_distance") then
                            Drawing.DrawTextWithOutline(screen.X, screen.Y + 14, string.format("%.0fm", dist), r, g, b, a, 0, 0, 0, 1)
                        end
                    end
                end
            end
        end
    end
end


local function k1_create_item(cfg)
    UIManager.CreateCheckbox("k1_" .. cfg.id, cfg.title, false)
    UIManager.SetElementParent("k1_" .. cfg.id, K1_TAB)

    UIManager.CreateColorPicker("k1_" .. cfg.id .. "_color", "", cfg.color.r, cfg.color.g, cfg.color.b, cfg.color.a)
    UIManager.SetElementParent("k1_" .. cfg.id .. "_color", K1_TAB)
    UIManager.SetElementSameLine("k1_" .. cfg.id .. "_color", true)
end

-- Fallen ESP uses main Fallen tab

UIManager.CreateSeparator("fallen_sep_esp")
UIManager.SetElementParent("fallen_sep_esp", TAB_ID)

UIManager.CreateText("k1_world_title", "World")
UIManager.SetElementParent("k1_world_title", K1_TAB)
UIManager.CreateSliderInt("k1_world_range", "World Range", 25, 2000, 500)
UIManager.SetElementParent("k1_world_range", K1_TAB)
for _, cfg in ipairs(K1_WORLD_ITEMS) do k1_create_item(cfg) end

UIManager.CreateSeparator("k1_sep_loot")
UIManager.SetElementParent("k1_sep_loot", K1_TAB)
UIManager.CreateText("k1_loot_title", "Loot")
UIManager.SetElementParent("k1_loot_title", K1_TAB)
UIManager.CreateSliderInt("k1_loot_range", "Loot Range", 25, 2000, 350)
UIManager.SetElementParent("k1_loot_range", K1_TAB)
for _, cfg in ipairs(K1_LOOT_ITEMS) do k1_create_item(cfg) end

UIManager.CreateSeparator("k1_sep_base")
UIManager.SetElementParent("k1_sep_base", K1_TAB)
UIManager.CreateText("k1_base_title", "Base")
UIManager.SetElementParent("k1_base_title", K1_TAB)
UIManager.CreateSliderInt("k1_base_range", "Base Range", 25, 2000, 220)
UIManager.SetElementParent("k1_base_range", K1_TAB)

UIManager.CreateCheckbox("k1_base_text", "Base Text", true)
UIManager.SetElementParent("k1_base_text", K1_TAB)

for _, cfg in ipairs(K1_BASE_ITEMS) do k1_create_item(cfg) end

UIManager.CreateSeparator("k1_sep_misc")
UIManager.SetElementParent("k1_sep_misc", K1_TAB)
UIManager.CreateCheckbox("k1_show_distance", "Show Distance", true)
UIManager.SetElementParent("k1_show_distance", K1_TAB)

UIManager.CreateButton("k1_force_rescan", "Force Rescan", function()
    k1.workspace_folders.last = 0
    k1.last_base_cache = 0
    k1.last_loot_cache = 0
    k1.last_loot_signature = ""
    k1.last_base_signature = ""
    k1.base_folder_cache = {}
    k1.loot_folder_cache = {}
    notify("Fallen ESP rescan forced", "success")
end)
UIManager.SetElementParent("k1_force_rescan", K1_TAB)

hooks.on_render(function()
    if not k1_any(K1_WORLD_ITEMS) and not k1_any(K1_LOOT_ITEMS) and not k1_any(K1_BASE_ITEMS) then
        return
    end

    local my = GetMyPosition()
    if not my then return end

    k1_draw_world(my)
    k1_draw_loot(my)
    k1_draw_base(my)
end)

notify("Fallen ESP no periodic rescan loaded", "success")

local function fallen_get_turret_health(inst)
    if not inst then
        return nil
    end

    local hp = nil

    pcall(function()
        local h = inst:find_first_child("Health")
        if h then
            hp = h:get_value()
        end
    end)

    if not hp then
        pcall(function()
            local h = inst:find_first_child("HP")
            if h then
                hp = h:get_value()
            end
        end)
    end

    if not hp then
        pcall(function()
            local h = inst:find_first_child("HitPoints")
            if h then
                hp = h:get_value()
            end
        end)
    end

    if not hp then
        pcall(function()
            hp = inst.health
        end)
    end

    hp = tonumber(hp)
    if not hp then
        return nil
    end

    if hp < 0 then hp = 0 end
    if hp > 250 then hp = 250 end

    return hp
end

local function fallen_draw_turret_hp(x, y, hp)
    if not hp then
        return
    end

    local text = string.format("HP: %.0f/250", hp)
    Drawing.DrawTextWithOutline(
        x, y,
        text,
        0.3, 1.0, 0.3, 1.0,
        0.0, 0.0, 0.0, 1.0
    )
end

notify("Fallen: Armor + ESP loaded", "success")


----------------------------------------------------------------
-- NPC ESP MODULE (MilitaryHitbox + Bosses) | merged with Armor/World/Loot/Base
----------------------------------------------------------------
do
local NPC_CFG = {
    enabled = false,
    mil_enabled = true,
    mil_range = 400,
    mil_box = true,
    mil_name = true,
    mil_hp = true,
    mil_dist = true,
    mil_skel = false,
    mil_col_box  = {1.00, 0.30, 0.30, 1},
    mil_col_name = {1.00, 1.00, 1.00, 1},
    mil_col_hp   = {0.20, 1.00, 0.30, 1},
    mil_col_dist = {0.85, 0.85, 0.85, 1},
    mil_col_skel = {1.00, 0.30, 0.30, 1},

    boss_enabled = true,
    boris = true,
    bruno = true,
    brutus = true,
    boss_range = 400,
    boss_box = true,
    boss_name = true,
    boss_hp = true,
    boss_dist = true,
    boss_skel = false,
    boris_col  = {0.78, 0.42, 1.00, 1},
    bruno_col  = {1.00, 0.65, 0.20, 1},
    brutus_col = {1.00, 0.30, 0.48, 1},
    boss_col_box  = {1.00, 0.55, 0.15, 1},
    boss_col_name = {1.00, 1.00, 1.00, 1},
    boss_col_hp   = {0.20, 1.00, 0.30, 1},
    boss_col_dist = {0.85, 0.85, 0.85, 1},
    boss_col_skel = {1.00, 0.55, 0.15, 1},
}

local npc_cache, npc_order = {}, {}
local npc_last_scan, npc_last_poll = 0, 0
local NPC_SCAN_EVERY, NPC_POLL_EVERY = 0.40, 0.05
local NPC_DECOY_Y, NPC_HOLD = -1000, 0.28
local npc_debug = "npc init"

local function nsafe(fn, fb)
    local ok, a = pcall(fn)
    if ok then return a end
    return fb
end

local function nalive(inst)
    if not inst then return false end
    return nsafe(function()
        if inst.is_valid then return inst:is_valid() end
        return true
    end, true) ~= false
end

local function nchildren(inst)
    return nsafe(function() return inst:get_children() end, {}) or {}
end

local function nchild(inst, name)
    if not inst then return nil end
    return nsafe(function() return inst:find_first_child(name) end, nil)
end

local function nclass(inst, cn)
    if not inst then return nil end
    return nsafe(function() return inst:find_first_child_of_class(cn) end, nil)
end

local function nis_a(inst, cn)
    return nsafe(function() return inst:is_a(cn) end, false) == true
end

local function nis_part(inst)
    if not inst then return false end
    if nis_a(inst, "BasePart") or nis_a(inst, "Part") or nis_a(inst, "MeshPart") then return true end
    local c = nsafe(function() return inst:get_class() end, "")
    return c == "Part" or c == "MeshPart" or c == "BasePart" or c == "UnionOperation"
end

local function npos(inst)
    if not nalive(inst) then return nil end
    return nsafe(function() return inst:get_position() end, nil)
end

local function nxyz(p)
    if not p then return nil end
    local x, y, z = p.X or p.x, p.Y or p.y, p.Z or p.z
    if type(x) == "number" and type(y) == "number" and type(z) == "number" then return x, y, z end
    return nil
end

local function nget_xyz(inst)
    return nxyz(npos(inst))
end

local function nfirst_part(root, depth)
    depth = depth or 0
    if not root or depth > 8 then return nil end
    if nis_part(root) then return root end
    local names = {"HumanoidRootPart","UpperTorso","LowerTorso","Torso","Head","Main","Root","PrimaryPart"}
    for i = 1, #names do
        local c = nchild(root, names[i])
        if c and nis_part(c) then return c end
    end
    local by = nclass(root, "BasePart") or nclass(root, "Part") or nclass(root, "MeshPart")
    if by then return by end
    for _, ch in ipairs(nchildren(root)) do
        local p = nfirst_part(ch, depth + 1)
        if p then return p end
    end
    return nil
end

-- боссы: моделька Boris/Bruno/Brutus может быть не прямым ребёнком, а глубже
local function nfind_name_deep(root, want, depth)
    depth = depth or 0
    if not root or depth > 6 then return false end
    local n = nsafe(function() return root:get_name() end, "") or ""
    local ln = string.lower(tostring(n))
    if ln == want or ln:find(want, 1, true) then return true end
    for _, ch in ipairs(nchildren(root)) do
        if nfind_name_deep(ch, want, depth + 1) then return true end
    end
    return false
end

local function ndetect_kind(rig)
    if nchild(rig, "Boris") or nfind_name_deep(rig, "boris") then return "boris" end
    if nchild(rig, "Bruno") or nfind_name_deep(rig, "bruno") then return "bruno" end
    if nchild(rig, "Brutus") or nfind_name_deep(rig, "brutus") then return "brutus" end
    -- иногда имя самого рига
    local rn = string.lower(tostring(nsafe(function() return rig:get_name() end, "") or ""))
    if rn:find("boris", 1, true) then return "boris" end
    if rn:find("bruno", 1, true) then return "bruno" end
    if rn:find("brutus", 1, true) then return "brutus" end
    return "soldier"
end

local function nread_hp(rig)
    local hum = nclass(rig, "Humanoid") or nchild(rig, "Humanoid")
    if not hum then return nil, nil end
    local hp = tonumber(nsafe(function() return hum:health() end, nil))
    local mx = tonumber(nsafe(function() return hum:max_health() end, nil))
    if hp then return hp, mx or 100 end
    return nil, nil
end

local function nlocal_xyz()
    if players and players.get_local then
        local lp = nsafe(function() return players.get_local() end, nil)
        if lp and lp.position then
            local x, y, z = nxyz(lp.position)
            if x then return x, y, z end
        end
    end
    local hrp = nsafe(function() return rbx.local_hrp() end, nil)
    return nget_xyz(hrp)
end

local function nw2s(x, y, z)
    local pos = Vector3 and Vector3(x, y, z) or {X=x,Y=y,Z=z}
    if aim and aim.world_to_screen then
        local s = nsafe(function() return aim.world_to_screen(pos) end, nil)
        if s and s.visible then
            local sx, sy = s.X or s.x, s.Y or s.y
            if type(sx) == "number" then return sx, sy end
        end
    end
    if rbx and rbx.world_to_screen then
        local s = nsafe(function() return rbx.world_to_screen(pos) end, nil)
        if s and s.visible ~= false then
            local sx, sy = s.X or s.x, s.Y or s.y
            if type(sx) == "number" and sx >= 0 then return sx, sy end
        end
    end
    return nil
end

local function nkey(inst, i)
    if inst and inst.addr then return tostring(inst.addr) end
    return tostring(i)
end

local function nscan()
    local ws = nsafe(function() return rbx.workspace() end, nil)
    if not nalive(ws) then npc_debug = "no workspace"; return end
    local animals = nchild(ws, "Animals")
    if not animals then npc_debug = "no Animals"; return end
    local mv = nchild(animals, "MilitaryVisuals")
    if not mv then npc_debug = "no MilitaryVisuals"; return end

    local list = nchildren(mv)
    local seen, live_n, pool_n = {}, 0, 0
    local t = tick()

    for i = 1, #list do
        local rig = list[i]
        if nalive(rig) then
            local root = nfirst_part(rig, 0)
            if root then
                local x, y, z = nget_xyz(root)
                if x then
                    local key = nkey(rig, i)
                    if y <= NPC_DECOY_Y then
                        pool_n = pool_n + 1
                        local e = npc_cache[key]
                        if e and e.status == "alive" then
                            e.status = "pool"
                            e.lost_at = t
                        end
                    else
                        live_n = live_n + 1
                        seen[key] = true
                        local head = nchild(rig, "Head")
                        local ax, ay, az = x, y + 1.6, z
                        if head then
                            local hx, hy, hz = nget_xyz(head)
                            if hx and hy > -1000 then ax, ay, az = hx, hy, hz end
                        end
                        local kind = ndetect_kind(rig)
                        local hp, maxhp = nread_hp(rig)
                        local e = npc_cache[key]
                        if not e then
                            e = { key = key }
                            npc_cache[key] = e
                            npc_order[#npc_order + 1] = key
                        end
                        e.kind = kind
                        e.name = ({soldier="Military",boris="Boris",bruno="Bruno",brutus="Brutus"})[kind]
                        e.status = (hp == 0) and "dead" or "alive"
                        e.rig, e.root, e.head = rig, root, head
                        e.x, e.y, e.z = ax, ay, az
                        e.fx, e.fy, e.fz = x, y, z
                        e.hp, e.maxhp = hp, maxhp
                        e.seen_at = t
                        if e.status == "dead" then e.lost_at = t end
                    end
                end
            end
        end
    end

    for key, e in pairs(npc_cache) do
        if e.status == "alive" and not seen[key] then
            e.status = (e.hp == 0) and "dead" or "pool"
            e.lost_at = t
        end
    end

    for key, e in pairs(npc_cache) do
        if e.status ~= "alive" and e.lost_at and (t - e.lost_at) > 5 then
            npc_cache[key] = nil
        end
    end
    local no = {}
    for i = 1, #npc_order do
        if npc_cache[npc_order[i]] then no[#no+1] = npc_order[i] end
    end
    npc_order = no
    local nb, nbru, nbrt, ns = 0, 0, 0, 0
    for key, e in pairs(npc_cache) do
        if e.status == "alive" then
            if e.kind == "boris" then nb = nb + 1
            elseif e.kind == "bruno" then nbru = nbru + 1
            elseif e.kind == "brutus" then nbrt = nbrt + 1
            else ns = ns + 1 end
        end
    end
    npc_debug = string.format("live=%d pool=%d kids=%d | M=%d Bo=%d Br=%d Bt=%d", live_n, pool_n, #list, ns, nb, nbru, nbrt)
end

local function npoll()
    local t = tick()
    for _, key in ipairs(npc_order) do
        local e = npc_cache[key]
        if e and e.status == "alive" and nalive(e.root) then
            local x, y, z = nget_xyz(e.root)
            if x and y > NPC_DECOY_Y then
                local ax, ay, az = x, y + 1.6, z
                if e.head and nalive(e.head) then
                    local hx, hy, hz = nget_xyz(e.head)
                    if hx and hy > -1000 then ax, ay, az = hx, hy, hz end
                end
                e.x, e.y, e.z = ax, ay, az
                e.fx, e.fy, e.fz = x, y, z
                e.seen_at = t
                local hp, maxhp = nread_hp(e.rig)
                if hp then
                    e.hp, e.maxhp = hp, maxhp
                    if hp <= 0 then e.status = "dead"; e.lost_at = t end
                end
            else
                e.status = "pool"; e.lost_at = t
            end
        end
    end
end

local function ncol4(c)
    return c[1] or 1, c[2] or 1, c[3] or 1, c[4] or 1
end

local function nis_boss(k)
    return k == "boris" or k == "bruno" or k == "brutus"
end

local function nboss_on(k)
    if k == "boris" then return NPC_CFG.boris end
    if k == "bruno" then return NPC_CFG.bruno end
    if k == "brutus" then return NPC_CFG.brutus end
    return false
end

local function nboss_color(k)
    if k == "boris" then return NPC_CFG.boris_col end
    if k == "bruno" then return NPC_CFG.bruno_col end
    if k == "brutus" then return NPC_CFG.brutus_col end
    return NPC_CFG.boss_col_box
end

local function ndraw_skel(e, c)
    local r, g, b, a = ncol4(c)
    local pts = {
        {e.x, e.y, e.z},
        {e.fx, (e.fy or 0) + 1.0, e.fz},
        {e.fx, (e.fy or 0) + 0.2, e.fz},
        {e.fx, (e.fy or 0) - 1.4, e.fz},
        {(e.fx or 0) - 0.7, (e.fy or 0) + 0.9, e.fz},
        {(e.fx or 0) + 0.7, (e.fy or 0) + 0.9, e.fz},
    }
    local scr = {}
    for i = 1, #pts do
        local sx, sy = nw2s(pts[i][1], pts[i][2], pts[i][3])
        if sx then scr[i] = {sx, sy} end
    end
    local function ln(i, j)
        if scr[i] and scr[j] then
            nsafe(function()
                Drawing.DrawLine(scr[i][1], scr[i][2], scr[j][1], scr[j][2], r, g, b, a, 1.2)
            end)
        end
    end
    ln(1,2) ln(2,3) ln(3,4) ln(2,5) ln(2,6)
end

-- Per-id state: не полагаемся только на GetCheckboxValue (у BB иногда путаются одинаковые label)
local NPC_UI = {}

local function nui_check(id, fallback)
    if NPC_UI[id] ~= nil then
        return NPC_UI[id] == true
    end
    if UIManager and UIManager.GetCheckboxValue then
        local v = nsafe(function() return UIManager.GetCheckboxValue(id) end, nil)
        if v ~= nil then
            NPC_UI[id] = (v == true)
            return NPC_UI[id]
        end
    end
    return fallback and true or false
end

local function nui_slider(id, fallback)
    if UIManager and UIManager.GetSliderIntValue then
        local v = nsafe(function() return UIManager.GetSliderIntValue(id) end, nil)
        if type(v) == "number" then return v end
    end
    return fallback
end

local function nui_color(id, fallback)
    local fb = fallback or {1,1,1,1}
    if UIManager and UIManager.GetColorPickerValue then
        local c = nsafe(function() return UIManager.GetColorPickerValue(id) end, nil)
        if c then
            local r = c.r or c.R or c.X or c[1] or fb[1]
            local g = c.g or c.G or c.Y or c[2] or fb[2]
            local b = c.b or c.B or c.Z or c[3] or fb[3]
            local a = c.a or c.A or c.W or c[4] or fb[4] or 1
            if r > 1 then r = r / 255 end
            if g > 1 then g = g / 255 end
            if b > 1 then b = b / 255 end
            if a > 1 then a = a / 255 end
            return {r, g, b, a}
        end
    end
    return fb
end

local function ndraw_one(e, lx, ly, lz)
    local boss = nis_boss(e.kind)

    -- LIVE read from UI (как World ESP) — Military и Bosses полностью раздельно
    local mil_on  = nui_check("fn_mil_en", NPC_CFG.mil_enabled)
    local boss_on_master = nui_check("fn_boss_en", NPC_CFG.boss_enabled)

    if boss then
        if not boss_on_master then return end
        if e.kind == "boris"  and not nui_check("fn_boris",  NPC_CFG.boris)  then return end
        if e.kind == "bruno"  and not nui_check("fn_bruno",  NPC_CFG.bruno)  then return end
        if e.kind == "brutus" and not nui_check("fn_brutus", NPC_CFG.brutus) then return end
    else
        if not mil_on then return end
    end

    local range = boss and nui_slider("fn_boss_range", NPC_CFG.boss_range) or nui_slider("fn_mil_range", NPC_CFG.mil_range)
    local dx, dy, dz = e.x - lx, e.y - ly, e.z - lz
    local dist = math.sqrt(dx*dx + dy*dy + dz*dz)
    if dist > range then return end

    local show_box, show_name, show_hp, show_dist, show_skel
    local col_box, col_name, col_hp, col_dist, col_skel

    if boss then
        show_box  = nui_check("fn_boss_box",  NPC_CFG.boss_box)
        show_name = nui_check("fn_boss_name", NPC_CFG.boss_name)
        show_hp   = nui_check("fn_boss_hp",   NPC_CFG.boss_hp)
        show_dist = nui_check("fn_boss_dist", NPC_CFG.boss_dist)
        show_skel = nui_check("fn_boss_skel", NPC_CFG.boss_skel)
        -- цвет босса: персональный, иначе общий box color
        if e.kind == "boris" then
            col_box = nui_color("fn_boris_c", NPC_CFG.boris_col)
        elseif e.kind == "bruno" then
            col_box = nui_color("fn_bruno_c", NPC_CFG.bruno_col)
        else
            col_box = nui_color("fn_brutus_c", NPC_CFG.brutus_col)
        end
        col_name = nui_color("fn_boss_name_c", NPC_CFG.boss_col_name)
        col_hp   = nui_color("fn_boss_hp_c",   NPC_CFG.boss_col_hp)
        col_dist = nui_color("fn_boss_dist_c", NPC_CFG.boss_col_dist)
        col_skel = nui_color("fn_boss_skel_c", NPC_CFG.boss_col_skel)
        -- если box color для боссов задан отдельно — для рамки можно смешать:
        local box_override = nui_color("fn_boss_box_c", NPC_CFG.boss_col_box)
        -- рамка = цвет типа босса (boris/bruno/brutus), имя/хп/дист = их пикеры
        if not col_box then col_box = box_override end
    else
        show_box  = nui_check("fn_mil_box",  NPC_CFG.mil_box)
        show_name = nui_check("fn_mil_name", NPC_CFG.mil_name)
        show_hp   = nui_check("fn_mil_hp",   NPC_CFG.mil_hp)
        show_dist = nui_check("fn_mil_dist", NPC_CFG.mil_dist)
        show_skel = nui_check("fn_mil_skel", NPC_CFG.mil_skel)
        col_box  = nui_color("fn_mil_box_c",  NPC_CFG.mil_col_box)
        col_name = nui_color("fn_mil_name_c", NPC_CFG.mil_col_name)
        col_hp   = nui_color("fn_mil_hp_c",   NPC_CFG.mil_col_hp)
        col_dist = nui_color("fn_mil_dist_c", NPC_CFG.mil_col_dist)
        col_skel = nui_color("fn_mil_skel_c", NPC_CFG.mil_col_skel)
    end

    -- голова / ноги: чуть расширяем по высоте, чтобы бокс закрывал тело
    local head_y = e.y + 0.35
    local feet_y = (e.fy or e.y) - 2.0
    local sx, sy = nw2s(e.x, head_y, e.z)
    local fx, fy = nw2s(e.fx or e.x, feet_y, e.fz or e.z)
    if not sx then return end

    local top = fy and math.min(sy, fy) or (sy - 40)
    local bot = fy and math.max(sy, fy) or (sy + 16)
    -- паддинг по вертикали/горизонтали — бокс крупнее
    local pad_y = math.max(4, (bot - top) * 0.08)
    top = top - pad_y
    bot = bot + pad_y
    local h = math.max(28, bot - top)
    local w = math.max(18, h * 0.72)
    local x1, x2 = sx - w * 0.5, sx + w * 0.5

    if show_skel then ndraw_skel(e, col_skel) end
    if show_box then
        local r,g,b,a = ncol4(col_box)
        nsafe(function() Drawing.DrawBox(x1, top, x2, bot, r,g,b,a, 1.8) end)
    end
    if show_name then
        local r,g,b,a = ncol4(col_name)
        nsafe(function() Drawing.DrawText(x1, top - 16, e.name or "NPC", r,g,b,a) end)
    end
    if show_dist then
        local r,g,b,a = ncol4(col_dist)
        nsafe(function() Drawing.DrawText(x1, bot + 3, string.format("%dm", math.floor(dist+0.5)), r,g,b,a) end)
    end
    if show_hp and e.hp and e.maxhp and e.maxhp > 0 then
        local ratio = math.max(0, math.min(1, e.hp / e.maxhp))
        local bh = h * ratio
        local r,g,b,a = ncol4(col_hp)
        nsafe(function()
            Drawing.DrawBoxFilled(x1-6, top, x1-2, bot, 0,0,0,0.55)
            Drawing.DrawBoxFilled(x1-6, bot-bh, x1-2, bot, r,g,b,a)
        end)
    end
end

-- UI on same Fallen tab
local function nparent(id)
    nsafe(function() UIManager.SetElementParent(id, TAB_ID) end)
end
local function nsame(id)
    nsafe(function() UIManager.SetElementSameLine(id, true) end)
end
local function ncheck(id, label, default, key)
    local def = default and true or false
    NPC_UI[id] = def
    nsafe(function()
        UIManager.CreateCheckbox(id, label, def, function(v)
            local on = v and true or false
            NPC_UI[id] = on
            if key then NPC_CFG[key] = on end
        end)
    end)
    nparent(id)
end
local function nrow(id, label, default, key, cid, col)
    ncheck(id, label, default, key)
    local r,g,b,a = col[1], col[2], col[3], col[4] or 1
    -- unique cid already separates Mil/Boss; short label + SameLine = square next to checkbox
    nsafe(function() UIManager.CreateColorPicker(cid, tostring(cid):sub(-6), r,g,b,a) end)
    nparent(cid)
    nsame(cid)
end
-- legacy readers (ndraw uses nui_* live); kept with correct API names
local function nread_color(id, dest)
    if UIManager and UIManager.GetColorPickerValue then
        local c = nsafe(function() return UIManager.GetColorPickerValue(id) end, nil)
        if c then
            dest[1] = c.r or c.R or c[1] or dest[1]
            dest[2] = c.g or c.G or c[2] or dest[2]
            dest[3] = c.b or c.B or c[3] or dest[3]
            dest[4] = c.a or c.A or c[4] or dest[4] or 1
        end
    end
end
local function nread_slider(id, key)
    if UIManager and UIManager.GetSliderIntValue then
        local v = nsafe(function() return UIManager.GetSliderIntValue(id) end, nil)
        if type(v) == "number" then NPC_CFG[key] = v end
    end
end

nsafe(function() UIManager.CreateSeparator("fn_sep_npc") end)
nparent("fn_sep_npc")
nsafe(function() UIManager.CreateText("fn_npc_title", "NPC ESP") end)
nparent("fn_npc_title")

ncheck("fn_master", "Enable NPC ESP", NPC_CFG.enabled, "enabled")
nsafe(function() UIManager.CreateSeparator("fn_sep0") end); nparent("fn_sep0")

nsafe(function() UIManager.CreateText("fn_mil_h", "Military") end); nparent("fn_mil_h")
ncheck("fn_mil_en", "Enable Military", NPC_CFG.mil_enabled, "mil_enabled")
nsafe(function() UIManager.CreateSliderInt("fn_mil_range", "Range", 0, 1000, NPC_CFG.mil_range) end)
nparent("fn_mil_range")
nrow("fn_mil_box",  "Mil Box",        NPC_CFG.mil_box,  "mil_box",  "fn_mil_box_c",  NPC_CFG.mil_col_box)
nrow("fn_mil_name", "Mil Name",       NPC_CFG.mil_name, "mil_name", "fn_mil_name_c", NPC_CFG.mil_col_name)
nrow("fn_mil_hp",   "Mil Health", NPC_CFG.mil_hp,   "mil_hp",   "fn_mil_hp_c",   NPC_CFG.mil_col_hp)
nrow("fn_mil_dist", "Mil Distance",   NPC_CFG.mil_dist, "mil_dist", "fn_mil_dist_c", NPC_CFG.mil_col_dist)
nrow("fn_mil_skel", "Mil Skeleton",   NPC_CFG.mil_skel, "mil_skel", "fn_mil_skel_c", NPC_CFG.mil_col_skel)

nsafe(function() UIManager.CreateSeparator("fn_sep1") end); nparent("fn_sep1")
nsafe(function() UIManager.CreateText("fn_boss_h", "Bosses") end); nparent("fn_boss_h")
ncheck("fn_boss_en", "Enable Bosses", NPC_CFG.boss_enabled, "boss_enabled")
nsafe(function() UIManager.CreateSliderInt("fn_boss_range", "Boss Range", 0, 1000, NPC_CFG.boss_range) end)
nparent("fn_boss_range")
nrow("fn_boris",  "Boris",  NPC_CFG.boris,  "boris",  "fn_boris_c",  NPC_CFG.boris_col)
nrow("fn_bruno",  "Bruno",  NPC_CFG.bruno,  "bruno",  "fn_bruno_c",  NPC_CFG.bruno_col)
nrow("fn_brutus", "Brutus", NPC_CFG.brutus, "brutus", "fn_brutus_c", NPC_CFG.brutus_col)

nsafe(function() UIManager.CreateSeparator("fn_sep2") end); nparent("fn_sep2")
nrow("fn_boss_box",  "Boss Box",        NPC_CFG.boss_box,  "boss_box",  "fn_boss_box_c",  NPC_CFG.boss_col_box)
nrow("fn_boss_name", "Boss Name",       NPC_CFG.boss_name, "boss_name", "fn_boss_name_c", NPC_CFG.boss_col_name)
nrow("fn_boss_hp",   "Boss Health", NPC_CFG.boss_hp,   "boss_hp",   "fn_boss_hp_c",   NPC_CFG.boss_col_hp)
nrow("fn_boss_dist", "Boss Distance",   NPC_CFG.boss_dist, "boss_dist", "fn_boss_dist_c", NPC_CFG.boss_col_dist)
nrow("fn_boss_skel", "Boss Skeleton",   NPC_CFG.boss_skel, "boss_skel", "fn_boss_skel_c", NPC_CFG.boss_col_skel)

-- nsync больше не нужен: ndraw_one читает UI live через GetCheckboxValue / GetColorPickerValue / GetSliderIntValue

hooks.on_render(function()
    local t = tick()
    if t - npc_last_scan >= NPC_SCAN_EVERY then
        npc_last_scan = t
        pcall(nscan)
    end
    if t - npc_last_poll >= NPC_POLL_EVERY then
        npc_last_poll = t
        pcall(npoll)
    end

    nsafe(function()
        Drawing.DrawText(12, 12, "NPC: " .. tostring(npc_debug), 1, 1, 0, 1)
        local mb = nui_check("fn_mil_box", true) and "1" or "0"
        local bb = nui_check("fn_boss_box", true) and "1" or "0"
        Drawing.DrawText(12, 26, "box mil=" .. mb .. " boss=" .. bb, 0.8, 0.8, 0.2, 1)
    end)

    if not nui_check("fn_master", NPC_CFG.enabled) then return end

    local lx, ly, lz = nlocal_xyz()
    if not lx then return end

    local tnow = tick()
    for i = 1, #npc_order do
        local e = npc_cache[npc_order[i]]
        if e and e.x then
            if e.status == "alive" then
                pcall(ndraw_one, e, lx, ly, lz)
            elseif e.lost_at and (tnow - e.lost_at) <= NPC_HOLD then
                local old = e.status
                e.status = "alive"
                pcall(ndraw_one, e, lx, ly, lz)
                e.status = old
            end
        end
    end
end)

pcall(nscan)

-- экспорт кэша для аима / отладки
_G.FallenNPC_Cache = npc_cache
_G.FallenNPC_Order = npc_order
_G.FallenNPC_CFG = NPC_CFG

----------------------------------------------------------------
--[[
  AIMBOT — Blueberry official primitives only
  Docs: roblox-modification-functions (aim.*), windows-functions, classes (players, hooks), recipes 1 & 9

  Keybind:
    CreateKeybind (menu) OR "Set Aim Key" button with 0.5s ignore after click so LMB is NOT bound.
  Aim path (priority):
    1) Windows.MoveMouse smoothed toward screen pos  (recipe 9 — camera follows)
    2) aim.write_mouse(screen)                       (recipe 1 — mouse service)
    3) aim.set_camera_rotation(aim.look_at_matrix)   (fallback)
  Targets:
    players.get_all / head_pos + NPC cache (MilitaryHitbox)
]]
----------------------------------------------------------------
do

----------------------------------------------------------------
-- PLAYER CACHE (Blueberry players API is already a live cache;
-- we mirror it into P_CACHE for aimbot, bone pick, sticky, debug)
-- hooks.on_rescan + periodic refresh every PLAYER_REFRESH_S
----------------------------------------------------------------
local PLAYER_REFRESH_S = 0.05
local P_CACHE = {
    -- [address] = {
    --   addr, name, hp, maxhp, dist,
    --   hx,hy,hz,  rx,ry,rz,  -- head / root
    --   bones = { {name,x,y,z}, ... },
    --   team, friend, self, alive, t
    -- }
}
local P_ORDER = {}
local p_last_refresh = 0
local p_debug = "players: init"

local function p_clear_stale(now, max_age)
    local keep = {}
    for i = 1, #P_ORDER do
        local a = P_ORDER[i]
        local e = P_CACHE[a]
        if e and (now - (e.t or 0)) <= max_age then
            keep[#keep + 1] = a
        else
            P_CACHE[a] = nil
        end
    end
    P_ORDER = keep
end

local function p_bone_list(p)
    local out = {}
    if p.bones and type(p.bones) == "table" then
        for i = 1, #p.bones do
            local b = p.bones[i]
            if b then
                local pos = b.position or b.pos
                local x = pos and (pos.X or pos.x) or b.X or b.x
                local y = pos and (pos.Y or pos.y) or b.Y or b.y
                local z = pos and (pos.Z or pos.z) or b.Z or b.z
                local n = b.name or b.Name or ("bone" .. i)
                if type(x) == "number" and type(y) == "number" and type(z) == "number" then
                    out[#out + 1] = { name = n, x = x, y = y, z = z }
                end
            end
        end
    end
    return out
end

local function p_refresh()
    local now = tick()
    if not players or not players.get_all then
        p_debug = "players API missing"
        return
    end
    local ok, list = pcall(function() return players.get_all() end)
    if not ok or type(list) ~= "table" then
        p_debug = "get_all failed"
        return
    end

    local seen = {}
    local n = 0
    for i = 1, #list do
        local p = list[i]
        if p and not p.is_self then
            local addr = p.address or p.player_addr or p.name
            if addr then
                local head = p.head_pos
                local root = p.position
                local hx = head and (head.X or head.x) or nil
                local hy = head and (head.Y or head.y) or nil
                local hz = head and (head.Z or head.z) or nil
                local rx = root and (root.X or root.x) or hx
                local ry = root and (root.Y or root.y) or hy
                local rz = root and (root.Z or root.z) or hz
                if type(hx) ~= "number" and type(rx) == "number" then
                    hx, hy, hz = rx, (ry or 0) + 1.5, rz
                end
                if type(hx) == "number" then
                    local e = P_CACHE[addr]
                    if not e then
                        e = {}
                        P_CACHE[addr] = e
                        P_ORDER[#P_ORDER + 1] = addr
                    end
                    e.addr = addr
                    e.name = p.name or p.display_name or "?"
                    e.hp = p.health or 0
                    e.maxhp = p.max_health or 100
                    e.dist = p.distance or 0
                    e.hx, e.hy, e.hz = hx, hy, hz
                    e.rx, e.ry, e.rz = rx or hx, ry or hy, rz or hz
                    e.bones = p_bone_list(p)
                    e.team = p.is_teammate and true or false
                    e.friend = (p.is_friended or p.is_marked_friend or p.is_roblox_friend) and true or false
                    e.knocked = p.is_knocked and true or false
                    e.alive = (e.hp or 0) > 0 and not e.knocked
                    e.t = now
                    e.raw = p -- keep ref for tool etc
                    seen[addr] = true
                    n = n + 1
                end
            end
        end
    end
    -- drop players not in this snapshot
    local keep = {}
    for i = 1, #P_ORDER do
        local a = P_ORDER[i]
        if seen[a] then
            keep[#keep + 1] = a
        else
            P_CACHE[a] = nil
        end
    end
    P_ORDER = keep
    p_debug = string.format("players: %d cached", n)
end

local function p_tick()
    local now = tick()
    if now - p_last_refresh >= PLAYER_REFRESH_S then
        p_last_refresh = now
        pcall(p_refresh)
        p_clear_stale(now, 1.0)
    end
end

-- Blueberry already rescans; mirror on rescan for lower latency
if hooks and hooks.on_rescan then
    pcall(function()
        hooks.on_rescan(function()
            p_last_refresh = 0
            pcall(p_refresh)
        end)
    end)
end
if hooks and hooks.on_player_join then
    pcall(function()
        hooks.on_player_join(function()
            p_last_refresh = 0
        end)
    end)
end
if hooks and hooks.on_player_leave then
    pcall(function()
        hooks.on_player_leave(function(addr)
            if addr and P_CACHE[addr] then
                P_CACHE[addr] = nil
            end
        end)
    end)
end

local AIM = {
    vk = 0,
    capture = false,
    capture_until = 0,
    locked = nil, -- {type="player", addr=...} | {type="npc", key=...}
    -- hist[key] = {x,y,z,t, svx,svy,svz, sax,say,saz}
    hist = {},
    hz = { id = nil, until_ms = 0, mul = 1, next = 0, ox = 0, oy = 0, oz = 0 },
    last_frame_t = 0,
    frame_dt = 1/60,
    ping_s = 0.05,
    pred_sx = nil,
    pred_sy = nil,
    last_wep = "Default",
    last_speed = 1000,
    last_grav = 18,
}

-- Fallen ballistic approx (studs/s, gravity scale). Tuned for long-range lead.
local WEAPON = {
    ["Military Barret"] = { speed = 1500, gravity = 25 },
    ["Military Barrett"] = { speed = 1500, gravity = 25 },
    ["Military M4A1"] = { speed = 1000, gravity = 18 },
    ["Military M39"] = { speed = 900, gravity = 18 },
    ["Military MP7"] = { speed = 750, gravity = 15 },
    ["Military PKM"] = { speed = 850, gravity = 18 },
    ["Military USP"] = { speed = 650, gravity = 12 },
    ["Military AA12"] = { speed = 550, gravity = 15 },
    ["Military Grenade Launcher"] = { speed = 350, gravity = 55 },
    ["Bruno's M4A1"] = { speed = 1000, gravity = 18 },
    ["Salvaged AK47"] = { speed = 800, gravity = 15 },
    ["Salvaged AK74u"] = { speed = 750, gravity = 15 },
    ["Salvaged AK4"] = { speed = 800, gravity = 15 },
    ["Salvaged Sniper"] = { speed = 1100, gravity = 20 },
    ["Salvaged M14"] = { speed = 850, gravity = 18 },
    ["Salvaged SMG"] = { speed = 700, gravity = 12 },
    ["Salvaged Skorpion"] = { speed = 650, gravity = 12 },
    ["Salvaged Python"] = { speed = 750, gravity = 15 },
    ["Salvaged P250"] = { speed = 650, gravity = 12 },
    ["Salvaged Pipe Rifle"] = { speed = 800, gravity = 20 },
    ["Salvaged Pump Action"] = { speed = 550, gravity = 15 },
    ["Salvaged Shotgun"] = { speed = 550, gravity = 15 },
    ["Salvaged Double Barrel"] = { speed = 550, gravity = 15 },
    ["Salvaged Break Action"] = { speed = 550, gravity = 15 },
    ["Salvaged RPG"] = { speed = 400, gravity = 60 },
    ["Salvaged Grenade Launcher"] = { speed = 350, gravity = 55 },
    ["Crossbow"] = { speed = 400, gravity = 35 },
    ["Wooden Bow"] = { speed = 300, gravity = 30 },
    ["Nail Gun"] = { speed = 350, gravity = 20 },
    ["Default"] = { speed = 1000, gravity = 18 },
}

local function parent(id)
    pcall(function() UIManager.SetElementParent(id, TAB_ID) end)
end

-- UI
pcall(function() UIManager.CreateSeparator("aim_sep0") end); parent("aim_sep0")
pcall(function() UIManager.CreateText("aim_title", "Aimbot (Players + NPCs)") end); parent("aim_title")
pcall(function() UIManager.CreateCheckbox("aim_en", "Enable Aimbot", false) end); parent("aim_en")
pcall(function() UIManager.CreateCheckbox("aim_players", "Target Players", true) end); parent("aim_players")
pcall(function() UIManager.CreateCheckbox("aim_npcs", "Target NPCs", true) end); parent("aim_npcs")

-- Keybind: official CreateKeybind + on_change stores VK. Never use LMB (1).
do
    local def = 0x45 -- E
    if VK and VK.E then def = VK.E end
    AIM.vk = def
    pcall(function()
        if UIManager.CreateKeybind then
            UIManager.CreateKeybind("aim_keybind", "Aim Key (hold)", def, function(vk)
                if type(vk) == "number" and vk > 1 then
                    AIM.vk = vk
                    if notify then notify("Aim Key = " .. tostring(vk), "success") end
                elseif type(vk) == "number" and vk == 1 then
                    -- LMB captured by mistake: force back to E
                    AIM.vk = def
                    if UIManager.SetKeybindValue then
                        pcall(function() UIManager.SetKeybindValue("aim_keybind", def) end)
                    end
                    if notify then notify("LMB ignored — set a KEYBOARD key", "warning") end
                end
            end)
        end
    end)
    parent("aim_keybind")
    if UIManager.SetKeybindValue then
        pcall(function() UIManager.SetKeybindValue("aim_keybind", def) end)
    end
end

pcall(function()
    UIManager.CreateButton("aim_setkey", "Set Aim Key (press key after click)", function()
        AIM.capture = true
        AIM.capture_until = tick() + 0.6
        AIM._cap_edges = {}
        if notify then notify("Click OK — then press E/X/C... (not mouse)", "normal") end
    end)
end)
parent("aim_setkey")
pcall(function() UIManager.CreateText("aim_key_txt", "Active Key: E") end); parent("aim_key_txt")

pcall(function() UIManager.CreateSeparator("aim_sep1") end); parent("aim_sep1")
pcall(function() UIManager.CreateText("aim_npc_h", "NPC filters") end); parent("aim_npc_h")
pcall(function() UIManager.CreateCheckbox("aim_mil", "Military", true) end); parent("aim_mil")
pcall(function() UIManager.CreateCheckbox("aim_bruno", "Bruno", true) end); parent("aim_bruno")
pcall(function() UIManager.CreateCheckbox("aim_boris", "Boris", true) end); parent("aim_boris")
pcall(function() UIManager.CreateCheckbox("aim_brutus", "Brutus", true) end); parent("aim_brutus")

pcall(function() UIManager.CreateSeparator("aim_sep2") end); parent("aim_sep2")
pcall(function() UIManager.CreateText("aim_part_h", "Aim Part") end); parent("aim_part_h")
pcall(function()
    UIManager.CreateCheckbox("aim_part_head", "Head", true, function(v)
        if v then
            pcall(function() UIManager.SetCheckboxValue("aim_part_torso", false) end)
            pcall(function() UIManager.SetCheckboxValue("aim_part_closest", false) end)
        end
    end)
end); parent("aim_part_head")
pcall(function()
    UIManager.CreateCheckbox("aim_part_torso", "Torso", false, function(v)
        if v then
            pcall(function() UIManager.SetCheckboxValue("aim_part_head", false) end)
            pcall(function() UIManager.SetCheckboxValue("aim_part_closest", false) end)
        end
    end)
end); parent("aim_part_torso")
pcall(function()
    UIManager.CreateCheckbox("aim_part_closest", "Closest", false, function(v)
        if v then
            pcall(function() UIManager.SetCheckboxValue("aim_part_head", false) end)
            pcall(function() UIManager.SetCheckboxValue("aim_part_torso", false) end)
        end
    end)
end); parent("aim_part_closest")

pcall(function() UIManager.CreateSliderInt("aim_range", "Range", 50, 1200, 850) end); parent("aim_range")
pcall(function() UIManager.CreateSliderInt("aim_fov", "FOV", 20, 500, 150) end); parent("aim_fov")
pcall(function() UIManager.CreateSliderInt("aim_smooth", "Smooth", 1, 25, 6) end); parent("aim_smooth")
pcall(function() UIManager.CreateCheckbox("aim_sticky", "Sticky Aim", true) end); parent("aim_sticky")
pcall(function() UIManager.CreateText("aim_pred_h", "Prediction") end); parent("aim_pred_h")
pcall(function() UIManager.CreateCheckbox("aim_pred", "Enabled", true) end); parent("aim_pred")
pcall(function() UIManager.CreateCheckbox("aim_pred_vis", "Visualize Prediction", false) end); parent("aim_pred_vis")
-- Custom prediction strength 1000..20000 (1000 = 1.0x, 20000 = 20.0x)
pcall(function() UIManager.CreateSliderInt("aim_pred_x", "Prediction X", 1000, 20000, 1000) end); parent("aim_pred_x")
pcall(function() UIManager.CreateSliderInt("aim_pred_y", "Prediction Y", 1000, 20000, 1000) end); parent("aim_pred_y")
pcall(function() UIManager.CreateCheckbox("aim_drop", "Bullet Drop", true) end); parent("aim_drop")
pcall(function() UIManager.CreateSliderInt("aim_bulletspeed", "Bullet Speed override (0=auto)", 0, 2000, 0) end); parent("aim_bulletspeed")
pcall(function() UIManager.CreateSliderInt("aim_gravity", "Gravity override (0=auto)", 0, 80, 0) end); parent("aim_gravity")
pcall(function() UIManager.CreateSliderInt("aim_ping", "Ping ms (0=auto EMA)", 0, 200, 50) end); parent("aim_ping")
pcall(function() UIManager.CreateCheckbox("aim_use_accel", "Use Acceleration", true) end); parent("aim_use_accel")
pcall(function() UIManager.CreateCheckbox("aim_quadratic", "Quadratic Intercept", true) end); parent("aim_quadratic")
pcall(function() UIManager.CreateCheckbox("aim_human", "Humanize", false) end); parent("aim_human")
pcall(function() UIManager.CreateCheckbox("aim_drawfov", "Draw FOV", true) end); parent("aim_drawfov")
pcall(function() UIManager.CreateColorPicker("aim_fov_col", "FOV Color", 1, 1, 1, 0.85) end); parent("aim_fov_col")
pcall(function() UIManager.SetElementSameLine("aim_fov_col", true) end)

pcall(function() UIManager.CreateCheckbox("aim_team", "Team Check (players)", true) end); parent("aim_team")

-- Aim type: Mouse (OS cursor) OR Camera (engine camera matrix)
pcall(function() UIManager.CreateText("aim_method_h", "Aim Type") end); parent("aim_method_h")
pcall(function()
    UIManager.CreateCheckbox("aim_method_mouse", "Mouse Aim (MoveMouse)", true, function(v)
        if v then
            pcall(function() UIManager.SetCheckboxValue("aim_method_cam", false) end)
        end
    end)
end); parent("aim_method_mouse")
pcall(function()
    UIManager.CreateCheckbox("aim_method_cam", "Camera Aim (set_camera_rotation)", false, function(v)
        if v then
            pcall(function() UIManager.SetCheckboxValue("aim_method_mouse", false) end)
        end
    end)
end); parent("aim_method_cam")

local function chk(id, fb)
    local v = nil
    if UIManager and UIManager.GetCheckboxValue then
        local ok, r = pcall(function() return UIManager.GetCheckboxValue(id) end)
        if ok then v = r end
    end
    if v == nil then return fb == true end
    return v == true
end
local function sli(id, fb)
    if UIManager and UIManager.GetSliderIntValue then
        local ok, r = pcall(function() return UIManager.GetSliderIntValue(id) end)
        if ok and type(r) == "number" then return r end
    end
    return fb
end

local VKN = {
    [0x01]="LMB",[0x02]="RMB",[0x04]="MMB",[0x05]="M4",[0x06]="M5",
    [0x08]="BKSP",[0x09]="TAB",[0x0D]="ENTER",[0x10]="SHIFT",[0x11]="CTRL",[0x12]="ALT",
    [0x1B]="ESC",[0x20]="SPACE",[0x45]="E",[0x58]="X",[0x43]="C",[0x56]="V",[0x51]="Q",
    [0x46]="F",[0x47]="G",[0x54]="T",[0x52]="R",[0x59]="Y",[0x48]="H",
}
for i = 0, 25 do VKN[0x41 + i] = string.char(65 + i) end
for i = 0, 9 do VKN[0x30 + i] = tostring(i) end
for i = 0, 11 do VKN[0x70 + i] = "F" .. (i + 1) end

local function vk_label(vk)
    if not vk or vk == 0 then return "none" end
    return VKN[vk] or ("VK"..tostring(vk))
end

local function set_key_txt()
    local t
    if AIM.capture then
        t = "Active Key: press key..."
    else
        t = "Active Key: " .. vk_label(AIM.vk) .. " (" .. tostring(AIM.vk or 0) .. ")"
    end
    pcall(function()
        if UIManager.SetText then UIManager.SetText("aim_key_txt", t)
        elseif UIManager.SetElementText then UIManager.SetElementText("aim_key_txt", t) end
    end)
end

-- Capture: edge-detect keys after delay; never LMB
local function poll_capture()
    if not AIM.capture then return end
    if not Windows or not Windows.IsKeyPressed then return end
    local now = tick()
    if now < AIM.capture_until then return end
    AIM._cap_edges = AIM._cap_edges or {}
    local prefer = {}
    for c = 0x30, 0x39 do prefer[#prefer+1] = c end
    for c = 0x41, 0x5A do prefer[#prefer+1] = c end
    for c = 0x70, 0x7B do prefer[#prefer+1] = c end
    prefer[#prefer+1] = 0x20
    prefer[#prefer+1] = 0x10
    prefer[#prefer+1] = 0x11
    prefer[#prefer+1] = 0x05
    prefer[#prefer+1] = 0x06
    prefer[#prefer+1] = 0x02
    for i = 1, #prefer do
        local vk = prefer[i]
        if vk == 0x01 then goto cont end
        local ok, down = pcall(function() return Windows.IsKeyPressed(vk) end)
        if ok and down then
            local was = AIM._cap_edges[vk]
            AIM._cap_edges[vk] = true
            if not was then
                AIM.vk = vk
                AIM.capture = false
                if UIManager and UIManager.SetKeybindValue then
                    pcall(function() UIManager.SetKeybindValue("aim_keybind", vk) end)
                end
                set_key_txt()
                if notify then notify("Aim key set: " .. vk_label(vk), "success") end
                return
            end
        else
            AIM._cap_edges[vk] = false
        end
        ::cont::
    end
end

local function sync_vk_from_widget()
    if not UIManager then return end
    local vk = nil
    if UIManager.GetKeybindValue then
        local ok, v = pcall(function() return UIManager.GetKeybindValue("aim_keybind") end)
        if ok and type(v) == "number" then vk = v end
    end
    if vk == 1 then
        -- LMB not allowed for aim hold
        local def = (VK and VK.E) or 0x45
        AIM.vk = def
        if UIManager.SetKeybindValue then
            pcall(function() UIManager.SetKeybindValue("aim_keybind", def) end)
        end
        return
    end
    if type(vk) == "number" and vk > 0 then
        AIM.vk = vk
    end
end

local function aim_key_held()
    if AIM.capture then return false end
    sync_vk_from_widget()

    -- 1) Official widget hold (tracks CreateKeybind even if we lag)
    if UIManager and UIManager.IsKeybindPressed then
        local ok, held = pcall(function() return UIManager.IsKeybindPressed("aim_keybind") end)
        if ok and held == true then return true end
    end

    local vk = AIM.vk
    if not vk or vk == 0 or vk == 1 then return false end

    -- 2) OS-level VK (keyboard + mouse side buttons / RMB)
    if Windows and Windows.IsKeyPressed then
        local ok, held = pcall(function() return Windows.IsKeyPressed(vk) end)
        if ok and held then return true end
    end

    return false
end

local function center()
    -- 1) ScreenSize() from docs
    if type(ScreenSize) == "function" then
        local ok, s = pcall(ScreenSize)
        if ok and s then
            local w = s.Width or s.X or s[1]
            local h = s.Height or s.Y or s[2]
            if type(w) == "number" and w > 0 then return w * 0.5, h * 0.5, w, h end
        end
    end
    if rbx and rbx.screen_dim then
        local ok, d = pcall(function() return rbx.screen_dim() end)
        if ok and d then
            local w = d.Width or d.X
            local h = d.Height or d.Y
            if type(w) == "number" and w > 0 then return w * 0.5, h * 0.5, w, h end
        end
    end
    if Windows and Windows.GetRobloxClientSize then
        local ok, s = pcall(function() return Windows.GetRobloxClientSize() end)
        if ok and s and s.Width then return s.Width * 0.5, s.Height * 0.5, s.Width, s.Height end
    end
    if Windows and Windows.GetScreenSize then
        local ok, s = pcall(function() return Windows.GetScreenSize() end)
        if ok and s and s.Width then return s.Width * 0.5, s.Height * 0.5, s.Width, s.Height end
    end
    return 960, 540, 1920, 1080
end

local function part_mode()
    if chk("aim_part_closest", false) then return 2 end
    if chk("aim_part_torso", false) then return 1 end
    return 0
end

local function v3(x, y, z)
    if Vector3 then return Vector3(x, y, z) end
    return { X = x, Y = y, Z = z, x = x, y = y, z = z }
end

local function w2s(x, y, z)
    if aim and aim.world_to_screen then
        local ok, s = pcall(function() return aim.world_to_screen(v3(x, y, z)) end)
        if ok and s and s.visible ~= false then
            local sx, sy = s.X or s.x, s.Y or s.y
            if type(sx) == "number" then return sx, sy end
        end
    end
    return nw2s(x, y, z)
end

local function npc_kind_ok(kind)
    if kind == "boris" then return chk("aim_boris", true) end
    if kind == "bruno" then return chk("aim_bruno", true) end
    if kind == "brutus" then return chk("aim_brutus", true) end
    return chk("aim_mil", true)
end

local function bone_from_xyz(hx, hy, hz, rx, ry, rz)
    local mode = part_mode()
    local tx, ty, tz = rx, ry + 0.6, rz
    if mode == 1 then return tx, ty, tz, "Torso" end
    if mode == 2 then
        local cx, cy = center()
        local best, bn, bd = {hx,hy,hz}, "Head", 1e18
        for _, c in ipairs({{hx,hy,hz,"Head"},{tx,ty,tz,"Torso"},{rx,ry-1.2,rz,"Feet"}}) do
            local sx, sy = w2s(c[1], c[2], c[3])
            if sx then
                local d = (sx - cx) * (sx - cx) + (sy - cy) * (sy - cy)
                if d < bd then bd = d; best = c; bn = c[4] end
            end
        end
        return best[1], best[2], best[3], bn
    end
    return hx, hy, hz, "Head"
end

-- Fuzzy match weapon name -> WEAPON table
local function resolve_weapon_name(raw)
    if not raw or raw == "" then return nil end
    if WEAPON[raw] then return raw end
    -- case-insensitive exact
    local low = string.lower(raw)
    for k, _ in pairs(WEAPON) do
        if string.lower(k) == low then return k end
    end
    -- substring (e.g. "Military M4A1" in longer string)
    for k, _ in pairs(WEAPON) do
        if k ~= "Default" and (low:find(string.lower(k), 1, true) or string.lower(k):find(low, 1, true)) then
            return k
        end
    end
    -- common aliases
    local aliases = {
        ["m4"] = "Military M4A1", ["m4a1"] = "Military M4A1",
        ["barret"] = "Military Barrett", ["barrett"] = "Military Barrett",
        ["ak"] = "Salvaged AK47", ["ak47"] = "Salvaged AK47",
        ["mp7"] = "Military MP7", ["pkm"] = "Military PKM",
        ["usp"] = "Military USP", ["m39"] = "Military M39",
        ["aa12"] = "Military AA12", ["bruno"] = "Bruno's M4A1",
    }
    if aliases[low] then return aliases[low] end
    return nil
end

local function detect_held_weapon()
    local name = nil
    -- 1) players.get_local().tool
    if players and players.get_local then
        local ok, me = pcall(function() return players.get_local() end)
        if ok and me then
            if me.tool and me.tool ~= "" then name = me.tool end
            -- some builds put tool on character
            if not name and me.raw and me.raw.tool then name = me.raw.tool end
        end
    end
    -- 2) rbx.local_tool()
    if not name and rbx and rbx.local_tool then
        local ok, t = pcall(function() return rbx.local_tool() end)
        if ok and t then
            local ok2, n = pcall(function() return t:get_name() end)
            if ok2 and n and n ~= "" then name = n end
        end
    end
    -- 3) GetCurrentTool global
    if not name and type(GetCurrentTool) == "function" then
        local ok, t = pcall(GetCurrentTool)
        if ok and t then
            if type(t) == "string" then name = t
            elseif type(t) == "table" and t.Name then name = t.Name
            elseif type(t) == "userdata" or type(t) == "table" then
                local ok2, n = pcall(function() return t:get_name() end)
                if ok2 then name = n end
            end
        end
    end
    return resolve_weapon_name(name) or name
end

-- EMA of observed frame time used as part of latency
local PING = { ema_ms = 50, last_t = 0 }

local function update_ping_ema()
    local now = tick()
    if PING.last_t > 0 then
        local dt = (now - PING.last_t) * 1000
        if dt > 1 and dt < 200 then
            PING.ema_ms = PING.ema_ms * 0.9 + dt * 0.1
        end
    end
    PING.last_t = now
end

local function weapon_stats()
    update_ping_ema()
    local name = detect_held_weapon()
    local st = (name and WEAPON[name]) or WEAPON.Default
    local spd_ov = sli("aim_bulletspeed", 0)
    local grv_ov = sli("aim_gravity", 0)
    local speed = (spd_ov > 0) and spd_ov or (st.speed or 1000)
    local grav = (grv_ov > 0) and grv_ov or (st.gravity or 18)
    -- clamp sane ballistics
    if speed < 80 then speed = 80 end
    if speed > 3000 then speed = 3000 end
    if grav < 0 then grav = 0 end
    if grav > 120 then grav = 120 end
    AIM.last_wep = name or "Default"
    AIM.last_speed = speed
    AIM.last_grav = grav
    return { speed = speed, gravity = grav, name = name or "Default" }
end

local function latency_seconds()
    -- Slider = one-way delay ms; if 0 → use EMA frame-ish fallback
    local ping_ms = sli("aim_ping", 50)
    if ping_ms <= 0 then
        ping_ms = math.max(10, math.min(120, PING.ema_ms))
    end
    local ping_s = ping_ms / 1000
    local frame_s = AIM.frame_dt or (1/60)
    if frame_s < 0.004 then frame_s = 0.004 end
    if frame_s > 0.08 then frame_s = 0.08 end
    -- half-frame: shot is mid-frame on average
    return ping_s + frame_s * 0.5, ping_ms, frame_s
end

--[[
  Ballistic intercept (700-800m capable):
  1) Sample TargetPosition / smoothed TargetVelocity / TargetAcceleration
  2) Time = flight + ping + frame_dt
  3) Quadratic intercept:
       |P + V t - L| = S * t
       (V·V - S^2) t^2 + 2(D·V) t + D·D = 0
       D = TargetPos - LocalPos
  4) PredictedPos = Pos + V*t + 0.5*A*t^2
  5) Bullet drop: Y += 0.5 * g * t^2
]]
local function predict(key, x, y, z)
    local st = weapon_stats()
    local speed = math.max(80, st.speed or 1000)
    local grav = st.gravity or 18
    local now = tick()

    -- ClientFrameTime
    if AIM.last_frame_t > 0 then
        local fdt = now - AIM.last_frame_t
        if fdt > 0.001 and fdt < 0.2 then
            AIM.frame_dt = AIM.frame_dt * 0.85 + fdt * 0.15
        end
    end
    AIM.last_frame_t = now

    local h = AIM.hist[key]
    local rvx, rvy, rvz = 0, 0, 0
    if h and h.t then
        local dt = now - h.t
        if dt > 0.001 and dt < 0.5 then
            rvx = (x - h.x) / dt
            rvy = (y - h.y) / dt
            rvz = (z - h.z) / dt
            local sp2 = rvx*rvx + rvy*rvy + rvz*rvz
            if sp2 > 250000 then -- Fallen NPC pool teleport
                rvx, rvy, rvz = 0, 0, 0
            end
        end
    end

    -- EMA velocity
    local alpha_v = 0.30
    local svx, svy, svz = rvx, rvy, rvz
    if h and h.svx then
        svx = h.svx + (rvx - h.svx) * alpha_v
        svy = h.svy + (rvy - h.svy) * alpha_v
        svz = h.svz + (rvz - h.svz) * alpha_v
    end

    -- Acceleration from velocity change (EMA)
    local sax, say, saz = 0, 0, 0
    if h and h.svx and h.t then
        local dt = now - h.t
        if dt > 0.001 and dt < 0.5 then
            local rax = (svx - h.svx) / dt
            local ray = (svy - h.svy) / dt
            local raz = (svz - h.svz) / dt
            local a2 = rax*rax + ray*ray + raz*raz
            if a2 < 500000 then -- ignore insane accel spikes
                local alpha_a = 0.25
                if h.sax then
                    sax = h.sax + (rax - h.sax) * alpha_a
                    say = h.say + (ray - h.say) * alpha_a
                    saz = h.saz + (raz - h.saz) * alpha_a
                else
                    sax, say, saz = rax, ray, raz
                end
            end
        end
    end

    AIM.hist[key] = {
        x = x, y = y, z = z, t = now,
        svx = svx, svy = svy, svz = svz,
        sax = sax, say = say, saz = saz,
    }

    local want_pred = chk("aim_pred", true)
    local want_drop = chk("aim_drop", true)
    if not want_pred and not want_drop then
        return x, y, z
    end

    local lx, ly, lz = nlocal_xyz()
    if not lx then return x, y, z end

    -- Prediction X/Y: 1000 = 1.0x, 20000 = 20.0x (horizontal / vertical)
    local px_s = sli("aim_pred_x", 1000) / 1000
    local py_s = sli("aim_pred_y", 1000) / 1000
    if px_s < 0.1 then px_s = 0.1 end
    if py_s < 0.1 then py_s = 0.1 end
    local vx = svx * px_s
    local vy = svy * py_s
    local vz = svz * px_s  -- lateral Z uses X scale
    local use_accel = chk("aim_use_accel", true)
    local ax = use_accel and (sax * px_s) or 0
    local ay = use_accel and (say * py_s) or 0
    local az = use_accel and (saz * px_s) or 0

    -- Latency from slider + frame EMA
    local ping_s, ping_ms, frame_s = latency_seconds()

    local dx0 = x - lx
    local dy0 = y - ly
    local dz0 = z - lz
    local dist0 = math.sqrt(dx0*dx0 + dy0*dy0 + dz0*dz0)

    local t_flight = 0
    local use_quad = chk("aim_quadratic", true)

    if want_pred and use_quad then
        -- Quadratic: (V·V - S^2) t^2 + 2(D·V) t + D·D = 0
        -- D = target - local, |D + V t| = S t
        local dvx, dvy, dvz = vx, vy, vz
        local d2 = dx0*dx0 + dy0*dy0 + dz0*dz0
        local a = (dvx*dvx + dvy*dvy + dvz*dvz) - (speed * speed)
        local b = 2 * (dx0*dvx + dy0*dvy + dz0*dvz)
        local c = d2
        local t_hit = nil

        if math.abs(a) < 1e-6 then
            -- linear fallback: 2 (D·V) t + D·D ≈ 0  or  t = dist/speed
            if math.abs(b) > 1e-6 then
                local t1 = -c / b
                if t1 > 0 then t_hit = t1 end
            end
            if not t_hit then t_hit = dist0 / speed end
        else
            local disc = b*b - 4*a*c
            if disc >= 0 then
                local sd = math.sqrt(disc)
                local t1 = (-b - sd) / (2 * a)
                local t2 = (-b + sd) / (2 * a)
                -- pick smallest positive root
                if t1 > 0 and t2 > 0 then
                    t_hit = math.min(t1, t2)
                elseif t1 > 0 then
                    t_hit = t1
                elseif t2 > 0 then
                    t_hit = t2
                end
            end
            if not t_hit then
                t_hit = dist0 / speed
            end
        end
        t_flight = t_hit
    else
        -- iterative linear refine
        local px, py, pz = x, y, z
        for _ = 1, 5 do
            local dx = px - lx
            local dy = py - ly
            local dz = pz - lz
            local dist = math.sqrt(dx*dx + dy*dy + dz*dz)
            t_flight = dist / speed
            if t_flight > 3.0 then t_flight = 3.0 end
            if want_pred then
                px = x + vx * t_flight + 0.5 * ax * t_flight * t_flight
                py = y + vy * t_flight + 0.5 * ay * t_flight * t_flight
                pz = z + vz * t_flight + 0.5 * az * t_flight * t_flight
            else
                break
            end
        end
    end

    if t_flight < 0 then t_flight = 0 end
    if t_flight > 3.0 then t_flight = 3.0 end -- hard cap ~800m+ slow proj

    -- Total time: flight + latency
    local t = t_flight + ping_s + frame_s
    if t > 3.2 then t = 3.2 end

    local px, py, pz = x, y, z
    if want_pred then
        -- Pos + V*t + 0.5*A*t^2
        px = x + vx * t + 0.5 * ax * t * t
        py = y + vy * t + 0.5 * ay * t * t
        pz = z + vz * t + 0.5 * az * t * t
    end

    -- Bullet drop compensation (aim higher)
    if want_drop and t_flight > 0.001 then
        py = py + 0.5 * grav * t_flight * t_flight
    end

    -- Visualize predicted world point
    if chk("aim_pred_vis", false) then
        local sx, sy = w2s(px, py, pz)
        if sx then
            AIM.pred_sx, AIM.pred_sy = sx, sy
        else
            AIM.pred_sx, AIM.pred_sy = nil, nil
        end
    else
        AIM.pred_sx, AIM.pred_sy = nil, nil
    end

    return px, py, pz
end

local function humanize(id, x, y, z, bone)
    if not chk("aim_human", false) then return x, y, z, 1 end
    local hz = AIM.hz
    local now = tick() * 1000
    if hz.id ~= id then
        hz.id = id
        hz.until_ms = now + 60 + math.random() * 100
        hz.mul = 0.85 + math.random() * 0.45
        hz.next = 0
    end
    if now < hz.until_ms then return nil end
    if now >= hz.next then
        hz.next = now + 200 + math.random() * 350
        local r = (bone == "Head") and 0.25 or 0.5
        hz.ox = (math.random() * 2 - 1) * r
        hz.oy = (math.random() * 2 - 1) * r * 0.7
        hz.oz = (math.random() * 2 - 1) * r
    end
    return x + hz.ox, y + hz.oy, z + hz.oz, hz.mul
end

local function collect_candidates(lx, ly, lz, fov, range)
    local cx, cy = center()
    local list = {}

    -- Players from P_CACHE (refreshed on_rescan + every 50ms)
    if chk("aim_players", true) then
        p_tick()
        for i = 1, #P_ORDER do
            local e = P_CACHE[P_ORDER[i]]
            if e and e.alive and not e.friend then
                if not (chk("aim_team", true) and e.team) then
                    local dist = e.dist
                    if not dist or dist <= 0 then
                        dist = math.sqrt((e.hx-lx)^2+(e.hy-ly)^2+(e.hz-lz)^2)
                    end
                    if dist <= range then
                        local hx, hy, hz = e.hx, e.hy, e.hz
                        local rx, ry, rz = e.rx or hx, e.ry or hy, e.rz or hz
                        -- prefer real bone from cache if Head/Torso present
                        if e.bones then
                            for bi = 1, #e.bones do
                                local b = e.bones[bi]
                                local nl = string.lower(b.name or "")
                                if nl == "head" or nl:find("head", 1, true) then
                                    hx, hy, hz = b.x, b.y, b.z
                                elseif nl == "uppertorso" or nl == "torso" or nl == "humanoidrootpart" then
                                    rx, ry, rz = b.x, b.y, b.z
                                end
                            end
                        end
                        local bx, by, bz, bn = bone_from_xyz(hx, hy, hz, rx, ry, rz)
                        local sx, sy = w2s(bx, by, bz)
                        if sx then
                            local fd = math.sqrt((sx-cx)^2+(sy-cy)^2)
                            if fd <= fov then
                                list[#list+1] = {
                                    type = "player",
                                    id = "p:" .. tostring(e.addr),
                                    addr = e.addr,
                                    fd = fd, dist = dist,
                                    x = bx, y = by, z = bz, bone = bn,
                                }
                            end
                        end
                    end
                end
            end
        end
    end

    if chk("aim_npcs", true) then
        for i = 1, #npc_order do
            local e = npc_cache[npc_order[i]]
            if e and e.status == "alive" and e.x and npc_kind_ok(e.kind) then
                local dist = math.sqrt((e.x-lx)^2+(e.y-ly)^2+(e.z-lz)^2)
                if dist <= range then
                    local bx, by, bz, bn = bone_from_xyz(e.x, e.y, e.z, e.fx or e.x, e.fy or e.y, e.fz or e.z)
                    local sx, sy = w2s(bx, by, bz)
                    if sx then
                        local fd = math.sqrt((sx-cx)^2+(sy-cy)^2)
                        if fd <= fov then
                            list[#list+1] = {
                                type = "npc",
                                id = e.key,
                                key = e.key,
                                fd = fd, dist = dist,
                                x = bx, y = by, z = bz, bone = bn,
                            }
                        end
                    end
                end
            end
        end
    end

    table.sort(list, function(a, b) return a.fd < b.fd end)
    return list
end

local function pick(lx, ly, lz)
    local fov = sli("aim_fov", 150)
    local range = sli("aim_range", 500)
    local sticky = chk("aim_sticky", true)
    local cx, cy = center()

    if sticky and AIM.locked then
        local L = AIM.locked
        if L.type == "player" and L.addr then
            p_tick()
            local e = P_CACHE[L.addr]
            if e and e.alive then
                local dist = e.dist or math.sqrt((e.hx-lx)^2+(e.hy-ly)^2+(e.hz-lz)^2)
                if dist <= range then
                    local bx, by, bz, bn = bone_from_xyz(e.hx, e.hy, e.hz, e.rx or e.hx, e.ry or e.hy, e.rz or e.hz)
                    local sx, sy = w2s(bx, by, bz)
                    if sx then
                        local fd = math.sqrt((sx-cx)^2+(sy-cy)^2)
                        if fd <= fov * 1.4 then
                            return { type="player", id=L.id or ("p:"..tostring(L.addr)), addr=L.addr, x=bx,y=by,z=bz, bone=bn, fd=fd, dist=dist }
                        end
                    end
                end
            end
        elseif L.type == "npc" and L.key then
            local e = npc_cache[L.key]
            if e and e.status == "alive" and e.x and npc_kind_ok(e.kind) then
                local dist = math.sqrt((e.x-lx)^2+(e.y-ly)^2+(e.z-lz)^2)
                if dist <= range then
                    local bx, by, bz, bn = bone_from_xyz(e.x, e.y, e.z, e.fx or e.x, e.fy or e.y, e.fz or e.z)
                    local sx, sy = w2s(bx, by, bz)
                    if sx then
                        local fd = math.sqrt((sx-cx)^2+(sy-cy)^2)
                        if fd <= fov * 1.4 then
                            return { type="npc", id=L.key, key=L.key, x=bx,y=by,z=bz, bone=bn, fd=fd, dist=dist }
                        end
                    end
                end
            end
        end
        AIM.locked = nil
        AIM.hz.id = nil
    end

    local list = collect_candidates(lx, ly, lz, fov, range)
    local best = list[1]
    if best and sticky then
        if best.type == "player" then
            AIM.locked = { type = "player", addr = best.addr, id = best.id }
        else
            AIM.locked = { type = "npc", key = best.key or best.id, id = best.id }
        end
    end
    return best
end

--[[
  Mouse Aim  = OS cursor emulation: Windows.MoveMouse toward target screen pos
               (game camera follows the physical/system cursor)
  Camera Aim = engine camera: aim.look_at_matrix + aim.set_camera_rotation
               (direct view matrix, no cursor move)
]]
local function apply_aim(x, y, z, smooth)
    smooth = math.max(1, smooth or 6)

    local use_cam = chk("aim_method_cam", false)
    local use_mouse = chk("aim_method_mouse", true)
    if use_cam then use_mouse = false end
    if not use_cam and not use_mouse then use_mouse = true end

    -- ===== MOUSE AIM =====
    -- w2s / aim.world_to_screen = game client pixels; GetMousePos = screen pixels.
    -- Use one space only: prefer aim.move_mouse (client) or MoveMouse with screen delta.
    if use_mouse then
        local sx, sy = w2s(x, y, z)
        if not sx then return false end
        local t = 1 / smooth

        -- 1) Blueberry aim.move_mouse (expects client/screen pos from world_to_screen)
        if aim and aim.move_mouse then
            local ok, mp = pcall(function()
                if Windows and Windows.GetMousePos then return Windows.GetMousePos() end
            end)
            if ok and mp and mp.X then
                pcall(function()
                    aim.move_mouse({ X = mp.X + (sx - mp.X) * t, Y = mp.Y + (sy - mp.Y) * t })
                end)
            else
                pcall(function() aim.move_mouse({ X = sx, Y = sy }) end)
            end
            return true
        end

        -- 2) Windows.MoveMouse — same coordinate space as GetMousePos (screen)
        if Windows and Windows.GetMousePos and Windows.MoveMouse then
            local ok, mp = pcall(function() return Windows.GetMousePos() end)
            if ok and mp and mp.X then
                pcall(function()
                    Windows.MoveMouse(mp.X + (sx - mp.X) * t, mp.Y + (sy - mp.Y) * t)
                end)
                return true
            end
        end
        return false
    end

    -- ===== CAMERA AIM =====
    if not (aim and aim.look_at_matrix and aim.set_camera_rotation and aim.get_camera_position) then
        return false
    end
    local ok, cpos = pcall(function() return aim.get_camera_position() end)
    if not ok or not cpos then return false end
    local ok2, m = pcall(function() return aim.look_at_matrix(cpos, v3(x, y, z)) end)
    if not ok2 or not m then return false end

    if smooth <= 1 then
        pcall(function() aim.set_camera_rotation(m) end)
        return true
    end
    local ok3, cur = pcall(function() return aim.get_camera_rotation() end)
    if ok3 and cur then
        local t = 1 / smooth
        local out = {}
        for i = 1, 9 do
            out[i] = (cur[i] or 0) + ((m[i] or 0) - (cur[i] or 0)) * t
        end
        pcall(function() aim.set_camera_rotation(out) end)
    else
        pcall(function() aim.set_camera_rotation(m) end)
    end
    return true
end

local function fov_color()
    local r, g, b, a = 1, 1, 1, 0.85
    if UIManager and UIManager.GetColorPickerValue then
        local c = nsafe(function() return UIManager.GetColorPickerValue("aim_fov_col") end, nil)
        if c then
            r = c.r or c.R or c[1] or r
            g = c.g or c.G or c[2] or g
            b = c.b or c.B or c[3] or b
            a = c.a or c.A or c[4] or a
            if r > 1 then r = r / 255 end
            if g > 1 then g = g / 255 end
            if b > 1 then b = b / 255 end
            if a > 1 then a = a / 255 end
        end
    end
    return r, g, b, a
end

local function draw_fov()
    -- FOV only while aimbot enabled
    if not chk("aim_en", false) then return end
    if not chk("aim_drawfov", true) then return end
    local cx, cy = center()
    local fov = sli("aim_fov", 150)
    if type(fov) ~= "number" or fov < 5 then fov = 150 end
    local r, g, b, a = fov_color()

    if Drawing and Drawing.DrawCircle then
        pcall(function() Drawing.DrawCircle(cx, cy, fov, r, g, b, a, 1.8) end)
    elseif type(DrawCircle) == "function" then
        pcall(function() DrawCircle(cx, cy, fov, r, g, b, a, 1.8) end)
    end
    -- ring fallback only (no crosshair, no FOV text)
    if Drawing and Drawing.DrawLine then
        local n, px, py = 64, nil, nil
        for i = 0, n do
            local ang = (i / n) * math.pi * 2
            local x = cx + math.cos(ang) * fov
            local y = cy + math.sin(ang) * fov
            if px then
                pcall(function() Drawing.DrawLine(px, py, x, y, r, g, b, a, 1.5) end)
            end
            px, py = x, y
        end
    end
end

local function draw_pred_vis()
    if not chk("aim_pred_vis", false) then return end
    if not AIM.pred_sx then return end
    local sx, sy = AIM.pred_sx, AIM.pred_sy
    if Drawing and Drawing.DrawCircle then
        pcall(function() Drawing.DrawCircle(sx, sy, 5, 1, 0.2, 0.2, 0.95, 1.5) end)
        pcall(function() Drawing.DrawCircle(sx, sy, 2, 1, 0.4, 0.4, 1, 1) end)
    elseif Drawing and Drawing.DrawCircleFilled then
        pcall(function() Drawing.DrawCircleFilled(sx, sy, 4, 1, 0.2, 0.2, 0.9) end)
    end
end

hooks.on_render(function()
    poll_capture()
    sync_vk_from_widget()
    set_key_txt()
    draw_fov()
    draw_pred_vis()
    p_tick()
    if Drawing and Drawing.DrawText then
        pcall(function()
            Drawing.DrawText(12, 40, p_debug .. " | npc:" .. tostring(#npc_order), 0.7, 0.9, 0.7, 0.85)
            local wep = AIM.last_wep or "?"
            local spd = AIM.last_speed or 0
            local pg = sli("aim_ping", 50)
            Drawing.DrawText(12, 54, string.format("wep:%s spd:%.0f ping:%dms", tostring(wep), spd, pg), 0.7, 0.85, 1, 0.85)
        end)
    end

    if not chk("aim_en", false) then
        AIM.locked = nil
        return
    end
    local held = aim_key_held()
    if Drawing and Drawing.DrawText then
        pcall(function()
            Drawing.DrawText(12, 68, string.format("aimKey:%s held:%s players:%s",
                tostring(AIM.vk), held and "Y" or "N",
                chk("aim_players", true) and "Y" or "N"), 0.9, 0.9, 0.4, 0.9)
        end)
    end
    if not held then
        AIM.locked = nil
        AIM.hz.id = nil
        return
    end

    local lx, ly, lz = nlocal_xyz()
    if not lx then return end

    local t = pick(lx, ly, lz)
    if not t then return end

    local x, y, z = predict(t.id, t.x, t.y, t.z)
    local hx, hy, hz, mul = humanize(t.id, x, y, z, t.bone or "Head")
    if not hx then return end

    local smooth = sli("aim_smooth", 6)
    if mul then smooth = math.max(2, smooth * mul) end
    apply_aim(hx, hy, hz, smooth)
end)

_G.FallenAim = AIM
if notify then notify("Aimbot ready: keybind + Players/NPCs (Blueberry aim API)", "success") end
end
end
