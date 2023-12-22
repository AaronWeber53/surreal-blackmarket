Config = Config or {}

Config.CurrentDealers = {}
-- this is what the data structure will look like when randomized
--[[ Config.CurrentDealers[1] = {
    coords = vector(x,y,z),
    inventory = {
        [1] = {
            name = 'itemname',
            price = 'price',
            amount = 'amount',
            info = {},
            type = "item",      
            minrep = "minrep",  
        }
    },
    randominventory = {
        ['pistol'] = {
            [1] = {
            name = 'itemname',
            price = 'price',
            amount = 'amount',
            info = {},
            type = "item",      
            minrep = "minrep",  
            }   
        }
    }
    sellPrices = {
        ['gold_bar'] = 100
    }
    time = {
        min = 12,
        max = 18,
    },
} ]]

Config.SellPrices = {
    ['goldbar'] = {
        minPrice = 500,
        maxPrice = 1000
    },
    ['diamond'] = {
        minPrice = 1000,
        maxPrice = 2000
    },
}

Config.GunCategories = {
    ['pistol'] = {
        numbertoshow = {
            { minrep = 100, quantity = 1},
            { minrep = 200, quantity = 2},
            { minrep = 300, quantity = 3},
        },
        randomitems = {
            [1] = {
                name = 'weapon_combatpistol',
                minrep = 50,     
                quantitylow = 1,
                quantityhigh = 5,
                pricelow = 3000,
                pricehigh = 5000,
            },
            [2] = {
                name = 'weapon_snspistol',
                minrep = 100,     
                quantitylow = 1,
                quantityhigh = 5,
                pricelow = 2000,
                pricehigh = 5000,
            },
            [3] = {
                name = 'weapon_heavypistol',
                minrep = 125,     
                quantitylow = 1,
                quantityhigh = 5,
                pricelow = 4000,
                pricehigh = 8000,
            },
            [4] = {
                name = 'weapon_revolver',
                minrep = 150,     
                quantitylow = 1,
                quantityhigh = 5,
                pricelow = 3500,
                pricehigh = 6000,
            },
            [5] = {
                name = 'weapon_doubleaction',
                minrep = 175,     
                quantitylow = 1,
                quantityhigh = 3,
                pricelow = 3500,
                pricehigh = 7000,
            },
            [6] = {
                name = 'weapon_ceramicpistol',
                minrep = 300,     
                quantitylow = 1,
                quantityhigh = 2,
                pricelow = 8000,
                pricehigh = 10000,
            },            
        },
        constantitems = {
            ['pistol_ammo'] = {
                minrep = 15,     
                quantitylow = 25,
                quantityhigh = 50,
                pricelow = 200,
                pricehigh = 300,
            }
        }
    },
    ['smg'] = {
        numbertoshow = {
            { minrep = 200, quantity = 1},
            { minrep = 300, quantity = 2},
        },
        randomitems = {
            [1] = {
                name = 'weapon_microsmg',
                minrep = 200,     
                quantitylow = 1,
                quantityhigh = 2,
                pricelow = 10000,
                pricehigh = 14000,
            },
            [2] = {
                name = 'weapon_smg',
                minrep = 250,     
                quantitylow = 1,
                quantityhigh = 3,
                pricelow = 12500,
                pricehigh = 15000,
            },
            [3] = {
                name = 'weapon_combatpdw',
                minrep = 300,     
                quantitylow = 1,
                quantityhigh = 3,
                pricelow = 14000,
                pricehigh = 18000,
            },
        },
        constantitems = {
            ['smg_ammo'] = {
                minrep = 50,     
                quantitylow = 1,
                quantityhigh = 10,
                pricelow = 500,
                pricehigh = 750,
            }
        }
    },
    ['shotgun'] = {
        numbertoshow = {
            { minrep = 200, quantity = 1},
            { minrep = 300, quantity = 2},
        },
        randomitems = {
            [1] = {
                name = 'weapon_pumpshotgun',
                minrep = 200,     
                quantitylow = 1,
                quantityhigh = 2,
                pricelow = 18000,
                pricehigh = 24000,
            },
            [2] = {
                name = 'weapon_sawnoffshotgun',
                minrep = 250,     
                quantitylow = 2,
                quantityhigh = 4,
                pricelow = 18000,
                pricehigh = 24000,
            },
            [3] = {
                name = 'weapon_dbshotgun',
                minrep = 275,     
                quantitylow = 2,
                quantityhigh = 3,
                pricelow = 18000,
                pricehigh = 24000,
            },
        },
        constantitems = {
            ['shotgun_ammo'] = {
                minrep = 50,     
                quantitylow = 1,
                quantityhigh = 5,
                pricelow = 500,
                pricehigh = 750,
            }
        }
    },
    ['throwables'] = {
        numbertoshow = {
            { minrep = 100, quantity = 1},
        },
        randomitems = {
            [1] = {
                name = 'weapon_grenade',
                minrep = 100,     
                quantitylow = 1,
                quantityhigh = 8,
                pricelow = 8000,
                pricehigh = 14000,
            },
            [2] = {
                name = 'weapon_molotov',
                minrep = 100,     
                quantitylow = 1,
                quantityhigh = 8,
                pricelow = 8000,
                pricehigh = 14000,
            },
        },
        constantitems = { }
    },
    ['rifle'] = {
        numbertoshow = {
            { minrep = 250, quantity = 1},
            { minrep = 350, quantity = 2},
        },
        randomitems = {
            [1] = {
                name = 'weapon_assaultrifle',
                minrep = 250,     
                quantitylow = 1,
                quantityhigh = 4,
                pricelow = 18000,
                pricehigh = 26000,
            },
            [2] = {
                name = 'weapon_carbinerifle',
                minrep = 300,     
                quantitylow = 1,
                quantityhigh = 3,
                pricelow = 20000,
                pricehigh = 28000,
            },
            [3] = {
                name = 'weapon_bullpuprifle',
                minrep = 350,     
                quantitylow = 1,
                quantityhigh = 2,
                pricelow = 22000,
                pricehigh = 30000,
            },
        },
        constantitems = {
            ['rifle_ammo'] = {
                minrep = 100,     
                quantitylow = 1,
                quantityhigh = 6,
                pricelow = 1000,
                pricehigh = 1500,
            },
        }
    },
    ['sniper'] = {
        numbertoshow = {
            { minrep = 400, quantity = 1},
        },
        randomitems = {
            [1] = {
                name = 'weapon_sniperrifle',
                minrep = 400,     
                quantitylow = 1,
                quantityhigh = 2,
                pricelow = 40000,
                pricehigh = 45000,
            },
            [2] = {
                name = 'weapon_heavysniper',
                minrep = 450,     
                quantitylow = 1,
                quantityhigh = 2,
                pricelow = 50000,
                pricehigh = 60000,
            },
            [3] = {
                name = 'weapon_marksmanrifle',
                minrep = 480,     
                quantitylow = 1,
                quantityhigh = 2,
                pricelow = 55000,
                pricehigh = 70000,
            },
        },
        constantitems = {
            ['snp_ammo'] = {
                minrep = 150,     
                quantitylow = 1,
                quantityhigh = 5,
                pricelow = 3000,
                pricehigh = 5500,
            },
        }
    },
    ['heavy'] = {
        numbertoshow = {
            { minrep = 425, quantity = 1},
            { minrep = 525, quantity = 2},
        },
        randomitems = {
            [1] = {
                name = 'weapon_mg',
                minrep = 425,     
                quantitylow = 1,
                quantityhigh = 2,
                pricelow = 40000,
                pricehigh = 55000,
            },
            [2] = {
                name = 'weapon_rpg',
                minrep = 500,     
                quantitylow = 1,
                quantityhigh = 2,
                pricelow = 60000,
                pricehigh = 80000,
            },
            [3] = {
                name = 'rpg_ammo',
                minrep = 500,     
                quantitylow = 1,
                quantityhigh = 3,
                pricelow = 8000,
                pricehigh = 10000,
            },
            [4] = {
                name = 'weapon_combatmg',
                minrep = 525,     
                quantitylow = 1,
                quantityhigh = 2,
                pricelow = 50000,
                pricehigh = 65500,
            },
        },
        constantitems = {
            ['mg_ammo'] = {
                minrep = 200,     
                quantitylow = 1,
                quantityhigh = 5,
                pricelow = 6000,
                pricehigh = 8000,
            }
        }
    },
    ['car'] = {
        numbertoshow = {
            { minrep = 100, quantity = 1},
            { minrep = 200, quantity = 2},
        },
        randomitems = {
            [1] = {
                name = 'nitrous',
                minrep = 100,     
                quantitylow = 1,
                quantityhigh = 5,
                pricelow = 10000,
                pricehigh = 15000,
            },
            [2] = {
                name = 'harness',
                minrep = 175,     
                quantitylow = 1,
                quantityhigh = 2,
                pricelow = 20000,
                pricehigh = 40000,
            },
            [3] = {
                name = 'cleaningkit',
                minrep = 100,     
                quantitylow = 5,
                quantityhigh = 10,
                pricelow = 300,
                pricehigh = 600,
            },
        },
        constantitems = { }
    },
    ['security'] = {
        numbertoshow = {
            { minrep = 100, quantity = 1},
            { minrep = 250, quantity = 2},
        },
        randomitems = {
            [1] = {
                name = 'gatecrack',
                minrep = 100,     
                quantitylow = 1,
                quantityhigh = 2,
                pricelow = 15000,
                pricehigh = 40000,
            },
            [2] = {
                name = 'thermite',
                minrep = 100,     
                quantitylow = 1,
                quantityhigh = 2,
                pricelow = 15000,
                pricehigh = 40000,
            },
            [3] = {
                name = 'security_card_01',
                minrep = 350,     
                quantitylow = 1,
                quantityhigh = 1,
                pricelow = 90000,
                pricehigh = 150000,
            },
            [4] = {
                name = 'security_card_02',
                minrep = 500,     
                quantitylow = 1,
                quantityhigh = 1,
                pricelow = 120000,
                pricehigh = 240000,
            },
            [5] = {
                name = 'twerks_candy',
                minrep = 1,     
                quantitylow = 1,
                quantityhigh = 100,
                pricelow = 10,
                pricehigh = 1000,
            },

        },
        constantitems = { }
    },
    ['keyshop'] = {
        numbertoshow = {
            { minrep = 10, quantity = 4},
        },
        randomitems = { },
        constantitems = { 
            ['methkey'] = {
                minrep = 250,     
                quantitylow = 0,
                quantityhigh = 5,
                pricelow = 8000,
                pricehigh = 10000,
                gangs = {
                    ['diablos'] = true
                }
            },
            ['cocainekey'] = {
                minrep = 250,     
                quantitylow = 0,
                quantityhigh = 5,
                pricelow = 8000,
                pricehigh = 10000,
                gangs = {
                    ['apegang'] = true,
                    ['families'] = true
                }
            },
            ['weedkey'] = {
                minrep = 250,     
                quantitylow = 0,
                quantityhigh = 5,
                pricelow = 8000,
                pricehigh = 10000,
                gangs = {
                    ['apegang'] = true,
                    ['families'] = true
                }
            },
            ['labkey'] = {
                minrep = 10,     
                quantitylow = 1,
                quantityhigh = 5,
                pricelow = 8000,
                pricehigh = 10000,
                gangs = {
                    ['ballas'] = true,
                    ['diablos'] = true
                }
            },
        }
    }
}
Config.MaxNumberOfDealersActive = 3
Config.GunDealerLocations = {
    [1] = {
        name = "Tony Small Arms Dealer", -- small arms dealer
	    locations = {
            [1] = vector3(-87.9, -1601.53, 32.31), -- 118 - North-E to maze bank
            [2] = vector3(112.91, -1588.88, 29.73), -- 128 - North-E maze bank
            [3] = vector3(-174.32, -1273.18, 32.6), -- 101 - City Bennies
            [4] = vector3(341.21, -1270.78, 31.98), -- 148 - Strip Club

        },
        locationInfo = "South-Eastern City",
        categories = {
            'pistol',
            'throwables',
            'smg'
        },
        time = {
            min = 16,
            max = 4,
        },
    },
    [2] = {
        name = "Jacob Medium Arms Dealer", -- medium arm dealer
	    locations = {
            [1] = vector3(13.26, 3732.25, 39.68), -- 1007 - Stab City
            [2] = vector3(1394.36, 3649.35, 34.68), -- 1016 - Car wash in Sandy City
            [3] = vector3(2685.25, 3515.27, 53.3), -- 956 - hardware
            [4] = vector3(2663.27, 2891.12, 36.94), -- 962 - Quarry
        },
        locationInfo = "Near Sandy",
        categories = {
            'shotgun',
            'sniper'
        },
        time = {
            min = 16,
            max = 4,
        },
    },
    [3] = {
        name = "Alex Large Arms Dealer", -- large arm dealer
	    locations = {
            [1] = vector3(-15.43, 6666.41, 31.92), -- 3022 - Paleto Docks
            [2] = vector3(-482.12, 6276.3, 13.63), -- 3009 - Paleto Beach
            [3] = vector3(-519.45, 5308.42, 80.24), -- 3002 - Lumber
            [4] = vector3(-1101.58, 4940.73, 218.35), -- 3001 - Hillbilly area        
            [5] = vector3(1522.42, 6329.21, 24.61), -- 3029 - Gas between grape seed and Paleto
        },
        locationInfo = "Near Paleto",
        categories = {
            'smg',
            'rifle',
            'throwables'
        },
        time = {
            min = 16,
            max = 4,
        },
    },
    [4] = {
        name = "Rick Heavy Arms Dealer", -- Heavy Weapon Dealer
	    locations = {
            [1] = vector3(2232.36, 5611.64, 54.91), -- 3031 - Grapeseed house off highway up mountain a little
            [2] = vector3(1338.43, 4359.43, 44.37), -- 2008 - Boatshop north of lake
            [3] = vector3(1967.16, 4634.19, 41.1), -- 2021 - House/property Near End of Airstrip

        },
        locationInfo = "Near Grapeseed",
        categories = {
            'pistol',
            'heavy',
        },
        time = {
            min = 16,
            max = 4,
        },
    },
    [5] = {
        name = "Carl's Security Detail", -- Security 
	    locations = {
            [1] = vector3(-970.51, -1121.08, 2.17), -- 346 - Canal Area 4 house thing
            [2] = vector3(-1645.27, -1060.49, 13.15), -- 611 - Docks
            [3] = vector3(-1569.48, -233.09, 49.57), -- 633 - Near Cemetery 
        },
        locationInfo = "North-Western City",
        categories = {
            'security',
        },
        time = {
            min = 16,
            max = 4,
        },
    },
    [6] = {
        name = "Jeff's Car Market", -- Car
	    locations = {
            [1] = vector3(-3072.73, 452.86, 6.36), -- 806 - House balcony
            [2] = vector3(-3412.24, 977.87, 8.35), -- 905 - End of docks
            [3] = vector3(-2949.75, 455.19, 15.31), -- 814 - Near convience store and bank
            [4] = vector3(-2173.81, 4282.12, 49.12), -- 2001 - Diner Back Door

        },
        locationInfo = "Near Chumash",
        categories = {
            'car',
        },
        time = {
            min = 16,
            max = 4,
        },
    },
}

Config.ConstantLocations = {
    [1] = {
        name = "Key Market",
	    locations = {
            [1] = vector3(160.95, 6650.32, 31.67), -- 806 - House balcony
        },
        locationInfo = "Paleto Keys",
        categories = {
            'keyshop',
        },
        time = {
            min = 16,
            max = 4,
        },
    }
}
-- Paleto - Blue - Large Arms Market
--vector3(-15.43, 6666.41, 31.92), -- 3022 - Paleto Docks
--vector3(-482.12, 6276.3, 13.63), -- 3009 - Paleto Beach
--vector3(-519.45, 5308.42, 80.24), -- 3002 - Lumber
--vector3(-1101.58, 4940.73, 218.35), -- 3001 - Hillbilly area

-- Grapeseed - Purple - Heavy Arms Market
--vector3(1522.42, 6329.21, 24.61), -- 3029 - Gas between grape seed and Paleto
--vector3(2232.36, 5611.64, 54.91), -- 3031 - Grapeseed house off highway up mountain a little
--vector3(1338.43, 4359.43, 44.37), -- 2008 - Boatshop north of lake
--vector3(1967.16, 4634.19, 41.1), -- 2021 - House/property Near End of Airstrip

-- Sandy - Yellow - Medium Arms Market
--vector3(13.26, 3732.25, 39.68), -- 1007 - Stab City
--vector3(1394.36, 3649.35, 34.68), -- 1016 - Car wash in Sandy City
--vector3(2685.25, 3515.27, 53.3), -- 956 - hardware
--vector3(2663.27, 2891.12, 36.94), -- 962 - Quarry

--South-Eastern City - Green - Small Arms Market
--vector3(-87.9, -1601.53, 32.31), -- 118 - North-E to maze bank
--vector3(112.91, -1588.88, 29.73), -- 128 - North-E maze bank
--vector3(-174.32, -1273.18, 32.6), -- 101 - City Bennies
--vector3(341.21, -1270.78, 31.98), -- 148 - Strip Club

-- North-Western City - Security Market
--vector3(-970.51, -1121.08, 2.17), -- 346 - Canal Area 4 house thing
--vector3(-1645.27, -1060.49, 13.15), -- 611 - Docks
--vector3(-1569.48, -233.09, 49.57), -- 633 - Near Cemetery 
--

-- Chumash - Orange - Vehicle Market
--vector3(-3072.73, 452.86, 6.36), -- 806 - House balcony
--vector3(-3412.24, 977.87, 8.35), -- 905 - End of docks
--vector3(-2949.75, 455.19, 15.31), -- 814 - Near convience store and bank
--vector3(-2173.81, 4282.12, 49.12), -- 2001 - Diner Back Door

-- Secret (Rare dealer doesn't give hint) - no Dealers Yet
--vector3(2806.53, 5978.78, 350.87), -- 3031 - Mount Gordo
--vector3(1138.88, -322.29, 67.15), -- 411 -Mirror Park gas
--vector3(-9.73, -14.57, 71.15), -- 570 - Near Race Dealer
--vector3(1915.61, 582.58, 176.37), -- 723 - Damn control building
--vector3(457.2, 5571.65, 781.18), -- 3008 - Mount chiliad
--vector3(2855.13, 1479.76, 24.74), -- 728 - Power Station
--vector3(3426.71, 5174.54, 7.4), -- 2027 - Lighthouse
