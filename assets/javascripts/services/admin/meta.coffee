define ['ng', 's/services'], (angular, services) ->
	'use strict'

	services.factory 'meta', [->

		{
      "sensorHubTypes": {
        "1": "Water Protector",
        "2": "Comfort Director",
        "3": "Home Defender"
      },
      "roomTypes": {
        "53335728e286cb970c88aaa0": "bedroom",
        "53335728e286cb970c88aaa1": "other",
        "53335728e286cb970c88aaa2": "downstairs",
        "53335728e286cb970c88aaa3": "hallway",
        "53335728e286cb970c88aaa4": "den",
        "53335728e286cb970c88aaa5": "living room",
        "53335728e286cb970c88aaa6": "master bedroom",
        "53335728e286cb970c88aaa7": "kids room",
        "53335728e286cb970c88aaa8": "laundry room",
        "53335728e286cb970c88aaa9": "upstairs",
        "53335728e286cb970c88aaaa": "family room",
        "53335728e286cb970c88aaab": "kitchen",
        "53335728e286cb970c88aaac": "dining room",
        "53335728e286cb970c88aaad": "entryway",
        "53335728e286cb970c88aaae": "office",
        "53335728e286cb970c88aaaf": "basement",
        "53920fe9ecfde8e9a5000001": "bathroom"
      },
      "waterSources": {
        "53937bb4c8fa744670f8b854": "Clothes Washer",
        "53937bb4c8fa744670f8b853": "Aquarium",
        "53937bb4c8fa744670f8b855": "Dishwasher",
        "53937bb4c8fa744670f8b858": "Radiator",
        "53937bb4c8fa744670f8b85a": "Sink",
        "53937bb4c8fa744670f8b85d": "Tub & shower",
        "53937bb4c8fa744670f8b85f": "Water Pipe (water supply line)",
        "53937bb4c8fa744670f8b856": "Humidifier",
        "53937bb4c8fa744670f8b852": "AC unit",
        "53937bb4c8fa744670f8b857": "Pool and Fountain",
        "53937bb4c8fa744670f8b859": "Refrigerator",
        "53937bb4c8fa744670f8b85b": "Sump Pump",
        "53937bb4c8fa744670f8b85e": "Water Heater",
        "53937bb4c8fa744670f8b85c": "Toilet"
      }
    }


	]