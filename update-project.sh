
echo off
clear

echo
echo "Preparing environment..."
cd ..

echo
echo "Updating Discovery System..."
cd ./acme-discovery-system
git fetch
git pull
cd ..

echo
echo "Updating Loading Balancer..."
cd ./acme-load-balancer
git fetch
git pull
cd ..

echo
echo "Updating Product Command..."
cd ./acme-product-command
git fetch
git pull
cd ..

# echo
# echo "Updating Product Query..."
# cd ./acme-product-query
# git fetch
# git pull
# cd ..

echo
echo "Updating Review Command..."
cd ./acme-review-command
git fetch
git pull
cd ..

echo
echo "Updating Review Query..."
cd ./acme-review-query
git fetch
git pull
cd ..

echo
echo "Updating Vote Command..."
cd ./acme-vote-command
git fetch
git pull
cd ..

echo
echo "Updating Vote Query..."
cd ./acme-vote-query
git fetch
git pull
cd ..

echo
echo "Running docker-compose.yml file..."

cd ./acme-project
docker compose up -d --build

echo
read -p "Press any key to resume..."
