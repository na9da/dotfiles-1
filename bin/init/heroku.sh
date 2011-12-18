echo 'deb http://toolbelt.herokuapp.com/ubuntu ./' > /etc/apt/sources.list.d/heroku.list
curl http://toolbelt.herokuapp.com/apt/release.key | apt-key add -

apt-get update
apt-get install -y heroku-toolbelt
