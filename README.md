[![Code Climate](https://codeclimate.com/github/emaserafini/kengai/badges/gpa.svg)](https://codeclimate.com/github/emaserafini/kengai)
[![Test Coverage](https://codeclimate.com/github/emaserafini/kengai/badges/coverage.svg)](https://codeclimate.com/github/emaserafini/kengai/coverage)

# kengai

```
curl -X PATCH -H "Content-Type: application/json"\
              -H "Accept: application/json" \
              -H "Authorization: Token token=12d51b54-bffd-419c-bf5b-b69f8a4e8527"\
              -d '{"thermostat":{"temperature_attributes":{"value":26.4}}}' \
              http://localhost:3000/api/thermostats/d7001008-81cb-4b89-bca8-b33ebdbf60fd
```

```
curl -X PUT -H "Content-Type: application/json"\
              -H "Accept: application/json" \
              -H "Authorization: Token token=e1b404f8-22c3-4964-8a05-b3db75ea7c85"\
              -d '{"thermostat":{"temperature_attributes":{"value":22.4},"humidity_attributes":{"value":45}}}' \
              http://localhost:3000/api/thermostats/f1c9e155-7e43-420b-9e4a-8a5575f160a1/sensors
```

```
curl -X PUT -H "Content-Type: application/json"\
              -H "Accept: application/json" \
              -H "Authorization: Token token=89b70b16-f606-4814-a99e-9264ea7d0c46"\
              -d '{"thermostat":{"temperature_attributes":{"value":26.4},"humidity_attributes":{"value":40}}}' \
              http://kengai.pw/api/thermostats/d30cfdae-fbfc-46c3-8783-4bf197da67f8
```
