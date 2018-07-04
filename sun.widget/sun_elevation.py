from astral import Location
import argparse
import datetime

options = argparse.ArgumentParser()
options.add_argument("lat", name="latitude", type=float)
options.add_argument("lng", name="longitude", type=float)
options.add_argument("timezone")

args = options.parse_args()

loc = Location(("Somewhere", None, args.lat, args.lng, args.timezone, 0))
solar_noon = loc.solar_noon()
afternoon = datetime.datetime.now() > solar_noon
elevation = loc.solar_elevation()

if afternoon:
    angle = 180 - elevation
else:
    angle = elevation

print(angle)
