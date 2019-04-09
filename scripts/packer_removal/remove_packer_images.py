import json
import requests
import os

api_key = os.environ['DO_TOKEN']
snapshots_api_url = 'https://api.digitalocean.com/v2/snapshots?resource_type=droplet'
delete_snapshot_url = 'https://api.digitalocean.com/v2/snapshots/'
headers = {'content-type': 'application/json','authorization': 'bearer {0}'.format(api_key)}
r = requests.get(snapshots_api_url, headers=headers)
snapshots = r.json()['snapshots']

for snapshot in snapshots:
    id = snapshot['id']
    r = requests.delete("{0}{1}".format(delete_snapshot_url,id), headers=headers)
    if r.status_code != 204:
        exit(1)