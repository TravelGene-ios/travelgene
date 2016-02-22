import urllib2
import requests
url = "http://127.0.0.1:5000/"
host = "http://127.0.0.1:5000/mongodb_connection_test"
r = requests.post(host, data={'city': "newyorks", 'category': 'spot', 'count': 2})

content = urllib2.urlopen(url).read()
print(r.status_code, r.reason)
