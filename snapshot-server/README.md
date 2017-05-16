## Collection of commands (from DO API Documentation)


* Authenticating to get a Bearer token: Generate from
    https://cloud.digitalocean.com/settings/api/tokens page

* Snapshot a droplet using it's `DROPLET_ID`

  ```sh
  curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer
  b7d03a6947b217efb6f3ec3bd3504582" -d '{"type":"snapshot","name":"Nifty New
  Snapshot"}' "https://api.digitalocean.com/v2/droplets/3164450/actions"
  ```
